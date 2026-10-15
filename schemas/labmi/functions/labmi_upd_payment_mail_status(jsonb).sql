-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_upd_payment_mail_status(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_payment_mail_status(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_upd_payment_mail_status(p_payjson jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare

        v_tracking_id numeric;
		v_is_mail_sent numeric;
		v_payment_json jsonb;

BEGIN

        v_payment_json :=p_payjson;
		
        select 	v_payment_json->'data'->>'is_mail_sent',
                v_payment_json->'data'->>'tracking_id'
        into    v_is_mail_sent,
                v_tracking_id;
				
		update labmi.labmi_product_cart_paydetails	
		set is_mail_sent = v_is_mail_sent
		where tracking_id = v_tracking_id;
			
		p_result := 1;

		exception
		when others then
		p_result := -1;
	

END;

    

$$;


--
