-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_get_entity_known_as(numeric)
-- Type: FUNCTION

-- Name: upstox_get_entity_known_as(numeric); Type: FUNCTION; Schema: upstox; Owner: -
--

CREATE FUNCTION upstox.upstox_get_entity_known_as(p_entity_role_map_id numeric, OUT p_entity_known_as character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin

select 
em.known_as into p_entity_known_as
from upstox.upstox_entity_role_map erm
inner join upstox.upstox_entity_master  em on em.entity_master_id=erm.entity_master_id
where erm.entity_role_map_id=p_entity_role_map_id;

end;

 $$;


--
