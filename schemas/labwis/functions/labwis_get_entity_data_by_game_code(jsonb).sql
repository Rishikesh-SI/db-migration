-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_entity_data_by_game_code(jsonb)
-- Type: FUNCTION

-- Name: labwis_get_entity_data_by_game_code(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_entity_data_by_game_code(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
v_game_code           character varying;
v_asset_type_id		  numeric;
v_entity_role_id numeric;
v_json jsonb;
BEGIN

select
p_in_json->'data'->>'gamecode',
p_in_json->'data'->>'asset_type_id'
into
v_game_code,
v_asset_type_id;

select entity_role_id into v_entity_role_id
from labwis.labwis_asset_type
where asset_type_id = v_asset_type_id;

if exists(select 1 from labwis.labwis_entity_role_map where entity_role_id = v_entity_role_id and source_object_id = v_game_code) then

	raise notice 'v_entity_role_id %',v_entity_role_id;

	select '{"data":' || json_agg(a.*) || '}' from 
	(select entity_display_name,canonical_url,entity_url,source_object_id,add_info,entity_role_map_id,
	entity_type_name,et.entity_type_id,0 as is_lang 
	from labwis.labwis_entity_role_map erm 
	join labwis.labwis_entity_master em on erm.entity_master_id = em.entity_master_id
	join labwis.labwis_entity_role er on er.entity_role_id = erm.entity_role_id
	join labwis.labwis_entity_type et on er.entity_type_id = et.entity_type_id
	where erm.source_object_id= v_game_code)a into v_json;
	
	p_out_json := v_json;
end if;

END
$$;


--
