-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_product_cart_checkout_list(character varying)
-- Type: FUNCTION

-- Name: labrr_get_product_cart_checkout_list(character varying); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_product_cart_checkout_list(p_userguid character varying, OUT p_checkoutjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
    v_checkoutjson  jsonb;
    v_productitem	json;
    v_total_price   numeric;
    v_delivery_charges numeric;
    v_payable_amount numeric;
    v_total_product_count  numeric;
    
	
begin
	
    select '{ "data" : ' || row_to_json(ab) || '}' into v_checkoutjson
    from 
    (
    select pc.product_cart_id, pc.user_id, pc.user_emailid, pc.total_select_product, pc.total_price, pc.delivery_charges,
    	   pc.payment_gateway_cancel_url, pc.payment_gateway_redirect_url, pc.payment_gateway_reference_no,
           pc.payment_status, pc.transaction_date, pc.user_cart_guid           
    from labrr.labrr_product_cart pc    
    where pc.user_cart_guid = p_userguid
    and coalesce(pc.payment_gateway_redirect_url,'') not in ('true', 'false')
    and pc.is_active = 1 
    and pc.is_deleted = 0
    )ab;
    
    select array_to_json(array_agg(a))  into v_productitem
     from (select product_cart_details_id,product_cart_id,delivery_charges, product_sku_id, is_customize, cm.product_customize_map_id, customize_text,
				  a.product_id, product_name, product_title, title_alias,  c.customize_name,
				  s.specification_name, specification_code, product_price as  unit_price,quantity, cm.customize_price,
				  (coalesce(cm.customize_price,0) * quantity) total_customize_price,  (product_price * quantity) total_prod_price,
				  (product_price * quantity) + (coalesce(cm.customize_price,0) * quantity)  total_price, stock_quantity
           		 ,
           		(select array_to_json(array_agg(ab)) 
                 from(
                        select  -- m.product_image_map_id, i.*
                     			m.product_image_map_id, coalesce(m.is_cover,0) is_cover, m.is_deleted as is_delete , m.is_active as is_active,        
                                i.image_id, i.content_source_id, i.image_caption, i.image_meta, i.image_desc, i.image_path, 
                                i.copyright_text, i.image_file_name, i.published_version_number, i.image_guid, i.show_copyright, i.content_source_link,
                     			i.order_number, i.title_alias
                     	from labrr.labrr_product_image_map m
                        inner join labrr.labrr_image i                         
                        on (m.image_id = i.image_id)
                        where m.product_id = a.product_id
                        and m.is_active = 1 
                        and m.is_deleted = 0 
                     order by coalesce(m.is_cover,0) desc limit 1
                       
                	)ab
               )imagedata
           		
            from (
                    select product_cart_details_id,cd.product_cart_id, cd.product_sku_id,
                            cd.is_customize, cd.product_customize_map_id, cd.customize_text,
                           sku.product_price , unnest(attribute_specification_ids) attribute_specification_id, cd.quantity, i.stock_quantity,
                            p.product_id, p.product_name, p.product_title, p.title_alias, pc.delivery_charges, 
                           cd.updated_date 
                    from labrr.labrr_product_sku sku
                    inner join labrr.labrr_product_cart_details cd
                    on (cd.product_sku_id = sku.product_sku_id)
                    inner join labrr.labrr_product_cart pc    
                    on (cd.product_cart_id = pc.product_cart_id)  
                    inner join labrr.labrr_product_inventory i
                    on (sku.product_sku_id = i.product_sku_id)
                    inner join labrr.labrr_product p
                    on (sku.product_id = p.product_id)        
                    where pc.user_cart_guid = p_userguid
                    and coalesce(pc.payment_gateway_redirect_url,'') not in ('true', 'false')
                    and cd.is_active = 1 
                	and cd.is_deleted = 0 
                    and sku.is_active = 1 
                	and sku.is_deleted = 0 
                	and i.is_active = 1 
                	and i.is_deleted = 0 
                   order by cd.updated_date  desc
                )a 
                inner join labrr.labrr_product_attribute_specification S 
                on (a.attribute_specification_id = s.product_attribute_specification_id)
                left join labrr.labrr_product_customize_map cm 
                on (cm.product_customize_map_id = a.product_customize_map_id)
                left join labrr.labrr_product_customize c 
           		on (cm.product_customize_id = c.product_customize_id )
          )a;
     
     	select sum((a->>'total_price')::numeric)  total_price, 
          		coalesce((a->>'delivery_charges')::numeric,0)  delivery_charges,
          		 (sum((a->>'total_price')::numeric) + coalesce((a->>'delivery_charges')::numeric,0)) payable_amount, 
                 count(1) total_product_count
        into v_total_price,
    		 v_delivery_charges,
             v_payable_amount,
    		 v_total_product_count 
        from json_array_elements(v_productitem)a
        group by (a->>'delivery_charges')::numeric ;
    	
        v_checkoutjson := jsonb_set(v_checkoutjson, '{data,total_price}', v_total_price::text::jsonb, true);
        v_checkoutjson := jsonb_set(v_checkoutjson, '{data,delivery_charges}', v_delivery_charges::text::jsonb, true);
        v_checkoutjson := jsonb_set(v_checkoutjson, '{data,payable_amount}', v_payable_amount::text::jsonb, true);
        v_checkoutjson := jsonb_set(v_checkoutjson, '{data,total_select_product}', v_total_product_count::text::jsonb, true);
        
    	v_checkoutjson := jsonb_set(v_checkoutjson, '{data,cartdetails}', v_productitem::jsonb, true);
       
        p_checkoutjson := v_checkoutjson ;
        

end;

$$;


--
