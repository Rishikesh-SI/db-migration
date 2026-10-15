-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_get_cachebuster_navigation_details_r(jsonb)
-- Type: FUNCTION

-- Name: labecn_get_cachebuster_navigation_details_r(jsonb); Type: FUNCTION; Schema: labecn; Owner: -
--

CREATE FUNCTION labecn.labecn_get_cachebuster_navigation_details_r(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_menu_ids character varying;
	v_template_id numeric;
	v_menu_array numeric[];
begin
	select 
		   p_inputjson->>'menu_ids'   
	into   
		   v_menu_ids;
		   
	/*select template_id
	into v_template_id
	from labecn.labecn_template_component_map
	where template_component_map_id = v_template_comp_map_id;
	
	p_data:= (SELECT JSON_AGG(src) FROM (select template_id
	from labecn.labecn_template_component_map
	where template_component_map_id = v_template_comp_map_id) src)::jsonb;*/
	
	v_menu_array:= string_to_array(v_menu_ids,',')::numeric[];
	
	p_data:= (SELECT JSON_AGG(src) FROM (select *
		from (select a.template_component_map_id, a.template_id, a.fetch_from, c.menu_id,
			 		(select array(select distinct entity_role_map_id
							    from labecn.labecn_asset_entity_map b
							    where b.asset_id = a.template_component_map_id
							    and b.asset_type_id = 13
							    order by 1)) as tcm_entity_arr,
					(select array(select distinct d.entity_role_map_id
							    from labecn.labecn_asset_entity_map d
							    where d.asset_id = c.menu_id
							    and d.asset_type_id = 22
							    order by 1)) as menu_entity_arr
			 from labecn.labecn_template_component_map a
			 join labecn.labecn_template t
			 on a.template_id = t.template_id
			 left join labecn.labecn_page_template_component_menu_map c
			 on c.template_component_map_id = a.template_component_map_id
			 and c.is_active = 1
			 and c.is_deleted = 0
			 --where a.template_id = v_template_id
			 --and a.template_component_map_id =any(array[v_template_comp_map_id])
			 and a.is_active = 1
			 and a.is_deleted = 0
			 and t.is_active = 1
			 and t.is_deleted = 0
			)a
		where menu_id=any(v_menu_array))src)::jsonb;
end;
$$;


--
