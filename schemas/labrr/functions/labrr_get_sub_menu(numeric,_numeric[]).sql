-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_sub_menu(numeric, numeric[])
-- Type: FUNCTION

-- Name: labrr_get_sub_menu(numeric, numeric[]); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_sub_menu(p_parent_id numeric, p_template_comp_map_id numeric[], OUT p_submenu_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from labrr.labrr_get_sub_menu(
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
	
	
begin

select json_agg(row) from (select p.alias,a.*,b.template_component_map_id
							from labRR.labRR_menu_page_map a
		join labRR.labRR_page_template_component_menu_map b
		on b.menu_id = tab.menu_id
		and b.template_component_map_id=p_template_comp_map_id
		join labRR.labRR_page p
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
		into p_submenu_json;
end;
$$;


--
