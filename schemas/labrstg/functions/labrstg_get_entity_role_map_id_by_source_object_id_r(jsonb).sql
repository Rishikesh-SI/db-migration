-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_entity_role_map_id_by_source_object_id_r(jsonb)
-- Type: FUNCTION

-- Name: labrstg_get_entity_role_map_id_by_source_object_id_r(jsonb); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_entity_role_map_id_by_source_object_id_r(p_json jsonb, OUT p_result numeric, OUT v_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 

	v_asset_type_id numeric;
	v_source_object_text text;
	v_source_object_id character varying[];

	begin

	select p_json->>'asset_type_id',
	p_json->>'source_object_id'
	into
	v_asset_type_id,
	v_source_object_text;
	v_source_object_id:=(SELECT  string_to_array(v_source_object_text,','));
	
	raise notice 'v_asset_type_id % ',v_asset_type_id;
	raise notice 'v_source_object_id % ',v_source_object_id;
	
	 select json_agg(row_alias)
	   from 
				(select B.asset_type_id,A.entity_role_map_id, A.source_object_id 
				from labrstg.labrstg_entity_role_map A
				join labrstg.labrstg_asset_type B
				on A.entity_role_id=B.entity_role_id
				where B.asset_type_id = v_asset_type_id
			    and A.source_object_id in (select source_object_id from unnest( v_source_object_id)source_object_id))
				--and A.source_object_id=ANY(v_source_object_id)
				 row_alias
				into v_json  ;

	p_result:=1;

	end;
$$;


--
