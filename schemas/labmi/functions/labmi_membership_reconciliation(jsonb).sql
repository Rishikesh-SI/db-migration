-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_membership_reconciliation(jsonb)
-- Type: FUNCTION

-- Name: labmi_membership_reconciliation(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_membership_reconciliation(p_input_json jsonb, OUT p_result numeric, OUT p_message text, OUT p_data_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_op_type text;
    v_user_guid text;
    v_tracking_id text;
    v_target_product_id numeric;
    v_product_code text;
    v_product_cart_id numeric;
    v_current_stock numeric;
    v_invoice_id text;
	v_tracking_ids jsonb;
	
BEGIN
   

    v_op_type := p_input_json->>'op_type';
    v_user_guid := p_input_json->>'user_guid';
    v_tracking_id := p_input_json->>'tracking_id';
    
  
    IF v_op_type IS NULL THEN
        p_message := 'Operation type (op_type) is required.';
        RETURN;
    END IF;

 
    IF v_op_type = 'UPDATE_MEMBERSHIP' THEN
        
        IF v_user_guid IS NULL THEN
            p_message := 'user_guid is required for UPDATE MEMBERSHIP.';
            RETURN;
        END IF;

        v_target_product_id := (p_input_json->>'product_id')::numeric; -- PRODUCT_ID=CAMPAIGN_ID
        
        IF v_target_product_id IS NULL THEN
            p_message := 'product_id is required for UPDATE MEMBERSHIP.';
            RETURN;
        END IF;
		
		---separate SP 
		----add user_guid from where it is coming 
		--- check product_id is same or not ,valid or not compare query from web_user
		---- single output in single sp : SRP

     ----WEB USER
        UPDATE labmi.labmi_web_user
        SET campaign_id = v_target_product_id,
            membership_start_date = CURRENT_TIMESTAMP,
            sync_data = 0
        WHERE user_guid = v_user_guid;

     ---PRODUCT CART
        UPDATE labmi.labmi_product_cart
        SET expiry_date = '2026-12-31 23:59:59'::timestamp, --condition automatic date 
            product_id = v_target_product_id 
        WHERE user_guid = v_user_guid 
          AND is_active = 1 
          AND is_deleted = 0;

      ----PRODUCT INVENTORY
        SELECT stock_quantity, product_code INTO v_current_stock, v_product_code
        FROM labmi.labmi_product_inventory pi
        JOIN labmi.labmi_product p ON p.product_id = pi.product_id
        WHERE pi.product_id = v_target_product_id;

        IF FOUND THEN
            UPDATE labmi.labmi_product_inventory
            SET stock_quantity = stock_quantity - 1 --why only minus?find ans
            WHERE product_id = v_target_product_id;
        END IF;

       ---PAYDETAILS
        IF v_tracking_id IS NOT NULL THEN
             
             SELECT product_cart_id INTO v_product_cart_id
             FROM labmi.labmi_product_cart_paydetails
             WHERE tracking_id = v_tracking_id;

             IF v_product_cart_id IS NOT NULL THEN
                 v_invoice_id := v_product_code || v_product_cart_id;
                 
                 UPDATE labmi.labmi_product_cart_paydetails
                 SET invoice_id = v_invoice_id
                 WHERE tracking_id = v_tracking_id;
             END IF;
        END IF;

        p_result := 1;
        p_message := 'Membership updated successfully.';

    ----------------------------------------------------------------------------
	
	
    ELSIF v_op_type = 'MARK_FAILED' THEN

        IF v_tracking_ids IS NULL THEN
            p_message := 'tracking_ids is required.';
            RETURN;
        END IF;
	
		-- trackig id condition should be  valid 
        FOR v_tracking_id IN
            SELECT jsonb_array_elements_text(v_tracking_ids)
        LOOP
            UPDATE labmi.labmi_product_cart_paydetails
            SET order_status = 'FAILED',
                status_message = 'Transaction Failed',
                is_status_flag = 3 --;prod flag =3 check it from stg as well as prod
            WHERE tracking_id = v_tracking_id;

            SELECT product_cart_id
            INTO v_product_cart_id
            FROM labmi.labmi_product_cart_paydetails
            WHERE tracking_id = v_tracking_id;

            UPDATE labmi.labmi_product
            SET is_active = 0,
                is_deleted = 1
            WHERE product_cart_id = v_product_cart_id;
        END LOOP;

        p_result := 1;
        p_message := 'Transaction(s) marked as failed.';
    ELSE
        p_message := 'Invalid op_type.';
    END IF;
	---- failed n success same sp input me 
	
--ERROR
EXCEPTION WHEN OTHERS THEN
    p_result := 0;
    p_message := 'Error: ' || SQLERRM;
    insert into siwaf.siwaf_client_logs(
        api_error_log_id, log_method_name, log_error_message, log_guid, error_json, created_date, client_name, log_type
    ) values (
        nextval('siwaf.seq_siwaf_api_error_log_id'),
        'labmi_membership_reconciliation',
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
