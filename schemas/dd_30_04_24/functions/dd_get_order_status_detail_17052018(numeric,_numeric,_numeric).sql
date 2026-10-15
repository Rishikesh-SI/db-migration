-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_order_status_detail_17052018(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: dd_get_order_status_detail_17052018(numeric, numeric, numeric); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_order_status_detail_17052018(p_status numeric, p_order_id numeric, p_tracking_id numeric, OUT p_orderjson jsonb) RETURNS jsonb
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
    v_active_flag  varchar(4000)  ;
begin
 -- v_search_text := upper(p_searchkeyword);
    
   
   
	--  p_ordercount := 10 ;-- v_count;
   
   
   if p_status=1 then 
         v_status:=1;
         v_active_flag:='and a.is_deleted=0 and a.is_active=0';
   ELSIF   p_status=0 then 
            v_status:=0;
            v_active_flag:='and a.is_active=1 and a.is_deleted=0';
   
   ELSIF   p_status=2 then 
   -- else         
     -- v_status:='Pending'
      v_status:=2;
   end if ;
   
  --if v_searchkeyword is not null then
     	
        --  v_searchkeyword:='*' || replace(''||v_searchkeyword||'',' ',':* & *') || ':*';
       --   v_entitysearchquery := ' and (to_tsvector(ab.product_cart_id::text) @@@ to_tsquery('''||v_searchkeyword||''')
                                    --    OR to_tsvector(shipment_name) @@@ to_tsquery('''||v_searchkeyword||'''))';
   
  -- end if ;

   execute '
     select  row_to_json(tab)    from (
     
     select   ab.product_cart_id,
          shipment_name,
          shipment_address1,
          shipment_address2,
          shipment_state,
          shipment_city,
          shipment_pincode,
          shipment_mobile_no,
          billing_name,
          billing_address1,
          billing_address2,
          billing_state,
          billing_city,
          billing_pincode,
          billing_mobile_no,
          billing_user_emailid,
          billing_country,
          shipping_country,
          bill_amount,
		  b.payment_mode,
	  	 
		  c.delivery_charges,											
          order_status,
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
             f.customize_name||'' (''||a.customize_text||'')'' 
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
             '||v_active_flag||   '
              
             )tab) as  products
      
           from dd.dd_product_shipment_user ab
           join dd.dd_product_cart_paydetails b
           on b.product_cart_id=ab.product_cart_id
		   join dd.dd_product_cart c on b.product_cart_id=c.product_cart_id
           where ab.product_cart_id='||p_order_id||'
		    and b.tracking_id='||p_tracking_id||'
			
          and  b.is_status_flag='||v_status ||'
            )tab
	 
	 '
    into v_json
	
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

$$;


--
