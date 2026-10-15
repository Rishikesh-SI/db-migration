-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_get_sub_menu(numeric, numeric[])
-- Type: FUNCTION

-- Name: labdd_v1_get_sub_menu(numeric, numeric[]); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_get_sub_menu(p_parent_id numeric, p_template_comp_map_id numeric[], OUT p_submenu_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from labdd_v1.labdd_v1_get_sub_menu(
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
--v_menu_id numeric :=p_menu_id;
v_page_id numeric;
v_submenu jsonb;
v_menu_array text:='[';
begin
--------------	

			select json_agg(row) from (select p.alias,a.*,b.template_component_map_id
								from labdd_v1.labdd_v1_menu_page_map a
			join labdd_v1.labdd_v1_page_template_component_menu_map b
			on b.menu_id = a.menu_id
			join labdd_v1.labdd_v1_page p
			on a.page_id = p.page_id					
			where a.parent_page_id=p_parent_id
			and b.is_active = 1
			and b.template_component_map_id = any(p_template_comp_map_id) 					   
			and b.is_deleted = 0
			and b.is_published = 1
			and a.is_active = 1
			and a.is_deleted = 0
			and p.is_active = 1
			and p.is_deleted = 0
			order by a.page_level, a.order_number) row
			into v_submenu;
			

			for i in select * from jsonb_array_elements(v_submenu)
			loop
			
				select i->>'page_id'
				into v_page_id;
				

				if (select count(1) from labdd_v1.labdd_v1_menu_page_map where parent_page_id=v_page_id) > 0 then
					select * from labdd_v1.labdd_v1_get_sub_menu(v_page_id,p_template_comp_map_id) into p_submenu_json;
					
					if p_submenu_json = '[]' THEN
						p_submenu_json:= null;
					end if;
					
					i:= jsonb_set(i,'{sub_menu}',coalesce(p_submenu_json,'null'),true);
				--raise notice 'i %',i;

				end if;

		     	v_menu_array := v_menu_array||i||',';
	 
				 
			end loop;
			v_menu_array := v_menu_array||']';
			select REPLACE(v_menu_array, ',]', ']' ) into p_submenu_json;

		--p_submenu_json:=v_menu_array;
end;
$$;


--
