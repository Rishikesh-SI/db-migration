-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_order_status_listingbk(numeric, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone)
-- Type: FUNCTION

-- Name: dd_get_order_status_listingbk(numeric, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_order_status_listingbk(p_status numeric, p_searchkeyword character varying, p_pagenumber numeric, p_itemnumber numeric, p_from_date timestamp without time zone, p_to_date timestamp without time zone, OUT p_ordercount numeric, OUT p_orderjson jsonb) RETURNS record
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
    	
        v_from_and_to := ' where  updated_date >= $1
        				  and updated_date <= $2 ';
                          
      v_from_and_to1:= '   and b.updated_date >= $1
        				  and b.updated_date <= $2 ';
        
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
        using p_from_date,p_to_date ;
   
   
   
   
   execute '
      select  array_to_json(array_agg(tab1))    from (
	 select * from (
	 select a.*,row_number() OVER (ORDER BY updated_date desc ) AS rno
   from (select 
          ab.product_cart_id,
          shipment_name,
          shipment_address1,
          shipment_address2,
          shipment_state,
          shipment_city,
          shipment_pincode,
          bill_amount,
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
          payment_json->''data''->>''trans_date'' as transaction_date
           ---
           from dd.dd_product_shipment_user ab
           join dd.dd_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
         
           where is_status_flag='||v_status||'
				'||v_entitysearchquery||'
                
    
			)a
			
			  ' ||v_from_and_to||'
         
           ) tab 
            where rno between '||v_fromrownumber||' and '||v_torownumber||'
           
           )tab1'
           
           into v_json
		
		using p_from_date,p_to_date
	
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
