-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_order_status_listing_24042023(numeric, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone)
-- Type: FUNCTION

-- Name: labrr_get_order_status_listing_24042023(numeric, character varying, numeric, numeric, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_order_status_listing_24042023(p_status numeric, p_searchkeyword character varying, p_pagenumber numeric, p_itemnumber numeric, p_from_date timestamp without time zone, p_to_date timestamp without time zone, OUT p_ordercount numeric, OUT p_orderjson jsonb) RETURNS record
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
	 v_active_flag  varchar(4000):=' '  ;
	 v_is_return numeric;
	 v_status_query varchar(4000) := ' ';
	 
begin
	
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);
        
    -- v_search_text := upper(p_searchkeyword);
    
   
   
	--  p_ordercount := 10 ;-- v_count;
   
   
   if p_status=1 then 
         v_status:=1;
		 v_status_query := 'and b.is_status_flag= 1 ';
		 v_active_flag:='and a.is_deleted=0 and a.is_active=1';
   ELSIF   p_status=0 then 
            v_status:=0;
			v_status_query := 'and b.is_status_flag= 0 ';
			v_active_flag:='and a.is_active=0 and a.is_deleted=0';
   ELSIF   p_status=3 then 
            v_status:=3;
			v_status_query := 'and b.is_status_flag= 3 ';
			v_active_flag:='and a.is_active=0 and a.is_deleted=1';
   ELSIF   p_status=2 then 
   -- else         
     -- v_status:='Pending'
      v_status:=2;
	  v_status_query := 'and b.is_status_flag= 2 ';
	  v_is_return := 0;
  ELSIF   p_status=4 then 
			v_status_query := ' and b.note_status = 1 ';

   end if ;
   
   
   
   if (p_from_date is not null and p_to_date is not null) then
    	
       /* v_from_and_to := ' where  updated_date::date >= $1
        				  and updated_date::date <= $2 ';*/
						  
     v_from_and_to := ' where (updated_date + ''5.50 hour''::interval)::date between $1 and  $2 '  ;            
      v_from_and_to1:= '   and (b.updated_date + ''5.50 hour''::interval)::date >= $1
        				  and (b.updated_date + ''5.50 hour''::interval)::date <= $2 ';
                           
        
	end if;
     
     if (p_from_date is  null and p_to_date is  null) then
      v_filter_str := 'where rno between '||v_fromrownumber||' and '||v_torownumber ;
     end if; 
	
   
  if v_searchkeyword is not null then
     	
          v_searchkeyword:='*' || replace(''||v_searchkeyword||'',' ',':* & *') || ':*';
         /* v_entitysearchquery := ' and (to_tsvector(ab.product_cart_id::text) @@@ to_tsquery('''||v_searchkeyword||''')
                                        OR to_tsvector(delivery_name) @@@ to_tsquery('''||v_searchkeyword||''')
										 OR to_tsvector(order_tracking_id) @@@ to_tsquery('''||v_searchkeyword||''')
										-- OR wu.email_id = '''||p_searchkeyword||''' 
										-- OR wu.mobile_no = '''||p_searchkeyword||'''
										 or ab.billing_mobile_no = '''||p_searchkeyword||'''
										 or ab.billing_user_emailid = '''||p_searchkeyword||'''
										 
										)';*/
   
   end if ;
   
   
  execute ' select 
         count(1) 
           from labrr.labrr_product_shipment_user ab
           join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
           --left join labrr.labrr_web_user wu on b.user_guid= wu.user_guid
           where 1=1 
           '||v_status_query ||'
				'||v_entitysearchquery  ||v_from_and_to1
		
		into p_ordercount
        using (p_from_date + '1 day'::interval)::date,(p_to_date + '1 day'::interval)::date ;
   
   raise notice 'p_ordercount:%', p_ordercount;
   
   
   execute '
      select  array_to_json(array_agg(tab1))    from (
	 select * from (
	 select a.*,products::jsonb,row_number() OVER (ORDER BY updated_date desc ) AS rno
   from (select  distinct  
          ab.product_cart_id,
          ab.delivery_name,
          --shipment_address1,
          --shipment_address2,
          ab.delivery_state,
          ab.delivery_city,
          ab.delivery_pincode,  
		  ab.delivery_mobile_no,
		  c.discount_percent as discount_percentage,		  
		  total_price as bill_amount,
          ab.bill_amount as base_amount,
		  ab.billing_name,
		  ab.billing_address1,
		  ab.billing_address2,
		  ab.billing_state,
		  ab.billing_city,
		  ab.billing_country,
		  ab.billing_pincode,
		  --wu.mobile_no as billing_mobile_no,
          --wc.name as city_name,
          --ws.name as state_name,
          ab.billing_landmark as landmark,
		  --wu.email_id,
		  ab.service_provider,
		  replace(ab.date_of_dispatch::date::text,''-'','''')||''000000'' as date_of_dispatch,
		  ab.aw_bill_number,
		  ab.courier_status,
		  ab.received_by,
		  ab.remarks,
		  c.delivery_charges,
		  c.name_on_card,
		  c.personalised_name,
		  c.personalised_number,
		  c.is_personalised,
		   p.product_name  as  membership_type,
		(select count(1)  from labrr.labrr_product_cart_details
        where is_customize=1 and product_cart_id=ab.product_cart_id
		 and is_active=0) as custmize_flag,
		order_tracking_status,
		ab.updated_date,
		--order_tracking_id,
		ord_tracking_status_value,
          order_status,
          b.status_message,
		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
		  b.order_status as jio_response,
		  b.bank_ref_no as transaction_id,
          b.tracking_id::text as tracking_id,
          ab.billing_name as shipment_name,
          ab.billing_user_emailid as email_id,
          ab.billing_mobile_no as billing_mobile_no,
          --b.updated_date+ ''5.5 hours''::interval as transaction_date,
          b.final_payment_json->''data''->>''trans_date'' as transaction_date,
		  --b.tracking_id::text as transaction_id,
		  --round(ab.taxes/2,2) as CGST,
		  --round(ab.taxes/2,2) as SGST,
		  --round(ab.taxes,2) as GST,
          p.add_info->>''gst'' as GST,
          p.add_info->>''cgst'' as CGST,
          p.add_info->>''sgst'' as SGST,
		  b.customer_note,
		  coalesce (b.note_status,0) as note_status,
		is_status_flag as order_status_value,
          --tracking_id, 
		  --cart_json->''data''->''cartdetails'' as cartdetails,
          final_payment_json->''data''->>''transaction_timestamp'' as transaction_date_1,
          initiated_payment_json->''data''->>''type'' as service_provider,
		(
          select array_to_json(array_agg(tab)) from (
           select 
			a.quantity,
			c.product_id,
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
             e.attribute_name from labrr.labrr_product_attribute_specification d
            join labrr.labrr_product_attribute e on d.product_attribute_id=e.product_attribute_id)row) as attributes
           from labrr.labrr_product_cart_details a
           join labrr.labrr_product_sku b on a.product_sku_id=b.product_sku_id
           join labrr.labrr_product_cart d on a.product_cart_id=d.product_cart_id
           join labrr.labrr_product c on c.product_id=d.product_id 
           left join labrr.labrr_product_customize_map e on e.product_customize_map_id=a.product_customize_map_id
           left join  labrr.labrr_product_customize f on f.product_customize_id=e.product_customize_id
         
           where a.product_cart_id in (ab.product_cart_id)
                '||v_active_flag||   '
              
             )tab)::text as  products
           ---
           from labrr.labrr_product_shipment_user ab
           join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
           join labrr.labrr_product_cart c on b.product_cart_id=c.product_cart_id
		   join labrr.labrr_product p on c.product_id=p.product_id
		   --left join labrr.labrr_web_user wu on c.user_guid= wu.user_guid
		   --join waf_master.waf_cities wc on ab.shipment_city_id = wc.city_id
           --join waf_master.waf_states ws on ab.shipment_state_id =  ws.state_id and ws.country_id = 101
           where 1=1 
           '|| v_status_query ||'
				--'||v_entitysearchquery||'
                
    
			)a
			
			  ' ||v_from_and_to||'
         
           ) tab 
           '||v_filter_str||'
           
           )tab1'
           
           into v_json
		
		using (p_from_date + '1 day'::interval)::date,(p_to_date + '1 day'::interval)::date
	
   ;
   
   raise notice 'v_json:%',v_json;
   
 	
   
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
