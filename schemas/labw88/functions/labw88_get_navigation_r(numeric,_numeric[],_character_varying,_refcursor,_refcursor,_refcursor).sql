-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_get_navigation_r(numeric, numeric[], character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labw88_get_navigation_r(numeric, numeric[], character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labw88; Owner: -
--

CREATE FUNCTION labw88.labw88_get_navigation_r(p_parent_id numeric, p_template_comp_map_id numeric[], p_entity character varying, p_menu_cur refcursor, p_navigation_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from labw88.labw88_get_navigation_r(
	null,-- <p_parent_id numeric>, 
	array[2],-- <p_template_comp_map_id numeric[]>, 
	'4',-- <p_entity character varying>, 
	'a',-- <p_menu_cur refcursor>, 
	'b',-- <p_navigation_cur refcursor>, 
	'c'-- <p_page_ent_cur refcursor>
);
fetch all in "a";
*/
declare
	
	v_entity_array numeric[];
	v_template_id numeric;
	v_template_component_map_id numeric;
	v_fetch_from numeric;
	v_menu_id numeric;
	v_tcm_entity_arr numeric[];
	v_menu_entity_arr numeric[];
	v_parent_id numeric := p_parent_id;
	
begin
	
	v_entity_array := string_to_array(p_entity,',')::numeric[];
	
	raise notice 'v_entity_array : %',v_entity_array;
	
	select template_id
	into v_template_id
	from labw88.labw88_template_component_map
	where template_component_map_id = p_template_comp_map_id[1];
	
	raise notice 'v_template_id : %',v_template_id;
	
 	if v_template_id is not null then
		
		select template_component_map_id, template_id, fetch_from, menu_id, tcm_entity_arr, menu_entity_arr
		from (select a.template_component_map_id, a.template_id, a.fetch_from, c.menu_id,
			 		(select array(select distinct entity_role_map_id
							    from labw88.labw88_asset_entity_map b
							    where b.asset_id = a.template_component_map_id
							    and b.asset_type_id = 13
							    order by 1)) as tcm_entity_arr,
					(select array(select distinct d.entity_role_map_id
							    from labw88.labw88_asset_entity_map d
							    where d.asset_id = c.menu_id
							    and d.asset_type_id = 22
							    order by 1)) as menu_entity_arr
			 from labw88.labw88_template_component_map a
			 join labw88.labw88_template t
			 on a.template_id = t.template_id
			 left join labw88.labw88_page_template_component_menu_map c
			 on c.template_component_map_id = a.template_component_map_id
			 and c.is_active = 1
			 and c.is_deleted = 0
			 where a.template_id = v_template_id
			 and a.template_component_map_id =any(p_template_comp_map_id)
			 and a.is_active = 1
			 and a.is_deleted = 0
			 and t.is_active = 1
			 and t.is_deleted = 0
			)a
		where menu_id is not null
		into v_template_component_map_id, v_template_id, v_fetch_from, v_menu_id, v_tcm_entity_arr, v_menu_entity_arr;
		
		raise notice 'v_template_component_map_id : %',v_template_component_map_id;
		raise notice 'v_template_id : %',v_template_id;
		raise notice 'v_fetch_from : %',v_fetch_from;
		raise notice 'v_menu_id : %',v_menu_id;
		raise notice 'v_tcm_entity_arr : %',v_tcm_entity_arr;
		raise notice 'v_menu_entity_arr : %',v_menu_entity_arr;
		
		if not v_menu_entity_arr <@ v_tcm_entity_arr then
			v_menu_id := 0;
		else
			if v_fetch_from <> 2 then
				if not v_menu_entity_arr <@ v_entity_array then
					v_menu_id := 0;
				end if;
			end if;
		end if;
		
		raise notice 'v_menu_id : %',v_menu_id;
		-- select 1/0;
		
		open p_menu_cur for
		select *
		from labw88.labw88_menu
		where menu_id = v_menu_id
		and is_active = 1
		and is_deleted = 0
		and is_published = 1;
    		
		open p_navigation_cur for
		select a.*, p.alias, b.template_component_map_id
		from labw88.labw88_menu_page_map a
		join labw88.labw88_page_template_component_menu_map b
		on b.menu_id = a.menu_id
		and b.template_component_map_id =any(p_template_comp_map_id)
		join labw88.labw88_page p
		on a.page_id = p.page_id
		where a.menu_id = v_menu_id
		and b.is_active = 1
		and b.is_deleted = 0
		and a.is_active = 1
		and a.is_deleted = 0
		and p.is_active = 1
		and p.is_deleted = 0
		order by a.page_level, a.order_number;
		
		open p_page_ent_cur for
     	select *, labw88.labw88_get_entity_known_as(entity_role_map_id) known_as
		from labw88.labw88_asset_entity_map
		where asset_type_id = 11
		and asset_id = v_parent_id;
		
	else
		
		open p_menu_cur for
		select * from labw88.labw88_menu where 1 = 0;
    		
		open p_navigation_cur for
		select a.*, null as alias, null as template_component_map_id
		from labw88.labw88_menu_page_map a
		where 1 = 0;
		
		open p_page_ent_cur for
		select a.*, null as known_as
		from labw88.labw88_asset_entity_map a
		where 1 = 0;
		
 	end if;
 	
end;

$$;


--
