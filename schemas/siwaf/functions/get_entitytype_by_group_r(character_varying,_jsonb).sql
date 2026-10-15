-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entitytype_by_group_r(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_entitytype_by_group_r(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entitytype_by_group_r(p_schema_prefix character varying, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	 v_entity_group_id numeric; 
	 entity_type_list jsonb;
begin
     
	 select  p_json->'groupid'
	 into    v_entity_group_id;
	 
	execute'(SELECT JSON_AGG(src) FROM (SELECT et.entity_type_id,et.entity_type_name FROM '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type et
                            join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role er on et.entity_type_id=er.entity_type_id
                            where er.entity_group_id='||v_entity_group_id||' and et.is_active=1 and et.is_deleted=0 and er.is_active=1 and er.is_deleted=0 ) src)'
     into entity_type_list;
	 
	 p_data = '{
	 "entity_type_list":'||entity_type_list ::text||'
	 }' ; 
	 
end;

$$;


--
