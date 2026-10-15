-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_entity_name_by_asset(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: lablsg_v1_get_entity_name_by_asset(numeric, numeric, numeric); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_entity_name_by_asset(p_assettypeid numeric, p_assetid numeric, p_versionnumber numeric, OUT p_entityname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_asset_data jsonb;
     v_entityrolemapid numeric;
begin
	
     select asset_data
     into strict v_asset_data
     from   lablsg_v1.lablsg_v1_asset_draft
     where  asset_type_id  = p_assettypeid
     and    asset_id       = p_assetid
     and    version_number = p_versionnumber;
     
     with entity(t_json)
     as(
         values ((v_asset_data->'data'->>'entitydata')::json)
     )
     select (obj->>'entity_role_map_id')
     into   v_entityrolemapid
	from   entity e, json_array_elements(e.t_json#>'{}') obj
	where  (obj->>'priority')::numeric = 2
	limit  1;
	
	select em.entity_name
	into strict p_entityname
	from   lablsg_v1.lablsg_v1_entity_role_map erm
	join   lablsg_v1.lablsg_v1_entity_master em
	on     em.entity_master_id = erm.entity_master_id
	and    erm.entity_role_map_id = v_entityrolemapid;
	
exception
	when no_data_found then
     	p_entityname := ' ';

end;

 $$;


--
