-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_get_entity_language_from_entities(numeric[])
-- Type: FUNCTION

-- Name: labiis_get_entity_language_from_entities(numeric[]); Type: FUNCTION; Schema: labiis; Owner: -
--

CREATE FUNCTION labiis.labiis_get_entity_language_from_entities(p_ent_role_map_id numeric[], OUT p_language_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
begin
    
    select er.entity_role_map_id
    into p_language_id
    from labiis.labiis_entity_category ec
    join labiis.labiis_entity_role_map er
    on ec.entity_role_id=er.entity_role_id
    where category_name='Language'
    and er.entity_role_map_id in (select entity_role_map_id from unnest(p_ent_role_map_id)entity_role_map_id)
    limit 1;
end ;

 $$;


--
