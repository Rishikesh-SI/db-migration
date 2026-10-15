-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_notification_json(text, numeric, text)
-- Type: FUNCTION

-- Name: sibot_get_notification_json(text, numeric, text); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_notification_json(p_application_key text, p_match_id numeric, p_event_payload_text text, OUT p_result numeric, OUT p_notitication_json jsonb, OUT p_receiver_jsonb jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_event_input_json jsonb;
    v_receiver_id text := '0';
    v_application_id numeric;
    
begin
if exists (select 1 from sibot.sibot_application_league_map alm
		join sibot.sibot_match m
		on alm.league_id=m.league_id
		where show_in_buddy=1 and bat_bowl_mode=1
		and match_id=p_match_id) and p_event_payload_text='LUNotification' then 
		
	p_event_payload_text:='BBNotification';
	else
	p_event_payload_text='LUNotification';
	end if;
    v_event_input_json := '{
    						"application_key": "'||p_application_key||'",
                            "receiver_id": "'||v_receiver_id||'",
                            "event_payload": "'||p_event_payload_text||'",
                            "match_id": '||p_match_id
                            ||'}';
   /* raise notice 'v_event_input_json : %',v_event_input_json;
     raise notice 'v_event_id : %',v_event_id;
          raise notice 'v_sport_id : %',v_sport_id;
               select 1/0;*/
    if v_event_input_json is not null then
    	
        select * from sibot.sibot_get_event_json(v_event_input_json) 
        into strict p_notitication_json;
        
        select application_id into v_application_id from 
        sibot.sibot_application where application_key = p_application_key;
		
		if exists (select 1 from sibot.sibot_application_league_map alm
		join sibot.sibot_match m
		on alm.league_id=m.league_id
		where show_in_buddy=1 and bat_bowl_mode=1
		and match_id=p_match_id) then
		
		
		select ('{"receiver" : ['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		from (select distinct receiver_id
			  from sibot.sibot_user_league_bat_bowl_mode ulbbm
		      join sibot.sibot_user u
              on u.user_id = ulbbm.user_id
              where u.application_id = v_application_id
			  and ulbbm.alert_status = 1
			  and (ulbbm.alert_stopped_till is null or ulbbm.alert_stopped_till < current_timestamp at time zone 'utc')
			  )row
		into p_receiver_jsonb;
		
		
		
    	else
		
    	select ('{"receiver" : ['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
    	from (select distinct receiver_id
              from sibot.sibot_user_league_team_map ultm
              join sibot.sibot_user u
              on u.user_id = ultm.user_id
              where u.application_id = v_application_id
              and ultm.team_id in(select team_a_id from sibot.sibot_match where match_id = p_match_id
                                  union
                                  select team_b_id from sibot.sibot_match where match_id = p_match_id)
              and ultm.alert_status = 1
              and (ultm.alert_stopped_till is null or ultm.alert_stopped_till < current_timestamp at time zone 'utc')
             )row
		into p_receiver_jsonb;
        
		end if;
        if p_notitication_json is not null and p_receiver_jsonb is not null then
        	p_result := 1;
		else
        	p_result := 0;
            p_notitication_json := '{}'::jsonb;
            p_receiver_jsonb := '{}'::jsonb;
        end if;
        
	else
    	
        p_result := 0;
        p_notitication_json := '{}'::jsonb;
        p_receiver_jsonb := '{}'::jsonb;
        
	end if;
    
/*exception
	when others then
    	
        p_result := -1;
        p_notitication_json := '{}'::jsonb;
        p_receiver_jsonb := '{}'::jsonb;*/
        
end;

$$;


--
