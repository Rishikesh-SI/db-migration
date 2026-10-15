-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_entity_url_r(numeric)
-- Type: FUNCTION

-- Name: labwis_get_entity_url_r(numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_entity_url_r(p_entity_role_map_id numeric, OUT p_ent_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 

begin
	if exists(select 1 from labwis.labwis_entity_role_map where entity_role_map_id = p_entity_role_map_id) then
    	select entity_url
        into   p_ent_url
        from   labwis.labwis_entity_master
        where  entity_master_id =(select entity_master_id
                                  from   labwis.labwis_entity_role_map
                                  where  entity_role_map_id = p_entity_role_map_id);
    end if;

	-- if p_ent_url is null 
	-- and p_entity_role_map_id <> 190727 
	-- then 
	-- 	if exists(select 1 from labwis.labwis_entity_role_map where entity_role_map_id = p_entity_role_map_id) then
 --    	select canonical_url
 --        into   p_ent_url
 --        from   labwis.labwis_entity_master
 --        where  entity_master_id =(select entity_master_id
 --                                  from   labwis.labwis_entity_role_map
 --                                  where  entity_role_map_id = p_entity_role_map_id);
	-- 	end if;
	-- 	end if;
end;

 
$$;


--
