-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_ins_user_team(text, numeric, numeric, jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_ins_user_team(text, numeric, numeric, jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_ins_user_team(p_user_id text, p_season_id numeric, p_week_id numeric, p_team_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_user_id numeric;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_match_id character varying;
    
begin
	
	
    select user_id into strict v_user_id 
	from labmi_v1.labmi_v1_web_user where user_guid = p_user_id;
	
	select p_team_json->>'match_id' into v_match_id;
    
    /*if exists(select 1 from labmi_v1.labmi_v1_season_weeks
              where season_id = p_season_id::varchar and week_id = p_week_id
			  and v_current_timestamp between week_start_date and week_end_date
			 ) then
			 */
		if not exists( select 1 from labmi_v1.labmi_v1_user_team 
					    where user_id = v_user_id 
					     and season_id = p_season_id::varchar 
					    and week_id = p_week_id
						and match_id=v_match_id
					 ) then
        	insert into labmi_v1.labmi_v1_user_team
            select nextval('labmi_v1.seq_labmi_v1_user_team_id'),v_user_id,p_team_json,current_timestamp at time zone 'utc',p_season_id,
			p_week_id,current_timestamp at time zone 'utc',v_match_id;
			
            p_result := 1;
			
		else
			update labmi_v1.labmi_v1_user_team
			set team_json = p_team_json,
			    updated_date = current_timestamp at time zone 'utc'
			where user_id = v_user_id 
			and season_id = p_season_id::varchar 
			and week_id = p_week_id
			and match_id=v_match_id;
			
        	p_result := 1;
			
		end if;
	--else
    --	p_result := -4;
    --end if;
	
exception
	when others then
		p_result := -1;
	
end;

$$;


--
