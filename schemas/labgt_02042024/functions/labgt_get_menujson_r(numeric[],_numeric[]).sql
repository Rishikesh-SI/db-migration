-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_get_menujson_r(numeric[], numeric[])
-- Type: FUNCTION

-- Name: labgt_get_menujson_r(numeric[], numeric[]); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_get_menujson_r(p_template_comp_map_id numeric[], p_menu_id numeric[], OUT p_navigation_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
    
	v_navigation_json json;
	
	begin

	if p_template_comp_map_id is not null then 
	
		select navigation into v_navigation_json from labgt.labgt_navigation
		where template_comp_map_id = p_template_comp_map_id;
	
	elseif p_menu_id is not null then
	
		select navigation into v_navigation_json from labgt.labgt_navigation
		where menu_id = p_menu_id;
		
	end if ;
	

    p_navigation_json := v_navigation_json ;
	
	--- raise notice '%' , p_navigation_json;

	end;
$$;


--
