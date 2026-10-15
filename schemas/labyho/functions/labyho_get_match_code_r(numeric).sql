-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_match_code_r(numeric)
-- Type: FUNCTION

-- Name: labyho_get_match_code_r(numeric); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_match_code_r(p_match_id numeric, OUT p_match_code text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	
	v_entity_role_id numeric;
	
begin
	
	select entity_role_id
	from labyho.labyho_entity_type et
	join labyho.labyho_entity_role er
	on er.entity_type_id = et.entity_type_id
	where et.entity_type_id = 5
	into v_entity_role_id;
	
	select source_object_id
	from labyho.labyho_entity_role_map
	where entity_role_id = v_entity_role_id
	and reverse(substring(reverse(source_object_id),1,6))::numeric = p_match_id
	into p_match_code;
	
end;
$$;


--
