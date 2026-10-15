-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: labecn_get_canonical_url_r(numeric)
-- Type: FUNCTION

-- Name: labecn_get_canonical_url_r(numeric); Type: FUNCTION; Schema: labecn_bkp07062024; Owner: -
--

CREATE FUNCTION labecn_bkp07062024.labecn_get_canonical_url_r(p_entity_role_map_id numeric, OUT p_canonical_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	if exists(select 1 from labecn.labecn_entity_role_map where entity_role_map_id = p_entity_role_map_id) then
    	select canonical_url
        into   p_canonical_url
        from   labecn.labecn_entity_master
        where  entity_master_id =(select entity_master_id
                                  from   labecn.labecn_entity_role_map
                                  where  entity_role_map_id = p_entity_role_map_id);
    end if;
end;

 $$;


--
