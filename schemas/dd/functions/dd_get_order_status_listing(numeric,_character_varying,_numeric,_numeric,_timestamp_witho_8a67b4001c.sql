-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_order_status_listing(numeric, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone)
-- Type: FUNCTION

-- Name: dd_get_order_status_listing(numeric, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_order_status_listing(p_status numeric, p_searchkeyword character varying, p_pagenumber numeric, p_itemnumber numeric, p_from_date timestamp without time zone, p_to_date timestamp without time zone, OUT p_ordercount numeric, OUT p_orderjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
v_json text;
v_status numeric;
v_fromrownumber numeric;
	v_torownumber numeric ;
	v_search_text text;
	
	--v_searchkeyword text;
	v_from_and_to           varchar(200) := ' ';
    	v_from_and_to1           varchar(200) := ' ';
	
	v_searchkeyword varchar(4000) := p_searchkeyword;
	v_entitysearchquery varchar(4000) := ' ';
     v_filter_str text :=' ';
begin
	
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);
        
    -- v_search_text := upper(p_searchkeyword);
    
   
   
	--  p_ordercount := 10 ;-- v_count;
   
   
   if p_status=1 then 
         v_status:=1;
   ELSIF   p_status=0 then 
            v_status:=0;
   ELSIF   p_status=2 then 
   -- else         
     -- v_status:='Pending'
      v_status:=2;
   end if ;
   
   
   
   if (p_from_date is not null and p_to_date is not null) then
    	
        v_from_and_to := ' where  updated_date::date >= $1
        				  and updated_date::date <= $2 ';
                          
      v_from_and_to1:= '   and b.updated_date::date >= $1
        				  and b.updated_date::date <= $2 ';
                           
        
	end if;
     
     if (p_from_date is  null and p_to_date is  null) then
      v_filter_str := 'where rno between '||v_fromrownumber||' and '||v_torownumber ;
     end if; 
	
   
  if v_searchkeyword is not null then
     	
          v_searchkeyword:='*' || replace(''||v_searchkeyword||'',' ',':* & *') || ':*';
          v_entitysearchquery := ' and (to_tsvector(ab.product_cart_id::text) @@@ to_tsquery('''||v_searchkeyword||''')
                                        OR to_tsvector(shipment_name) @@@ to_tsquery('''||v_searchkeyword||''')
										 OR to_tsvector(order_tracking_id) @@@ to_tsquery('''||v_searchkeyword||''')
										
										)';
   
   end if ;
   
   
  execute ' select 
         count(1) 
           from dd.dd_product_shipment_user ab
           join dd.dd_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
         
           where 
		is_status_flag='''||v_status||'''
				'||v_entitysearchquery  ||v_from_and_to1
		
		into p_ordercount
        using p_from_date::date,p_to_date::date ;
   
   
   
   
   execute '
      select  array_to_json(array_agg(tab1))    from (
	 select * from (
	 select a.*,products::jsonb,row_number() OVER (ORDER BY updated_date desc ) AS rno
   from (select  distinct  
          ab.product_cart_id,
          shipment_name,
          shipment_address1,
          shipment_address2,
          shipment_state,
          shipment_city,
          shipment_pincode,  
		 shipment_mobile_no,
          bill_amount,
		  ab.billing_name,
		  ab.billing_address1,
		  ab.billing_address2,
		  ab.billing_state,
		  ab.billing_city,
		  ab.billing_country,
		  ab.billing_pincode,
		  ab.billing_mobile_no,
		  c.delivery_charges,
		(select count(1)  from dd.dd_product_cart_details
        where is_customize=1 and product_cart_id=ab.product_cart_id
		 and is_active=0) as custmize_flag,
		order_tracking_status,
		ab.updated_date,
		order_tracking_id,
		ord_tracking_status_value,
          order_status,
          b.status_message,
		is_status_flag as order_status_value,
          tracking_id, 
          payment_json->''data''->>''trans_date'' as transaction_date,
		(
          select array_to_json(array_agg(tab)) from (
           select 
			a.quantity,
			b.product_id,
            coalesce(a.product_price,0) + coalesce(a.customize_price,0)  as total_price,
            b.product_price as unit_price,
            c.product_name  as  product_name,
             f.customize_name||''(''||a.customize_text||'')'' 
              as  customize_text,
             coalesce(f.custmize_prize,0)  as customize_price,		  
            e.product_customize_map_id,
            f.customize_name,
            ( select array_to_json(array_agg(row)) 
             from ( 
             select  d.specification_name,
             e.attribute_name from dd.dd_product_attribute_specification d
            join dd.dd_product_attribute e on d.product_attribute_id=e.product_attribute_id
            where product_attribute_specification_id =any(attribute_specification_ids))row) as attributes
           from dd.dd_product_cart_details a
           join dd.dd_product_sku b on a.product_sku_id=b.product_sku_id
           join dd.dd_product c on c.product_id=b.product_id 
           join dd.dd_product_cart d on a.product_cart_id=d.product_cart_id
           left join dd.dd_product_customize_map e on e.product_customize_map_id=a.product_customize_map_id
           left join  dd.dd_product_customize f on f.product_customize_id=e.product_customize_id
         
           where a.product_cart_id in (ab.product_cart_id)
                and    a.is_deleted!=1    
                and a.is_deleted=0 and a.is_active=0
              
             )tab)::text as  products
           ---
           from dd.dd_product_shipment_user ab
           join dd.dd_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
           join dd.dd_product_cart c on b.product_cart_id=c.product_cart_id
           where is_status_flag='||v_status||'
				'||v_entitysearchquery||'
                
    
			)a
			
			  ' ||v_from_and_to||'
         
           ) tab 
           '||v_filter_str||'
           
           )tab1'
           
           into v_json
		
		using p_from_date::date,p_to_date::date
	
   ;
   
 	
   
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

$_$;


--
