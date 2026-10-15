-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_order_status_detail(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labrr_get_order_status_detail(numeric, numeric, numeric); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_order_status_detail(p_status numeric, p_order_id numeric, p_tracking_id numeric, OUT p_orderjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

v_json text;
v_status numeric;
v_fromrownumber numeric;
	v_torownumber numeric ;
	v_search_text text;
	
	--v_searchkeyword text;
	
	-- v_searchkeyword varchar(4000) := p_searchkeyword;
	v_entitysearchquery varchar(4000) := ' ';
    v_active_flag  varchar(4000):=' '  ;
    v_tracking_query	varchar(4000) := ' ';
	v_product_id numeric;
    v_module_name character varying;
begin
 -- v_search_text := upper(p_searchkeyword);
    
   
   
	--  p_ordercount := 10 ;-- v_count;
   
   
   if p_status=1 then 
         v_status:=1;
         v_active_flag:='and a.is_deleted=0 and a.is_active=1';
   ELSIF   p_status=0 then 
            v_status:=0;
            v_active_flag:='and a.is_active=0 and a.is_deleted=1';
   
   ELSIF   p_status=2 then 
   -- else         
     -- v_status:='Pending'
      v_status:=2;
   ELSIF   p_status=3 then 
      v_status:=3;
	  v_active_flag:='and a.is_active=0 and a.is_deleted=1';
   end if ;
   
   select module_name into v_module_name from labrr.labrr_product_cart_paydetails 
   where product_cart_id=p_order_id or tracking_id=p_tracking_id;
   
  --if v_searchkeyword is not null then
     	
        --  v_searchkeyword:='*' || replace(''||v_searchkeyword||'',' ',':* & *') || ':*';
       --   v_entitysearchquery := ' and (to_tsvector(ab.product_cart_id::text) @@@ to_tsquery('''||v_searchkeyword||''')
                                    --    OR to_tsvector(shipment_name) @@@ to_tsquery('''||v_searchkeyword||'''))';
   
  -- end if ;

 	if p_tracking_id is not null then 
    
    	v_tracking_query := ' and b.tracking_id= '|| p_tracking_id ;
     
    end if ;

-- select 1/0;

if v_module_name ='membership' then
   execute '
     select  row_to_json(tab)    from (
     select *,products::jsonb from (
     select  distinct  ab.product_cart_id,
          delivery_name,
          --shipment_address1,
          --shipment_address2,
          delivery_address,
          delivery_state,
          delivery_city,
          delivery_pincode,
          u.mobile_no shipment_mobile_no,
		  u.dob,
		  --''27AADCR8195F1Z0'' as gst_no,
		  total_price ,
         bill_amount,
          billing_name,
          --billing_address1,
          --billing_address2,
          billing_address,
		  billing_district,
		  billing_landmark,
          s.name as billing_state,
          ct.name as billing_city,
          billing_pincode,
          u.mobile_no billing_mobile_no,
          u.email_id billing_user_emailid,
          d.name as billing_country,
          delivery_country,
		  cart_json->''data''->''cartdetails'' as cartdetails,
          --(case when upper(shipping_country)=''NEPAL'' then 300 else 0 end ) as other_charges,
          bill_amount as bill_amount,
		  --final_payment_json->''data''->>''mer_amount'' as bill_amount1, 
		  --final_payment_json->''data''->>''transaction_txntype'' as payment_mode,
          b.payment_mode as payment_mode,
		  c.delivery_charges,											
          order_status,
          tracking_id, 
          final_payment_json->''data''->>''transaction_timestamp'' as transaction_date,
		  final_payment_json->''data''->>''order_id'' as order_id,	
          
          (
          select array_to_json(array_agg(tab)) from (
           select 
			a.quantity,
			b.product_id,
            coalesce(a.product_price,0) + coalesce(a.customize_price,0)  as total_price,
            b.product_price as unit_price,
            c.product_name  as  product_name,
             f.customize_name||'' (''||a.customize_text||'')'' 
              as  customize_text,
             coalesce(f.custmize_prize,0)  as customize_price,		  
            e.product_customize_map_id,
            f.customize_name,
            ( select array_to_json(array_agg(row)) 
             from ( 
             select  d.specification_name,
             e.attribute_name from labrr.labrr_product_attribute_specification d
            join labrr.labrr_product_attribute e on d.product_attribute_id=e.product_attribute_id
            where product_attribute_specification_id =any(attribute_specification_ids))row) as attributes		   
           from  labrr.labrr_product_cart d 
		   join  labrr.labrr_product_cart_details a on d.product_id=a.product_id
           join labrr.labrr_product_sku b on a.product_sku_id=b.product_sku_id
           join labrr.labrr_product c on c.product_id=b.product_id           
           left join labrr.labrr_product_customize_map e on e.product_customize_map_id=a.product_customize_map_id
           left join  labrr.labrr_product_customize f on f.product_customize_id=e.product_customize_id         
           where a.product_cart_id in ('||p_order_id||')
		   limit 1
             )tab)::text as  products,
			 
			(select array_to_json(array_agg(tab)) from(
			select * from (	
			select a.customer_note,a.note_status,u.user_name,a.note_updated_date 
			from labrr.labrr_product_cart_paydetails a
			left join labrr.labrr_user u on a.note_updated_by=u.user_id
			where a.product_cart_id in ('||p_order_id||') and a.customer_note is not null
			union
			select ua.customer_note,ua.note_status,u.user_name,ua.note_updated_date 
			from labrr.labrr_user_awb_notes_history ua
			left join labrr.labrr_user u on ua.note_updated_by=u.user_id
			where ua.product_cart_id in ('||p_order_id||') and ua.customer_note is not null) row
			order by note_updated_date desc)
			tab)::text::jsonb as customer_note
			
           from labrr.labrr_product_shipment_user ab
           join labrr.labrr_product_cart_paydetails b
           on b.product_cart_id=ab.product_cart_id
		   join labrr.labrr_web_user u 
		   on u.user_guid=b.user_guid
		   join labrr.labrr_product_cart c 
		   on b.product_cart_id=c.product_cart_id
		   left join waf_master.waf_cities ct on ab.shipment_city_id=ct.city_id
		   left join waf_master.waf_states s on ab.shipment_state_id=s.state_id
		   left join waf_master.waf_countries d on ab.shipment_country_id=d.country_id
           where ab.product_cart_id = '||p_order_id||'   
			
          and  b.is_status_flag='||v_status 
          || v_tracking_query ||'
              )row
            )tab
              
	 
	 '
    into v_json;
    
    else
    
    execute '
     select  row_to_json(tab)    from (
     select * from (
     select  distinct  ab.product_cart_id,
          delivery_name,
          --shipment_address1,
          --shipment_address2,
          delivery_address,
          delivery_state,
          ab.pancard as pancard,
          c.donation_cause as donation_cause,
          delivery_city,
          delivery_pincode,
          --u.mobile_no shipment_mobile_no,
		  --u.dob,
		  --''27AADCR8195F1Z0'' as gst_no,
		  total_price ,
         bill_amount,
          billing_name,
          --billing_address1,
          --billing_address2,
          billing_address,
		  billing_district,
		  billing_landmark,
          s.name as billing_state,
          ct.name as billing_city,
          billing_pincode,
          --u.mobile_no billing_mobile_no,
          --u.email_id billing_user_emailid,
          ab.billing_user_emailid as billing_user_emailid,
          ab.billing_mobile_no as billing_mobile_no,
          d.name as billing_country,
          delivery_country,
		  cart_json->''data''->''cartdetails'' as cartdetails,
          --(case when upper(shipping_country)=''NEPAL'' then 300 else 0 end ) as other_charges,
          bill_amount as total_price,
		  --final_payment_json->''data''->>''mer_amount'' as bill_amount1, 
		  --final_payment_json->''data''->>''transaction_txntype'' as payment_mode,
          b.payment_mode as payment_mode,
		  c.delivery_charges,											
          order_status,
          tracking_id, 
          final_payment_json->''data''->>''transaction_timestamp'' as transaction_date,
		  final_payment_json->''data''->>''order_id'' as order_id
           from labrr.labrr_product_shipment_user ab
           join labrr.labrr_product_cart_paydetails b
           on b.product_cart_id=ab.product_cart_id
		   --join labrr.labrr_web_user u 
		   --on u.user_guid=b.user_guid
		   join labrr.labrr_product_cart c 
		   on b.product_cart_id=c.product_cart_id
		   left join waf_master.waf_cities ct on ab.shipment_city_id=ct.city_id
		   left join waf_master.waf_states s on ab.shipment_state_id=s.state_id
		   left join waf_master.waf_countries d on ab.shipment_country_id=d.country_id
           where ab.product_cart_id = '||p_order_id||'   
			
          and  b.is_status_flag='||v_status 
          || v_tracking_query ||'
              )row
            )tab
              
	 
	 '
    into v_json;
    
    
    end if;
   
 	
   
   if v_json is not null 
   then   
   		p_orderjson :=   ('{ "data" : '|| v_json || '}' )::json; --v_json::json;
   else 
   		p_orderjson := ('{ "data" : {}}')::json;
   end if ;
/* 
 exception
     when others then
      	p_productcount := -1;
          p_productjson  := '{"items":[]}';
 */ 
end;

$$;


--
