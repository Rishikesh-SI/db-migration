-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_get_entity_language_from_entities(numeric[])
-- Type: FUNCTION

-- Name: labos_get_entity_language_from_entities(numeric[]); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_get_entity_language_from_entities(p_ent_role_map_id numeric[], OUT p_language_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
begin
    
    select er.entity_role_map_id
    into p_language_id
    from labos.labos_entity_category ec
    join labos.labos_entity_role_map er
    on ec.entity_role_id=er.entity_role_id
    where category_name='Language'
    and er.entity_role_map_id in (select entity_role_map_id from unnest(p_ent_role_map_id)entity_role_map_id)
    limit 1;
end ;

 $$;


--
