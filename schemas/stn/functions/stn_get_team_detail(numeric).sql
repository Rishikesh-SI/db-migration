-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_team_detail(numeric)
-- Type: FUNCTION

-- Name: stn_get_team_detail(numeric); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_team_detail(p_team_id numeric, OUT p_team_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
	
	if exists(select 1 from stn.stn_team_info where team_id = p_team_id) then
		
		select ('{"team":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
		from (select * from stn.stn_team_info where team_id = p_team_id)row
		into p_team_json;
		
		p_result := 1;
		
	else
		
		p_team_json := '{"team":[]}'::jsonb;
		p_result := 0;
		
	end if;
	
exception
	when others then
		p_team_json := '{"team":[]}'::jsonb;
		p_result := -1;
	
end;

$$;


--
