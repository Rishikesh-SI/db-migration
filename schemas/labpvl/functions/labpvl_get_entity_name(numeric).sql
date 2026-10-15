-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_get_entity_name(numeric)
-- Type: FUNCTION

-- Name: labpvl_get_entity_name(numeric); Type: FUNCTION; Schema: labpvl; Owner: -
--

CREATE FUNCTION labpvl.labpvl_get_entity_name(p_entity_role_map_id numeric, OUT p_entity_name character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin

select coalesce(em.wafc_entity_display_name,em.entity_display_name) into p_entity_name
from labpvl.labpvl_entity_role_map erm
inner join labpvl.labpvl_entity_master  em on em.entity_master_id=erm.entity_master_id
where erm.entity_role_map_id=p_entity_role_map_id;

end;

 $$;


--
