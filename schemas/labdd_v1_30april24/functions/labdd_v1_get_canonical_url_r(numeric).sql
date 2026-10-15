-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_get_canonical_url_r(numeric)
-- Type: FUNCTION

-- Name: labdd_v1_get_canonical_url_r(numeric); Type: FUNCTION; Schema: labdd_v1_30april24; Owner: -
--

CREATE FUNCTION labdd_v1_30april24.labdd_v1_get_canonical_url_r(p_entity_role_map_id numeric, OUT p_canonical_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	if exists(select 1 from labdd_v1.labdd_v1_entity_role_map where entity_role_map_id = p_entity_role_map_id) then
    	select canonical_url
        into   p_canonical_url
        from   labdd_v1.labdd_v1_entity_master
        where  entity_master_id =(select entity_master_id
                                  from   labdd_v1.labdd_v1_entity_role_map
                                  where  entity_role_map_id = p_entity_role_map_id);
    end if;
end;

 $$;


--
