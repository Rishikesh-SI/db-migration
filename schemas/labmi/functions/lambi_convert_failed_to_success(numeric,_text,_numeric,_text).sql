-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: lambi_convert_failed_to_success(numeric, text, numeric, text)
-- Type: FUNCTION

-- Name: lambi_convert_failed_to_success(numeric, text, numeric, text); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.lambi_convert_failed_to_success(p_opt_type numeric, p_email_id text, p_amount numeric, p_tracking_id text) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_user_guid varchar;
    v_campaign_id numeric;
    v_invoice_prefix TEXT;
    v_expiry_date DATE := '2026-12-31';
    v_result JSONB;

BEGIN

RAISE NOTICE 'Function started | email: %, tracking_id: %, opt_type: %',
p_email_id, p_tracking_id, p_opt_type;

--------------------------------------------------
-- Get User
--------------------------------------------------

SELECT user_guid
INTO v_user_guid
FROM labmi.labmi_web_user
WHERE email_id = p_email_id;

RAISE NOTICE 'User GUID found: %', v_user_guid;

IF v_user_guid IS NULL THEN
    RAISE NOTICE 'User not found';
    RETURN jsonb_build_object(
        'status','error',
        'message','Email does not exist'
    );
END IF;

--------------------------------------------------
-- Validate tracking id
--------------------------------------------------

IF NOT EXISTS (
    SELECT 1
    FROM labmi.labmi_product_cart_paydetails
    WHERE tracking_id = p_tracking_id
    AND user_guid = v_user_guid
) THEN

    RAISE NOTICE 'Tracking ID not found for user';

    RETURN jsonb_build_object(
        'status','error',
        'message','Tracking ID does not exist'
    );
END IF;

RAISE NOTICE 'Tracking validation passed';

--------------------------------------------------
-- REVIEW MODE
--------------------------------------------------

IF p_opt_type = 1 THEN

    RAISE NOTICE 'Running in REVIEW mode';

    SELECT jsonb_build_object(
        'mode','review',
        'web_user', (
            SELECT jsonb_build_object(
                'email_id', w.email_id,
                'mobile_no', w.mobile_no,
                'user_guid', w.user_guid,
                'campaign_id',w.campaign_id,
                'membership_start_date',w.membership_start_date
            )
            FROM labmi.labmi_web_user w
            WHERE w.user_guid = v_user_guid
        ),

        'payment_details', (
            SELECT jsonb_agg(
                jsonb_build_object(
                    'product_cart_id', p.product_cart_id,
                    'tracking_id', p.tracking_id,
                    'order_status', p.order_status,
                    'failure_message', p.failure_message,
                    'status_message', p.status_message,
                    'status_code', p.status_code,
                    'invoice_id', p.invoice_id,
                    'is_status_flag', p.is_status_flag,
                    'is_active',p.is_active,
                    'is_deleted',p.is_deleted
                )
            )
            FROM labmi.labmi_product_cart_paydetails p
            WHERE p.user_guid = v_user_guid
            AND (
                p.tracking_id = p_tracking_id
                OR p.product_cart_id = p_tracking_id::numeric
            )
        )
    )
    INTO v_result;

    RETURN v_result;

END IF;

--------------------------------------------------
-- UPDATE MODE
--------------------------------------------------

IF p_opt_type = 2 THEN

RAISE NOTICE 'Running in UPDATE mode';

--------------------------------------------------
-- Membership Logic
--------------------------------------------------

IF p_amount > 550 AND p_amount < 750 THEN
    v_campaign_id := 3;
    v_invoice_prefix := 'SMT';

ELSIF p_amount >= 750 AND p_amount < 2000 THEN
    v_campaign_id := 5;
    v_invoice_prefix := 'JMT';

ELSIF p_amount >= 2000 AND p_amount < 3000 THEN
    v_campaign_id := 4;
    v_invoice_prefix := 'GMT';

ELSE

    RAISE NOTICE 'Invalid membership amount: %', p_amount;

    RETURN jsonb_build_object(
        'status','error',
        'message','Invalid membership amount'
    );
END IF;

RAISE NOTICE 'Campaign ID: %, Invoice Prefix: %',
v_campaign_id, v_invoice_prefix;

--------------------------------------------------
-- Activate selected cart
--------------------------------------------------

UPDATE labmi.labmi_product_cart
SET expiry_date = v_expiry_date,
    is_active = 1,
    is_deleted = 0
WHERE user_guid = v_user_guid
AND product_cart_id = p_tracking_id::numeric;

RAISE NOTICE 'Activated product_cart_id %', p_tracking_id;

--------------------------------------------------
-- Deactivate other carts
--------------------------------------------------

UPDATE labmi.labmi_product_cart
SET expiry_date = v_expiry_date,
    is_active = 0,
    is_deleted = 1
WHERE user_guid = v_user_guid
AND product_cart_id IS DISTINCT FROM p_tracking_id::numeric;

RAISE NOTICE 'Other carts deactivated';

--------------------------------------------------
-- Mark selected payment SUCCESS
--------------------------------------------------

UPDATE labmi.labmi_product_cart_paydetails
SET order_status = 'SUCCESS',
    failure_message = '0000',
    status_message = 'Transaction successful',
    status_code = '000',
    invoice_id = v_invoice_prefix || p_tracking_id,
    is_status_flag = 1,
    is_active = 1,
    is_deleted = 0,
product_cart_id=p_tracking_id::numeric
WHERE user_guid = v_user_guid
AND tracking_id = p_tracking_id;

RAISE NOTICE 'Payment marked SUCCESS for tracking_id %', p_tracking_id;

--------------------------------------------------
-- Mark other payments FAILED
--------------------------------------------------

UPDATE labmi.labmi_product_cart_paydetails
SET order_status = 'FAILED',
    failure_message = 'P1006',
    status_message = NULL,
    status_code = '500',
    invoice_id = NULL,
    is_status_flag = 0,
    is_active = 0,
    is_deleted = 1
WHERE user_guid = v_user_guid
AND tracking_id IS DISTINCT FROM p_tracking_id;

RAISE NOTICE 'Other payments marked FAILED';

--------------------------------------------------
-- Update Web User
--------------------------------------------------

UPDATE labmi.labmi_web_user
SET campaign_id = v_campaign_id,
    membership_start_date = CASE
        WHEN membership_start_date IS NULL THEN NOW()
        WHEN EXTRACT(YEAR FROM membership_start_date) >= 2026 THEN membership_start_date
        WHEN EXTRACT(YEAR FROM membership_start_date) < 2026 THEN NOW()
        ELSE NULL
    END,
    sync_data = 0
WHERE user_guid = v_user_guid;

RAISE NOTICE 'User membership updated';

--------------------------------------------------
-- Return Success
--------------------------------------------------

RAISE NOTICE 'Transaction conversion completed';

RETURN jsonb_build_object(
    'status','success',
    'message','Transaction converted successfully',
    'tracking_id', p_tracking_id,
    'user_guid', v_user_guid
);

END IF;

--------------------------------------------------
-- Invalid opt_type
--------------------------------------------------

RAISE NOTICE 'Invalid opt_type: %', p_opt_type;

RETURN jsonb_build_object(
    'status','error',
    'message','Invalid opt_type (use 1=review, 2=update)'
);

END;

$$;


--
