-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_users_bat_bowl_mode(numeric, numeric, text)
-- Type: FUNCTION

-- Name: sibot_get_users_bat_bowl_mode(numeric, numeric, text); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_users_bat_bowl_mode(p_application_id numeric, p_league_id numeric, p_type_id text, OUT p_count numeric, OUT p_receivers text[]) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    
begin
/*raise notice 'p_application_id:%',p_application_id;
raise notice 'p_league_id:%',p_league_id;
raise notice 'p_type_id:%',p_type_id;*/

	
  /*  select alert_stopped_till  from sibot.sibot_user_league_bat_bowl_mode 
	 if v_current_timestamp::date > v_alert_stopped_till::date 
	then
	     update sibot.sibot_user_kabaddi_insider 
		 set alert_status=1,alert_stopped_till =null
		 where alert_stopped_till::date < v_current_timestamp::date;
	end if;*/
	
    	select array(select distinct u.receiver_id
                     from sibot.sibot_user_league_bat_bowl_mode ulbbm
                     join sibot.sibot_user u
                     on u.user_id = ulbbm.user_id
                     where u.application_id = p_application_id
					 and ulbbm.league_id= p_league_id
                     and ulbbm.alert_status = 1 and opt_type in (select opt_type from sibot.sibot_application_bat_bowl_mode
																 where opt_type in
																 (select unnest(string_to_array(p_type_id,',')))))
		 into p_receivers ;
																 
																 
    	
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
          
          
    
    
    select coalesce(array_length(p_receivers,1),0) into p_count;
    
end;

$$;


--
