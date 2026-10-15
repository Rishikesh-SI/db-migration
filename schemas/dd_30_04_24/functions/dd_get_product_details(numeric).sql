-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_product_details(numeric)
-- Type: FUNCTION

-- Name: dd_get_product_details(numeric); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_product_details(p_productid numeric, OUT p_result numeric, OUT p_productjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_category_query character varying := '';
	v_manufacturer_query character varying := '';
	v_search_query character varying := '';
	v_fromrownumber numeric;
	v_torownumber numeric ;
    v_startend_date_query character varying := '';
    v_search_text character varying := '';
    v_json  jsonb ; 
    v_sku_json  text ; 
    v_product_shipping text ; 
    v_customizejson text ; 
    v_attributejson  text ; 
    v_asset_type_id numeric := 23;
    v_entityjson text ;
    v_imagejson text ; 
    v_versionnumber numeric;
begin
	
    
     	
      select      published_version_number
      into strict v_versionnumber
      from   	  dd.dd_product 
	  where product_id = p_productid ;
     
     select 	  asset_data
     into strict v_json
     from   	  dd.dd_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = p_productid
	 and    	  version_number = v_versionnumber;
    
    
    /* select product_json into v_json
       from dd.dd_product 
	   where product_id = p_productid ;
    */ 
    
  select  '[' || string_agg('{"skudata" : ' || skudata,'},')|| '}]' into v_sku_json
 from (

    select row_to_json(a)::text as skudata -- array_to_json(array_agg(a)) into v_sku_json 
    from (
       select product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata::jsonb, inventory_method_id, 
            product_inventory_id, stock_quantity, (string_agg(attribute1, ','))::jsonb specification,
        	attribute_specification_ids
       from (
       select product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id, 
            product_inventory_id, stock_quantity , attribute_specification_ids,
      		'{"attribute" : [{'|| string_agg('"attribute_specification_id" :'|| product_attribute_specification_id::text ||', 
                                "specification_name" : "'||  specification_name ||'", "attribute_name" : "'|| attribute_name ||'" '
                                                               ,'},{')||'}]}' attribute1 
           
       from 
       (
          select s.product_sku_id, s.product_id, s.sku_code,unnest(s.attribute_specification_ids)specification_id, s.product_price, 
              s.is_customize, s.sku_guid, s.sku_json->'skudata'->>'imagedata' imagedata, s.attribute_specification_ids::text,
            i.inventory_method_id, i.product_inventory_id, i.stock_quantity stock_quantity           
          from dd.dd_product_sku s 
          inner join dd.dd_product_inventory i 
          on (s.product_sku_id = i.product_sku_id)          
          where s.product_id = p_productid  
          and s.is_active = 1
          and s.is_deleted = 0
          and i.is_active = 1
          and i.is_deleted = 0           
       )spc
       inner join dd.dd_product_attribute_specification pas
       on (spc.specification_id = pas.product_attribute_specification_id)
       inner join dd.dd_product_attribute pa
       on (pas.product_attribute_id = pa.product_attribute_id)
       group by product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id, 
            product_inventory_id, stock_quantity, 
           attribute_specification_ids
      
       )abc
       group by product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id, 
            product_inventory_id, stock_quantity, attribute_specification_ids
     )a
     )ab;
    
    v_json := jsonb_set(v_json,'{data,skujson}', v_sku_json::jsonb, true); 
   
    
   select array_to_json(array_agg(ab)) into v_customizejson 
   from (
   select row_to_json(a) as data --'"data" : '|| row_to_json(a) data1
    from (select m.product_id, m.product_customize_map_id, m.customize_price, m.is_added_price,
    	   m.pcm_guid, m.product_customize_id, c.customize_name  
    from dd.dd_product_customize c 
    inner join dd.dd_product_customize_map m
    on (c.product_customize_id = m.product_customize_id)
    where  m.product_id = p_productid 
     )a
     )ab ;
     
     v_json := jsonb_set(v_json,'{data,customizejson}', coalesce(v_customizejson,'null')::jsonb, true);
     
    select array_to_json(array_agg(row)) into v_entityjson
    from(
         select asset_entity_map_id, aem.entity_role_map_id, em.entity_name as name,aem.priority,aem.is_visible, aem.is_linkable ,em.canonical_url
         from dd.dd_asset_entity_map aem
        join dd.dd_entity_role_map erm
        on erm.entity_role_map_id = aem.entity_role_map_id
        join dd.dd_entity_master em
        on em.entity_master_id = erm.entity_master_id
         where aem.asset_id = p_productid
         and aem.asset_type_id = v_asset_type_id
    )row;
    
    v_json := jsonb_set(v_json,'{data,entitydata}', coalesce(v_entityjson,'null')::jsonb, true);
    
    select array_to_json(array_agg(row)) into v_imagejson
    from(
        select row_to_json (a) as data
        from(
        select  m.product_image_map_id, i.* from dd.dd_product_image_map m
        inner join dd.dd_image i 
        on (m.image_id = i.image_id)
        where m.product_id = p_productid
        )a
    )row;  
    
    v_json := jsonb_set(v_json,'{data,imagejson}', coalesce(v_imagejson,'null')::jsonb, true);
    
     select  '[' ||string_agg(data1::text,',') ||']'  ---  array_to_json(array_agg(pas)) 
     into v_attributejson
     from ( 
            select ('{"'||attribute_name ||'" : [{'|| string_agg('"product_attribute_specification_id" :'|| product_attribute_specification_id::text ||',"specification_name" : "' || specification_name ,'"},{')||'"}]}')::json as data1
            from
            (
            select  product_id, unnest(s.attribute_specification_ids) specid 
            from dd.dd_product_sku s
            where product_id = p_productid
            and s.is_active = 1
            and s.is_deleted =1
            )ab
            inner join dd.dd_product_attribute_specification  s 
            on (s.product_attribute_specification_id = ab.specid)
            inner join dd.dd_product_attribute a 
            on (a.product_attribute_id = s.product_attribute_id)
            group by  attribute_name  
          )pas
        ;
    
    -- v_attributejson := ' "attributejson" : '|| v_attributejson ||';
     
     v_json := jsonb_set(v_json,'{data, attributejson}', coalesce(v_attributejson,'null')::jsonb, true);
    
    if v_json is null then 
    	p_productjson := '{}' ;
    else 
    
   	 p_productjson := v_json;       		
    end if; 
    
	p_result := 1;   
/* 
 exception
     when others then
      	p_productcount := -1;
          p_productjson  := '{"items":[]}';
 */ 
end;

$$;


--
