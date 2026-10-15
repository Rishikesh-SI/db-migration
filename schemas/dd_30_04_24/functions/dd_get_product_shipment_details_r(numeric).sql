-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_product_shipment_details_r(numeric)
-- Type: FUNCTION

-- Name: dd_get_product_shipment_details_r(numeric); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_product_shipment_details_r(p_product_cartid numeric, OUT p_shipmentjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	v_json text;
    
begin
	
     select  row_to_json (a)  into v_json
     from (select u.product_shipment_user_id, u.product_cart_id, u.shipment_name, u.shipment_address1,
    		u.shipment_address2, u.shipment_state, u.shipment_city, u.shipment_pincode, u.shipment_mobile_no ,
    		u.is_shipment_billing_address_same,
		u.billing_name, u.billing_address1,
		u.billing_address2,
    		u.billing_state, u.billing_city, 
		u.billing_pincode, u.billing_mobile_no, 
		u.billing_user_emailid,u.billing_country,u.shipping_country,
            (c.total_price + c.delivery_charges + (case when lower(u.shipping_country)='nepal' then 300 else 0 end )) bill_amount,
           u.total_amount, 
           c.total_select_product,
           c.user_cart_guid 
    		 
         from dd.dd_product_shipment_user  u  
         inner join dd.dd_product_cart c
         on (u.product_cart_id = c.product_cart_id)
         where c.product_cart_id = p_product_cartid
         and u.is_active = 1 
         and u.is_deleted = 0
         and c.is_active = 1 
         and c.is_deleted = 0
       ) a; 
   
   	p_shipmentjson := ('{ "paymentdetails" : ' || v_json || '}')::jsonb ; 
   
end;

$$;


--
