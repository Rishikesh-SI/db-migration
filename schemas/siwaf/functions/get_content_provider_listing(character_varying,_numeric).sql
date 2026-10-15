-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_content_provider_listing(character varying, numeric)
-- Type: FUNCTION

-- Name: _get_content_provider_listing(character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_content_provider_listing(p_schema_prefix character varying, p_content_provider_id numeric, OUT p_result numeric, OUT p_content_provider_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
	
	execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select *
					from '||p_schema_prefix||'.'||p_schema_prefix||'_content_provider
					where (content_provider_id = '||p_content_provider_id||' or coalesce('||p_content_provider_id||', 0) = 0)
					and is_active = 1
					and is_deleted = 0) row'
     into p_content_provider_json;
	
	p_result := 1;
     
exception
	when others then
		p_result := -1;
		p_content_provider_json := '{"data":[]}'::jsonb;
	
end;

$$;


--
