-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_place_order(character varying, numeric, jsonb)
-- Type: FUNCTION

-- Name: labbsc_place_order(character varying, numeric, jsonb); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_place_order(p_user_guid character varying, p_cart_id numeric, p_billing_json jsonb, OUT p_result numeric, OUT p_order_id numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_id numeric;
	v_amount numeric;
	v_order_id numeric;
	v_is_ba_sa_same numeric;
	v_send_email numeric;
	v_page_flag character varying(10);
	v_email_subject text;
	v_billing_details jsonb;
	v_shipment_details jsonb;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_pan_no text;
	v_gst_number text;
	 v_is_state numeric;
	 v_counseller_id numeric;
	 v_counseller_name varchar(500);
begin
	
	select user_id
	into strict v_user_id
	from labbsc.labbsc_web_user
	where user_guid = p_user_guid;
	
	 
	
	begin
		
		select net_amount
		into strict v_amount
		from labbsc.labbsc_cart
		where cart_id = p_cart_id
		and user_id = v_user_id
		and status in (0,1);
		---raise notice '%',v_amount;
		
		v_order_id := nextval('labbsc.seq_labbsc_purchase_order_id');
		
		select p_billing_json->>'is_ba_sa_same', p_billing_json->>'send_email', p_billing_json->>'page_flag', p_billing_json->>'email_subject',
				p_billing_json->'billinginfo',
				p_billing_json->'billinginfo'->>'pancard_number',
				p_billing_json->'billinginfo'->>'gst_number',
				p_billing_json->'billinginfo'->>'isState',
				p_billing_json->>'counselor_id',
				p_billing_json->>'counselor_name'
		into v_is_ba_sa_same, v_send_email, v_page_flag, v_email_subject, v_billing_details,
		v_pan_no,
		v_gst_number,
		v_is_state,
		v_counseller_id,
		v_counseller_name;
		
		 
		if v_is_ba_sa_same = 0 then
			
			select p_billing_json->'shipmentinfo'
			into v_shipment_details;
			
		else
			
			v_is_ba_sa_same := 1;
			v_shipment_details := v_billing_details;
			
		end if;
		
		insert into labbsc.labbsc_purchase_order(order_id, cart_id, billing_details_json, is_ba_sa_same, shipment_details_json, amount, created_date,
													updated_date, send_email, page_flag, email_subject)
		select v_order_id, p_cart_id, v_billing_details, v_is_ba_sa_same, v_shipment_details, v_amount, v_current_timestamp, v_current_timestamp, v_send_email,
				v_page_flag, v_email_subject;
		
		update labbsc.labbsc_cart
		set status = 1,
			updated_date = v_current_timestamp,
			pancard_number=v_pan_no,
			gst_number=v_gst_number,
			is_state= v_is_state,
			counseller_id=v_counseller_id,
			counseller_name=v_counseller_name
		where cart_id = p_cart_id;
		
		
		 
	 
	exception
		when no_data_found then
			p_result := 0;
			return;
	
	end;
	
	if v_order_id is not null then
		
		p_result := 1;
		p_order_id := v_order_id;
		
	else
		
		p_result := -2;
		
	end if;
 /*
exception
	when no_data_found then
		p_result := 0;
	when others then
		p_result := -1; */
	
end;
$$;


--
