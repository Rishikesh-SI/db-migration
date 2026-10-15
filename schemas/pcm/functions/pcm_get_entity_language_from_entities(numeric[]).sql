-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_get_entity_language_from_entities(numeric[])
-- Type: FUNCTION

-- Name: pcm_get_entity_language_from_entities(numeric[]); Type: FUNCTION; Schema: pcm; Owner: -
--

CREATE FUNCTION pcm.pcm_get_entity_language_from_entities(p_ent_role_map_id numeric[], OUT p_language_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
begin
    
    SELECT er.entity_role_map_id
    INTO p_language_id
    FROM pcm.pcm_ENTITY_CATEGORY ec
    join pcm.pcm_entity_role_map er
    on ec.entity_role_id=er.entity_role_id
    WHERE category_name='Language'
    and er.entity_role_map_id in (select entity_role_map_id from UNNEST(p_ent_role_map_id)entity_role_map_id)
    LIMIT 1;
end ;

 $$;


--
