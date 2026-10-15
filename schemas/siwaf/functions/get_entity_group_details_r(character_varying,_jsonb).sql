-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_group_details_r(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_entity_group_details_r(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_group_details_r(p_schema_prefix character varying, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	 v_entity_group_id numeric; 
begin
     
	 select  p_json->'id'
	 into    v_entity_group_id;
	 
	 execute 'select row_to_json(row) from (select * from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group  where entity_group_id='|| v_entity_group_id||') as row;'
	 into p_data;
	 
end;

 

$$;


--
