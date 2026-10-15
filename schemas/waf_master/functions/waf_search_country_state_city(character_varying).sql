-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_search_country_state_city(character varying)
-- Type: FUNCTION

-- Name: waf_search_country_state_city(character varying); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_search_country_state_city(p_search_text character varying, OUT p_city_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	 
		 
			select ('{"cities":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb into p_city_json
			from (
					select city_id,name,state_id
					from waf_master.waf_cities
					where upper(name) like '%'|| upper(p_search_text)||'%'
			) row;
		 
		 
  exception when others then
 p_city_json := '{"cities":[]}'::jsonb;
end;

$$;


--
