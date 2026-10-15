-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_canonical_url_r(numeric)
-- Type: FUNCTION

-- Name: swa_get_canonical_url_r(numeric); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_canonical_url_r(p_entity_role_map_id numeric, OUT p_canonical_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$

begin
	if exists(select 1 from swa.swa_entity_role_map where entity_role_map_id = p_entity_role_map_id) then
    	select canonical_url
        into   p_canonical_url
        from   swa.swa_entity_master
        where  entity_master_id =(select entity_master_id
                                  from   swa.swa_entity_role_map
                                  where  entity_role_map_id = p_entity_role_map_id);
    end if;
end;

$$;


--
