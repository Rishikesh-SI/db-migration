-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_get_canonical_url_r(numeric)
-- Type: FUNCTION

-- Name: labmcfc_get_canonical_url_r(numeric); Type: FUNCTION; Schema: labmcfc; Owner: -
--

CREATE FUNCTION labmcfc.labmcfc_get_canonical_url_r(p_entity_role_map_id numeric, OUT p_canonical_url character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	if exists(select 1 from labmcfc.labmcfc_entity_role_map where entity_role_map_id = p_entity_role_map_id) 
	then
    	select coalesce(canonical_url,'/'||lower(entity_name))
        into   p_canonical_url
        from   labmcfc.labmcfc_entity_master
        where  entity_master_id =(select entity_master_id
                                  from   labmcfc.labmcfc_entity_role_map
                                  where  entity_role_map_id = p_entity_role_map_id);
    end if;
end;

 $$;


--
