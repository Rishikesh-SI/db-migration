-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_page_data_r_new(character varying, numeric, numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labyho_get_page_data_r_new(character varying, numeric, numeric, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_page_data_r_new(p_url character varying, p_is_amp numeric, p_is_mobile numeric, p_page_cur refcursor, p_page_ent_cur refcursor, p_tempt_cur refcursor, p_tc_cur refcursor, p_tc_ent_cur refcursor, p_mast_tempt_cur refcursor, p_mast_tc_cur refcursor, p_mast_tc_ent_cur refcursor, p_redirect_cur refcursor, p_meta_info_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_url text := p_url;
	v_is_amp numeric := coalesce(p_is_amp, 0);
    v_page_id numeric;
	v_url_slash_count integer;
	v_alias text;
	v_initial_entities_url text;
	v_is_detail numeric := 0;
	v_asset_id numeric;
	v_asset_type_id numeric;
	v_primary_erm_id numeric;
	v_secondary_erm_id numeric;
	v_browser_title text;
	v_full_text text;
	v_primary_entity_url text;
	v_secondary_entity_url text;
	v_content_filter_exists numeric;
	v_show_ads numeric := 1;
	v_asset_language_erm_id numeric;
	v_asset_language_em_id numeric;
	v_asset_language_entity_url text;
	v_new_entities_url text;
	v_entities_url_slash_count numeric;
	v_entities_url text;
	v_loop_count integer;
	v_parent_page_id numeric;
	v_is_redirect numeric := 0;
	v_page_language_erm_id numeric;
	v_page_language_em_id numeric;
	v_page_language_entity_url text;
	v_template_id numeric;
	v_series_id text;
	v_page_asset_type_id numeric := 11;
	v_master_template_id numeric;
    v_template_component_asset_type_id numeric := 13;
	
begin
	
	select page_id
	into v_page_id 
	from labyho.labyho_page 
	where alias = v_url
	and is_amp = v_is_amp
	and is_active = 1
	and is_deleted = 0
	and is_published = 1;
	
	if v_page_id is null then
		
		select page_id
		into v_page_id
		from labyho.labyho_page
		where v_url ~ concat('^', alias, '$')
		and alias <> ''
		and is_amp = v_is_amp
		and is_active = 1
		and is_deleted = 0
		and is_published = 1;
		
		if v_page_id is null then

			select *
			into v_url_slash_count
			from labyho.regexp_count(v_url, '/');
			
			v_alias := lower(split_part(v_url, '/'::text, (v_url_slash_count + 1)));
			
			v_initial_entities_url = substring(v_url, 1, (length(v_url) - (length(v_alias) + 1))); 
			
			if exists(select 1
					  from labyho.labyho_asset_list
					  where lower(title_alias) = v_alias
					  and asset_type_id not in (14)
					  and is_published = 1) then
				
				v_is_detail := 1;
				
				select asset_id, asset_type_id, primary_entity_role_map_id, secondary_entity_role_map_id,
						web_detail_jsn->'data'->>'browser_title', web_detail_jsn->'data'->>'full_text'
				into v_asset_id, v_asset_type_id, v_primary_erm_id, v_secondary_erm_id, v_browser_title, v_full_text
				from labyho.labyho_asset_list
				where lower(title_alias) = v_alias
				and asset_type_id not in (14)
				and is_published = 1;
				
				select lower(replace(entity_name, ' ', '-'))
				into v_primary_entity_url
				from labyho.labyho_entity_role_map erm
				join labyho.labyho_entity_master em
				on em.entity_master_id = erm.entity_master_id
				where erm.entity_role_map_id = v_primary_erm_id;
				
				select lower(replace(entity_name, ' ', '-'))
				into v_secondary_entity_url
				from labyho.labyho_entity_role_map erm
				join labyho.labyho_entity_master em
				on em.entity_master_id = erm.entity_master_id
				where erm.entity_role_map_id = v_secondary_erm_id;
				
				select entity_role_map_id
				into v_asset_language_erm_id
				from labyho.labyho_asset_entity_map
				where asset_id = v_asset_id
				and asset_type_id = v_asset_type_id
				and entity_role_map_id =any(array(select entity_role_map_id
												  from labyho.labyho_entity_role_map
												  where entity_role_id = (select entity_role_id
																		  from labyho.labyho_entity_category
																		  where category_name = 'Language')));
				
				select em.entity_master_id, coalesce(em.canonical_url||'/','')
				into v_asset_language_em_id, v_asset_language_entity_url
				from labyho.labyho_entity_role_map erm
				join labyho.labyho_entity_master em
				on em.entity_master_id = erm.entity_master_id
				where erm.entity_role_map_id = v_asset_language_erm_id;
				
				v_new_entities_url = v_asset_language_entity_url||v_secondary_entity_url;
				
				v_content_filter_exists := labyho.labyho_check_asset_ent_by_cat('Content Filters', v_asset_id, v_asset_type_id);
				
				v_show_ads := case v_content_filter_exists when 1 then 0 else 1 end;
								
				if v_is_redirect <> 1 then
					
					select *
					into v_entities_url_slash_count
					from labyho.regexp_count(v_initial_entities_url, '/');

					v_entities_url := v_initial_entities_url;
					v_loop_count := v_entities_url_slash_count + 1;

					for i in 1..v_loop_count
					loop

						select page_id
						into v_parent_page_id
						from labyho.labyho_page
						where alias = v_entities_url
						and is_amp = v_is_amp
						and is_active = 1
						and is_deleted = 0
						and is_published = 1;

						if v_parent_page_id is not null then

							select page_id
							into v_page_id
							from labyho.labyho_page
							where parent_id = v_parent_page_id
							and asset_type_id = v_asset_type_id
							and is_amp = v_is_amp
							and is_active = 1
							and is_deleted = 0
							and is_published = 1;

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
						from labyho.labyho_page
						where alias = ''
						and is_amp = v_is_amp
						and is_active = 1
						and is_deleted = 0
						and is_published = 1;
						
						select page_id
						into v_page_id
						from labyho.labyho_page
						where parent_id = v_parent_page_id
						and asset_type_id = v_asset_type_id
						and is_amp = v_is_amp
						and is_active = 1
						and is_deleted = 0
						and is_published = 1;

					end if;
					
				end if;
				
			else
				
				select labyho.labyho_get_new_url(v_alias)
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
		from labyho.labyho_asset_entity_map
		where asset_id = v_page_id
		and asset_type_id = v_page_asset_type_id
		and entity_role_map_id =any(array(select entity_role_map_id
										  from labyho.labyho_entity_role_map
										  where entity_role_id = (select entity_role_id
																  from labyho.labyho_entity_category
																  where category_name = 'Language')));
		
		select em.entity_master_id, coalesce(em.canonical_url||'/','')
		into v_page_language_em_id, v_page_language_entity_url
		from labyho.labyho_entity_role_map erm
		join labyho.labyho_entity_master em
		on em.entity_master_id = erm.entity_master_id
		where erm.entity_role_map_id = v_page_language_erm_id;
		
		select parent_id
		into v_template_id
		from labyho.labyho_template
		where page_id = v_page_id;
		
		if v_url ~ '\/?series\/[a-z0-9-]+-(\d+)\/?$' then
			
			v_series_id := substring(v_url, '\/?series\/[a-z0-9-]+-(\d+)\/?$');
			
			if v_series_id is not null then
				
				if exists(select 1
						  from labyho.labyho_entity_role_map erm
						  join labyho.labyho_entity_role er
						  on er.entity_role_id = erm.entity_role_id
						  join labyho.labyho_entity_type et
						  on et.entity_type_id = er.entity_type_id
						  join labyho.labyho_entity_master em
						  on em.entity_master_id = erm.entity_master_id
						  where er.entity_role_id = 8
						  and et.entity_type_name = 'BilateralSeries'
						  and erm.canonical_url = '/'||v_url
						  and erm.tour_id = v_series_id) then
					
					select template_id
					into v_template_id
			 		from labyho.labyho_template
			 		where template_name = 'BilateralSeries';
					
				end if;
				
			end if;
			
		end if;
		
		open p_page_cur for
		select v_is_detail as is_detail, p.*, sd.meta_info, v_page_language_erm_id as lang_erm_id,
				(select labyho.labyho_get_entity_name(v_page_language_erm_id)) as lang_name
		from labyho.labyho_page p
		left join labyho.labyho_seo_data sd
		on sd.asset_id = p.page_id
		and sd.asset_type_id = v_page_asset_type_id
		where page_id = v_page_id 
		and p.is_active = 1 
		and p.is_deleted = 0;

		open p_page_ent_cur for
		select aem.*, em.entity_name, em.canonical_url, et.entity_type_name, erm.source_object_id, erm.tour_id
		from labyho.labyho_asset_entity_map aem
		join labyho.labyho_entity_role_map erm
	 	on erm.entity_role_map_id = aem.entity_role_map_id
	 	join labyho.labyho_entity_master em
	 	on em.entity_master_id = erm.entity_master_id
	 	join labyho.labyho_entity_role er
	 	on er.entity_role_id = erm.entity_role_id
	 	join labyho.labyho_entity_type et
	 	on et.entity_type_id = er.entity_type_id
		where aem.asset_id = v_page_id
		and aem.asset_type_id = v_page_asset_type_id 
		and aem.is_published = 1
		and aem.is_active = 1
		and aem.is_deleted = 0;
		
		if v_template_id is not null then
			
			select t.layout_id
			into v_master_template_id
			from labyho.labyho_template t 
			where t.template_id = v_template_id;
			
			open p_tempt_cur for
			select template_id, case coalesce(p_is_mobile, 0) when 1 then coalesce(mobile_html, template_html)
									when 0 then template_html
									else null
								end as template_html
			from labyho.labyho_template
			where template_id = v_template_id
			and is_active = 1
			and is_deleted = 0;

			open p_tc_cur for
			select case coalesce(tcm.show_in_mobile, 0)
						when 1 then coalesce(tcm.parent_container_id, tcm.template_component_map_id)
						else tcm.template_component_map_id
					end as template_component_map_id, tcm.template_id, tcm.component_id, tcm.title, tcm.display_title, tcm.title_mobile,
					tcm.title_app, tcm.show_in_mobile, tcm.show_in_app, tcm.show_in_web, tcm.fetch_from, tcm.created_date, tcm.updated_date,
					tcm.created_by, tcm.updated_by, tcm.is_active, tcm.is_deleted, tcm.is_published, tcm.tcmap_guid, tcm.parent_container_id,
					tcm.parent_tcmap_id, tcm.meta_info
			from labyho.labyho_template_component_map tcm
			left join labyho.labyho_template_component_map tcm1
			on tcm1.parent_container_id = tcm.template_component_map_id
			and tcm1.parent_container_id is not null
			where tcm.template_id = v_template_id
			and tcm.is_deleted = 0
			and tcm.is_active = 1
			order by tcm.template_component_map_id;
			
			open p_tc_ent_cur for
			select aem.*, em.entity_name, em.canonical_url, et.entity_type_name, erm.source_object_id, erm.tour_id
			from labyho.labyho_asset_entity_map aem
			join labyho.labyho_entity_role_map erm
			on erm.entity_role_map_id = aem.entity_role_map_id
			join labyho.labyho_entity_master em
			on em.entity_master_id = erm.entity_master_id
			join labyho.labyho_entity_role er
			on er.entity_role_id = erm.entity_role_id
			join labyho.labyho_entity_type et
			on et.entity_type_id = er.entity_type_id
			where aem.asset_id in (select template_component_map_id
								   from labyho.labyho_template_component_map
								   where template_id = v_template_id
								   and is_deleted = 0
								   and is_active = 1)
			and aem.asset_type_id = v_template_component_asset_type_id
			and aem.is_published = 1
			and aem.is_active = 1
			and aem.is_deleted = 0;
			
			if v_master_template_id is not null then
				
				open p_mast_tempt_cur for
				select template_id, case coalesce(p_is_mobile, 0) when 1 then coalesce(mobile_html, template_html)
										when 0 then template_html
										else null
									end as template_html
				from labyho.labyho_template
				where template_id = v_master_template_id
				and is_active = 1 
				and is_deleted = 0;

				open p_mast_tc_cur for
				select *
				from labyho.labyho_template_component_map
				where template_id = v_master_template_id
				and is_deleted = 0
				and is_active = 1
				order by template_component_map_id;  

				open p_mast_tc_ent_cur for
				select aem.*, em.entity_name, et.entity_type_name, erm.source_object_id
				from labyho.labyho_asset_entity_map aem
				join labyho.labyho_entity_role_map erm
	 			on erm.entity_role_map_id = aem.entity_role_map_id
	 			join labyho.labyho_entity_master em
	 			on em.entity_master_id = erm.entity_master_id
	 			join labyho.labyho_entity_role er
	 			on er.entity_role_id = erm.entity_role_id
	 			join labyho.labyho_entity_type et
	 			on et.entity_type_id = er.entity_type_id
				where aem.asset_id in (select template_component_map_id
									   from labyho.labyho_template_component_map
									   where template_id = v_master_template_id
									   and is_deleted = 0
									   and is_active = 1)
				and aem.asset_type_id = v_template_component_asset_type_id
				and aem.is_published = 1
				and aem.is_active = 1
				and aem.is_deleted = 0;
				
			else
				
				open p_mast_tempt_cur for
				select template_id, template_html
				from labyho.labyho_template
				where 1 = 0;
				
				open p_mast_tc_cur for
				select *
				from labyho.labyho_template_component_map
				where 1 = 0;
				
				open p_mast_tc_ent_cur for
				select *, null as entity_name, null as entity_type_name, null as source_object_id
				from labyho.labyho_asset_entity_map
				where 1 = 0;
				
			end if;
			
		else
			
			open p_tempt_cur for
			select template_id, template_html
			from labyho.labyho_template
			where 1 = 0;
			
			open p_tc_cur for
			select template_component_map_id, template_id, component_id, title, display_title, title_mobile, title_app, show_in_mobile,
					show_in_app, show_in_web, fetch_from, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
					is_published, tcmap_guid, parent_container_id, parent_tcmap_id, meta_info
			from labyho.labyho_template_component_map
			where 1 = 0;
			
			open p_tc_ent_cur for
			select *, null as entity_name, null as canonical_url, null as entity_type_name, null as source_object_id, null as tour_id
			from labyho.labyho_asset_entity_map
			where 1 = 0;
			
		end if;
		
	else
		
		open p_page_cur for
		select null as is_detail, *, null as meta_info, null as lang_erm_id, null as lang_name
		from labyho.labyho_page
		where 1 = 0;
		
		open p_page_ent_cur for
		select *, null as entity_name, null as canonical_url, null as entity_type_name, null as source_object_id, null as tour_id
		from labyho.labyho_asset_entity_map
		where 1 = 0;
		
		open p_tempt_cur for
		select template_id, template_html
		from labyho.labyho_template
		where 1 = 0;
		
		open p_tc_cur for
		select template_component_map_id, template_id, component_id, title, display_title, title_mobile, title_app, show_in_mobile,
				show_in_app, show_in_web, fetch_from, created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
				tcmap_guid, parent_container_id, parent_tcmap_id, meta_info
		from labyho.labyho_template_component_map
		where 1 = 0;
		
		open p_tc_ent_cur for
		select *, null as entity_name, null as canonical_url, null as entity_type_name, null as source_object_id, null as tour_id
		from labyho.labyho_asset_entity_map
		where 1 = 0;
		
		open p_mast_tempt_cur for
		select template_id, template_html
		from labyho.labyho_template
		where 1 = 0;
		
		open p_mast_tc_cur for
		select *
		from labyho.labyho_template_component_map
		where 1 = 0;
		
		open p_mast_tc_ent_cur for
		select *, null as entity_name, null as entity_type_name, null as source_object_id
		from labyho.labyho_asset_entity_map
		where 1 = 0;
		
	end if;
	
	if v_is_redirect = 1 then
		
		open p_redirect_cur for
		select v_alias as new_asset_alias, v_is_redirect as is_redirect, v_show_ads as show_ads, v_new_entities_url as new_ent_path; 
		
	else
		
		open p_redirect_cur for
		select null as new_asset_alias, v_is_redirect as is_redirect, v_show_ads as show_ads, null as new_ent_path;
		
	end if;
	
	open p_meta_info_cur for
	select al.asset_list_id, al.asset_id, al.asset_type_id, al.asset_title, al.title_alias, al.author_id, al.short_desc, al.tags,
			al.primary_entity_role_map_id, al.secondary_entity_role_map_id, al.total_assets, al.image_file_name, al.image_path, al.duration,
			al.show_in_web, al.show_in_mobile, al.show_in_app, al.published_version_number, al.is_trashed, al.created_date, al.updated_date,
			al.created_by, al.updated_by, al.is_active, al.is_deleted, al.is_published, al.published_date, al.asset_guid, al.show_copyright,
			al.order_number, 1 as rno, u.display_name user_name, emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name,
			coalesce(pel.entity_display_name, emp.entity_display_name) pri_ent_disp_name,
			coalesce(sel.entity_display_name, ems.entity_display_name) sec_ent_disp_name,
			case v_is_detail when 1 then v_asset_language_erm_id else v_page_language_erm_id end as language_id,
			sd.meta_info->>'keywords' keywords, sd.meta_info, v_full_text as full_text,
			case v_is_detail when 1 then v_asset_language_entity_url else v_page_language_entity_url end as lang_url,
			v_browser_title browser_title, 0 is_amp, cp.content_provider_id content_source_id, cp.content_provider_name,
			web_detail_jsn->'data'->>'client_canonical_url' as client_canonical_url
	from labyho.labyho_asset_list al
	join labyho.labyho_entity_role_map ermp
	on ermp.entity_role_map_id = al.primary_entity_role_map_id
	join labyho.labyho_entity_role_map erms
	on erms.entity_role_map_id = al.secondary_entity_role_map_id
	join labyho.labyho_entity_master emp
	on emp.entity_master_id = ermp.entity_master_id
	join labyho.labyho_entity_master ems
	on ems.entity_master_id = erms.entity_master_id
	left join labyho.labyho_user u
	on u.user_id = al.author_id
	left join labyho.labyho_entity_language_map pel
	on emp.entity_master_id = pel.entity_master_id
	and pel.language_master_id = case v_is_detail when 1 then v_asset_language_em_id else v_page_language_em_id end
	left join labyho.labyho_entity_language_map sel
	on ems.entity_master_id=sel.entity_master_id
	and sel.language_master_id = case v_is_detail when 1 then v_asset_language_em_id else v_page_language_em_id end
	left join labyho.labyho_seo_data sd
	on sd.asset_id = al.asset_id
	and sd.asset_type_id = al.asset_type_id
	left join yho.yho_provider_author_map pam
	on pam.author_id = al.author_id
	left join yho.yho_content_provider cp
	on cp.content_provider_id = pam.content_provider_id
	where al.asset_id = case v_is_detail when 1 then v_asset_id else v_page_id end
	and al.asset_type_id = case v_is_detail when 1 then v_asset_type_id else v_page_asset_type_id end
	and al.is_active = 1
	and al.is_deleted = 0
	and al.is_published = 1
	and al.published_date <= current_timestamp at time zone 'utc';
	                                            
end;

$_$;


--
