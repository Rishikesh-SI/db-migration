-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_state_city(numeric)
-- Type: FUNCTION

-- Name: stn_get_state_city(numeric); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_state_city(p_state_id numeric, OUT p_state_json jsonb, OUT p_city_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
	
	select ('{"states":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
	from (select state_id, state_name from stn.stn_state_master order by state_name) row
	into p_state_json;
	
	if p_state_id is not null then
		
		select ('{"cities":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
		from (select city_id, city_name from stn.stn_state_master where state_id = p_state_id order by city_name) row
		into p_city_json;
		
	end if;
	
	p_result := 1;
	
exception
	when others then
		
		p_state_json := '{"states":[]}'::jsonb;
		p_city_json := '{"cities":[]}'::jsonb;
		p_result := -1;
	
end;

$$;


--
