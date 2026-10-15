-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_showcase(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_showcase(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_showcase(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_showcase_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_json jsonb := p_json;
	v_showcase_id numeric;
	v_published_date timestamp;
	v_updated_by numeric;
	v_asset_map jsonb;
	v_language_entity_role_map_id numeric;
	v_version_number numeric;
	v_asset_json json;
	v_i numeric := 0;
	v_asset_id numeric;
	v_asset_type_id numeric;
	v_asset_order numeric;
	v_asset_entity json;
	v_entity_json json;
	v_entity_role_map_id numeric;
	v_priority numeric;
	v_asset_entity_map_id numeric;
	v_template_component_asset_map_id numeric;
	v_asset_draft_id numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	
begin
	
	select v_json->'data'->>'showcase_id', v_json->'data'->>'published_date', v_json->'data'->>'updated_by', v_json->'data'->'asset_map',
			v_json->'data'->>'language_id'
	into v_showcase_id, v_published_date, v_updated_by, v_asset_map, v_language_entity_role_map_id;
	
	execute 'select coalesce(max(published_version_number),0) + 1
			from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map
			where template_component_map_id = '||p_showcase_id
	into v_version_number;	
	
	if v_version_number > 1 then
		
		execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
				where exists(select 1
							from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
							where tcam.asset_id = aem.asset_id
							and tcam.asset_type_id = aem.asset_type_id
							and tcam.asset_type_id = 12
							and tcam.language_entity_role_map_id = '||v_language_entity_role_map_id||')';
		
		execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map
				where template_component_map_id = '||p_showcase_id||'
				and language_entity_role_map_id = '||v_language_entity_role_map_id||')';
		
	end if;
	
	for v_asset_json in select * from json_array_elements(v_asset_map::json)
	loop
		
		v_i := v_i + 1;
		
		select (v_asset_json->'asset_meta'->>'asset_id')::numeric, (v_asset_json->'asset_meta'->>'asset_type_id')::numeric,
				(v_asset_json->>'asset_order')::numeric, (v_asset_json->'entitydata')::jsonb
		into v_asset_id, v_asset_type_id, v_asset_order, v_asset_entity;
		
		if v_asset_id is null and v_asset_type_id = 12 then
			
			execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_external_asset_id'')'
			into v_asset_id;
			
			v_asset_json := jsonb_set(v_asset_json::jsonb,'{asset_id}',v_asset_id::jsonb,true);
			v_asset_json := jsonb_set(v_asset_json::jsonb,'{asset_meta,asset_id}',v_asset_id::jsonb,true);
			
			for v_entity_json in select * from json_array_elements(v_asset_entity)
			loop
				
				select (v_entity_json->>'entity_role_map_id')::numeric, (v_entity_json->>'priority')::numeric
				into v_entity_role_map_id, v_priority;
				
				execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_entity_map_id'')'
				into v_asset_entity_map_id;
				
				execute 'insert into '||$1||'.'||$1||'_asset_entity_map(asset_entity_map_id,asset_id,asset_type_id,entity_role_map_id,
																priority)
						values($2,$3,$4,$5,$6)'
				using p_schema_prefix,v_asset_entity_map_id,v_asset_id,v_asset_type_id,v_entity_role_map_id,v_priority;
				
			end loop;
			
		end if;
		
		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_template_component_asset_map_id'')'
		into v_template_component_asset_map_id;
		
		execute 'insert into '||$1||'.'||$1||'_template_component_asset_map(template_component_asset_map_id,template_component_map_id,
																asset_order,asset_id,asset_type_id,asset_meta)
				values($2,$3,$4,$5,$6,$7)'
		using p_schema_prefix,v_template_component_asset_map_id,p_showcase_id,v_asset_order,v_asset_id,v_asset_type_id,v_asset_json;
		
	end loop;
	
	execute 'select (''[''||string_agg(asset_map::text,'','')||'']'')::jsonb
			from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map
			where template_component_map_id = '||p_showcase_id
	into v_asset_map;
	
	v_json := jsonb_set(v_json,'{data,asset_map}',v_asset_map,true);
	
	execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_draft_id'')'
	into v_asset_draft_id;
	
	execute 'insert into '||$1||'.'||$1||'_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,
												updated_date,created_by,updated_by,is_active,is_deleted,asset_draft_guid)
			values($2,$3,8,$4,$5,$6,$6,$7,$7,1,0,$8)'
	using p_schema_prefix,v_asset_draft_id,p_showcase_id,v_version_number,v_json,v_current_timestamp,v_updated_by,uuid_generate_v4();
	
	execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft
			where asset_id = '||p_showcase_id||'
			and asset_type_id = 8
			and version_number = '||(v_version_number - 1);
	
	p_result := 1;
	p_showcase_json := v_json;
	
	if p_showcase_json is null then
		p_result := 0;
		p_showcase_json := '{"data":[]}'::jsonb;
	end if;
	
exception
	when others then
		p_result := -1;
		p_showcase_json := '{"data":[]}'::jsonb;
end;
$_$;


--
