-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_product_listing_r(numeric, numeric, numeric, numeric, numeric[], numeric[], character varying)
-- Type: FUNCTION

-- Name: dd_get_product_listing_r(numeric, numeric, numeric, numeric, numeric[], numeric[], character varying); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_product_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_product_typeid numeric, p_entityrolemapid numeric[], p_any_entityrole_mapid numeric[], p_searchkeyword character varying, OUT p_productcount numeric, OUT p_productjson jsonb) RETURNS record
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
    v_json  jsonb ; 
    v_count_text character varying := '';
    v_count numeric := 0;
	v_asset_type_id numeric := 23 ;
	v_entityrolemap_arr numeric[];
	v_entity_query  character varying := '';
    v_anyentity_query character varying := '';
    v_allentityjson text ; 
begin
	
  --  v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  --  v_torownumber   := (p_pagenumber * p_itemnumber);
    
    if p_page1_size is null 
    then 
          v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          v_torownumber   := (p_pagenumber * p_itemnumber);
    else 
          if (p_pagenumber=1) then 
          		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          else 
          		v_fromrownumber := p_page1_size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
          end if;
   			v_torownumber   := p_page1_size + ( (p_pagenumber-1) * p_itemnumber);
  	end if;
        
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
	
   if  p_any_entityrole_mapid is not null then 
   		
        v_anyentity_query := ' and exists (select 1 from dd.dd_asset_entity_map aem 
										where aem.asset_type_id = $5
										and aem.asset_id = p.product_id
										and aem.entity_role_map_id in (select unnest($7))) ';
                                        
   end if ;
	
   	execute '
    select array_to_json(array_agg(a)) , max(count)
	from(
    select * 
    from (select count(1) over() count, -- row_number() over(order by p.published_date desc) srno,
    			row_number() over(order by p.updated_date desc) srno,
				sl.asset_list_id, p.product_id, sl.asset_id , sl.asset_type_id,
                p.product_name, p.short_desc, p.description, p.product_type_id, p.product_price,
                p.product_code, p.title_alias, sl.asset_title, sl.primary_entity_role_map_id, 
                sl.secondary_entity_role_map_id, total_assets, p.gtin_number, p.manufacturer_part_number,
                sl.image_file_name, sl.image_path, sl.is_published, sl.published_date, p.available_start_date, 
                p.available_end_date, sl.show_copyright, sl.order_number,p.product_guid, p.updated_date,
                sl.show_in_web, sl.show_in_mobile, 
                sl.show_in_app, emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name,
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
                          select product_sku_id, product_id, sku_code, product_price, is_customize, sku_guid, imagedata::jsonb, inventory_method_id, 
                            product_inventory_id, stock_quantity, (''[''|| string_agg(attribute1, '','')||'']'')::jsonb specification,
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
                                    i.inventory_method_id, i.product_inventory_id, i.stock_quantity 
                                          
                                  from dd.dd_product_sku s 
                                  inner join dd.dd_product_inventory i 
                                  on (s.product_sku_id = i.product_sku_id)                                  
                                  where s.product_id = p.product_id	
                                  and s.is_active = 1 
                                  and s.is_deleted = 0
                                  and i.is_active = 1 
                                  and i.is_deleted = 0
                                  and i.stock_quantity <>0
                                  
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
                               order by product_price 
                                   limit 1
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
                            and s.is_active = 1 
                            and s.is_deleted = 0
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
    inner join dd.dd_asset_list sl
    on (p.product_id = sl.asset_id  and sl.asset_type_id = $5)
    join   dd.dd_entity_role_map ermp
      on     (ermp.entity_role_map_id = sl.primary_entity_role_map_id)
    left join   dd.dd_entity_role_map erms
      on     (erms.entity_role_map_id = sl.secondary_entity_role_map_id)
    join   dd.dd_entity_master emp
      on    (emp.entity_master_id = ermp.entity_master_id)
    left join   dd.dd_entity_master ems
      on     ems.entity_master_id = erms.entity_master_id
	where p.is_published = $1  '   
     || v_producttype_query  
	 || v_entity_query
     || v_search_query  
     || v_anyentity_query
     ||')ab
     where srno between $8 and $9
     order by srno
    ) a '
    into v_json, v_count
    using 1 , p_product_typeid, null, v_search_text, v_asset_type_id, v_entityrolemap_arr ,p_any_entityrole_mapid, v_fromrownumber, v_torownumber  ;
	
    raise notice ' 1 : % ' ,v_json ;
   
	 p_productcount := v_count;
     
    select array_to_json(array_agg(row))  into v_allentityjson
    from(
         select distinct aem.entity_role_map_id,
											em.entity_name as name,
											em.priority,aem.is_visible, 
											aem.is_linkable ,em.ent_ordering,em.canonical_url
        from dd.dd_asset_entity_map aem
        join dd.dd_entity_role_map erm
        on erm.entity_role_map_id = aem.entity_role_map_id
        join dd.dd_entity_master em
        on em.entity_master_id = erm.entity_master_id
         where aem.asset_type_id = 23
	   order by em.ent_ordering asc							
    )row;
    
     
    p_productjson := ('{ "data" : '|| v_json::text || '}' )::json;
    
     p_productjson := jsonb_set(p_productjson,'{entitydata}', v_allentityjson::jsonb, true);
    
/* 
 exception
     when others then
      	p_productcount := -1;
          p_productjson  := '{"items":[]}';
 */ 
end;

$_$;


--
