-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_country_state_city(numeric, numeric)
-- Type: FUNCTION

-- Name: waf_get_country_state_city(numeric, numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_country_state_city(p_country_id numeric, p_state_id numeric, OUT p_country_json jsonb, OUT p_state_json jsonb, OUT p_city_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
	select ('{"countries":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb into p_country_json
	from (
			select country_id,short_name,name,phone_code
			from waf_master.waf_countries
	) row;
	if p_country_id is not null then
		select ('{"states":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb into p_state_json
		from (
				select state_id,name,country_id
				from waf_master.waf_states
				where country_id = p_country_id
			) row;
		if p_state_id is not null then
			select ('{"cities":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb into p_city_json
			from (
					select city_id,name,state_id
					from waf_master.waf_cities
					where state_id = p_state_id
			) row;
		else
			p_city_json := '{"cities":[]}'::jsonb;
		end if;
	else
		p_state_json := '{"states":[]}'::jsonb;
		p_city_json := '{"cities":[]}'::jsonb;
	end if;
end;

$$;


--
