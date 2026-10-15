-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_event(jsonb)
-- Type: FUNCTION

-- Name: sibot_get_event(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_event(p_input_json jsonb, OUT p_output_json jsonb) RETURNS jsonb
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
     v_venue_id text;
     v_bs_category char(1);
     v_bs_category_id numeric;
     v_bs_change_option char(1);
     v_bs_change_value numeric;
     v_bs_mobile_number text;
     v_bs_email_id text;
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
    	v_image_id text;
    	v_team_count numeric;
     v_bs_base_amount numeric;
     v_bs_target_amount numeric;
     v_bs_change_amount numeric;
     v_bs_scenario_id numeric;
     v_bs_total_income numeric;
     v_bs_total_spend numeric;
     v_bs_balance_amount numeric;
     v_bs_play_id numeric;
    	v_filter_query text := ' ';
		v_opt_type text;
begin
	
    	select p_input_json->>'application_id', p_input_json->>'user_id', p_input_json->>'event_id' into v_application_id, v_user_id, v_event_id;
     
     if v_application_id in(1,2) then
     	select p_input_json->>'sport_id', p_input_json->>'league_id', p_input_json->>'match_id',
          p_input_json->>'team_id', p_input_json->>'quiz_id',
          		p_input_json->>'venue_id',p_input_json->>'opt_type'
		into v_sport_id, v_league_id, v_match_id, v_team_id, v_quiz_id, v_venue_id,v_opt_type;
     elsif v_application_id = 3 then
     	select p_input_json->>'bs_category', p_input_json->>'bs_category_id', 
          p_input_json->>'bs_change_option', p_input_json->>'bs_change_value',
          		p_input_json->>'bs_mobile_number', p_input_json->>'bs_email_id'
          into v_bs_category, v_bs_category_id, v_bs_change_option, v_bs_change_value,
          v_bs_mobile_number, v_bs_email_id;
     end if;
     
    	case v_event_id
     	
        when 1 then
        	if v_application_id = 3 then
            	if exists(select 1 from sibot.sibot_bs_user_budget where user_id = v_user_id) then
                	delete from sibot.sibot_bs_user_budget where user_id = v_user_id;
                end if;
            end if;
            
            when 1303 then
           -- raise notice 'v_application_id : %',v_application_id;
     /*raise notice 'v_event_id : %',v_event_id;
          raise notice 'v_sport_id : %',v_sport_id;
          raise notice 'v_check_event_change : %',v_check_event_change;*/
               
            -- v_league_id :='30'; /* for ipl */
			
            -- v_league_id :='48'; /* for icc world cup*/
             v_league_id :='49'; /* for pkl*/
            /*raise notice 'v_league_id : %',v_league_id;
          raise notice 'v_team_id : %',v_team_id;
             select 1/0;*/
             if v_team_id ='0'
             then
             
                 if not exists(select 1 from sibot.sibot_match m 
                                    join sibot.sibot_application_match_map amm
                                    on m.match_id = amm.match_id
                                    where m.league_id = v_league_id::numeric
                                    and amm.application_id = v_application_id
                                    and m.match_end_date >= current_timestamp at time zone 'utc'
                                    and m.status=1 
                                    and amm.match_schedule_image_url is not null
                                    and m.status=1 ) 
                                    then
                                        v_event_id := 1305;
            else 
                v_event_id := 1303;
            end if;
            else
             
                if not exists(select 1 from sibot.sibot_match m 
                                        join sibot.sibot_application_match_map amm
                                        on m.match_id = amm.match_id
                                        where m.league_id = v_league_id::numeric
                                        and amm.application_id = v_application_id
                                        and m.match_end_date >= current_timestamp at time zone 'utc'
                                        and m.status=1 
                                        and (team_a_id = v_team_id::numeric or
                                           team_b_id = v_team_id::numeric) 
                                        and amm.match_schedule_image_url is not null
                                        and m.status=1 ) 
                                        then
                                            v_event_id := 1305;
            -- raise notice 'v_event_id : %',v_event_id;
         -- raise notice 'v_team_id : %',v_team_id;
            -- select 1/0;
                else 
                    v_event_id := 1303;
                end if;
         end if;
        
          when 1215, 1223 then
          	if v_bs_change_option = 'U' then
               	update sibot.sibot_bs_user_budget
                    set change_option = v_bs_change_option
                    where user_id = v_user_id and category = v_bs_category and category_id = v_bs_category_id;
                    if not exists(select 1 from sibot.sibot_bs_user_budget where user_id = v_user_id and category = v_bs_category and change_option is null) then
                    	if v_bs_category = 'I' then
                    		v_event_id := 1222;
					else
                         	v_event_id := 1229;
                         end if;
                    end if;
			else
               	if not exists(select 1 from sibot.sibot_bs_user_budget where user_id = v_user_id and category = v_bs_category and change_option is null) then
                    	if v_bs_category = 'I' then
                    		v_event_id := 1221;
					else
                         	v_event_id := 1228;
                         end if;
                    end if;
               end if;
			
		when 1219 then
               if not exists(select 1 from sibot.sibot_bs_user_budget
                             where user_id = v_user_id and category = v_bs_category
                             and category_id <> v_bs_category_id and change_option is null) then
                    v_event_id := 1221;
			else
				v_event_id := 1219;
			end if;
               
		when 1220, 1227 then
          	update sibot.sibot_bs_user_budget
               set change_option = null, change_value = null
               where user_id = v_user_id and category = v_bs_category
               and category_id = case when v_bs_category_id = 0 then category_id else v_bs_category_id end;
               if v_event_id = 1220 then
               	v_event_id := 1215;
			else
               	v_event_id := 1223;
			end if;
			
		when 1224 then
          	update sibot.sibot_bs_user_budget
               set change_option = v_bs_change_option
               where user_id = v_user_id and category = v_bs_category and category_id = v_bs_category_id;
               
		when 1226 then
          	select category_id into v_bs_category_id
               from sibot.sibot_bs_user_budget
               where user_id = v_user_id and category = 'S' and change_option is not null and change_value is null;
          	if not exists(select 1 from sibot.sibot_bs_user_budget
                             where user_id = v_user_id and category = 'S'
                             and category_id <> v_bs_category_id and change_option is null) then
                    v_event_id := 1228;
			else
				v_event_id := 1226;
			end if;
               
		when 1230 then
          	select base_amount, target_amount, coalesce(change_value,0), category_id
               into v_bs_base_amount, v_bs_target_amount, v_bs_change_amount, v_bs_category_id
               from sibot.sibot_bs_user_budget
               where user_id = v_user_id and category = 'S' and is_priority = 1;
               if v_bs_change_amount < v_bs_target_amount then
               	v_bs_scenario_id := 1;
                    v_event_id := 1231;
               else
               	select sum(coalesce(change_value,base_amount)) into v_bs_total_income
               	from sibot.sibot_bs_user_budget
               	where user_id = v_user_id and category = 'I';
               	select sum(coalesce(change_value,base_amount)) into v_bs_total_spend
               	from sibot.sibot_bs_user_budget
               	where user_id = v_user_id and category = 'S';
               	v_bs_balance_amount := v_bs_total_income - v_bs_total_spend;
                    if v_bs_balance_amount < 0 then
                    	v_bs_scenario_id := 2;
                         v_event_id := 1231;
				elsif v_bs_balance_amount > 300 then
                    	v_bs_scenario_id := 3;
                         v_event_id := 1231;
				else
                    	select category_id into v_bs_category_id
					from sibot.sibot_bs_user_budget ub
					where user_id = v_user_id and category = 'S' and ub.change_option <> 'U' and is_priority = 0
                         and (40 - ub.change_value) >= 0
					order by (40 - ub.change_value) desc
					limit 1;
                         if v_bs_category_id is not null then
                         	v_event_id := 1231;
                         	case v_bs_category_id
                         		when 1 then
                              		v_bs_scenario_id := 5;
                              	when 2 then
                              		v_bs_scenario_id := 7;
                              	when 3 then
                              		v_bs_scenario_id := 9;
                              	when 4 then
                              		v_bs_scenario_id := 11;
                              	when 5 then
                              		v_bs_scenario_id := 13;
							else
                            	if exists(select 1 from sibot.sibot_user
                                          where application_id = v_application_id and user_id = v_user_id
                                          and mobile_number is not null and email_id is not null) then
                                   	v_event_id := 1237;
								else
                                	v_event_id := 1230;
                                end if;
						end case;
                         else
                         	select category_id into v_bs_category_id
						from sibot.sibot_bs_user_budget ub
						where user_id = v_user_id and category = 'S' and ub.change_option <> 'U'
                              and (ub.change_value - 540) >= 0
						order by (ub.change_value - 540) desc
						limit 1;
                              v_event_id := 1231;
                              case v_bs_category_id
                         		when 1 then
                              		v_bs_scenario_id := 4;
                              	when 2 then
                              		v_bs_scenario_id := 6;
                              	when 3 then
                              		v_bs_scenario_id := 8;
                              	when 4 then
                              		v_bs_scenario_id := 10;
                              	when 5 then
                              		v_bs_scenario_id := 12;
							else
                              		if exists(select 1 from sibot.sibot_user
                                          where application_id = v_application_id and user_id = v_user_id
                                          and mobile_number is not null and email_id is not null) then
                                   	v_event_id := 1237;
								else
                                	v_event_id := 1230;
                                end if;
                         	end case;
                         end if;
                    end if;
               end if;
               
          when 1232 then
          	if v_bs_mobile_number is not null then
          		update sibot.sibot_user set mobile_number = v_bs_mobile_number where user_id = v_user_id;
                    v_event_id = 1233;
			end if;
               
		when 1234 then
          	if v_bs_email_id is not null then
          		update sibot.sibot_user set email_id = v_bs_email_id where user_id = v_user_id;
			end if;
		
          when 1236 then
          	select coalesce(max(play_id),0) + 1 into v_bs_play_id from sibot.sibot_bs_user_budget_archive where user_id = v_user_id;
          	insert into sibot.sibot_bs_user_budget_archive
               select user_budget_id, user_id, category_id, category, is_priority, base_amount, target_amount, change_option,
               		change_value, null, v_bs_play_id, v_current_timestamp
               from sibot.sibot_bs_user_budget where user_id = v_user_id;
               delete from sibot.sibot_bs_user_budget where user_id = v_user_id;
          	v_event_id := 1202;
			
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
			v_league_id:=null;
	   
	   when 404 then
	   
	   
            
	   if not exists (select 1 from sibot.sibot_user_league_team_map
                             where league_id in 
					               (select league_id from sibot.sibot_application_league_map
				                                     where show_in_buddy=1 and league_id=v_league_id::numeric)) then
     /*exists (select 1 from sibot.sibot_application_league_map where show_in_buddy=1
                  and  league_id in (select league_id from sibot.sibot_league where league_id=49))*/
		        /* if exists (select 1 from sibot.sibot_user_league_bat_bowl_mode 
		                     where league_id=v_league_id::numeric and user_id=v_user_id
				                   and ( opt_type='Bat' or  opt_type='Bowl') and alert_status=1	)	*/	
		         -- then 
				  --v_event_id:=417 ;
		        --  else
		         v_event_id=415;
				  -- end if;
		 else
		 v_event_id:=404;
		 end if;
		/*raise notice 'v_event_id:%',v_event_id;
		 select 1/0;*/
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
			
			/*raise notice 'v_league_count: %', v_league_count;
			raise notice 'v_league_id:%', v_league_id;
            select 1/0;*/
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
			
      when 416 then 
	  /*raise notice 'v_application_id:%',v_application_id;
	  raise notice 'v_opt_type:%',v_opt_type;
	  raise notice 'v_user_id:%',v_user_id;
	  raise notice 'v_league_id:%',v_league_id;*/
	  
	 
	/*  if  exists (select 1 from sibot.sibot_user_league_bat_bowl_mode where application_id=v_application_id
					 and opt_type=v_opt_type
				and user_id=v_user_id and league_id=v_league_id::numeric and alert_status=1 )
				then
				v_event_id:=418;
		else */
				v_event_id:=416;
       -- end if;
		/*raise notice 'v_event_id:%',v_event_id;
		select 1/0;*/
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
            
			-- raise notice 'v_quiz_type:%',v_quiz_type;
			
            v_event_id := case v_quiz_type when 'T' then 604 when 'I' then 605 else null end;
            
		when 606 then
        	
            select quiz_type, question_limit into strict v_quiz_type, v_question_limit
            from sibot.sibot_application_quiz where application_id = v_application_id 
            and quiz_id = v_quiz_id and is_active = 1;
            
            select count(1) into v_answered_question_count
            from sibot.sibot_user_quiz_play
            where user_id = v_user_id and quiz_id = v_quiz_id 
            and include_in_scorecard = 1 and is_answered = 1;
            
            select count(1) into v_unanswered_question_count
            from sibot.sibot_user_quiz_play
            where user_id = v_user_id and quiz_id = v_quiz_id 
            and include_in_scorecard = 1 and is_answered = 0;
            -- raise notice 'v_answered_question_count: %',v_answered_question_count;
             -- raise notice 'v_unanswered_question_count: %',v_unanswered_question_count;
            if v_question_limit = (v_answered_question_count + v_unanswered_question_count) then
            	v_is_last_question := 1;
			else
            	v_is_last_question := 0;
            end if;
           -- raise notice 'v_is_last_question: %',v_is_last_question;
            if v_quiz_type = 'T' then
            	v_event_id := case v_is_last_question when 0 then 607 else 609 end;
			elsif v_quiz_type = 'I' then
            	--v_event_id := case v_is_last_question when 0 then 607 else 609 end;
				
				v_event_id := case v_is_last_question when 0 then 608 else 609 end;
			else
            	null;
			end if;
             /* raise notice 'v_event_id:%',v_event_id;
              select 1/0;*/
               
            
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
                        "team_id": '||coalesce('"'||v_team_id||'"','null')||',
                        "bs_scenario_id": '||coalesce(v_bs_scenario_id,0)||'
                        }';
    
end;

$$;


--
