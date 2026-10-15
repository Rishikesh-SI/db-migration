-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_user_team(text, jsonb)
-- Type: FUNCTION

-- Name: isl_ins_user_team(text, jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_user_team(p_user_id text, p_team_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_user_id numeric;
    
begin
	
    select user_id into strict v_user_id
    from isl.isl_web_user
    where user_guid = p_user_id;
    
    if current_timestamp <= '2020-03-30 19:00:00.000000' then
    	if not exists(select 1 from isl.isl_user_team where user_id = v_user_id) then
        	insert into isl.isl_user_team
        	select nextval('isl.seq_isl_user_team_id'),v_user_id,p_team_json,current_timestamp at time zone 'utc';
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
