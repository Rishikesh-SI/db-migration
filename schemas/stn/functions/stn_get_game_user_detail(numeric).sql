-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_game_user_detail(numeric)
-- Type: FUNCTION

-- Name: stn_get_game_user_detail(numeric); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_game_user_detail(p_user_id numeric, OUT p_user_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
	
	if exists(select 1 from stn.stn_user_info where user_id = p_user_id) then
		
		select ('{"user":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
		from (select * from stn.stn_user_info where user_id = p_user_id)row
		into p_user_json;
		
		p_result := 1;
		
	else
		
		p_user_json := '{"user":[]}'::jsonb;
		p_result := 0;
		
	end if;
	
exception
	when others then
		p_user_json := '{"user":[]}'::jsonb;
		p_result := -1;
	
end;

$$;


--
