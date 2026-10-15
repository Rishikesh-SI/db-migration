-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_category_listing(character varying)
-- Type: FUNCTION

-- Name: _get_entity_category_listing(character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_category_listing(p_schema_prefix character varying, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 
	
	execute 'select (''{"data":''||json_agg(row_to_json(row))::text||''}'')::jsonb
				from (select et.entity_type_id::text, et.entity_type_name as type_name, et.is_child::text as display_child,
								(select json_agg(row)
									from (select et1.entity_type_name, er.entity_role_id, eg.group_name
											from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type et1
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role er
											on er.entity_type_id = et1.entity_type_id
											join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group eg
											on eg.entity_group_id = er.entity_group_id
											where et1.entity_type_id = et.entity_type_id
										) row
								) as items
						from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type et
					) row'
	into p_json;

end;

$$;


--
