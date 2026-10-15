-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_get_user_shipment_details_r(character varying)
-- Type: FUNCTION

-- Name: labmi_get_user_shipment_details_r(character varying); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_get_user_shipment_details_r(p_user_guid character varying, OUT p_shipmentjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	v_json text;
    
begin

	select  row_to_json (a)  into v_json
     from (select u.product_shipment_user_id, u.product_cart_id, u.shipment_name, u.shipment_address1,
    		u.shipment_address2, u.shipment_state_id, u.shipment_city_id, u.shipment_pincode, u.shipment_mobile_no ,
    		u.is_shipment_billing_address_same,
		u.billing_name, u.billing_address1,s1.name as shipment_state ,c1.name as shipment_city,
		u.billing_address2,
    		u.shipment_state_id as billing_state_id , u.shipment_city_id as billing_city_id ,
		u.billing_pincode, u.billing_mobile_no, s1.name as billing_state ,c1.name as billing_city,
		u.billing_user_emailid,d.name as billing_country,d.name as shipping_country,
		  u.shipment_country_id,u.shipment_country_id as billing_country_id	, 
		   u.billing_landmark , c.name_on_card  , u.billing_landmark,u.billing_district
         from labmi.labmi_product_shipment_user_archive  u  
         inner join labmi.labmi_product_cart_archive c
         on (u.product_cart_id = c.product_cart_id and c.is_active = 1) 
		 left join labmi.labmi_web_user  wu
		 on c.user_guid= wu.user_guid 
		 left join waf_master.waf_cities c1 on u.shipment_city_id=c1.city_id
		 left join waf_master.waf_states s1 on u.shipment_state_id=s1.state_id 
		 left join waf_master.waf_countries d on u.shipment_country_id=d.country_id  
		 left join labmi.labmi_product_cart_paydetails_archive  p on c.product_cart_id = p.product_cart_id
		 left join labmi.labmi_product_sku ps on  c.product_id = ps.product_id
         where c.user_guid = p_user_guid
         and u.is_active = 1 
         and u.is_deleted = 0
         and c.is_active = 1 
         and c.is_deleted = 0
		 order by u.product_cart_id desc
       ) a; 
   
   	p_shipmentjson := ('{ "paymentdetails" : ' || v_json || '}')::jsonb ; 
	
    
   	p_shipmentjson := ('{ "paymentdetails" : ' || v_json || '}')::jsonb ; 
   
end;

$$;


--
