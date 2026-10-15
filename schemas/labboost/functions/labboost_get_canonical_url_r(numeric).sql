-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_get_canonical_url_r(numeric)
-- Type: FUNCTION

-- Name: labboost_get_canonical_url_r(numeric); Type: FUNCTION; Schema: labboost; Owner: -
--

CREATE FUNCTION labboost.labboost_get_canonical_url_r(p_entity_role_map_id numeric, OUT p_canonical_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	if exists(select 1 from labboost.labboost_entity_role_map where entity_role_map_id = p_entity_role_map_id) then
    	select canonical_url
        into   p_canonical_url
        from   labboost.labboost_entity_master
        where  entity_master_id =(select entity_master_id
                                  from   labboost.labboost_entity_role_map
                                  where  entity_role_map_id = p_entity_role_map_id);
    end if;
end;

 $$;


--
