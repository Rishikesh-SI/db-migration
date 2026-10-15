-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_get_entity_known_as(numeric)
-- Type: FUNCTION

-- Name: labkkr_get_entity_known_as(numeric); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_get_entity_known_as(p_entity_role_map_id numeric, OUT p_entity_known_as character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin

select 
em.known_as into p_entity_known_as
from labkkr.labkkr_entity_role_map erm
inner join labkkr.labkkr_entity_master  em on em.entity_master_id=erm.entity_master_id
where erm.entity_role_map_id=p_entity_role_map_id;

end;

 $$;


--
