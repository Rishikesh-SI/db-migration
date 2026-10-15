-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_get_entity_language_from_entities(numeric[])
-- Type: FUNCTION

-- Name: ttmum_get_entity_language_from_entities(numeric[]); Type: FUNCTION; Schema: ttmum; Owner: -
--

CREATE FUNCTION ttmum.ttmum_get_entity_language_from_entities(p_ent_role_map_id numeric[], OUT p_language_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
begin
    
    SELECT er.entity_role_map_id
    INTO p_language_id
    FROM ttmum.ttmum_ENTITY_CATEGORY ec
    join ttmum.ttmum_entity_role_map er
    on ec.entity_role_id=er.entity_role_id
    WHERE category_name='Language'
    and er.entity_role_map_id in (select entity_role_map_id from UNNEST(p_ent_role_map_id)entity_role_map_id)
    LIMIT 1;
end ;

$$;


--
