-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_entity_known_as(numeric)
-- Type: FUNCTION

-- Name: zeven_get_entity_known_as(numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_entity_known_as(p_entity_role_map_id numeric, OUT p_entity_known_as character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$    

begin

select 
em.known_as into p_entity_known_as
from zeven.zeven_entity_role_map erm
inner join zeven.zeven_entity_master  em on em.entity_master_id=erm.entity_master_id
where erm.entity_role_map_id=p_entity_role_map_id;

end;

    $$;


--
