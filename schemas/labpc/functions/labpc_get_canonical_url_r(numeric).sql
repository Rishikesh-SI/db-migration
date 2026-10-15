-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_get_canonical_url_r(numeric)
-- Type: FUNCTION

-- Name: labpc_get_canonical_url_r(numeric); Type: FUNCTION; Schema: labpc; Owner: -
--

CREATE FUNCTION labpc.labpc_get_canonical_url_r(p_entity_role_map_id numeric, OUT p_canonical_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	if exists(select 1 from labpc.labpc_entity_role_map where entity_role_map_id = p_entity_role_map_id) then
    	select canonical_url
        into   p_canonical_url
        from   labpc.labpc_entity_master
        where  entity_master_id =(select entity_master_id
                                  from   labpc.labpc_entity_role_map
                                  where  entity_role_map_id = p_entity_role_map_id);
    end if;
end;

 $$;


--
