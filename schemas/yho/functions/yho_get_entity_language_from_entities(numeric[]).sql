-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_entity_language_from_entities(numeric[])
-- Type: FUNCTION

-- Name: yho_get_entity_language_from_entities(numeric[]); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_entity_language_from_entities(p_ent_role_map_id numeric[], OUT p_language_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
begin
    
    SELECT er.entity_role_map_id
    INTO p_language_id
    FROM yho.yho_ENTITY_CATEGORY ec
    join yho.yho_entity_role_map er
    on ec.entity_role_id=er.entity_role_id
    WHERE category_name='Language'
    and er.entity_role_map_id in (select entity_role_map_id from UNNEST(p_ent_role_map_id)entity_role_map_id)
    LIMIT 1;
end ;

 $$;


--
