-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_get_entity_language_from_entities(numeric[])
-- Type: FUNCTION

-- Name: labdd_v1_get_entity_language_from_entities(numeric[]); Type: FUNCTION; Schema: labdd_v1_30april24; Owner: -
--

CREATE FUNCTION labdd_v1_30april24.labdd_v1_get_entity_language_from_entities(p_ent_role_map_id numeric[], OUT p_language_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
begin
    
    select er.entity_role_map_id
    into p_language_id
    from labdd_v1.labdd_v1_entity_category ec
    join labdd_v1.labdd_v1_entity_role_map er
    on ec.entity_role_id=er.entity_role_id
    where category_name='Language'
    and er.entity_role_map_id in (select entity_role_map_id from unnest(p_ent_role_map_id)entity_role_map_id)
    limit 1;
end ;

 $$;


--
