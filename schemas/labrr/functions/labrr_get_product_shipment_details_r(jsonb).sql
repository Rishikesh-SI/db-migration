-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_product_shipment_details_r(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_product_shipment_details_r(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_product_shipment_details_r(p_json jsonb, OUT p_data jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	v_json text;
    p_product_cartid numeric;
    p_user_guid character varying; 
    p_trackingid numeric;
    
begin

select p_json->'data'->>'product_cart_id',
p_json->'data'->>'tracking_id',
p_json->'data'->>'user_guid'
into p_product_cartid,p_trackingid,p_user_guid;
	
    
    
     select  row_to_json (a)into v_json
     from (select u.product_shipment_user_id, u.product_cart_id, u.delivery_name,
           u.delivery_address, u.delivery_pincode as delivery_zip, u.delivery_mobile_no as delivery_tel,
    		u.is_shipment_billing_address_same,u.delivery_email,u.discount_code as offer_code,u.discount_type as offer_type,
		u.billing_name, u.billing_address,u.delivery_state ,u.delivery_city,
		u.billing_pincode as billing_zip, u.billing_mobile_no as billing_tel,u.billing_state,u.billing_city,
		u.billing_user_emailid as billing_email,u.billing_country,u.delivery_country,
            --(c.total_price + c.delivery_charges + (case when lower(u.delivery_country)='nepal' then 300 else 0 end )) bill_amount,
          -- ps.product_price as total_amount, 
		   case when c.total_price::text ilike '%.00' then replace(c.total_price::text,'.00','.0')
           when c.total_price::text ilike '%.10' then replace(c.total_price::text,'.10','.1')
           when c.total_price::text ilike '%.20' then replace(c.total_price::text,'.20','.2')
           when c.total_price::text ilike '%.30' then replace(c.total_price::text,'.30','.3')
           when c.total_price::text ilike '%.40' then replace(c.total_price::text,'.40','.4')
           when c.total_price::text ilike '%.50' then replace(c.total_price::text,'.50','.5')
           when c.total_price::text ilike '%.60' then replace(c.total_price::text,'.60','.6')
           when c.total_price::text ilike '%.70' then replace(c.total_price::text,'.70','.7')
           when c.total_price::text ilike '%.80' then replace(c.total_price::text,'.80','.8')
           when c.total_price::text ilike '%.90' then replace(c.total_price::text,'.90','.9')
            else c.total_price::text end as amount,
           p.tracking_id,
           u.currency,
           c.user_cart_guid,wu.mobile_no, wu.email_id,
           p.order_status,
		   case when lower(p.order_status) in ('si-initiated','success','awaited') then 0
		   		else 1 end as process_payment,
         product_name as product_info 		   
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
         left join labrr.labrr_product pp on  pp.product_id = c.product_id
         where  (c.product_cart_id=p_product_cartid or p.tracking_id=p_trackingid)
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
