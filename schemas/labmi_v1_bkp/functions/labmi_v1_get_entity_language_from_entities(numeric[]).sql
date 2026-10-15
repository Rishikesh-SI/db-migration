-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_get_entity_language_from_entities(numeric[])
-- Type: FUNCTION

-- Name: labmi_v1_get_entity_language_from_entities(numeric[]); Type: FUNCTION; Schema: labmi_v1_bkp; Owner: -
--

CREATE FUNCTION labmi_v1_bkp.labmi_v1_get_entity_language_from_entities(p_ent_role_map_id numeric[], OUT p_language_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare 
begin
    
    select er.entity_role_map_id
    into p_language_id
    from labmi_v1.labmi_v1_entity_category ec
    join labmi_v1.labmi_v1_entity_role_map er
    on ec.entity_role_id=er.entity_role_id
    where category_name='Language'
    and er.entity_role_map_id in (select entity_role_map_id from unnest(p_ent_role_map_id)entity_role_map_id)
    limit 1;
end ;

 $$;


--
