-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_update_membership_failed(numeric)
-- Type: FUNCTION

-- Name: labmi_update_membership_failed(numeric); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_update_membership_failed(p_product_cart_id numeric, OUT p_result boolean, OUT p_message text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    
    IF p_product_cart_id IS NULL THEN
        p_result  := false;
        p_message := 'product_cart_id is required.';
        RETURN;
    END IF;

   
    IF NOT EXISTS (
        SELECT 1
        FROM labmi.labmi_product_cart_paydetails
        WHERE product_cart_id = p_product_cart_id
    ) THEN
        p_result  := false;
        p_message := 'Invalid product_cart_id.';
        RETURN;
    END IF;
	
		-- Check current status
			IF EXISTS (
				SELECT 1
				FROM labmi.labmi_product_cart_paydetails
				WHERE product_cart_id = p_product_cart_id
				  AND order_status = 'FAILED'
			) THEN
				p_result  := false;
				p_message := 'Transaction already marked as FAILED.';
				RETURN;
			END IF;
			
	
    -- Update paydetails
    UPDATE labmi.labmi_product_cart_paydetails
    SET order_status   = 'FAILED',
        status_message = 'Transaction Failed',
        is_status_flag = 3
    WHERE product_cart_id = p_product_cart_id;

    -- Soft delete product
    UPDATE labmi.labmi_product
    SET is_active  = 0,
        is_deleted = 1
    WHERE product_cart_id = p_product_cart_id;

    p_result  := true;
    p_message := 'Transaction marked as failed successfully.';

EXCEPTION WHEN OTHERS THEN
    p_result  := false;
    p_message := SQLERRM;
END;
$$;


--
