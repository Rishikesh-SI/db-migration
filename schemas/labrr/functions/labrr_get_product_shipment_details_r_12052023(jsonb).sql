-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_product_shipment_details_r_12052023(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_product_shipment_details_r_12052023(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_product_shipment_details_r_12052023(p_json jsonb, OUT p_data jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_json text;
    p_product_cartid numeric;
    p_user_guid character varying; 
    
begin

select p_json->'data'->>'product_cart_id',
p_json->'data'->>'user_guid'
into p_product_cartid,p_user_guid;
	
    
    
     select  row_to_json (a)into v_json
     from (select u.product_shipment_user_id, u.product_cart_id, u.delivery_name,
           u.delivery_address, u.delivery_pincode as delivery_zip, u.delivery_mobile_no as delivery_tel,
    		u.is_shipment_billing_address_same,u.delivery_email,
		u.billing_name, u.billing_address,u.delivery_state ,u.delivery_city,
		u.billing_pincode as billing_zip, u.billing_mobile_no as billing_tel,u.billing_state,u.billing_city,
		u.billing_user_emailid as billing_email,u.billing_country,u.delivery_country,
            (c.total_price + c.delivery_charges + (case when lower(u.delivery_country)='nepal' then 300 else 0 end )) bill_amount,
          -- ps.product_price as total_amount, 
		   c.total_price as amount,
           u.currency,
           c.user_cart_guid,wu.mobile_no, wu.email_id,
		   case when lower(p.order_status) in ('si-initiated','success','awaited') then 0
		   		else 1 end as process_payment		   
         from labrr.labrr_product_shipment_user  u  
         inner join labrr.labrr_product_cart c
         on (u.product_cart_id = c.product_cart_id)
		 left join labrr.labrr_web_user  wu
		 on c.user_guid= wu.user_guid 
		 --left join waf_master.waf_cities c1 on u.shipment_city_id=c1.city_id
		 --left join waf_master.waf_states s1 on u.shipment_state_id=s1.state_id 
		 --left join waf_master.waf_countries d on u.shipment_country_id=d.country_id  
		 left join labrr.labrr_product_cart_paydetails  p on c.product_cart_id = p.product_cart_id
		 left join labrr.labrr_product_sku ps on  c.product_id = ps.product_id
         where  c.product_cart_id=p_product_cartid
         and u.is_active = 1 
         and u.is_deleted = 0
         and c.is_active = 1 
         and c.is_deleted = 0
		 order by u.product_cart_id desc
       ) a;
       
    if v_json is not null then 
    p_result:=1; 
    else
    p_result:=0;
    end if;

   	p_data := ('{ "paymentdetails" : ' || v_json || '}')::jsonb; 
    
end;

$$;


--
