-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: labecn_get_entity_name(numeric)
-- Type: FUNCTION

-- Name: labecn_get_entity_name(numeric); Type: FUNCTION; Schema: labecn_bkp07062024; Owner: -
--

CREATE FUNCTION labecn_bkp07062024.labecn_get_entity_name(p_entity_role_map_id numeric, OUT p_entity_name character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin

select coalesce(em.wafc_entity_display_name,em.entity_display_name) into p_entity_name
from labecn.labecn_entity_role_map erm
inner join labecn.labecn_entity_master  em on em.entity_master_id=erm.entity_master_id
where erm.entity_role_map_id=p_entity_role_map_id;

end;

 $$;


--
