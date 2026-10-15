-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_product_listing(numeric, numeric, numeric[], character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: labrr_get_product_listing(numeric, numeric, numeric[], character varying, numeric, numeric); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_product_listing(p_status numeric, p_product_typeid numeric, p_entityrolemapid numeric[], p_searchkeyword character varying, p_pagenumber numeric, p_itemnumber numeric, OUT p_productcount numeric, OUT p_productjson jsonb) RETURNS record
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
	v_draftproducttypequery  character varying := '';
    v_searchdraftquery character varying := '';
    v_draftproductcount  numeric := 0;
    v_assetdraftidarr       numeric[];
    v_titlealias character varying := '';
    v_assetdraftid          numeric;
    v_productcount numeric := 0;
    v_assetidarr            numeric[];
    v_assetfilterquery      varchar(4000) := ' ';
begin
	
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);
        
    v_search_text := upper(p_searchkeyword);
    
    if p_product_typeid is not null then
    	
		v_producttype_query := ' and p.product_type_id = $2 ' ;
		
		v_draftproducttypequery   := ' and (adv.asset_data->''data''->>''product_type_id'')::numeric =  $2 ';
      		
	end if;
    
 
	if p_searchkeyword is not null then
    	
		v_search_query :=  ' and upper(p.product_name) like ''%''||'||'$4'||'||''%'' ';
        v_searchdraftquery := ' and upper(asset_data->'||''''||'data'||'''->>'||''''||'product_name'||''''||') like ''%''||'||'$4'||'||''%'' ';    		
	end if;	
	   
	if p_entityrolemapid is not null then 
    
		WITH  
		RECURSIVE entityrolemap AS
		(
			SELECT em.entity_master_id 
			FROM    labrr.labrr_entity_master em 
			inner join labrr.labrr_entity_role_map erm on (em.entity_master_id = erm.entity_master_id)
			WHERE  erm.entity_role_map_id in (select unnest(p_entityrolemapid))
			UNION 
			SELECT  q.entity_master_id
			FROM     labrr.labrr_entity_master q
			JOIN    entityrolemap m
			ON      m.entity_master_id = q.parent_entity_master_id
		)
		SELECT array_agg( erm.entity_role_map_id) into v_entityrolemap_arr
		FROM  entityrolemap A
		inner join labrr.labrr_entity_role_map erm on (A.entity_master_id = erm.entity_master_id) ; 
		
		v_entity_query := ' and exists (select 1 from labrr.labrr_asset_entity_map aem 
										where aem.asset_type_id = $5
										and aem.asset_id = adv.product_id
										and aem.entity_role_map_id in (select unnest($6))) ';
                                        
		if p_status = 0 then
         with entitydata(t_json)
                as
				(select (asset_data->'data'->>'entitydata')::json, asset_id, ASSET_TYPE_ID
                 from   labrr.labrr_ASSET_DRAFT AD
                 WHERE  ASSET_TYPE_ID = v_asset_type_id
                 and    version_number = (SELECT MAX(VERSION_NUMBER)
                                          FROM   labrr.labrr_ASSET_DRAFT ADI
                                          WHERE  ADI.ASSET_ID = AD.ASSET_ID
                                          AND    ADI.ASSET_TYPE_ID = AD.ASSET_TYPE_ID)
                 and    (asset_data->'data'->>'entitydata') is not null
                 and    (asset_data->'data'->>'entitydata') like '%[%')
				select array
				(
                    select asset_id
                    from
                    (select obj->>'entity_role_map_id', asset_id, ASSET_TYPE_ID
                     from   entitydata ci, json_array_elements(ci.t_json#>'{}') obj
					 where  (obj->>'entity_role_map_id')::numeric in (select entityid
                                                                     from   unnest(v_entityrolemap_arr) U(entityid))) jd
               )
               into  v_assetidarr;
			   
			END IF;
            
			if exists (select unnest(array[v_assetidarr]))  then
				
				v_assetfilterquery := ' and adv.asset_id in(select asset_id from unnest($9 ) U(asset_id)) ';
            	
            end if;
        
          end if; 
        
        
	
	
	 create temp table if not exists v_productjsondata
	(
        product_id     numeric,
        title          varchar(4000),
        product_guid   varchar(256),
        status         varchar(256),
        entity_id      numeric,
        created_date   timestamp,
        updated_date   timestamp,
        version_number numeric,
        title_alias     varchar(512)
    );
    
	if p_status = 0 then
		
      --  raise notice '1 product ' ; 
        
		execute 'select count(1)
     		     from   labrr.labrr_asset_draft as adv
	             where  adv.asset_type_id = '||v_asset_type_id || '
     	         and    adv.version_number = (select max(ad1.version_number)
                     						  from   labrr.labrr_asset_draft as ad1
                                              where  ad1.asset_id = adv.asset_id
                     						  and    ad1.asset_type_id = adv.asset_type_id)
				and     ((exists (select product_id
                     			  from   labrr.labrr_product a
                     			  where  a.product_id = adv.asset_id
                     			  and is_published = 0
                     			  and is_trashed = 0 ))
						 or (adv.version_number > (select max(published_version_number)
                     							   from   labrr.labrr_product
                     							   where  product_id = adv.asset_id )))'
				||v_draftproducttypequery
				||v_searchdraftquery  
                ||v_assetfilterquery
		into    v_draftproductcount
     	using   p_status, p_product_typeid, null, v_search_text, v_asset_type_id, v_entityrolemap_arr ,v_fromrownumber, v_torownumber,v_assetidarr ;
		
        --raise notice 'count draft %', v_draftproductcount; 
        
     	execute 'select array(select asset_draft_id
                 from   (select row_number() over (order by adv.updated_date desc) slno, asset_draft_id
                     	 from   labrr.labrr_asset_draft as adv
                         where  adv.asset_type_id = '||v_asset_type_id||'
                         and    adv.version_number = (select max(ad1.version_number)
                     								  from   labrr.labrr_asset_draft as ad1
                     								  where  ad1.asset_id = adv.asset_id
                     								  and    ad1.asset_type_id = adv.asset_type_id)
                         and     ((exists (select product_id
                     			  from   labrr.labrr_product a
                     			  where  a.product_id = adv.asset_id
                     			  and is_published = 0
                     			  and is_trashed = 0 ))
						 or (adv.version_number > (select max(published_version_number)
                     							   from   labrr.labrr_product
                     							   where  product_id = adv.asset_id )))  '
				 ||v_searchdraftquery
                 ||v_draftproducttypequery
                 ||v_assetfilterquery
				 ||')tab
				 where  slno between '||'$7'||' and '||'$8'||')'
		into    v_assetdraftidarr
		using  p_status, p_product_typeid, null, v_search_text, v_asset_type_id, v_entityrolemap_arr ,v_fromrownumber, v_torownumber,v_assetidarr ;
		
		foreach v_assetdraftid in array v_assetdraftidarr
		loop
			
			select asset_data->'data'->>'product_title' --, asset_data->'data'->>'entitydata'
			into   v_titlealias --, v_entityjson
      		from   labrr.labrr_asset_draft
      		where  asset_draft_id = v_assetdraftid;
			
			insert into v_productjsondata
			select ad.asset_id, v_titlealias, (asset_data->'data'->>'product_guid'), v.is_published, null::numeric, ad.created_date, ad.updated_date,
				   ad.version_number, (asset_data->'data'->>'slug_url')
			from   labrr.labrr_asset_draft ad
			join   labrr.labrr_product v
			on     ad.asset_id = v.product_id
			where  asset_draft_id = v_assetdraftid;
				
			
		end loop;
		
	elsif p_status = 1 then
		
		execute 'select count(1)
				 from   labrr.labrr_product as adv
                 where  is_published = 1
                 and    is_trashed   = 0
                 and    is_deleted = 0 '  
				 || v_producttype_query  
                 ||v_search_query                 
		into    v_productcount
		using    p_status, p_product_typeid, null, v_search_text ;
		
		  raise notice 'count %', v_productcount; 
          
        execute 'insert into v_productjsondata
				 select product_id, product_title, product_guid, is_published, entity_master_id, created_date, updated_date, published_version_number
                     	, title_alias
				 from   (select row_number() over(order by adv.updated_date desc) slno, product_id, product_title, product_guid, adv.is_published,
                     	       null::numeric entity_master_id, adv.created_date, adv.updated_date, published_version_number, adv.title_alias
                   	     from   labrr.labrr_product as adv                         
                         where  adv.is_published = 1
                         and    adv.is_trashed = 0
                         and    is_deleted = 0 '                       
						 || v_producttype_query  
                         ||v_search_query  
						 || v_entity_query  
                         ||') tab
				 where  slno between '||'$7'||' and '||'$8'
		using   p_status, p_product_typeid, null, v_search_text, v_asset_type_id, v_entityrolemap_arr ,v_fromrownumber, v_torownumber ;
		
	else
		
		execute 'select count(1)
          	     from   labrr.labrr_product adv
				 where  is_published = 0
                 and    is_trashed = 1
                 and    is_deleted = 0 '
				|| v_producttype_query
				||v_search_query				
		into    v_productcount
		using    p_status, p_product_typeid, null, v_search_text ;
		
        raise notice 'count product %', v_productcount; 
        
		execute 'insert into v_productjsondata
				 select product_id, product_title, product_guid, is_published, entity_master_id, created_date, updated_date, published_version_number
                     , title_alias
                 from   (select row_number() over(order by adv.updated_date desc) slno, product_id, product_title, product_guid, adv.is_published,
                     	     	null::numeric entity_master_id, adv.created_date, adv.updated_date, published_version_number, adv.title_alias
                     	 from   labrr.labrr_product as adv                     	 
                     	 where  adv.is_published = 0
                     	 and    adv.is_trashed = 1
                     	 and    adv.is_deleted = 0 '
                     	 
						 || v_producttype_query  
                         ||v_search_query  
						 || v_entity_query  
                         ||') tab
				 where  slno between '||'$7'||' and '||'$8'
		using  p_status, p_product_typeid, null, v_search_text, v_asset_type_id, v_entityrolemap_arr ,v_fromrownumber, v_torownumber;
		
  	end if;
	
  	p_productcount := v_draftproductcount + v_productcount;
	
	-----------------------------------------------------------------------------------------------------------------------------------------------------
    
	
   	execute '
    select array_to_json(array_agg(a)) 
	from(
    select * 
    from (select   -- row_number() over(order by p.published_date desc) srno,
				row_number() over(order by pd.updated_date desc) srno,
    			p.product_id, pd.title product_name, p.short_desc, p.description, p.product_type_id, p.product_code,
    			p.title_alias, pd.title product_title, p.product_price,  
                p.gtin_number, p.manufacturer_part_number, pd.version_number published_version_number,
                p.available_start_date, p.available_end_date, 
				pd.product_guid, p.published_date, p.is_published ,
                (select array_to_json(array_agg(a))
                 from (
                        select I.* from labrr.labrr_image I
                        where exists  ( select 1 from labrr.labrr_product_image_map a
                                        where  a.product_id = p.product_id
                                        and a.image_id = I.image_id 
                                        and a.is_active = 1 
                                        and a.is_deleted = 0 
                                       )                      
                        )a 
                  )imagedata,
				(select array_to_json(array_agg(a))
				 from  (select erm.priority, erm.entity_role_map_id, emi.entity_name
						from   labrr.labrr_entity_master emi
						join   labrr.labrr_entity_role_map erm
						on     erm.entity_master_id = emi.entity_master_id
						join   labrr.labrr_asset_entity_map aem
						on     aem.entity_role_map_id = erm.entity_role_map_id
						and    aem.asset_id = p.product_id
						and    aem.asset_type_id = $5
						
						)a
				) as entitydata,                
                (select array_to_json(array_agg(a))
				 from  (select m.product_customize_map_id, m.product_customize_id, m.product_id, m.customize_price, 
                 		m.is_added_price, c.customize_name, c.description  
                        from labrr.labrr_product_customize_map m
                        inner join labrr.labrr_product_customize c 
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
                                  from labrr.labrr_product_sku s 
                                  inner join labrr.labrr_product_inventory i 
                                  on (s.product_sku_id = i.product_sku_id)                                  
                                  where s.product_id = p.product_id	
                                  
                               )spc
                               inner join labrr.labrr_product_attribute_specification pas
                               on (spc.specification_id = pas.product_attribute_specification_id)
                               inner join labrr.labrr_product_attribute pa
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
                            from labrr.labrr_product_sku s
                            where product_id = p.product_id 
                            )ab
                            inner join labrr.labrr_product_attribute_specification  s 
                            on (s.product_attribute_specification_id = ab.specid)
                            inner join labrr.labrr_product_attribute a 
                            on (a.product_attribute_id = s.product_attribute_id)
                            group by  attribute_name
                     )pas
                   ) attributejson,
                null::jsonb seo
                
    from labrr.labrr_product p 	    
	inner join v_productjsondata pd 
	on (p.product_id = pd.product_id)
	-- where p.is_published = $1
	)ab
    -- where srno between $7 and $8
     order by srno
    ) a '
    into v_json 
    using p_status, p_product_typeid, null, v_search_text, v_asset_type_id, v_entityrolemap_arr ,v_fromrownumber, v_torownumber
	;
	
    raise notice ' 1 : % ' ,v_json ;
   
	
   
   if v_json is not null 
   then   
   		p_productjson := ('{ "data" : '|| v_json || '}' )::json;
   else 
   		p_productjson := ('{ "data" : {}}')::json;
   end if ;
   
   drop table v_productjsondata;
/* 
 exception
     when others then
      	p_productcount := -1;
          p_productjson  := '{"items":[]}';
 */ 
end;

$_$;


--
