-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_get_sub_menu(jsonb, numeric, numeric[], numeric)
-- Type: FUNCTION

-- Name: labos_get_sub_menu(jsonb, numeric, numeric[], numeric); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_get_sub_menu(p_json jsonb, p_parent_id numeric, p_template_comp_map_id numeric[], p_menu_id numeric, OUT p_submenu_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from labos.labos_get_sub_menu(
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
i jsonb;	
v_menu_id numeric :=p_menu_id;
v_page_id numeric;
begin
--------------	
		for i in select * from jsonb_array_elements(p_json)
		loop
			select page_id into v_page_id
			from labos.labos_menu_page_map
			where parent_page_id=p_parent_id
			and is_active=1 and is_deleted=0
			and menu_id=v_menu_id;
			raise notice 'v_page_id %',v_page_id;
			
			select json_agg(row) from (select p.alias,a.*,b.template_component_map_id
								from labos.labos_menu_page_map a
			join labos.labos_page_template_component_menu_map b
			on b.menu_id = a.menu_id
			and b.template_component_map_id=any(p_template_comp_map_id)
			join labos.labos_page p
			on a.page_id = p.page_id					
			where a.parent_page_id=v_page_id
			and a.menu_id=p_menu_id				   
			and b.is_active = 1
			and b.is_deleted = 0
			and b.is_published = 1
			and a.is_active = 1
			and a.is_deleted = 0
			and p.is_active = 1
			and p.is_deleted = 0
			order by a.page_level, a.order_number) row
			into p_submenu_json;
			
			p_json:= jsonb_set(p_json,'{0,sub_menu}',p_submenu_json,true);
			
			select * from labos.labos_get_sub_menu(p_json,v_page_id,p_template_comp_map_id,v_menu_id)
			into p_submenu_json;
			
		end loop;
		
		
		
end;
$$;


--
