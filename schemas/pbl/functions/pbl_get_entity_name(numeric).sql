-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_get_entity_name(numeric)
-- Type: FUNCTION

-- Name: pbl_get_entity_name(numeric); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_get_entity_name(p_entity_role_map_id numeric, OUT p_entity_name character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$  

begin

select coalesce(em.wafc_entity_display_name,em.entity_display_name) into p_entity_name
from pbl.pbl_entity_role_map erm
inner join pbl.pbl_entity_master  em on em.entity_master_id=erm.entity_master_id
where erm.entity_role_map_id=p_entity_role_map_id;

end;

  $$;


--
