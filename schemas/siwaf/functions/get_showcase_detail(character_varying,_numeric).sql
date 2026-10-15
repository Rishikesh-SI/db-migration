-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_showcase_detail(character varying, numeric)
-- Type: FUNCTION

-- Name: _get_showcase_detail(character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_showcase_detail(p_schema_prefix character varying, p_showcase_id numeric, OUT p_result numeric, OUT p_showcase_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_version_number numeric;
	
begin
	
	execute 'select max(published_version_number)
			from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map
			where template_component_map_id = '||p_showcase_id
	into v_version_number;
	
	execute 'select (''{"data":''||string_agg(row_to_json(row)::text,'','')||''}'')::jsonb
			from (select tcm.title, ad.asset_data
					from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
					join '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_map tcm
					on tcm.template_component_map_id = ad.asset_id
					where asset_id = '||p_showcase_id||'
					and asset_type_id = 8
					and version_number = '||v_version_number||') row'
	into p_showcase_json;
	
	p_result := 1;

exception
	when others then
		p_result := -1;
		p_showcase_json := '{"data":null}'::jsonb; 
		
end;
$$;


--
