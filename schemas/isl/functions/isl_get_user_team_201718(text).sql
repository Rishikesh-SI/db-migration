-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_user_team_201718(text)
-- Type: FUNCTION

-- Name: isl_get_user_team_201718(text); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_user_team_201718(p_user_id text, OUT p_user_team_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_id numeric;
	
begin
	
	select user_id into strict v_user_id
	from isl.isl_web_user
	where user_guid = p_user_id;
	
	if exists(select 1 from isl.isl_user_team where user_id = v_user_id) then
		select team_json into p_user_team_json from isl.isl_user_team where user_id = v_user_id;
		p_result := 1;
	else
		p_result := 0;
        p_user_team_json := null;
	end if;
	
exception
	when others then
		p_result := -1;
        p_user_team_json := null;
	
end;

$$;


--
