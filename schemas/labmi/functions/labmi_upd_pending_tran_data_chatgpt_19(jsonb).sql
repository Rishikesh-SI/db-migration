-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_upd_pending_tran_data_chatgpt_19(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_pending_tran_data_chatgpt_19(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_upd_pending_tran_data_chatgpt_19(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE
    i RECORD;
    v_response_count numeric;
    v_user_guid varchar(1000);
    v_product_id numeric;
    v_product_cart_id numeric;
BEGIN

FOR i IN
    SELECT
        b->>'tracking_id' tracking_id,
        b->>'status_message' status_message,
        b->>'order_status' order_status,
        b->>'response_code' response_code,
        b->>'status_code' status_code,
        b->>'transaction_timestamp' transaction_timestamp,
        b
    FROM json_array_elements(p_json::json->'data') b
LOOP

/* ---------------------------------------------------------
   PENDING / INITIATED / AWAITED
--------------------------------------------------------- */
IF lower(i.order_status) = 'awaited'
   OR lower(i.order_status) = 'initiated'
   OR i.order_status IS NULL THEN

    SELECT response_count
    INTO v_response_count
    FROM labmi.labmi_product_cart_paydetails
    WHERE tracking_id = i.tracking_id;

    UPDATE labmi.labmi_product_cart_paydetails
    SET response_count = COALESCE(v_response_count,0) + 1,
        updated_date = current_timestamp AT TIME ZONE 'utc'
    WHERE tracking_id = i.tracking_id;

/* ---------------------------------------------------------
   🔥 RETRY LIMIT EXCEEDED – MOVE TO HISTORY & DELETE
--------------------------------------------------------- */
    IF EXISTS (
        SELECT 1
        FROM labmi.labmi_product_cart_paydetails
        WHERE tracking_id = i.tracking_id
          AND response_count > 2
    ) THEN

        /* 1️⃣ Archive payment */
        INSERT INTO labmi.labmi_product_cart_paydetails_history
        SELECT *
        FROM labmi.labmi_product_cart_paydetails
        WHERE tracking_id = i.tracking_id;

        /* 2️⃣ Capture cart id before delete */
        SELECT product_cart_id, user_guid
        INTO v_product_cart_id, v_user_guid
        FROM labmi.labmi_product_cart_paydetails
        WHERE tracking_id = i.tracking_id;

        /* 3️⃣ Delete payment (KEY FIX) */
        DELETE FROM labmi.labmi_product_cart_paydetails
        WHERE tracking_id = i.tracking_id;

        /* 4️⃣ Deactivate old cart (safe) */
        UPDATE labmi.labmi_product_cart
        SET is_active = 0,
            is_deleted = 1
        WHERE product_cart_id = v_product_cart_id;

    END IF;

/* ---------------------------------------------------------
   FINAL STATUS (SUCCESS / FAILED / BOUNCED)
--------------------------------------------------------- */
ELSE

    UPDATE labmi.labmi_product_cart_paydetails
    SET order_status = i.order_status,
        failure_message = i.response_code,
        status_code = i.status_code,
        status_message = i.status_message,
        transaction_date =
            to_timestamp(i.transaction_timestamp,'YYYYMMDDHH24MISS')::date,
        payment_json = ('{ "data":' || i.b || '}')::jsonb,
        updated_date = current_timestamp AT TIME ZONE 'utc',
        is_active =
            CASE WHEN lower(i.order_status) = 'success' THEN 1 ELSE 0 END,
        is_deleted =
            CASE
                WHEN lower(i.order_status) = 'success' THEN 0
                WHEN lower(i.order_status) = 'awaited' THEN 0
                ELSE 1
            END,
        is_status_flag =
            CASE
                WHEN lower(i.order_status) = 'success' THEN 1
                WHEN lower(i.order_status) = 'failed' THEN 2
                ELSE 0
            END
    WHERE tracking_id = i.tracking_id;

/* ---------------------------------------------------------
   SUCCESS FLOW (UNCHANGED)
--------------------------------------------------------- */
    IF lower(i.order_status) = 'success' THEN

        SELECT user_guid
        INTO v_user_guid
        FROM labmi.labmi_product_cart_paydetails
        WHERE tracking_id = i.tracking_id;

        SELECT product_id, product_cart_id
        INTO v_product_id, v_product_cart_id
        FROM labmi.labmi_product_cart
        WHERE user_guid = v_user_guid;

        UPDATE labmi.labmi_product_cart
        SET expiry_date =
            current_timestamp AT TIME ZONE 'utc' + interval '1 year'
        WHERE user_guid = v_user_guid;

        UPDATE labmi.labmi_web_user
        SET campaign_id = v_product_id,
            membership_start_date =
                current_timestamp AT TIME ZONE 'utc'
        WHERE user_guid = v_user_guid;

        UPDATE labmi.labmi_product_cart_paydetails
        SET product_cart_id = v_product_cart_id
        WHERE tracking_id = i.tracking_id;

        UPDATE labmi.labmi_product_inventory
        SET stock_quantity = stock_quantity - 1
        WHERE product_id = v_product_id;

    END IF;

END IF;

END LOOP;

p_result := 1;

END;
$$;


--
