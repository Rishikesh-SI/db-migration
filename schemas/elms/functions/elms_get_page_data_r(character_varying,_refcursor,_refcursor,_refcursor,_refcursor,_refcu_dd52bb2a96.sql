-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: elms
-- Object: elms_get_page_data_r(character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: elms_get_page_data_r(character varying, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: elms; Owner: -
--

CREATE FUNCTION elms.elms_get_page_data_r(p_url character varying, p_page_cur refcursor, p_page_ent_cur refcursor, p_tempt_cur refcursor, p_tc_cur refcursor, p_tc_ent_cur refcursor, p_mast_tempt_cur refcursor, p_mast_tc_cur refcursor, p_mast_tc_ent_cur refcursor, p_redirect_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_url text := p_url;
    v_page_id numeric;
	v_url_slash_count integer;
	v_alias text;
	v_initial_entities_url text;
	v_is_detail numeric := 0;
	v_asset_id numeric;
	v_asset_type_id numeric;
	v_primary_erm_id numeric;
	v_secondary_erm_id numeric;
	v_primary_entity_url text;
	v_secondary_entity_url text;
	v_content_filter_exists numeric;
	v_show_ads numeric := 1;
	v_asset_language_erm_id numeric;
	v_asset_language_entity_url text;
	v_hplc_erm_id numeric := 206;
	v_new_entities_url text;
	v_entities_url_slash_count numeric;
	v_entities_url text;
	v_loop_count integer;
	v_parent_page_id numeric;
	v_is_redirect numeric := 0;
	v_page_language_erm_id numeric;
	v_template_id numeric;
	v_page_asset_type_id numeric := 11;
	v_master_template_id numeric;
    v_template_component_asset_type_id numeric := 13;
	
begin
	
	select page_id
	into v_page_id 
	from elms.elms_page 
	where alias = v_url
	and is_deleted = 0
	and is_amp = 0;
	
	if v_page_id is null then
		
		select page_id
		into v_page_id
		from elms.elms_page
		where v_url ~ concat('^', alias, '$')
		and alias <> ''
		and is_amp = 0;
		
		if v_page_id is null then

			select *
			into v_url_slash_count
			from elms.regexp_count(v_url, '/');
			
			v_alias := lower(split_part(v_url, '/'::text, (v_url_slash_count + 1)));
			
			v_initial_entities_url = substring(v_url, 1, (length(v_url) - (length(v_alias) + 1))); 
			
			if exists(select 1
					  from elms.elms_asset_list
					  where lower(title_alias) = v_alias
					  and asset_type_id not in (14)
					  and is_published = 1) then
				
				v_is_detail := 1;
				
				select asset_id, asset_type_id, primary_entity_role_map_id, secondary_entity_role_map_id
				into v_asset_id, v_asset_type_id, v_primary_erm_id, v_secondary_erm_id
				from elms.elms_asset_list
				where lower(title_alias) = v_alias
				and asset_type_id not in (14)
				and is_published = 1;
				
				select lower(replace(entity_name, ' ', '-'))
				into v_primary_entity_url
				from elms.elms_entity_role_map erm
				join elms.elms_entity_master em
				on em.entity_master_id = erm.entity_master_id
				where erm.entity_role_map_id = v_primary_erm_id;
				
				select lower(replace(entity_name, ' ', '-'))
				into v_secondary_entity_url
				from elms.elms_entity_role_map erm
				join elms.elms_entity_master em
				on em.entity_master_id = erm.entity_master_id
				where erm.entity_role_map_id = v_secondary_erm_id;
				
				select entity_role_map_id
				into v_asset_language_erm_id
				from elms.elms_asset_entity_map
				where asset_id = v_asset_id
				and asset_type_id = v_asset_type_id
				and entity_role_map_id =any(array(select entity_role_map_id
												  from elms.elms_entity_role_map
												  where entity_role_id = (select entity_role_id
																		  from elms.elms_entity_category
																		  where category_name = 'Language')));
				
				select coalesce(canonical_url||'/','')
				into v_asset_language_entity_url
				from elms.elms_entity_role_map erm
				join elms.elms_entity_master em
				on em.entity_master_id = erm.entity_master_id
				where erm.entity_role_map_id = v_asset_language_erm_id;
				
				v_new_entities_url = v_asset_language_entity_url||v_secondary_entity_url;
				
				v_content_filter_exists := elms.elms_check_asset_ent_by_cat('Content Filters', v_asset_id, v_asset_type_id);
				
				v_show_ads := case v_content_filter_exists when 1 then 0 else 1 end;
				
				if v_primary_erm_id = v_hplc_erm_id then
					
					v_new_entities_url = v_asset_language_entity_url||v_primary_entity_url||'/'||v_secondary_entity_url;
					
					if v_new_entities_url <> v_initial_entities_url then
						v_is_redirect := 1;
					end if;
					
				end if;
				
				if v_is_redirect <> 1 then
					
					select *
					into v_entities_url_slash_count
					from elms.regexp_count(v_initial_entities_url, '/');

					v_entities_url := v_initial_entities_url;
					v_loop_count := v_entities_url_slash_count + 1;

					for i in 1..v_loop_count
					loop

						select page_id
						into v_parent_page_id
						from elms.elms_page
						where alias = v_entities_url
						and is_deleted = 0
						and is_amp = 0;

						if v_parent_page_id is not null then

							select page_id
							into v_page_id
							from elms.elms_page
							where parent_id = v_parent_page_id
							and asset_type_id = v_asset_type_id
							and is_active = 1 
							and is_deleted = 0
							and is_amp = 0;

						end if;

						v_loop_count := v_loop_count - 1;

						if v_loop_count <= 0 or v_page_id is not null then

							exit;

						else

							v_entities_url := split_part(v_initial_entities_url, '/'::text, v_loop_count);

						end if;

					end loop;

					if v_page_id is not null then
						
						if v_new_entities_url <> v_initial_entities_url then
							v_is_redirect := 1;
						end if;
						
					else
						
						select page_id
						into v_parent_page_id
						from elms.elms_page
						where alias = '';

						select page_id
						into v_page_id
						from elms.elms_page
						where parent_id = v_parent_page_id
						and asset_type_id = v_asset_type_id
						and is_active = 1
						and is_deleted = 0
						and is_amp = 0;

					end if;
					
				end if;
				
			else
				
				select elms.elms_get_new_url(v_alias)
				into v_alias;
				
				if v_alias is not null then
					
					v_is_detail := 1;
					v_is_redirect := 1;
					
				end if;
				
			end if;
			
		end if;
		
	end if;
	
	if v_page_id is not null then
		
		select entity_role_map_id
		into v_page_language_erm_id
		from elms.elms_asset_entity_map
		where asset_id = v_page_id
		and asset_type_id = v_page_asset_type_id
		and entity_role_map_id =any(array(select entity_role_map_id
										  from elms.elms_entity_role_map
										  where entity_role_id = (select entity_role_id
																  from elms.elms_entity_category
																  where category_name = 'Language')));
		
		select parent_id
		into v_template_id
		from elms.elms_template
		where page_id = v_page_id;
		
		open p_page_cur for
		select v_is_detail as is_detail, p.*, sd.meta_info, v_page_language_erm_id as lang_erm_id,
				(select elms.elms_get_entity_name(v_page_language_erm_id)) as lang_name
		from elms.elms_page p
		left join elms.elms_seo_data sd
		on sd.asset_id = p.page_id
		and sd.asset_type_id = v_page_asset_type_id
		where page_id = v_page_id 
		and p.is_active = 1 
		and p.is_deleted = 0;

		open p_page_ent_cur for
		select *
		from elms.elms_asset_entity_map
		where asset_id = v_page_id
		and asset_type_id = v_page_asset_type_id 
		and is_published = 1
		and is_active = 1
		and is_deleted = 0;
		
		if v_template_id is not null then
			
			select t.layout_id
			into v_master_template_id
			from elms.elms_template t 
			where t.template_id = v_template_id;
			
			open p_tempt_cur for
			select *
			from elms.elms_template
			where template_id = v_template_id
			and is_active = 1
			and is_deleted = 0;

			open p_tc_cur for
			select *
			from elms.elms_template_component_map
			where template_id = v_template_id
			and is_deleted = 0
			and is_active = 1
			order by template_component_map_id;

			open p_tc_ent_cur for
			select *
			from elms.elms_asset_entity_map
			where asset_id in (select template_component_map_id
							   from elms.elms_template_component_map
							   where template_id = v_template_id
							   and is_deleted = 0
							   and is_active = 1)
			and asset_type_id = v_template_component_asset_type_id
			and is_published = 1
			and is_active = 1
			and is_deleted = 0;
			
			if v_master_template_id is not null then
				
				open p_mast_tempt_cur for
				select *
				from elms.elms_template
				where template_id = v_master_template_id
				and is_active = 1 
				and is_deleted = 0;

				open p_mast_tc_cur for
				select *
				from elms.elms_template_component_map
				where template_id = v_master_template_id
				and is_deleted = 0
				and is_active = 1
				order by template_component_map_id;  

				open p_mast_tc_ent_cur for
				select *
				from elms.elms_asset_entity_map
				where asset_id in (select template_component_map_id
								   from elms.elms_template_component_map
								   where template_id = v_master_template_id
								   and is_deleted = 0
								   and is_active = 1)
				and asset_type_id = v_template_component_asset_type_id
				and is_published = 1
				and is_active = 1
				and is_deleted = 0;
				
			else
				
				open p_mast_tempt_cur for
				select *
				from elms.elms_template
				where 1 = 0;
				
				open p_mast_tc_cur for
				select *
				from elms.elms_template_component_map
				where 1 = 0;
				
				open p_mast_tc_ent_cur for
				select *
				from elms.elms_asset_entity_map
				where 1 = 0;
				
			end if;
			
		else
			
			open p_tempt_cur for
			select *
			from elms.elms_template
			where 1 = 0;
			
			open p_tc_cur for
			select *
			from elms.elms_template_component_map
			where 1 = 0;
			
			open p_tc_ent_cur for
			select *
			from elms.elms_asset_entity_map
			where 1 = 0;
			
		end if;
		
	else
		
		open p_page_cur for
		select null is_detail, *, null meta_info, null lang_erm_id, null lang_name
		from elms.elms_page
		where 1 = 0;
		
		open p_page_ent_cur for
		select *
		from elms.elms_asset_entity_map
		where 1 = 0;
		
		open p_tempt_cur for
		select *
		from elms.elms_template
		where 1 = 0;

		open p_tc_cur for
		select *
		from elms.elms_template_component_map
		where 1 = 0;

		open p_tc_ent_cur for
		select *
		from elms.elms_asset_entity_map
		where 1 = 0;
		
		open p_mast_tempt_cur for
		select *
		from elms.elms_template
		where 1 = 0;

		open p_mast_tc_cur for
		select *
		from elms.elms_template_component_map
		where 1 = 0;

		open p_mast_tc_ent_cur for
		select *
		from elms.elms_asset_entity_map
		where 1 = 0;
		
	end if;
	
	if v_is_redirect = 1 then
		
		open p_redirect_cur for
		select v_alias as new_asset_alias, v_is_redirect as is_redirect, v_show_ads as show_ads, v_new_entities_url as new_ent_path; 
		
	else
		
		open p_redirect_cur for
		select null as new_asset_alias, v_is_redirect as is_redirect, v_show_ads as show_ads, null as new_ent_path;
		
	end if;
	                                            
end;

$_$;


--
