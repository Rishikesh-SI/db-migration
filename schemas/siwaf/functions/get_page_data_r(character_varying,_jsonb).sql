-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_page_data_r(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_page_data_r(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_page_data_r(p_schema_prefix character varying, p_input_json jsonb, OUT p_result numeric, OUT p_page_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
/*
SELECT * from siwaf._get_page_data_r(
	'yho',-- <p_schema_prefix character varying>, 
	'{
  "url": "",
  "is_amp": "0"
}'-- <p_input_json jsonb>
);
*/
declare
	
	v_url text;
	v_is_amp numeric;
	v_page_id numeric;
	v_slash_count numeric;
	v_asset_alias text;
	v_asset_id numeric;
	v_asset_type_id numeric;
	v_new_asset_alias text;
	v_redirect numeric := 0;
	v_redirect_url text;
	v_asset_language_curl text;
	v_asset_primary_entity_curl text;
	v_asset_secondary_entity_curl text;
	v_url_structure text;
	v_redirect_parent text;
	v_page_json jsonb := '{"html":null,"is_protected":null,"template_id":null,"master_template_id":null,"lang_erm_id":null,"parent_id":null,
							"Masterhtml":null,"pageentity":null,"pageid":null,"lang_entity":null,"lang_name":null,"title_web":null,
							"title_mobile":null,"required_entities":null,"asset_type_id":null,"team_id":null,"team_name":null,"player_id":null,
							"full_name":null,"metainfo":null,"title_app":null,"isredirect":"0","redirectparent":"","redirecturl":"",
							"MasterModules":null,"modules":null}'::jsonb;
	v_length numeric;
	v_parent_page_id numeric;
	v_page_language_curl text;
	v_page_language_ermid numeric;
	v_page_language_ename text;
	v_template_id numeric;
	v_template_html text;
	v_master_template_id numeric;
	v_master_template_html text;
	v_master_module_json jsonb;
	v_module_json jsonb;
	v_asset_language_entity_id numeric;
	v_asset_primary_entity_id numeric;
	v_asset_secondary_entity_id numeric;
	v_asset_url text;
	
begin
	
    set enable_seqscan = false;
	
    select coalesce(substring(lower(p_input_json->>'url'),'(.*[^\/\s])'),''), coalesce((p_input_json->>'is_amp')::numeric,0)
	into v_url, v_is_amp;
	
    execute 'select page_id
				from '||$1||'.'||$1||'_page
				where alias = $2
				and coalesce(is_amp,0) = $3
				and is_deleted = 0'
    into v_page_id
    using p_schema_prefix, trim(leading '/' from v_url), v_is_amp;
	
    if v_page_id is null then
		
		execute 'select page_id
					from '||$1||'.'||$1||'_page
					where $2 ~ concat(''^'',alias,''$'')
					and length(alias) <> 0
					and coalesce(is_amp,0) = $3
					and is_deleted = 0'
     	into v_page_id
     	using p_schema_prefix, v_url, v_is_amp;
		
	end if;
	
	if v_page_id is null then
		
		v_slash_count := regexp_count(v_url,'/') + 1;
		v_asset_alias := split_part(v_url,'/',v_slash_count::int);
		
		execute 'select asset_id, asset_type_id
					from '||$1||'.'||$1||'_redirect
					where lower(old_alias) = $2'
		into v_asset_id, v_asset_type_id
		using p_schema_prefix, v_asset_alias;
		
		if v_asset_id is not null and v_asset_type_id is not null then
			
			execute 'select new_alias
						from '||$1||'.'||$1||'_redirect r
						where r.asset_id = $2
                    	and r.asset_type_id = $3
                    	and r.alias_number = (select max(r1.alias_number)
												from '||$1||'.'||$1||'_redirect r1
                    							where r1.asset_id = r.asset_id
												and r1.asset_type_id = r.asset_type_id)'
			into v_new_asset_alias
			using p_schema_prefix, v_asset_id, v_asset_type_id;
			
			if v_new_asset_alias is not null then
				
				v_redirect := 1;
				v_redirect_url := v_new_asset_alias;
				
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
				
				select client_json->>'UrlStructure'
				into v_url_structure
				from waf_master.waf_client
				where client_prefix = p_schema_prefix;
				
				if v_url_structure = '{0}/{1}/{2}' then
					v_redirect_parent := coalesce(v_asset_language_curl,'')||v_asset_primary_entity_curl||v_asset_secondary_entity_curl;
				elsif v_url_structure = '{0}/{2}' then
					v_redirect_parent := coalesce(v_asset_language_curl,'')||v_asset_primary_entity_curl;
				elsif v_url_structure = '{1}/{2}' then
					v_redirect_parent := coalesce(v_asset_language_curl,'')||v_asset_secondary_entity_curl;
				end if;
				
				v_page_json := jsonb_set(v_page_json,'{isredirect}',('"1"')::jsonb,false);
				v_page_json := jsonb_set(v_page_json,'{redirectparent}',('"'||v_redirect_parent||'"')::jsonb,false);
				v_page_json := jsonb_set(v_page_json,'{redirecturl}',('"'||v_redirect_url||'"')::jsonb,false);
				
			end if;
			
		else
			
			execute 'select asset_id, asset_type_id, title_alias, language_id, primary_entity_role_map_id, secondary_entity_role_map_id
						from '||$1||'.'||$1||'_asset_list
               			where lower(title_alias) = $2
                    	and asset_type_id in(1,2,4,5)
                    	and is_published = 1'
     		into v_asset_id, v_asset_type_id, v_asset_alias, v_asset_language_entity_id, v_asset_primary_entity_id, v_asset_secondary_entity_id
     		using p_schema_prefix, v_asset_alias;
			
			if v_asset_id is not null and v_asset_type_id is not null then
				
				execute 'select lower(em.canonical_url)
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
				
				execute 'select lower(em.canonical_url)
							from '||$1||'.'||$1||'_asset_list al
                        	join '||$1||'.'||$1||'_entity_role_map erm
                        	on erm.entity_role_map_id = al.primary_entity_role_map_id
                        	join '||$1||'.'||$1||'_entity_master em
                        	on em.entity_master_id = erm.entity_master_id
                        	where al.asset_id = $2
                        	and al.asset_type_id  = $3'
     			into v_asset_primary_entity_curl
     			using p_schema_prefix, v_asset_id, v_asset_type_id;
				
				execute 'select lower(em.canonical_url)
							from '||$1||'.'||$1||'_asset_list al
                       		join '||$1||'.'||$1||'_entity_role_map erm
                        	on erm.entity_role_map_id = al.secondary_entity_role_map_id
                        	join '||$1||'.'||$1||'_entity_master em
                        	on em.entity_master_id = erm.entity_master_id
                        	where al.asset_id = $2
                        	and al.asset_type_id  = $3'
				into v_asset_secondary_entity_curl
     			using p_schema_prefix, v_asset_id, v_asset_type_id;
				
				select client_json->>'UrlStructure'
				into v_url_structure
				from waf_master.waf_client
				where client_prefix = p_schema_prefix;
				
				if v_url_structure = '{0}/{1}/{2}' then
					v_redirect_parent := coalesce(v_asset_language_curl,'')||v_asset_primary_entity_curl||v_asset_secondary_entity_curl;
				elsif v_url_structure = '{0}/{2}' then
					v_redirect_parent := coalesce(v_asset_language_curl,'')||v_asset_primary_entity_curl;
				elsif v_url_structure = '{1}/{2}' then
					v_redirect_parent := coalesce(v_asset_language_curl,'')||v_asset_secondary_entity_curl;
				end if;
				
				v_asset_url := coalesce(v_redirect_parent||'/','')||v_asset_alias;
				
				if v_asset_url <> v_url then
					
					v_page_json := jsonb_set(v_page_json,'{isredirect}',('"1"')::jsonb,false);
					v_page_json := jsonb_set(v_page_json,'{redirectparent}',('"'||v_redirect_parent||'"')::jsonb,false);
					v_page_json := jsonb_set(v_page_json,'{redirecturl}',('"'||v_asset_url||'"')::jsonb,false);
					
				else
					
					select char_length(v_url) - char_length(split_part(v_url,'/',v_slash_count::int)||'/')
					into v_length;
					
					select substring(v_url from '^.{'||v_length||'}')
					into v_url;
					
					execute 'select parent_id
								from '||$1||'.'||$1||'_page
								where alias = $2
								and coalesce(is_amp,0) = $4
								and is_deleted = 0'
					into v_parent_page_id
					using p_schema_prefix, trim(leading '/' from v_url), v_asset_type_id, v_is_amp;
					
					if v_parent_page_id is not null then
						
						execute 'select page_id
									from '||$1||'.'||$1||'_page
									where parent_id = $2
									and asset_type_id = $3
									and coalesce(is_amp,0) = $4
									and is_deleted = 0'
						into v_page_id
						using p_schema_prefix, v_parent_page_id, v_asset_type_id, v_is_amp;
						
					else
						
						execute 'select page_id
									from '||$1||'.'||$1||'_page
									where alias = ''''
									and coalesce(is_amp,0) = $2
									and is_deleted = 0'
						into v_parent_page_id
						using p_schema_prefix, v_is_amp;
						
						execute 'select page_id
									from '||$1||'.'||$1||'_page
									where parent_id = $2
									and asset_type_id = $3
									and coalesce(is_amp,0) = $4
									and is_deleted = 0'
						into v_page_id
						using p_schema_prefix, v_parent_page_id, v_asset_type_id, v_is_amp;
						
					end if;
					
					if v_page_id is null then
						
						v_slash_count := regexp_count(v_url,'/') + 1;
						
						select char_length(v_url) - char_length(split_part(v_url,'/',v_slash_count::int)||'/')
						into v_length;
						
						select substring(v_url from '^.{'||v_length||'}')
						into v_url;
						
					end if;
					
				end if;
					
			end if;
			
		end if;
		
	end if;
	
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
          	
     	end if;
     	
		execute 'select pt.template_id, pt.template_html, l.master_template_id, mt.template_html
					from '||$1||'.'||$1||'_template t
               		join '||$1||'.'||$1||'_template pt
               		on pt.template_id = t.parent_id
					join '||$1||'.'||$1||'_layout l
					on l.layout_id = pt.layout_id
					join '||$1||'.'||$1||'_template mt
					on mt.template_id = l.master_template_id
               		where t.page_id = $2'
		into v_template_id, v_template_html, v_master_template_id, v_master_template_html
     	using p_schema_prefix, v_page_id;
		
		if v_template_id is null then
			
			execute 'select pt.template_id, pt.template_html, mt.template_id, mt.template_html
						from '||$1||'.'||$1||'_template t
               			join '||$1||'.'||$1||'_template pt
               			on pt.template_id = t.parent_id
						join '||$1||'.'||$1||'_template mt
						on mt.template_id = pt.layout_id
               			where t.page_id = $2'
			into v_template_id, v_template_html, v_master_template_id, v_master_template_html
     		using p_schema_prefix, v_page_id;
			
		end if;
		
     	execute 'select row_to_json(row)::jsonb
					from (select $3 as html, null as is_protected, $4 as template_id, $5 as master_template_id, $6 as lang_erm_id,
									coalesce(p.parent_id::text,'''') as parent_id, $7 as "Masterhtml",
									coalesce((select string_agg(aem.entity_role_map_id::text,'','')
												from '||$1||'.'||$1||'_asset_entity_map aem
												where aem.asset_id = p.page_id
												and aem.asset_type_id = 11),'''') as pageentity, p.page_id, $6 as lang_entity, $8 as lang_name,
												p.title as title_web, p.title_mobile,
												(select array_to_json(array_agg(a))
													from (select aem.entity_role_map_id as entity_id, aem.is_required
															from '||$1||'.'||$1||'_asset_entity_map aem
															where aem.asset_id = p.page_id
															and aem.asset_type_id = 11)a) as required_entities, p.asset_type_id,
												null as team_id, null as team_name, null as player_id, null as full_name, sd.meta_info,
												p.title_app, 0 as isredirect, '''' as redirectparent, '''' as redirecturl,
												null as "MasterModules",
									null as modules
							from '||$1||'.'||$1||'_page p
     						left join '||$1||'.'||$1||'_seo_data sd
     						on sd.asset_id = p.page_id
     						and sd.asset_type_id = 11
     						where p.page_id = $2
						) row'
     	into v_page_json
     	using p_schema_prefix, v_page_id, v_template_html::text, v_template_id::text, v_master_template_id::text, v_page_language_ermid,
				v_master_template_html, v_page_language_ename;
		
		execute 'select (''[''||string_agg(row_to_json(row)::text,'','')||'']'')::jsonb
					from (select tcm.tcmap_guid as selector, tcm.title, tcm.template_component_map_id as componentid,
									tcm.component_id as tempcomponentid, tcm.fetch_from as fetchfrom,
									(select row_to_json(row)
										from (select null as selector, coalesce((select string_agg(aem.entity_role_map_id::text,'','')
																					from '||$1||'.'||$1||'_asset_entity_map aem
																					where aem.asset_id = tcm.template_component_map_id
																					and aem.asset_type_id = 13),'''') as entities,
														(select array_to_json(array_agg(a))
															from (select aem.entity_role_map_id as entity_id, aem.is_required
																	from '||$1||'.'||$1||'_asset_entity_map aem
																	where aem.asset_id = tcm.template_component_map_id
																	and aem.asset_type_id = 13)a) as required_entities, tcm.title,
														null as parent_container, tcm.template_component_map_id as componentid,
														tcm.component_id as tempcomponentid, null as "displayCount", tcm.meta_info,
														tcm.display_title, tcm.title_mobile, tcm.title_app, tcm.show_in_web, tcm.show_in_mobile,
														tcm.show_in_app, null as is_protected,
														(select array_to_json(array_agg(a))
															from (select ctcm.tcmap_guid as selector,
																			(select row_to_json(row)
																				from (select null as selector,
																								coalesce((select string_agg(aem.entity_role_map_id::text,'','')
																											from '||$1||'.'||$1||'_asset_entity_map aem
																											where aem.asset_id = ctcm.template_component_map_id
																											and aem.asset_type_id = 13),'''') as entities,
																								(select array_to_json(array_agg(a))
																									from (select aem.entity_role_map_id as entity_id,
																													aem.is_required
																											from '||$1||'.'||$1||'_asset_entity_map aem
																											where aem.asset_id = ctcm.template_component_map_id
																											and aem.asset_type_id = 13)a) as required_entities,
																								ctcm.title, null as parent_container,
																								ctcm.template_component_map_id as componentid,
																								ctcm.component_id as tempcomponentid,
																								null as "displayCount", ctcm.meta_info,
																								ctcm.display_title, ctcm.title_mobile,
																								ctcm.title_app, ctcm.show_in_web,
																								ctcm.show_in_mobile, ctcm.show_in_app,
																								null as is_protected,
																								''[]''::jsonb as dependency
																					)row
																			) as params, ctcm.fetch_from as fetchfrom
																	from '||$1||'.'||$1||'_template_component_map ctcm
																	where ctcm.parent_tcmap_id = tcm.template_component_map_id
																	and ctcm.is_active = 1
																	and ctcm.is_deleted = 0
																) a
														) as dependency
											)row
									) as params
							from '||$1||'.'||$1||'_template_component_map tcm
                    		where tcm.template_id = $2
                    		and tcm.parent_tcmap_id is null
							and tcm.is_active = 1
							and tcm.is_deleted = 0
						) as row'
		into v_master_module_json
		using p_schema_prefix, v_master_template_id;
		
		if v_master_module_json is not null then
			
			v_page_json := jsonb_set(v_page_json,'{MasterModules}',v_master_module_json,false);
			
			p_result := 1;
			
        else
			
			p_result := 0;
			
		end if;
		
		execute 'select (''[''||string_agg(row_to_json(row)::text,'','')||'']'')::jsonb
					from (select tcm.tcmap_guid as selector, tcm.title, tcm.template_component_map_id as componentid,
									tcm.component_id as tempcomponentid, tcm.fetch_from as fetchfrom,
									(select row_to_json(row)
										from (select null as selector, coalesce((select string_agg(aem.entity_role_map_id::text,'','')
																					from '||$1||'.'||$1||'_asset_entity_map aem
																					where aem.asset_id = tcm.template_component_map_id
																					and aem.asset_type_id = 13),'''') as entities,
														(select array_to_json(array_agg(a))
															from (select aem.entity_role_map_id as entity_id, aem.is_required
																	from '||$1||'.'||$1||'_asset_entity_map aem
																	where aem.asset_id = tcm.template_component_map_id
																	and aem.asset_type_id = 13)a) as required_entities, tcm.title,
														null as parent_container, tcm.template_component_map_id as componentid,
														tcm.component_id as tempcomponentid, null as "displayCount", tcm.meta_info,
														tcm.display_title, tcm.title_mobile, tcm.title_app, tcm.show_in_web, tcm.show_in_mobile,
														tcm.show_in_app, null as is_protected,
														(select array_to_json(array_agg(a))
															from (select ctcm.tcmap_guid as selector,
																			(select row_to_json(row)
																				from (select null as selector,
																								coalesce((select string_agg(aem.entity_role_map_id::text,'','')
																											from '||$1||'.'||$1||'_asset_entity_map aem
																											where aem.asset_id = ctcm.template_component_map_id
																											and aem.asset_type_id = 13),'''') as entities,
																								(select array_to_json(array_agg(a))
																									from (select aem.entity_role_map_id as entity_id,
																													aem.is_required
																											from '||$1||'.'||$1||'_asset_entity_map aem
																											where aem.asset_id = ctcm.template_component_map_id
																											and aem.asset_type_id = 13)a) as required_entities,
																								ctcm.title, null as parent_container,
																								ctcm.template_component_map_id as componentid,
																								ctcm.component_id as tempcomponentid,
																								null as "displayCount", ctcm.meta_info,
																								ctcm.display_title, ctcm.title_mobile,
																								ctcm.title_app, ctcm.show_in_web,
																								ctcm.show_in_mobile, ctcm.show_in_app,
																								null as is_protected,
																								''[]''::jsonb as dependency
																					)row
																			) as params, ctcm.fetch_from as fetchfrom
																	from '||$1||'.'||$1||'_template_component_map ctcm
																	where ctcm.parent_tcmap_id = tcm.template_component_map_id
																	and ctcm.is_active = 1
																	and ctcm.is_deleted = 0
																) a
														) as dependency
											)row
									) as params
							from '||$1||'.'||$1||'_template_component_map tcm
                    		where tcm.template_id = $2
                    		and tcm.parent_tcmap_id is null
							and tcm.is_active = 1
							and tcm.is_deleted = 0
						) as row'
		into v_module_json
		using p_schema_prefix, v_template_id;
		
		if v_module_json is not null then
			
			v_page_json := jsonb_set(v_page_json,'{modules}',v_module_json,false);
			
			p_result := 1;
			
        else
			
			p_result := 0;
			
		end if;
		
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
