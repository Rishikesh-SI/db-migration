-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_razorpay_details_r(text, numeric, text)
-- Type: FUNCTION

-- Name: labbsc_dev_get_razorpay_details_r(text, numeric, text); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_razorpay_details_r(p_user_guid text, p_order_id numeric, p_gateway_type text, OUT p_order_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_transaction_id character varying(50);
	v_order_status character varying(50);
	v_transaction_date varchar(500);
	v_version_number numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_cart_id numeric;
	v_user_id numeric;
	 v_contact_no text;
	v_email_id text;
	v_first_name text;
	v_last_name text;
	v_addline_1 text;
	v_addline_2 text;
	v_state text;
	v_country text;
	v_city  text;
	v_pin text;
	v_currency varchar(500);
	v_amount numeric(10,2);
	v_activity_id numeric;
	v_module_name varchar(500);
	v_merchant_name varchar(500);
	v_activity_name varchar(500);
	v_order_id numeric;
begin
	
	 		 
	 
		select  c.cart_id,c.user_id,c.gross_amount,c.activity_id,po.order_id 
		from labbsc_dev.labbsc_dev_purchase_order po
		join labbsc_dev.labbsc_dev_cart c
		on c.cart_id=po.cart_id
		where order_id = p_order_id
		into v_cart_id,v_user_id,v_amount,v_activity_id,v_order_id;
		
		select activity_name,module_name,merchant_name
		from labbsc_dev.labbsc_dev_journey_activity
		where activity_id=v_activity_id
		into v_activity_name,v_module_name,v_merchant_name;
		
		if v_user_id is not null
		then
		  select
		  billing_details_json->>'email',
		   billing_details_json->>'mobile',
		   billing_details_json->>'firstname',
		  billing_details_json->>'lastname',
		   billing_details_json->>'address1',
		   billing_details_json->>'address2',
		    billing_details_json->>'state',
			 billing_details_json->>'country',
			  billing_details_json->>'city',
			   billing_details_json->>'pin'
		  from labbsc_dev.labbsc_dev_purchase_order
where order_id=v_order_id
		 
		into  v_email_id,v_contact_no,v_first_name,v_last_name, 
		v_addline_1,v_addline_2,v_state,v_country,v_city,v_pin;
		
		 
		select '{"razorpay":'||row_to_json(tab)::text||'}' 
		from (
			select p_order_id as order_id,
			v_amount as amount,
			'INR' as currency,
			v_first_name as first_name,
			v_last_name as last_name,
			v_email_id as email,
			v_contact_no as contactNumber,
			v_addline_1 as address_line1,
			v_addline_2 as address_line2,
			v_city as city,
			v_pin as pin,
			v_state as state_name,
			v_country as country,
			v_activity_name as activity_name,
			v_module_name as module_name,
			v_activity_id as activity_id,
			v_merchant_name as merchant_name
			
			 ) tab
		
		into p_order_json;
		
		 
		
		end if;
		
		end;
$$;


--
