-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_product_listing_16052018(numeric, numeric, numeric[], character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: dd_get_product_listing_16052018(numeric, numeric, numeric[], character varying, numeric, numeric); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_product_listing_16052018(p_status numeric, p_product_typeid numeric, p_entityrolemapid numeric[], p_searchkeyword character varying, p_pagenumber numeric, p_itemnumber numeric, OUT p_productcount numeric, OUT p_productjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	v_producttype_query  character varying := '';
	v_product_specification_query character varying := '';
	v_sku_query character varying := '';
	v_category_query character varying := '';
	v_manufacturer_query character varying := '';
	v_search_query character varying := '';
	v_fromrownumber numeric;
	v_torownumber numeric ;
    v_startend_date_query character varying := '';
    v_search_text character varying := '';
    v_json  text ; 
    v_count_text character varying := '';
    v_count numeric := 0;
	v_asset_type_id numeric := 23 ;
	v_entityrolemap_arr numeric[];
	v_entity_query  character varying := '';
begin
	
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);
        
    v_search_text := upper(p_searchkeyword);
    
    if p_product_typeid is not null then
    	
		v_producttype_query := ' and p.product_type_id = $2 ' ;
      		
	end if;
    
 
	if p_searchkeyword is not null then
    	
		v_search_query :=  ' and upper(p.product_name) like ''%''||'||'$4'||'||''%'' ';
      		
	end if;	
	   
	if p_entityrolemapid is not null then 
		WITH  
		RECURSIVE entityrolemap AS
		(
			SELECT em.entity_master_id 
			FROM    dd.dd_entity_master em 
			inner join dd.dd_entity_role_map erm on (em.entity_master_id = erm.entity_master_id)
			WHERE  erm.entity_role_map_id in (select unnest(p_entityrolemapid))
			UNION 
			SELECT  q.entity_master_id
			FROM     dd.dd_entity_master q
			JOIN    entityrolemap m
			ON      m.entity_master_id = q.parent_entity_master_id
		)
		SELECT array_agg( erm.entity_role_map_id) into v_entityrolemap_arr
		FROM  entityrolemap A
		inner join dd.dd_entity_role_map erm on (A.entity_master_id = erm.entity_master_id) ; 
		
		v_entity_query := ' and exists (select 1 from dd.dd_asset_entity_map aem 
										where aem.asset_type_id = $5
										and aem.asset_id = p.product_id
										and aem.entity_role_map_id in (select unnest($6))) ';
		
	end if;
	
	
   	execute '
    select array_to_json(array_agg(a)) , max(count)
	from(
    select * 
    from (select count(1) over() count,  -- row_number() over(order by p.published_date desc) srno,
				row_number() over(order by p.updated_date desc) srno,
    			p.product_id, p.product_name, p.short_desc, p.description, p.product_type_id, p.product_code,
    			p.title_alias, p.product_title, p.product_price,  
                p.gtin_number, p.manufacturer_part_number, p.published_version_number,
                p.available_start_date, p.available_end_date, 
				p.product_guid, p.published_date, p.is_published ,
                (select array_to_json(array_agg(a))
                 from (
                        select I.* from dd.dd_image I
                        where exists  ( select 1 from dd.dd_product_image_map a
                                        where  a.product_id = p.product_id
                                        and a.image_id = I.image_id 
                                        and a.is_active = 1 
                                        and a.is_deleted = 0 
                                       )
                       -- limit 1
                        )a 
                  )imagedata,
				(select array_to_json(array_agg(a))
				 from  (select erm.priority, erm.entity_role_map_id, emi.entity_name
						from   dd.dd_entity_master emi
						join   dd.dd_entity_role_map erm
						on     erm.entity_master_id = emi.entity_master_id
						join   dd.dd_asset_entity_map aem
						on     aem.entity_role_map_id = erm.entity_role_map_id
						and    aem.asset_id = p.product_id
						and    aem.asset_type_id = $5
						
						)a
				) as entitydata,                
                (select array_to_json(array_agg(a))
				 from  (select m.product_customize_map_id, m.product_customize_id, m.product_id, m.customize_price, 
                 		m.is_added_price, c.customize_name, c.description  
                        from dd.dd_product_customize_map m
                        inner join dd.dd_product_customize c 
                        on (m.product_customize_id = c.product_customize_id)
                        where m.product_id = p.product_id						
						)a
				) as customizejson,      
                
                 (select array_to_json(array_agg(a))
				 from  (
                          select product_sku_id, 
						product_id, sku_code, 
						product_price, is_customize, 
						sku_guid, imagedata::jsonb, inventory_method_id, 
                            product_inventory_id, 
							stock_quantity, (''[''|| string_agg(attribute1, '','')||'']'')::jsonb specification,
                            attribute_specification_ids
                          from (
                               select product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id, 
                                    product_inventory_id, stock_quantity , attribute_specification_ids,
                               ''{"attribute" : {''|| string_agg(''"attribute_specification_id" :''|| product_attribute_specification_id::text ||'', 
                                "specification_name" : "''||  specification_name ||''", "attribute_name" : "''|| attribute_name ||''" ''
                                                               ,''","'') ||''}}'' attribute1
                               from 
                               (
                                  select s.product_sku_id, s.product_id, s.sku_code,unnest(s.attribute_specification_ids)specification_id, s.product_price, 
                                      s.is_customize, s.sku_guid, s.sku_json->''skudata''->>''imagedata'' imagedata, s.attribute_specification_ids::varchar,
                                    i.inventory_method_id, i.product_inventory_id, i.stock_quantity stock_quantity                                          
                                  from dd.dd_product_sku s 
                                  inner join dd.dd_product_inventory i 
                                  on (s.product_sku_id = i.product_sku_id)                                  
                                  where s.product_id = p.product_id	
                                  
                               )spc
                               inner join dd.dd_product_attribute_specification pas
                               on (spc.specification_id = pas.product_attribute_specification_id)
                               inner join dd.dd_product_attribute pa
                               on (pas.product_attribute_id = pa.product_attribute_id)
                               group by product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id, 
                                    product_inventory_id, stock_quantity, pa.attribute_name, attribute_specification_ids
                               )abc
                               group by product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata, inventory_method_id, 
                                    product_inventory_id, stock_quantity, attribute_specification_ids                     						
                     )a
                    ) as skujson,
                
                (select (''['' ||string_agg(data::text,'','') ||'']'')::json  --array_to_json(array_agg(pas))
                     from ( 
                            select (''{"''||attribute_name ||''" : [{''|| string_agg(''"product_attribute_specification_id" :''|| product_attribute_specification_id::text ||'',"specification_name" : "'' || specification_name ,''"},{'')||''"}]}'') as data
                            from
                            (
                            select  product_id, unnest(s.attribute_specification_ids) specid 
                            from dd.dd_product_sku s
                            where product_id = p.product_id 
                            )ab
                            inner join dd.dd_product_attribute_specification  s 
                            on (s.product_attribute_specification_id = ab.specid)
                            inner join dd.dd_product_attribute a 
                            on (a.product_attribute_id = s.product_attribute_id)
                            group by  attribute_name
                     )pas
                   ) attributejson,
                null::jsonb seo
                
    from dd.dd_product p 	    
	where p.is_published = $1  '   
     || v_producttype_query    
    -- || v_sku_query
	 || v_entity_query
    -- || v_category_query
   --  || v_manufacturer_query
     || v_search_query       
     ||')ab
     where srno between $7 and $8
     order by srno
    ) a '
    into v_json, v_count
    using p_status, p_product_typeid, null, v_search_text, v_asset_type_id, v_entityrolemap_arr ,v_fromrownumber, v_torownumber  ;
	
    raise notice ' 1 : % ' ,v_json ;
   
	 p_productcount := v_count;
   
   if v_json is not null 
   then   
   		p_productjson := ('{ "data" : '|| v_json || '}' )::json;
   else 
   		p_productjson := ('{ "data" : {}}')::json;
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
