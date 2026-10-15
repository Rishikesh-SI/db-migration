-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_membership_conversion_update(numeric, numeric)
-- Type: FUNCTION

-- Name: labmi_membership_conversion_update(numeric, numeric); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_membership_conversion_update(p_product_cart_id numeric, p_target_product_id numeric, OUT p_result boolean, OUT p_message text, OUT p_data_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_guid       text;
    v_old_product_id  integer;
    v_current_stock   integer;
    v_product_code    text;
    v_invoice_id      text;
BEGIN
   
    IF p_product_cart_id IS NULL THEN
        p_message := 'product_cart_id is required.';
        RETURN;
    END IF;

    IF p_target_product_id IS NULL THEN
        p_message := 'product_id is required.';
        RETURN;
    END IF;
	
	--product id
		IF NOT EXISTS (
			SELECT 1
			FROM labmi.labmi_product
			WHERE product_id = p_target_product_id
		) THEN
			p_message := 'Invalid / mismatched product_id.';
			RETURN;
		END IF;



    SELECT pd.user_guid
    INTO v_user_guid
    FROM labmi.labmi_product_cart_paydetails pd
    WHERE pd.product_cart_id = p_product_cart_id;

    IF NOT FOUND OR v_user_guid IS NULL THEN
        p_message := 'Invalid product_cart_id.';
        RETURN;
    END IF;

    SELECT campaign_id
    INTO v_old_product_id
    FROM labmi.labmi_web_user
    WHERE user_guid = v_user_guid;

    IF v_old_product_id = p_target_product_id THEN
        p_message := 'User already has this membership.';
        RETURN;
    ELSE
        UPDATE labmi.labmi_web_user
        SET campaign_id = p_target_product_id,
            membership_start_date = CURRENT_TIMESTAMP,
            sync_data = 0
        WHERE user_guid = v_user_guid;

        IF NOT FOUND THEN
            p_message := 'Web user not found.';
            RETURN;
        END IF;

     
		--- blue membership
		
        IF p_target_product_id <> 1 THEN
            IF v_old_product_id IS NOT NULL  THEN
                UPDATE labmi.labmi_product_inventory
                SET stock_quantity = stock_quantity + 1
                WHERE product_id = v_old_product_id;
            END IF;

            SELECT stock_quantity
            INTO v_current_stock
            FROM labmi.labmi_product_inventory
            WHERE product_id = p_target_product_id; 


            UPDATE labmi.labmi_product_inventory
            SET stock_quantity = stock_quantity - 1  ---keeping track of the inventory for that particular product(gold/silver/junior)
            WHERE product_id = p_target_product_id;
        END IF;
	-------------------------
	
	
	   UPDATE labmi.labmi_product_cart
        SET expiry_date = (
                date_trunc('year', CURRENT_DATE)
                + interval '1 year'
                - interval '1 second'   --23:59:59
            ), --current_date now it will get updated last day of the year 23:59:59
            product_id = p_target_product_id
        WHERE product_cart_id = p_product_cart_id
          AND is_active = 1
          AND is_deleted = 0;
		  
	 -----------
        SELECT product_code
        INTO v_product_code
        FROM labmi.labmi_product
        WHERE product_id = p_target_product_id;

        v_invoice_id := v_product_code || p_product_cart_id;

        UPDATE labmi.labmi_product_cart_paydetails
        SET invoice_id = v_invoice_id
        WHERE product_cart_id = p_product_cart_id;
 
        p_result := true;
        p_message := 'Membership updated successfully.';
        p_data_json := jsonb_build_object(
            'product_cart_id', p_product_cart_id,
            'old_product_id', v_old_product_id,
            'new_product_id', p_target_product_id,
            'invoice_id', v_invoice_id
        );
   END IF;

EXCEPTION WHEN OTHERS THEN
    p_result := false;
    p_message := SQLERRM;
END;
$$;


--
