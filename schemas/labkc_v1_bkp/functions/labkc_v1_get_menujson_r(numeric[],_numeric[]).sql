-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_get_menujson_r(numeric[], numeric[])
-- Type: FUNCTION

-- Name: labkc_v1_get_menujson_r(numeric[], numeric[]); Type: FUNCTION; Schema: labkc_v1_bkp; Owner: -
--

CREATE FUNCTION labkc_v1_bkp.labkc_v1_get_menujson_r(p_template_comp_map_id numeric[], p_menu_id numeric[], OUT p_navigation_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
    
	v_navigation_json json;
	
	begin

	if p_template_comp_map_id is not null then 
	
		select navigation into v_navigation_json from labkc_v1.labkc_v1_navigation
		where template_comp_map_id = p_template_comp_map_id;
	
	elseif p_menu_id is not null then
	
		select navigation into v_navigation_json from labkc_v1.labkc_v1_navigation
		where menu_id = p_menu_id;
		
	end if ;
	

    p_navigation_json := v_navigation_json ;
	
	--- raise notice '%' , p_navigation_json;

	end;
$$;


--
