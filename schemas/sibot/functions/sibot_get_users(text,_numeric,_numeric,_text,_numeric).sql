-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_users(text, numeric, numeric, text, numeric)
-- Type: FUNCTION

-- Name: sibot_get_users(text, numeric, numeric, text, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_users(p_opt_type text, p_application_id numeric, p_league_id numeric, p_team_id text, p_match_id numeric, OUT p_count numeric, OUT p_receivers text[]) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    
begin
	
    if p_opt_type = 'MA' then
    	
       	with match as
        (
        	select league_id, team_a_id team_id
        	from sibot.sibot_match
        	where match_id = p_match_id
        	union
        	select league_id, team_b_id team_id
        	from sibot.sibot_match
        	where match_id = p_match_id
		)
        select array(select distinct u.receiver_id
                     from match m
                     join sibot.sibot_user_league_team_map ultm
                     on ultm.league_id = m.league_id
                     and coalesce(ultm.team_id,0) = coalesce(m.team_id,0)
                     join sibot.sibot_user u
                     on u.user_id = ultm.user_id
                     where u.application_id = p_application_id
                     and ultm.alert_status = 1
                     and (v_current_timestamp > ultm.alert_stopped_till or ultm.alert_stopped_till is null))
		into p_receivers;
        
	elsif p_opt_type = 'MU' then
    	
        /*select array(select distinct u.receiver_id
                     from sibot.sibot_match m
                     join sibot.sibot_user_league_team_map ultm
                     on ultm.league_id = m.league_id
                     and (coalesce(ultm.team_id,0) = coalesce(m.team_a_id,0) or coalesce(ultm.team_id,0) = coalesce(m.team_b_id,0))
                     join sibot.sibot_user u
                     on u.user_id = ultm.user_id
                     where u.application_id = p_application_id
                     and m.league_id = p_league_id
                     and (m.team_a_id in(select unnest(string_to_array(p_team_id,',')::numeric[]))
                          or m.team_b_id in(select unnest(string_to_array(p_team_id,',')::numeric[])))
                     and ultm.alert_status = 1
                     and (v_current_timestamp > ultm.alert_stopped_till or ultm.alert_stopped_till is null))
		into p_receivers;*/
          
          select array(select distinct u.receiver_id
                     from  sibot.sibot_user_league_team_map ultm
                     join sibot.sibot_user u
                     on u.user_id = ultm.user_id
                     where u.application_id = p_application_id
                     and ultm.league_id = p_league_id
                     and ultm.alert_status = 1
                     and team_id in(select unnest(string_to_array(p_team_id,',')::numeric[]))
                     and (v_current_timestamp > ultm.alert_stopped_till
                              or ultm.alert_stopped_till is null))
		into p_receivers;
          
        
    end if;
    
    select coalesce(array_length(p_receivers,1),0) into p_count;
    
end;

$$;


--
