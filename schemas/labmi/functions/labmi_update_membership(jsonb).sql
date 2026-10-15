-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_update_membership(jsonb)
-- Type: FUNCTION

-- Name: labmi_update_membership(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_update_membership(p_input_json jsonb, OUT p_result numeric, OUT p_message text, OUT p_data_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_product_cart_id    numeric;
    v_user_guid          text;
    v_target_product_id  numeric;
    v_old_product_id     numeric;
    v_current_stock      numeric;
    v_product_code       text;
    v_invoice_id         text;
BEGIN
    p_result := 0;

    -- INPUT
    v_product_cart_id   := (p_input_json->>'product_cart_id')::numeric;
    v_target_product_id := (p_input_json->>'product_id')::numeric;

    IF v_product_cart_id IS NULL THEN
        p_message := 'product_cart_id is required.';
        RETURN;
    END IF;

    IF v_target_product_id IS NULL THEN
        p_message := 'product_id is required.';
        RETURN;
    END IF;

    --------------------------------------------------
    -- Fetch user_guid using product_cart_id
    SELECT pd.user_guid
    INTO v_user_guid
    FROM labmi.labmi_product_cart_paydetails pd
    WHERE pd.product_cart_id = v_product_cart_id;

    IF NOT FOUND OR v_user_guid IS NULL THEN
        p_message := 'Invalid product_cart_id.';
        RETURN;
    END IF;

    --------------------------------------------------
    -- Fetch existing membership BEFORE update
    SELECT campaign_id
    INTO v_old_product_id
    FROM labmi.labmi_web_user
    WHERE user_guid = v_user_guid;

    -- Prevent same membership update
    IF v_old_product_id = v_target_product_id THEN
        p_message := 'User already has this membership.';
        RETURN;
    END IF;

    --------------------------------------------------
    -- Update web user membership
    UPDATE labmi.labmi_web_user
    SET campaign_id = v_target_product_id,
        membership_start_date = CURRENT_TIMESTAMP,
        sync_data = 0
    WHERE user_guid = v_user_guid;

    IF NOT FOUND THEN
        p_message := 'Web user not found.';
        RETURN;
    END IF;

    --------------------------------------------------
    -- Update product cart expiry (31st Dec current year)
    UPDATE labmi.labmi_product_cart
    SET expiry_date = (
            date_trunc('year', CURRENT_DATE)
            + interval '1 year'
            - interval '1 second'
        ),
        product_id = v_target_product_id
    WHERE product_cart_id = v_product_cart_id
      AND is_active = 1
      AND is_deleted = 0;

    --------------------------------------------------
    -- STOCK LOGIC (exclude BLUE = product_id 1)
    IF v_target_product_id NOT IN (1) THEN

        -- Return stock for old membership (if stock-based)
        IF v_old_product_id IS NOT NULL AND v_old_product_id NOT IN (1) THEN
            UPDATE labmi.labmi_product_inventory
            SET stock_quantity = stock_quantity + 1
            WHERE product_id = v_old_product_id;
        END IF;

        -- Check stock for new membership
        SELECT stock_quantity
        INTO v_current_stock
        FROM labmi.labmi_product_inventory
        WHERE product_id = v_target_product_id;

        IF v_current_stock <= 0 THEN
            p_message := 'Insufficient stock.';
            RETURN;
        END IF;

        -- Consume stock for new membership
        UPDATE labmi.labmi_product_inventory
        SET stock_quantity = stock_quantity - 1
        WHERE product_id = v_target_product_id;

    END IF;

    --------------------------------------------------
    -- Fetch product code for invoice
    SELECT product_code
    INTO v_product_code
    FROM labmi.labmi_product
    WHERE product_id = v_target_product_id;

    v_invoice_id := v_product_code || v_product_cart_id;

    UPDATE labmi.labmi_product_cart_paydetails
    SET invoice_id = v_invoice_id
    WHERE product_cart_id = v_product_cart_id;

    --------------------------------------------------
    p_result := 1;
    p_message := 'Membership updated successfully.';

EXCEPTION WHEN OTHERS THEN
    p_result := 0;
    p_message := SQLERRM;

    INSERT INTO siwaf.siwaf_client_logs (
        api_error_log_id,
        log_method_name,
        log_error_message,
        log_guid,
        error_json,
        created_date,
        client_name,
        log_type
    ) VALUES (
        nextval('siwaf.seq_siwaf_api_error_log_id'),
        'labmi_update_membership',
        SQLERRM,
        uuid_generate_v4(),
        p_input_json,
        current_timestamp,
        'labmi',
        'error'
    );
END;
$$;


--
