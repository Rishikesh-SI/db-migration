-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_discussion_topic_listing(numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: isl_get_discussion_topic_listing(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_discussion_topic_listing(p_showcase_id numeric, p_page_number numeric, p_item_number numeric, p_sort_option numeric, OUT p_discussion_topic_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_from_row_number numeric;
	v_to_row_number numeric;
	v_count numeric;
	
begin
	
	if p_showcase_id is not null and p_page_number is not null and p_item_number is not null then
		
		v_from_row_number := (p_page_number * p_item_number - (p_item_number - 1));
  		v_to_row_number := (p_page_number * p_item_number);
		
		raise notice 'v_from_row_number : %',v_from_row_number;
		raise notice 'v_to_row_number : %',v_to_row_number;
		
		select count(1)
		into v_count
		from isl.isl_template_component_asset_map
		where template_component_map_id = p_showcase_id
		and asset_meta->>'asset_id' is not null
		and asset_meta->>'content_type' is not null;
		
		with tab as
		(
			select asset_id, asset_type_id, title, title_alias, image_path, image_name, asset_order, language_master_id, reaction_count,
					case coalesce(p_sort_option, 1)
						when 1 then row_number() over(order by asset_order)
						when 2 then row_number() over(order by reaction_count desc)
					end as rno
			from (select (tcam.asset_meta->>'asset_id')::numeric as asset_id, (tcam.asset_meta->>'content_type')::numeric as asset_type_id,
				  			tcam.asset_meta->>'title' as title, tcam.asset_meta->>'title_alias' as title_alias,
				  			(tcam.asset_meta->>'image_path') as image_path, (tcam.asset_meta->>'image_name') as image_name,
				  			tcam.asset_order, em.entity_master_id as language_master_id,
				  			(select count(1) from isl.isl_user_asset_reaction uar
							 where uar.asset_id = (tcam.asset_meta->>'asset_id')::numeric
							 and uar.asset_type_id = (tcam.asset_meta->>'content_type')::numeric) as reaction_count
				  from isl.isl_template_component_asset_map tcam
				  join isl.isl_asset_entity_map aem
				  on aem.asset_id = (tcam.asset_meta->>'asset_id')::numeric
				  and aem.asset_type_id = (tcam.asset_meta->>'content_type')::numeric
				  join isl.isl_entity_role_map erm
				  on erm.entity_role_map_id = aem.entity_role_map_id
				  join isl.isl_entity_category ec
				  on ec.entity_role_id = erm.entity_role_id
				  and ec.category_name = 'Language'
				  join isl.isl_entity_master em
				  on em.entity_master_id = erm.entity_master_id
				  where tcam.template_component_map_id = p_showcase_id
				  and tcam.asset_meta->>'asset_id' is not null
				  and tcam.asset_meta->>'content_type' is not null
				 ) tab
		)
		select ('{"items":'||json_agg(row)::text||'}')::jsonb
		from (select t.asset_id, t.asset_type_id, t.title, t.title_alias, t.image_path, t.image_name, t.reaction_count,
			  			al.primary_entity_role_map_id, al.secondary_entity_role_map_id, emp.entity_name primary_entity_name,
			  			ems.entity_name secondary_entity_name, coalesce(pel.entity_display_name, emp.entity_display_name) pri_ent_disp_name,
						coalesce(sel.entity_display_name, ems.entity_display_name) sec_ent_disp_name, al.published_date
			  from tab t
			  join isl.isl_asset_list al
			  on al.asset_id = t.asset_id
			  and al.asset_type_id = t.asset_type_id
			  join isl.isl_entity_role_map ermp
			  on ermp.entity_role_map_id = al.primary_entity_role_map_id
			  join isl.isl_entity_role_map erms
			  on erms.entity_role_map_id = al.secondary_entity_role_map_id
			  join isl.isl_entity_master emp
			  on emp.entity_master_id = ermp.entity_master_id
			  join isl.isl_entity_master ems
			  on ems.entity_master_id = erms.entity_master_id
			  left join isl.isl_entity_language_map pel
			  on emp.entity_master_id = pel.entity_master_id
			  and pel.language_master_id = t.language_master_id
			  left join isl.isl_entity_language_map sel
			  on ems.entity_master_id = sel.entity_master_id
			  and sel.language_master_id = t.language_master_id
			  where t.rno between v_from_row_number and v_to_row_number
			 ) as row
		into p_discussion_topic_json;
		
		raise notice 'v_count : %',v_count;
		raise notice 'p_discussion_topic_json : %',p_discussion_topic_json;
		
	else
		p_discussion_topic_json := '{"items":[]}'::jsonb;
		p_result := 0;
	end if;
	
	if p_discussion_topic_json is not null then
		p_result := v_count;
	end if;
	
/*exception
	when others then
		p_discussion_topic_json := '{"items":[]}'::jsonb;
		p_result := -1;*/
	
end;
$$;


--
