-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_app_page_data_rod(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_app_page_data_rod(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_app_page_data_rod(p_schema_prefix character varying, p_input_json jsonb, OUT p_result numeric, OUT p_page_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

/*
SELECT * from siwaf._get_app_page_data_r(
	'labstmp',-- <p_schema_prefix character varying>, 
	'{
  "url": "apphomepage",
  "is_amp": "0"
}'-- <p_input_json jsonb>
);
*/
declare
	
     v_url text;
     v_is_amp numeric;
	 v_require_widget_data numeric;
     v_page_id numeric;
     v_slash_count numeric;
     v_asset_alias text;
     v_asset_id numeric;
     v_asset_type_id numeric;
     v_new_asset_alias text;
     v_redirect_url text;
     v_asset_language_curl text;
     v_asset_primary_entity_curl text;
     v_asset_secondary_entity_curl text;
     v_page_json jsonb := '{"title": null,"asset_type_id": null,"language_id": null,"other_entities": null,"html": null,
     					"language_name": null,"page_id": null,"template_id": null,"required_entities": null,
						"metainfo": null,"widgets": null,"redirect_url": null,"widgets_data": null}'::jsonb;
	v_page_count numeric;
     v_parent_page_id numeric;
     v_page_language_curl text;
     v_page_language_ermid numeric;
     v_page_language_ename text;
     v_page_required_entities text;
     v_page_other_entities text;
	v_page_exclude_entities text;
     v_template_id numeric;
     v_template_html text;
     v_widget_json jsonb;
	v_json json;
	v_guid text;
	v_widget_id numeric;
	v_component_id numeric;
	v_other_entities text;
	v_exclude_entities text;
	v_required_entities text;
	v_item_count numeric;
	v_other_entities_arr numeric[];
	v_exclude_entities_arr numeric[];
	v_required_entities_arr numeric[];
	v_page_number numeric := 1;
	v_asset_count numeric;
	v_asset_json jsonb;
	v_result numeric;
	v_widget_data_json jsonb;
	v_widget_data_arr jsonb[];
	v_widget_data jsonb;
	v_widget_data_abc jsonb;
    v_widget_json1 jsonb; 
	
	v_dependencies jsonb;
    v_dep_json jsonb;

v_dep_guid text;
v_dep_widget_id numeric;
v_dep_component_id numeric;
v_dep_other_entities text;
v_exclude_dep_entities text;
v_required_dep_entities text;
v_item_dep_count numeric;

v_dep_other_entities_arr numeric[];
v_dep_exclude_entities_arr numeric[];
v_dep_required_entities_arr numeric[];

v_dep_asset_count numeric;
v_dep_asset_json  jsonb;
v_dep_widget_data_json jsonb;
v_dep_widget_data_arr  jsonb[];
v_dep_widget_data jsonb;

begin
     
     set enable_seqscan = false;
     
     select coalesce(substring(lower(p_input_json->>'url'),'(.*[^\/\s])'),''), 
	 coalesce((p_input_json->>'is_amp')::numeric,0) ,
	 		 coalesce((p_input_json->>'require_widget_data')::numeric,0)
     into v_url, v_is_amp, v_require_widget_data;
     
	 --v_require_widget_data := 1;
	 
	--raise notice 'v_url : %', v_url;
	--raise notice 'v_is_amp : %', v_is_amp;
	
	
	
     execute 'select page_id from '||$1||'.'||$1||'_page
     		where alias = $2
               and is_amp = $3'
     into v_page_id
     using p_schema_prefix, v_url, v_is_amp;
     
	--raise notice 'v_page_id : %', v_page_id;
	--select 1/0;
     if v_page_id is null then
     	
          execute 'select page_id from '||$1||'.'||$1||'_page
          		where $2 ~ concat(''^'',alias,''$'')
                    and length(alias) <> 0
                    and is_amp = $3'
     	into v_page_id
     	using p_schema_prefix, v_url, v_is_amp;
          
     end if;
     
	--raise notice 'v_page_id : %', v_page_id;
	
     if v_page_id is null then
     	
          v_slash_count := regexp_count(v_url,'/') + 1;
          v_asset_alias := split_part(v_url,'/',v_slash_count::int);
          
		--raise notice 'v_slash_count : %', v_slash_count;
		--raise notice 'v_asset_alias : %', v_asset_alias;
		
						
          execute 'select asset_id, asset_type_id
				from '||$1||'.'||$1||'_redirect
				where lower(old_alias) = $2'
          into v_asset_id, v_asset_type_id
          using p_schema_prefix, v_asset_alias;
          
		--raise notice 'v_asset_id : %', v_asset_id;
		--raise notice 'v_asset_type_id : %', v_asset_type_id;
		
          execute 'select new_alias from '||$1||'.'||$1||'_redirect r
          		where r.asset_id = $2
                    and r.asset_type_id = $3
                    and r.alias_number = (select max(r1.alias_number)
									from '||$1||'.'||$1||'_redirect r1
                    					where r1.asset_id = r.asset_id
                                             and r1.asset_type_id = r.asset_type_id)'
		into v_new_asset_alias
          using p_schema_prefix, v_asset_id, v_asset_type_id;
          
		--raise notice 'v_new_asset_alias : %', v_new_asset_alias;
		
          if v_new_asset_alias is not null then
          	
               v_redirect_url := v_new_asset_alias;
               
			--raise notice 'v_redirect_url : %', v_redirect_url;
			
               execute 'select em.canonical_url
               		from '||$1||'.'||$1||'_asset_entity_map aem
                         join '||$1||'.'||$1||'_entity_role_map erm
                         on erm.entity_role_map_id = aem.entity_role_map_id
                         join '||$1||'.'||$1||'_entity_category ec
                         on ec.entity_role_id = erm.entity_role_id
                         join '||$1||'.'||$1||'_entity_master em
                         on em.entity_master_id  = erm.entity_master_id
                         where aem.asset_id = $2
                         and aem.asset_type_id  = $3
                         and ec.category_name = ''Language'''
     		into v_asset_language_curl
     		using p_schema_prefix, v_asset_id, v_asset_type_id;
               
			--raise notice 'v_asset_language_curl : %', v_asset_language_curl;
			
               execute 'select em.canonical_url
               		from '||$1||'.'||$1||'_asset_list al
                         join '||$1||'.'||$1||'_entity_role_map erm
                         on erm.entity_role_map_id = al.primary_entity_role_map_id
                         join '||$1||'.'||$1||'_entity_master em
                         on em.entity_master_id = erm.entity_master_id
                         where al.asset_id = $2
                         and al.asset_type_id  = $3'
     		into v_asset_primary_entity_curl
     		using p_schema_prefix, v_asset_id, v_asset_type_id;
               
			--raise notice 'v_asset_primary_entity_curl : %', v_asset_primary_entity_curl;
			
               execute 'select em.canonical_url
               		from '||$1||'.'||$1||'_asset_list al
                         join '||$1||'.'||$1||'_entity_role_map erm
                         on erm.entity_role_map_id = al.secondary_entity_role_map_id
                         join '||$1||'.'||$1||'_entity_master em
                         on em.entity_master_id = erm.entity_master_id
                         where al.asset_id = $2
                         and al.asset_type_id  = $3'
     		into v_asset_secondary_entity_curl
     		using p_schema_prefix, v_asset_id, v_asset_type_id;
               
			--raise notice 'v_asset_secondary_entity_curl : %', v_asset_secondary_entity_curl;
			
               v_redirect_url := coalesce(v_asset_language_curl,'')||v_asset_primary_entity_curl||v_asset_secondary_entity_curl||'/'||v_redirect_url;
               v_page_json := jsonb_set(v_page_json,'{redirect_url}',('"'||v_redirect_url||'"')::jsonb,false);
			
			--raise notice 'v_redirect_url : %', v_redirect_url;
			--raise notice 'v_page_json : %', v_page_json;
               
		else
          	
               execute 'select asset_type_id
					from '||$1||'.'||$1||'_asset_list
               		where lower(title_alias) = $2
                    	and asset_type_id in(1,2,4,5)
                    	and is_published = 1'
     		into v_asset_type_id
     		using p_schema_prefix, v_asset_alias;
          	
			--raise notice 'v_asset_type_id : %', v_asset_type_id;
			
          	if v_asset_type_id is not null then
               	
                    execute 'select count(1)
						from '||$1||'.'||$1||'_page
                    		where asset_type_id = $2
                              and is_amp = $3'
               	into v_page_count
               	using p_schema_prefix, v_asset_type_id, v_is_amp;
                    
				--raise notice 'v_page_count : %', v_page_count;
				
                    if v_page_count = 1 then
               		
                         execute 'select page_id
							from '||$1||'.'||$1||'_page
                         		where asset_type_id = $2
                                   and is_amp = $3'
               		into v_page_id
               		using p_schema_prefix, v_asset_type_id, v_is_amp;
                         
					--raise notice 'v_page_id : %', v_page_id;
					
				elsif v_page_count > 1 then
                    	
                         while v_slash_count >= 1 and v_page_id is null
                         loop
                         	
						select substring(v_url from 1 for (char_length(v_url) - char_length(split_part(v_url,'/',v_slash_count::int))))
                              into v_url;
                              
					--	--raise notice 'v_url : %', v_url;
						
                              execute 'select page_id
								from '||$1||'.'||$1||'_page
                              		where alias = $2
                                        and is_amp = $3'
     					into v_parent_page_id
     					using p_schema_prefix, v_url, v_is_amp;
                              
						--raise notice 'v_parent_page_id : %', v_parent_page_id;
						
     					if v_page_id is null then
     						
          					execute 'select page_id
									from '||$1||'.'||$1||'_page
          							where $2 ~ concat(''^'',alias,''$'')
                    					and length(alias) <> 0
                                             and is_amp = $3'
     						into v_parent_page_id
     						using p_schema_prefix, v_url, v_is_amp;
          					
							--raise notice 'v_parent_page_id : %', v_parent_page_id;
							
     					end if;
                              
                              if v_parent_page_id is null then
                              
                              	execute 'select page_id
									from '||$1||'.'||$1||'_page
                                   		where parent_id = $2
                                        	and asset_type_id = $3
                                             and is_amp = $4'
							into v_page_id
                              	using p_schema_prefix, v_parent_page_id, v_asset_type_id, v_is_amp;
                                   
							--raise notice 'v_page_id : %', v_page_id;
							
						end if;
                              
                              v_slash_count := regexp_count(v_url,'/');
						
						--raise notice 'v_slash_count : %', v_slash_count;
                              
                         end loop;
                         
               	end if;
                    
          	end if;
               
          end if;
          
     end if;
     
	--raise notice 'v_page_id : %', v_page_id;
	-- select 1/0;
	
     if v_page_id is not null then
     	
          execute 'select em.canonical_url, erm.entity_role_map_id, em.entity_name
     			from '||$1||'.'||$1||'_entity_master em
               	join '||$1||'.'||$1||'_entity_role_map erm
               	on erm.entity_master_id = em.entity_master_id
               	join '||$1||'.'||$1||'_entity_category ec
               	on ec.entity_role_id = erm.entity_role_id
               	where ec.category_name = ''Language''
				and em.canonical_url = (''/''||split_part($2,''/'',1))'
     	into v_page_language_curl, v_page_language_ermid, v_page_language_ename
     	using p_schema_prefix, v_url;
     	
		--raise notice 'v_page_language_curl : %', v_page_language_curl;
		--raise notice 'v_page_language_ermid : %', v_page_language_ermid;
		--raise notice 'v_page_language_ename : %', v_page_language_ename;
		
     	if v_page_language_ermid is null then
     		
               execute 'select em.canonical_url, erm.entity_role_map_id, em.entity_name
           			from '||$1||'.'||$1||'_entity_master em
               		join '||$1||'.'||$1||'_entity_role_map erm
               		on erm.entity_master_id = em.entity_master_id
               		join '||$1||'.'||$1||'_entity_category ec
               		on ec.entity_role_id = erm.entity_role_id
               		where ec.category_name = ''Language''
                    	and em.canonical_url is null'
			into v_page_language_curl, v_page_language_ermid, v_page_language_ename
          	using p_schema_prefix;
          	
			--raise notice 'v_page_language_curl : %', v_page_language_curl;
			--raise notice 'v_page_language_ermid : %', v_page_language_ermid;
			--raise notice 'v_page_language_ename : %', v_page_language_ename;
			
     	end if;
     	
     	execute 'select string_agg(entity_role_map_id::text,'','')
     			from '||$1||'.'||$1||'_asset_entity_map
               	where asset_id = $2
               	and asset_type_id = 11
               	and is_required = 1'
		into v_page_required_entities
		using p_schema_prefix, v_page_id;
     	
		--raise notice 'v_page_required_entities : %', v_page_required_entities;
		
     	execute 'select string_agg(entity_role_map_id::text,'','')
     			from '||$1||'.'||$1||'_asset_entity_map
               	where asset_id = $2
               	and asset_type_id = 11
               	and (is_required = 0 or is_required is null)'
		into v_page_other_entities
		using p_schema_prefix, v_page_id;
		
		--raise notice 'v_page_other_entities : %', v_page_other_entities;
		
		execute 'select string_agg(entity_role_map_id::text,'','')
     			from '||$1||'.'||$1||'_asset_entity_map
               	where asset_id = $2
               	and asset_type_id = 11
               	and is_required = 2'
		into v_page_exclude_entities
		using p_schema_prefix, v_page_id;
     	
		--raise notice 'v_page_exclude_entities : %', v_page_exclude_entities;
		
    		execute 'select pt.template_id, pt.template_html
     			from '||$1||'.'||$1||'_template t
               	join '||$1||'.'||$1||'_template pt
               	on pt.template_id = t.parent_id
               	where t.page_id = $2'
		into v_template_id, v_template_html
     	using p_schema_prefix, v_page_id;
     	
		--raise notice 'v_template_id : % %', v_template_id,v_page_id;
		--raise notice 'v_template_html : %', v_template_html;
		
     	execute 'select row_to_json(row)::jsonb
     			from (select p.page_id, p.title_app as title, p.asset_type_id, $3 as language_id, $4 as language_name,
                    			sd.meta_info, $5 as required_entities, $6 as other_entities, $7 as exclude_entities,
							$8 as template_id, $9 as redirect_url, null as widgets, null as widgets_data
						from '||$1||'.'||$1||'_page p
     					left join '||$1||'.'||$1||'_seo_data sd
     					on sd.asset_id = p.page_id
     					and sd.asset_type_id = 11
     					where p.page_id = $2
					) row'
     	into v_page_json
     	using p_schema_prefix, v_page_id, v_page_language_ermid, v_page_language_ename, v_page_required_entities,
          		v_page_other_entities, v_page_exclude_entities, v_template_id, v_redirect_url;
          
		--raise notice 'v_page_json : %', v_page_json;
		
          execute 'select (''[''||string_agg(row_to_json(row)::text,'','')||'']'')::jsonb
          		from (select tcm.template_component_map_id as widget_id, tcm.display_title as title,
							tcm.component_id, tcm.tcmap_guid as guid, tcm.fetch_from, tcm.meta_info, tab.slno,tcm.parent_tcmap_id,
                                   (select string_agg(entity_role_map_id::text,'','')
                                   	from '||$1||'.'||$1||'_asset_entity_map aem
                                        where aem.asset_id = tcm.template_component_map_id
                                        and aem.asset_type_id = 13
                                        and aem.is_required = 1
							) as required_entities,
                              	(select string_agg(entity_role_map_id::text,'','')
                                   	from '||$1||'.'||$1||'_asset_entity_map aem
                                        where aem.asset_id = tcm.template_component_map_id
                                        and aem.asset_type_id = 13
                                        and (aem.is_required = 0 or aem.is_required is null)
							) as other_entities,
							(select string_agg(entity_role_map_id::text,'','')
                                   	from '||$1||'.'||$1||'_asset_entity_map aem
                                        where aem.asset_id = tcm.template_component_map_id
                                        and aem.asset_type_id = 13
                                        and aem.is_required = 2
							) as exclude_entities,
                                 coalesce(  (select array_to_json(array_agg(a))
                                   	from (select ctcm.template_component_map_id as widget_id,
											ctcm.display_title as title, ctcm.component_id,
											ctcm.tcmap_guid as guid, ctcm.fetch_from, ctcm.meta_info,
                                                       (select string_agg(entity_role_map_id::text,'','')
                                                       	from '||$1||'.'||$1||'_asset_entity_map aem
                                                            where aem.asset_id = ctcm.template_component_map_id
                                                            and aem.asset_type_id = 13
                                                            and aem.is_required = 1
											) as required_entities,
                              				(select string_agg(entity_role_map_id::text,'','')
                                   					from '||$1||'.'||$1||'_asset_entity_map aem
                                        				where aem.asset_id = ctcm.template_component_map_id
                                        				and aem.asset_type_id = 13
                                        				and (aem.is_required = 0 or aem.is_required is null)
											) as other_entities,
											(select string_agg(entity_role_map_id::text,'','')
                                   					from '||$1||'.'||$1||'_asset_entity_map aem
                                        				where aem.asset_id = ctcm.template_component_map_id
                                        				and aem.asset_type_id = 13
                                        				and aem.is_required = 2
											) as exclude_entities
                                        		from '||$1||'.'||$1||'_template_component_map ctcm
                                                  where ctcm.parent_tcmap_id = tcm.template_component_map_id
                                                  and ctcm.is_active = 1
                              				and ctcm.is_deleted = 0
									) a
							)::jsonb,''[]'') as dependencies
						from '||$1||'.'||$1||'_template_component_map tcm
                              left join (select a[1] as guid, row_number() over() as slno
                              			from (select regexp_matches($3,''([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})'',''g'') as a
										) as b
								) tab
						on tab.guid = tcm.tcmap_guid
                    		where tcm.template_id = $2
                    		and tcm.parent_tcmap_id is null
                              and tcm.is_active = 1
                              and tcm.is_deleted = 0
                    	) as row'
		into v_widget_json
          using p_schema_prefix, v_template_id, v_template_html;
		  
		  
		
		--raise notice 'v_widget_json : %', v_widget_json;
		
          if v_widget_json is not null then
          	

					
               v_page_json := jsonb_set(v_page_json,'{widgets}',v_widget_json,false);
               
			   
			   
			if v_require_widget_data = 1 then
				
				for v_json in(select * from json_array_elements(v_widget_json::json))
			loop
				
				-- --raise notice 'v_json : %', v_json;
				 v_widget_data_json := null;
				 v_dep_widget_data_arr :=null;
				
				select  v_json->>'guid', v_json->>'widget_id', v_json->>'component_id', v_json->>'other_entities',
						v_json->>'exclude_entities', v_json->>'required_entities', v_json->'meta_info'->>'sm_row',
						v_json->'dependencies'
				into v_guid, v_widget_id, v_component_id, v_other_entities, v_exclude_entities, v_required_entities,
					v_item_count ,v_dependencies;

				raise notice '% dep',v_dependencies;
				
				v_other_entities_arr := string_to_array(v_other_entities,',');
				v_exclude_entities_arr := string_to_array(v_exclude_entities,',');
				v_required_entities_arr := string_to_array(v_required_entities,',');
				
				--raise notice 'guid : %', v_json;
				
				--select 1/0;
				
				--raise notice 'widget_id : %', v_widget_id;
				--raise notice 'component_id : %', v_component_id;
				--raise notice 'other_entities : %', v_other_entities;
				--raise notice 'exclude_entities : %', v_exclude_entities;
				--raise notice 'required_entities : %', v_required_entities;
				--raise notice 'v_item_count : %', v_item_count;
				
				if v_component_id = 1 then
					
					execute 'select * from '||$1||'.'||$1||'_get_ad_r($2,3,$3,0)'
					into v_asset_json, v_result
					using p_schema_prefix, v_url, v_required_entities_arr;
					
					--raise notice 'v_result : %',v_result;
					--raise notice 'v_asset_json : %',v_asset_json;
					
					if v_result = 1 then
						select row_to_json(row)::jsonb
						from (select v_guid as guid, (select row_to_json(row)
												from (select v_result as result, v_asset_json as data
													) as row
											    ) as content
							) as row
						into v_widget_data_json;
					end if;
					
					
					--raise notice 'v_widget_data_json : %',v_widget_data_json;
					--select 1/0;
					
				elsif v_component_id = 7 then
					
					execute 'select *
							from '||$1||'.'||$1||'_get_asset_listing_r($2, $3, $3, $4, $5, null, null, $6)'
					into v_asset_count, v_asset_json
					using p_schema_prefix, v_page_number, v_item_count, v_required_entities_arr,
							v_other_entities_arr, v_exclude_entities_arr;
					
					--raise notice 'v_asset_count : %',v_asset_count;
					--raise notice 'v_asset_json : %',v_asset_json;
					
					select row_to_json(row)::jsonb
					from (select v_guid as guid, (select row_to_json(row)
											from (select v_asset_count as count, v_asset_json as data
												) as row
										    ) as content
						) as row
					into v_widget_data_json;
					
					-- --raise notice 'v_widget_data_json : %',v_widget_data_json;
					
					--select 1/0;
					--raise notice 'dependancy1 : %',v_dependencies;
					--raise notice 'dependancy : %',v_dependencies;
					
					
					if v_dependencies !='[]' -- is not  null or v_dependencies !=null 
					 then 
					
					  raise notice 'parent : % depend :%    dependancy %' , 
					  v_guid,v_dep_guid ,v_dependencies;
					  
					  for v_dep_json in(select * from jsonb_array_elements(v_dependencies))
					  loop
					   -- raise notice 'parent : % depend :%' , v_guid,v_dep_guid;
						  select  v_dep_json->>'guid', 
								  v_dep_json->>'widget_id', 
								  v_dep_json->>'component_id',
								  v_dep_json->>'other_entities',
								  v_dep_json->>'exclude_entities',
								  v_dep_json->>'required_entities',
								  v_dep_json->'meta_info'->>'sm_row'
								 
						 into v_dep_guid, v_dep_widget_id, v_dep_component_id,
						  v_dep_other_entities, v_exclude_dep_entities, v_required_dep_entities,
						 v_item_dep_count ;
						
						
						
						
						
						v_dep_other_entities_arr := string_to_array(v_dep_other_entities,',');
						v_dep_exclude_entities_arr := string_to_array(v_exclude_dep_entities,',');
						v_dep_required_entities_arr := string_to_array(v_required_dep_entities,',');
						
						-- --raise notice 'v_dep guid :%',v_dep_guid;
						 
						 execute 'select *
							from '||$1||'.'||$1||'_get_asset_listing_r($2, $3, $3, $4, $5, null, null, $6)'
							into v_dep_asset_count, v_dep_asset_json
							using p_schema_prefix, v_page_number, v_item_dep_count, v_dep_required_entities_arr,
							v_dep_other_entities_arr, v_dep_exclude_entities_arr;
						 
			             --raise notice 'v_dep guid :%',v_dep_asset_json;
						 
						 
						select row_to_json(row)::jsonb
						from (select v_dep_guid as guid, (select row_to_json(row)
											from (select v_dep_asset_count as count, 
												  v_dep_asset_json as data
												) as row
										    ) as content
								) as row
							into v_dep_widget_data_json; 
						 
						  if v_dep_widget_data_json is not null then
					     v_dep_widget_data_arr := array_append(v_dep_widget_data_arr, v_dep_widget_data_json);
				         end if;
					  
					  end loop;
					
					
					
						
					  select json_agg(row)::jsonb
						from (select widget_dep_data_json::json  as data
				 		from unnest(v_dep_widget_data_arr) u(widget_dep_data_json)
							) row
						into v_dep_widget_data;
					  	
						--raise notice 'JSON %',v_dep_widget_data;
					  
					  end if ;
					  
					  v_widget_data_json:=jsonb_set(v_widget_data_json,'{dependancy}',coalesce(v_dep_widget_data,'[]'),true);

				
				elseif v_component_id = 9 then
					
					execute 'select * from siwaf._get_showcase_detail_r($1,$2,$3,$4,$5,$6,$7,$8,$9)'
					into v_result, v_asset_json
					using p_schema_prefix, v_widget_id, v_required_entities_arr, v_other_entities_arr, v_exclude_entities_arr, v_page_number,
							v_item_count, v_item_count, 1::numeric;
					
					--raise notice 'v_result : %',v_result;
					--raise notice 'v_asset_json : %',v_asset_json;
					
					if v_result = 1 then
						select row_to_json(row)::jsonb
						from (select v_guid as guid, (select row_to_json(row)
												from (select v_result as result, v_asset_json as data
													) as row
											    ) as content
							) as row
						into v_widget_data_json;
					end if;
					
						
				elseif v_component_id = 211 then
					
					null;
					
				end if;
				
				if v_widget_data_json is not null then
					v_widget_data_arr := array_append(v_widget_data_arr, v_widget_data_json);
				end if;
				
			end loop;
			--raise notice 'JSON %',v_widget_data_json;
			--select 1/0;
			
			select json_agg(row)::jsonb
			from (select widget_data_json::json as data
				 from unnest(v_widget_data_arr) u(widget_data_json)
				) row
			into v_widget_data;
			
			v_page_json := jsonb_set(v_page_json,'{widgets_data}',coalesce(v_widget_data,'[]'),false);
			
			end if;
			
			-- select 1/0;
			
		end if;
		
		p_result := 1;
          
	else
     	
		p_result := 0;
          
     end if;
     
     p_page_json := v_page_json;
     
/*exception
	when others then
     	p_result := -1;
          p_page_json := '{}'::jsonb;*/
end;

$_$;


--
