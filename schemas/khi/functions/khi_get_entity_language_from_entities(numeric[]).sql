-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_entity_language_from_entities(numeric[])
-- Type: FUNCTION

-- Name: khi_get_entity_language_from_entities(numeric[]); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_entity_language_from_entities(p_ent_role_map_id numeric[], OUT p_language_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$  

declare 
begin
    
    SELECT er.entity_role_map_id
    INTO p_language_id
    FROM khi.khi_ENTITY_CATEGORY ec
    join khi.khi_entity_role_map er
    on ec.entity_role_id=er.entity_role_id
    WHERE category_name='Language'
    and er.entity_role_map_id in (select entity_role_map_id from UNNEST(p_ent_role_map_id)entity_role_map_id)
    LIMIT 1;
end ;

  $$;


--
