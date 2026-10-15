-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_get_canonical_url_r(numeric)
-- Type: FUNCTION

-- Name: labukk_get_canonical_url_r(numeric); Type: FUNCTION; Schema: labukk; Owner: -
--

CREATE FUNCTION labukk.labukk_get_canonical_url_r(p_entity_role_map_id numeric, OUT p_canonical_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	if exists(select 1 from labukk.labukk_entity_role_map where entity_role_map_id = p_entity_role_map_id) then
    	select canonical_url
        into   p_canonical_url
        from   labukk.labukk_entity_master
        where  entity_master_id =(select entity_master_id
                                  from   labukk.labukk_entity_role_map
                                  where  entity_role_map_id = p_entity_role_map_id);
    end if;
end;

 $$;


--
