-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_event_old(jsonb)
-- Type: FUNCTION

-- Name: sibot_get_event_old(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_event_old(p_input_json jsonb, OUT p_output_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
    v_application_id numeric;
    v_user_id numeric;
    v_event_id numeric;
    v_sport_id text;
    v_league_id text;
    v_match_id text;
    v_team_id text;
    v_quiz_id numeric;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_current_date date := v_current_timestamp::date;
    v_league_count numeric;
    v_match_count numeric;
	v_48_hours_date date := (v_current_timestamp + '48 hours'::interval)::date;
    v_sport_count numeric;
    v_quiz_type text;
    v_question_limit numeric;
    v_answered_question_count numeric;
    v_unanswered_question_count numeric;
    v_is_last_question numeric;
    v_venue_id text;
    v_image_id text;
    v_team_count numeric;
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'user_id', p_input_json->>'event_id', p_input_json->>'sport_id', p_input_json->>'league_id',
    		p_input_json->>'match_id', p_input_json->>'team_id', p_input_json->>'quiz_id', p_input_json->>'venue_id'
	into v_application_id, v_user_id, v_event_id, v_sport_id, v_league_id, v_match_id, v_team_id, v_quiz_id, v_venue_id;
    
    case v_event_id
    	
        when 401 then
        	
            select string_agg(distinct league_id::text,',') into v_league_id
            from (select l.league_id league_id
                  from sibot.sibot_application_league_map alm
                  join sibot.sibot_league l
                  on l.league_id = alm.league_id
                  where alm.application_id = v_application_id
                  and alm.show_in_buddy = 1
                  order by l.league_end_date) a;
            
            select coalesce(array_length(string_to_array(v_league_id,','),1),0) into v_league_count;
            
            select case v_league_count when 0 then null when 1 then 404 else 401 end into v_event_id;
            
		when 407 then
        	
            if not exists(select 1
                          from sibot.sibot_user_league_team_map ultm
                          join sibot.sibot_user u
                          on u.user_id = ultm.user_id
                          where u.user_id = v_user_id
                          and u.application_id = v_application_id) then
				v_event_id := 414;
			else
            	v_event_id := 407;
            end if;
            
		when 409 then
			
            select string_agg(league_id::text,',') into v_league_id
            from (select distinct l.league_id league_id
                  from sibot.sibot_application_league_map alm
                  join sibot.sibot_league l
                  on l.league_id = alm.league_id
                  where alm.application_id = v_application_id
                  and alm.show_in_buddy = 1
                  and exists(select 1 from sibot.sibot_user_league_team_map ultm
                             where ultm.user_id = v_user_id
                             and ultm.league_id = l.league_id)) a;
			
            select coalesce(array_length(string_to_array(v_league_id,','),1),0) into v_league_count;
            
            if v_league_count = 1 then
            	
                if v_team_id is null then
                	
                    select string_agg(team_id::text,',') into v_team_id
                    from (select distinct altm.team_id team_id
                          from sibot.sibot_application_league_team_map altm
                          where altm.application_id = v_application_id
                          and altm.league_id = v_league_id::numeric
                          and exists(select 1 from sibot.sibot_user_league_team_map ultm
                                     where ultm.user_id = v_user_id
                                     and ultm.league_id = altm.league_id
                                     and ultm.team_id = altm.team_id)) a;
                    
                end if;
                
                select coalesce(array_length(string_to_array(v_team_id,','),1),0) into v_team_count;
                
                select case v_team_count when 1 then 406 else 410 end into v_event_id;
                
			elsif v_league_count > 1 then
            	
                v_event_id := 409;
                
			else
            	
                select string_agg(league_id::text,',') into v_league_id
                from sibot.sibot_application_league_map
                where application_id in(select application_id from sibot.sibot_user where user_id = v_user_id);
                
                v_event_id := 413;
                
            end if;
        
        when 501 then
        	
            select string_agg(alm.league_id::text,',') into v_league_id
        	from sibot.sibot_application_league_map alm
        	join sibot.sibot_league l
        	on l.league_id = alm.league_id
        	where alm.application_id = v_application_id
        	and l.league_end_date >= v_current_date
            and l.is_active=1;
        	
            select coalesce(array_length(string_to_array(v_league_id,','),1),0) into v_league_count;
            
        	if v_league_count = 0 then
        		
            	v_event_id := 508;
            	
			elsif v_league_count = 1 then
        		
            	select l.league_id::text into v_league_id
        		from sibot.sibot_application_league_map alm
        		join sibot.sibot_league l
        		on l.league_id = alm.league_id
        		where alm.application_id = v_application_id
        		and l.league_end_date >= v_current_date
                and l.is_active=1;
            	
            	select count(1) into v_match_count
            	from sibot.sibot_match m
            	where m.league_id = v_league_id::numeric
                and m.match_end_date >= v_current_timestamp
            	and m.match_start_date::date between v_current_date and v_48_hours_date
                and m.status =1;
	            
            	v_event_id := case v_match_count when 0 then 504 else 503 end;
        		
			else
        		
        		select string_agg(distinct l.sport_id::text,',') into v_sport_id
            	from sibot.sibot_application_league_map alm
            	join sibot.sibot_league l
            	on l.league_id = alm.league_id
            	where alm.application_id = v_application_id
            	and l.league_end_date >= v_current_date
                and l.is_active=1;
            	
                select coalesce(array_length(string_to_array(v_sport_id,','),1),0) into v_sport_count;
                
                v_event_id := case v_sport_count when 1 then 502 else 501 end;
                
        	end if;
            
		when 502 then
        	
            select string_agg(distinct alm.league_id::text,',') into v_league_id
        	from sibot.sibot_application_league_map alm
        	join sibot.sibot_league l
        	on l.league_id = alm.league_id
        	where alm.application_id = v_application_id
        	and l.sport_id in (select sport_id from unnest(string_to_array(v_sport_id,',')::numeric[]) u(sport_id))
        	and l.league_end_date >= v_current_date
            and l.is_active=1;
        	
            select coalesce(array_length(string_to_array(v_league_id,','),1),0) into v_league_count;
            
        	if v_league_count = 1 then
        		
            	select count(1) into v_match_count
            	from sibot.sibot_match m
            	where m.league_id = v_league_id::numeric
                and m.match_end_date >= v_current_timestamp
            	and m.match_end_date::date between v_current_date and v_48_hours_date
                and m.status =1;
            	
            	v_event_id := case v_match_count when 0 then 504 else 503 end;
            	
        	elsif v_league_count > 1 then
        		
            	v_event_id := 502;
            	
			else
        		
            	v_event_id := 508;
            	
        	end if;
            
		when 503 then
        	
            if exists(select 1 from sibot.sibot_league where league_id = v_league_id::numeric and league_end_date >= v_current_date) then
        	
            	select count(1) into v_match_count
        		from sibot.sibot_match m
        		join sibot.sibot_league l
        		on l.league_id = m.league_id
        		where m.league_id = v_league_id::numeric
                and m.match_end_date >= v_current_timestamp
        		and m.match_start_date::date between v_current_date and v_48_hours_date
        		and l.league_end_date >= v_current_date
                and m.status =1;
        		
        		v_event_id := case v_match_count when 0 then 504 else 503 end;
            	
        	else
        		
        		v_event_id := 508;
            	
        	end if;
            
		when 506 then
        	
            select string_agg(distinct l.sport_id::text,',') into v_sport_id
        	from sibot.sibot_application_league_map alm
        	join sibot.sibot_league l
        	on l.league_id = alm.league_id
        	where alm.application_id = v_application_id
        	and l.league_end_date >= v_current_date
            and l.is_active=1;
        	
            select coalesce(array_length(string_to_array(v_sport_id,','),1),0) into v_sport_count;
            
        	if v_sport_count = 1 then
        		
            	select count(1) into v_league_count
        		from sibot.sibot_application_league_map alm
        		join sibot.sibot_league l
        		on l.league_id = alm.league_id
        		where alm.application_id = v_application_id
        		and l.sport_id = v_sport_id::numeric
        		and l.league_end_date >= v_current_date
                and l.is_active=1;
        		
            	v_event_id := case v_league_count when 1 then 507 else 502 end;
            	
			else
        		
            	v_event_id := 501;
            	
			end if;
            
		when 510 then
        	
            select count(1) into v_match_count
            from sibot.sibot_match m
            where m.league_id = v_league_id::numeric
            and m.match_end_date >= v_current_timestamp
            and m.match_end_date::date between v_current_date and v_48_hours_date
            and m.status =1;
            
            v_event_id := case v_match_count when 0 then 504 else 503 end;
            
		when 511 then
        	
            select count(1) into v_match_count
            from sibot.sibot_match m
            where m.league_id = v_league_id::numeric
            and (m.team_a_id in (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id))
                 or m.team_b_id in (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id)))
			and m.match_end_date >= v_current_timestamp
            and m.match_end_date::date between v_current_date and v_48_hours_date
            and m.status =1;
            
            v_event_id := case v_match_count when 0 then 504 else 511 end;
            
		when 601 then
        	
			select string_agg(distinct sport_id::text,',') into v_sport_id
        	from sibot.sibot_application_quiz
        	where application_id = v_application_id and is_active = 1;
        	
            select coalesce(array_length(string_to_array(v_sport_id,','),1),0) into v_sport_count;
            
            v_event_id := case v_sport_count when 1 then 602 else 601 end;
            
		when 603 then
        	
            select quiz_type into strict v_quiz_type
            from sibot.sibot_application_quiz where application_id = v_application_id and quiz_id = v_quiz_id and is_active = 1;
            
            v_event_id := case v_quiz_type when 'T' then 604 when 'I' then 605 else null end;
            
		when 606 then
        	
            select quiz_type, question_limit into strict v_quiz_type, v_question_limit
            from sibot.sibot_application_quiz where application_id = v_application_id and quiz_id = v_quiz_id and is_active = 1;
            
            select count(1) into v_answered_question_count
            from sibot.sibot_user_quiz_play
            where user_id = v_user_id and quiz_id = v_quiz_id and include_in_scorecard = 1 and is_answered = 1;
            
            select count(1) into v_unanswered_question_count
            from sibot.sibot_user_quiz_play
            where user_id = v_user_id and quiz_id = v_quiz_id and include_in_scorecard = 1 and is_answered = 0;
            
            if v_question_limit = (v_answered_question_count + v_unanswered_question_count) then
            	v_is_last_question := 1;
			else
            	v_is_last_question := 0;
            end if;
            
            if v_quiz_type = 'T' then
            	v_event_id := case v_is_last_question when 0 then 607 else 608 end;
			elsif v_quiz_type = 'I' then
            	v_event_id := case v_is_last_question when 0 then 609 else 610 end;
			else
            	null;
			end if;
            
		when 711 then
          	
            select facilities_image_attachment_id into v_image_id
            from sibot.sibot_application_venue_map
            where application_id = v_application_id and venue_id = v_venue_id::numeric;
            
			if v_image_id is null then
            	v_event_id := 713;
			end if;
            
		when 906 then
			
            if exists(select 1
                      from sibot.sibot_application_match_map amm
                      join sibot.sibot_match m
                      on m.match_id = amm.match_id
                      where amm.application_id = v_application_id
                      and (m.team_a_id in (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id))
                           or m.team_b_id = (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id)))
                      and m.match_end_date <= v_current_timestamp) then
				
                v_event_id := 906;
                
			else
            	
            	v_event_id := 909;
                
            end if;
			
		when 913 then
          	
            if exists(select 1
                      from sibot.sibot_application_match_map amm
                      join sibot.sibot_match m
                      on m.match_id = amm.match_id
                      where amm.application_id = v_application_id
                      and m.match_end_date <= v_current_timestamp) then
				
				v_event_id := 913;
                
			else
            	
               	v_event_id := 914;
				
			end if;
		
		else
        	
            null;
            
    end case;
    
    p_output_json := '{
                        "event_id": '||v_event_id||',
                        "sport_id": '||coalesce('"'||v_sport_id||'"','null')||',
                        "league_id": '||coalesce('"'||v_league_id||'"','null')||',
                        "team_id": '||coalesce('"'||v_team_id||'"','null')||'
                        }';
    
end;

$$;


--
