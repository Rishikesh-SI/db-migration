-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_del_product_fromcart(jsonb)
-- Type: FUNCTION

-- Name: dd_get_del_product_fromcart(jsonb); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_del_product_fromcart(p_remove_deljson jsonb, OUT p_result numeric, OUT p_checkoutjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare	
	v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
    v_json jsonb;
    v_total_price  numeric;
    v_delivery_charges	numeric;
    v_payable_amount	numeric;
    v_total_product_count numeric; 
	v_checkoutjson text ;
    v_productcart_detailsid numeric;
    v_opttypeid  numeric;
    v_quantity  numeric;
    v_product_cart_id  numeric;
begin
	
   select p_remove_deljson->'data'->>'product_cart_details_id',
    	  p_remove_deljson->'data'->>'option_typeid',
    	  p_remove_deljson->'data'->>'quantity'
    into  v_productcart_detailsid,
    	  v_opttypeid, 
          v_quantity;
    
    select product_cart_id into v_product_cart_id 
    from  dd.dd_product_cart_details 
    where product_cart_details_id = v_productcart_detailsid ;
                                    
    if v_opttypeid = 1 then
    	
        update dd.dd_product_cart_details 
        set is_active = 0, is_deleted = 1, updated_date = v_currenttimestamp
        where product_cart_details_id = v_productcart_detailsid
        and is_active = 1 
        and is_deleted = 0 ;
     
    elsif   v_opttypeid = 2 then
    
    	raise notice 'in ' ; 
        
     update dd.dd_product_cart_details
       set quantity = v_quantity, 
       	   product_price = a.product_price, 
           customize_price = a.customize_price,
           updated_date = v_currenttimestamp 
       from
       (   select cd.product_cart_details_id, cd.product_sku_id, (v_quantity * s.product_price) product_price,
                   -- (v_quantity * (s.product_price + coalesce(customize_price,0))) total_price ,
                    (v_quantity * coalesce(cm.customize_price,0)) customize_price
           from dd.dd_product_cart_details cd 
           inner join dd.dd_product_sku s 
           on (cd.product_sku_id = s.product_sku_id)
           left join dd.dd_product_customize_map cm 
           on (cm.product_customize_map_id = cd.product_customize_map_id)
           left join dd.dd_product_customize c 
           on (cm.product_customize_id = c.product_customize_id)
           where product_cart_details_id = v_productcart_detailsid
           and cd.is_active = 1 
           and cd.is_deleted = 0
       )a
        where dd_product_cart_details.product_cart_details_id = a.product_cart_details_id 
        and is_active = 1 
        and is_deleted = 0;
        
        SELECT  row_to_json(ab) into v_json
		FROM (select product_cart_details_id, product_cart_id, product_sku_id, is_customize, c.product_customize_id, customize_text,
				  a.product_id, product_name, product_title, title_alias,  c.customize_name,
				  s.specification_name, specification_code, product_price as  unit_price,quantity, cm.customize_price,
				  (coalesce(cm.customize_price,0) * quantity) total_customize_price,  (product_price * quantity) total_prod_price,
				  (product_price * quantity) + (coalesce(cm.customize_price,0) * quantity)  total_price, stock_quantity ,
           		(select array_to_json(array_agg(ab)) 
                  from (
                                select  m.product_image_map_id, i.* from dd.dd_product_image_map m
                                inner join dd.dd_image i 
                                on (m.image_id = i.image_id)
                                where m.product_id = a.product_id
                       			and m.is_active = 1
                      			and m.is_deleted = 0
                          
                	)ab
               )imagedata
           		
            from (
                    select cd.product_cart_details_id,cd.product_cart_id, cd.product_sku_id,
                            cd.is_customize, cd.product_customize_map_id, cd.customize_text,
                           sku.product_price , unnest(attribute_specification_ids) attribute_specification_id, cd.quantity, i.stock_quantity,
                            p.product_id, p.product_name, p.product_title, p.title_alias, pc.delivery_charges, 
                           cd.updated_date 
                    from dd.dd_product_sku sku
                    inner join dd.dd_product_cart_details cd
                    on (cd.product_sku_id = sku.product_sku_id)
                    inner join dd.dd_product_cart pc    
                    on (cd.product_cart_id = pc.product_cart_id)  
                    inner join dd.dd_product_inventory i
                    on (sku.product_sku_id = i.product_sku_id)
                    inner join dd.dd_product p
                    on (sku.product_id = p.product_id)        
                    where cd.product_cart_details_id = v_productcart_detailsid
                    and coalesce(pc.payment_gateway_redirect_url,'') not in ('true', 'false')
                    and cd.is_active = 1 
                    and cd.is_deleted = 0  
                  
                )a 
                inner join dd.dd_product_attribute_specification S 
                on (a.attribute_specification_id = s.product_attribute_specification_id)
                left join dd.dd_product_customize_map cm 
                on (cm.product_customize_map_id = a.product_customize_map_id)
                left join dd.dd_product_customize c 
           		on (cm.product_customize_id = c.product_customize_id) 
     	)ab ; 
                  
      
    end if ;  
        
        select sum(product_price + coalesce(customize_price,0))  total_price, 
          	  -- (case when sum(product_price + coalesce(customize_price,0)) >= 500 then 0 else 50 end)  delivery_charges,
          	  --  sum(product_price + coalesce(customize_price,0))
        	  --	+ (case when sum(product_price + coalesce(customize_price,0)) >= 500 then 0 else 60 end)  payable_amount, 
                 count(1) total_product_count
        into v_total_price,
    		-- v_delivery_charges,
            -- v_payable_amount,
    		 v_total_product_count              
        from dd.dd_product_cart_details a         
        where a.product_cart_id =  v_product_cart_id
        and a.is_active = 1 
        and a.is_deleted = 0 ;
        
       v_delivery_charges = (case
                            	  when  v_total_price >= 500 then 0
                            	  else 60 
                             end) ;
                            
       v_payable_amount := coalesce(v_total_price,0)  +  v_delivery_charges;
       
        update dd.dd_product_cart 
        set total_select_product = v_total_product_count,
        	total_price = v_total_price,
            delivery_charges =   v_delivery_charges         
        where product_cart_id = v_product_cart_id
        and is_active = 1 
        and is_deleted = 0 ;
        
      v_checkoutjson =  '{ "data" : { "total_price": '  || coalesce(v_total_price,0) 	
                         || ', "delivery_charges" : '|| coalesce(v_delivery_charges,0)
                         || ', "total_select_product" :' || coalesce(v_total_product_count,0)
                         || ', "payable_amount" : ' || coalesce(v_payable_amount,0)
                         || ', "cartdetails" : ' ||coalesce(v_json,'null') || '}}'
         ;
        
       raise notice 'a : %', v_checkoutjson;
       p_checkoutjson := v_checkoutjson::jsonb;   
      
    
	p_result:=1;

exception
	     when others then
    	 p_result := -1;
         
end ;

$$;


--
