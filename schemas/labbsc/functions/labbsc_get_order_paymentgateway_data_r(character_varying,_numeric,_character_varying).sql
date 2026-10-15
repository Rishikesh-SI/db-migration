-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_order_paymentgateway_data_r(character varying, numeric, character varying)
-- Type: FUNCTION

-- Name: labbsc_get_order_paymentgateway_data_r(character varying, numeric, character varying); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_order_paymentgateway_data_r(p_user_guid character varying, p_order_id numeric, p_paymentgateway character varying, OUT p_result numeric, OUT p_paymentgatewayorder_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_id numeric;
	
begin
	
	select user_id
	into strict v_user_id
	from labbsc.labbsc_web_user
	where user_guid = p_user_guid;
	
	if exists(select 1
			  from labbsc.labbsc_purchase_order po
			  join labbsc.labbsc_cart c
			  on c.cart_id = po.cart_id
			  where po.order_id = p_order_id
			  and c.user_id = v_user_id
			  and c.status = 1) then
		
		if p_paymentgateway = 'ccavenue' then
			
			select ('{"ccavenue":'||row_to_json(row)::text||'}')::jsonb
			from (select po.amount as bill_amount, po.billing_details_json->>'city' as billing_city,
				  			po.billing_details_json->>'fullname' as billing_name, po.amount as total_amount,
				  			po.billing_details_json->>'state' as billing_state, po.shipment_details_json->>'city' as shipment_city,
				  			po.shipment_details_json->>'fullname' as shipment_name, po.shipment_details_json->>'state' as shipment_state,
				  			null as user_cart_guid, po.billing_details_json->>'country' as billing_country,
				  			po.billing_details_json->>'zip' as billing_pincode, po.cart_id as product_cart_id, po.order_id,
				  			po.billing_details_json->>'address1' as billing_address1, po.billing_details_json->>'address2' as billing_address2,
				  			po.shipment_details_json->>'zip' as shipment_pincode, po.shipment_details_json->>'country' as shipping_country,
							po.billing_details_json->>'mobile' as billing_mobile_no, po.shipment_details_json->>'address1' as shipment_address1,
							po.shipment_details_json->>'address2' as shipment_address2, po.shipment_details_json->>'mobile' as shipment_mobile_no,
							po.billing_details_json->>'email' as billing_user_emailid, null as total_select_product,
				  			null as product_shipment_user_id, po.is_ba_sa_same as is_shipment_billing_address_same,
				  			ja.merchant_name as merchant_param1, c.activity_id::text as merchant_param2, 
				         case when c.activity_id=4 then lv.title_alias else '0' end as merchant_param3,
				  			'0' as merchant_param4, '0' as merchant_param5
				  from labbsc.labbsc_purchase_order po
				  join labbsc.labbsc_cart c
				  on c.cart_id = po.cart_id
				  join labbsc.labbsc_journey_activity ja
				  on ja.activity_id=c.activity_id
				  left join labbsc.labbsc_video lv
				  on lv.video_id=c.video_id
				   where po.order_id = p_order_id
				 ) row
			into p_paymentgatewayorder_json;
			
		end if;
		
		if p_paymentgatewayorder_json is not null then
			p_result := 1;
		else
			p_result := 0;
		end if;
		
	else
		
		p_result := 0;
		
	end if;
	
exception
	when no_data_found then
		p_result := 0;
	when others then
		p_result := -1;
end;
$$;


--
