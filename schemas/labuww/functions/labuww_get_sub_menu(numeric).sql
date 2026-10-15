-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_sub_menu(numeric)
-- Type: FUNCTION

-- Name: labuww_get_sub_menu(numeric); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_sub_menu(p_parent_id numeric, OUT p_submenu_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from labuww.labuww_get_sub_menu(
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
								from labuww.labuww_menu_page_map a
			join labuww.labuww_page_template_component_menu_map b
			on b.menu_id = a.menu_id
			join labuww.labuww_page p
			on a.page_id = p.page_id					
			where a.parent_page_id=p_parent_id
			and b.is_active = 1
			and b.is_deleted = 0
			and b.is_published = 1
			and a.is_active = 1
			and a.is_deleted = 0
			and p.is_active = 1
			and p.is_deleted = 0
			order by a.page_level, a.order_number) row
			into v_submenu;

			--raise notice 'v_submenu %',v_submenu;
			for i in select * from jsonb_array_elements(v_submenu)
			loop
			
				select i->>'page_id'
				into v_page_id;
				

				if (select count(1) from labuww.labuww_menu_page_map where parent_page_id=v_page_id) > 0 then
					--raise notice 'v_page_id %',v_page_id;
					select * from labuww.labuww_get_sub_menu(v_page_id) into p_submenu_json;
					
					
					i:= jsonb_set(i,'{sub_menu}',coalesce(p_submenu_json,'null'),true);
				raise notice 'i %',i;

				end if;
				--v_menu_array:=jsonb_array_elements(array_append(v_menu_array,i));
				--raise notice 'v_menu_array %',v_menu_array;
				
		     	v_menu_array := v_menu_array||i||',';
  			 -- raise notice 'v_menu_array %',v_menu_array;
	 
				 
			end loop;
			v_menu_array := v_menu_array||']';
				--raise notice 'v_menu_array %',v_menu_array;
			select REPLACE(v_menu_array, ',]', ']' ) into p_submenu_json;
				--raise notice 'p_submenu_json %',p_submenu_json;

		--p_submenu_json:=v_menu_array;
end;
$$;


--
