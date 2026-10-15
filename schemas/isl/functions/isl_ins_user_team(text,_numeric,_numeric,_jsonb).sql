-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_user_team(text, numeric, numeric, jsonb)
-- Type: FUNCTION

-- Name: isl_ins_user_team(text, numeric, numeric, jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_user_team(p_user_id text, p_season_id numeric, p_week_id numeric, p_team_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_user_id numeric;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    
begin
	
    select user_id into strict v_user_id from isl.isl_web_user where user_guid = p_user_id;
    
    if exists(select 1 from isl.isl_season_weeks
              where season_id = p_season_id::varchar and week_id = p_week_id and v_current_timestamp between week_start_date and week_end_date) then
		if not exists(select 1 from isl.isl_user_team where user_id = v_user_id and season_id = p_season_id::varchar and week_id = p_week_id) then
        	insert into isl.isl_user_team
            select nextval('isl.seq_isl_user_team_id'),v_user_id,p_team_json,current_timestamp at time zone 'utc',p_season_id,p_week_id;
            p_result := 1;
		else
        	p_result := 0;
		end if;
	else
    	p_result := -4;
    end if;
	
exception
	when others then
		p_result := -1;
	
end;

$$;


--
