-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_get_entity_name_and_id_r(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_entity_name_and_id_r(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_get_entity_name_and_id_r(p_data_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare
	v_asset_type_id numeric;
begin
	
select p_data_json->>'asset_type_id'
into   v_asset_type_id;

		select json_agg(x) from
		(select a.entity_name as value,b.entity_role_map_id as id
		from labrr.labrr_entity_master a
		 join labrr.labrr_entity_role_map b
		 on a.entity_master_id=b.entity_master_id
		 where b.entity_role_id in (select entity_role_id
								   from labrr.labrr_asset_type
								   where asset_type_id=v_asset_type_id)
		)x
		into p_out_json;
end;
$$;


--
