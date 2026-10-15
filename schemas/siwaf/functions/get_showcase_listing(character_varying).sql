-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_showcase_listing(character varying)
-- Type: FUNCTION

-- Name: _get_showcase_listing(character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_showcase_listing(p_schema_prefix character varying, OUT p_result numeric, OUT p_showcase_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
	
	execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select tcm.template_component_map_id, title, tcmap_guid, erm.entity_role_map_id as language_entity_role_map_id,
						em.entity_name as language
					from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_map tcm
					join '||p_schema_prefix||'.'||p_schema_prefix||'_template t
					on t.template_id = tcm.template_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_template t1
					on t1.parent_id = t.template_id
					left join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
					on aem.asset_id = t1.page_id
					and aem.asset_type_id = 11
					left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
					on erm.entity_role_map_id = aem.entity_role_map_id
					left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_category ec
					on ec.entity_role_id = erm.entity_role_id
					left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
					on em.entity_master_id = erm.entity_master_id
					where tcm.component_id = 9
					and ec.category_name = '''||'Language'||''')row'
	into p_showcase_json;
	
	p_result := 1;
	
	if p_showcase_json is null then
		p_showcase_json := '{"data":[]}'::jsonb;
		p_result := 0;
	end if;
	
exception
	when others then
		p_showcase_json := '{"data":[]}'::jsonb;
		p_result := -1;
end;
$$;


--
