-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_liveupdates_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_liveupdates_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_liveupdates_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*select * from sibot.sibot_get_liveupdates_message_json(
    '{
  "application_id": "2",
  "receiver_id": "1730455343748895",
  "user_id": "291",
  "module_id": "2",
  "event_id": "405",
  "widget_id": "204",
  "template_id": "5",
  "parent_template_id": "4",
  "sport_id": null,
  "league_id": "13",
  "match_id": null,
  "team_id": "70",
  "quiz_id": null,
  "question_id": null,
  "option_id": null,
  "venue_id": null,
  "player_id": null,
  "country_id": null
}');*/

declare
	
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_module_id numeric := 2;
    v_event_id numeric;
	v_widget_id numeric;
    v_league_id numeric;
    v_team_id text;
    v_match_id numeric;
    v_template_id numeric;
    v_template_json jsonb;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_current_date date := v_current_timestamp::date;
    v_count numeric;
    v_title text;
	v_type text;
    v_image_url text;
    v_url text;
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_template_id numeric;
    v_button_template_json jsonb;
	v_template_json_text jsonb;
    v_button_template_json_arr text[];
    v_template_json_arr text[];
    v_message_text text;
    v_filter_query text := ' ';
    v_sub_title text;
    v_player_profile_url text;
    v_team_fixtures_url text;
    v_names text;
    v_league_team_count numeric;
    v_user_league_team_count numeric;
    v_message_condition_id numeric;
    v_team_name text;
    v_followed_league_filter_query text := ' ';
    v_followed_team_filter_query text := ' ';
    v_parent_template_id numeric;
    v_all_team_query text := ' ';
    v_i numeric;
	v_bat_bowl_count numeric;
	v_opt_type text;
	v_payload_event_id numeric;
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'module_id', p_input_json->>'event_id',
    		p_input_json->>'widget_id', p_input_json->>'league_id', p_input_json->>'team_id', p_input_json->>'match_id',p_input_json->>'opt_type'
    into v_application_id, v_receiver_id, v_user_id, v_module_id, v_event_id, v_widget_id, v_league_id, v_team_id,v_match_id,v_opt_type;
	
    select user_id into v_user_id from sibot.sibot_user where receiver_id = v_receiver_id;
    select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
	
	--select unnest(string_to_array(string_agg(1,2,','),','))::numeric into v_league_id;
	
	/*select league_id into v_league_id from sibot.sibot_league where league_id in ( 
		select unnest(string_to_array(string_agg(distinct league_id::text,','),','))::numeric 
            from (select l.league_id league_id
                  from sibot.sibot_application_league_map alm
                  join sibot.sibot_league l
                  on l.league_id = alm.league_id
                  where alm.application_id = v_application_id
                  and alm.show_in_buddy = 1
                  order by l.league_end_date) a);*/
	
	/*raise notice 'v_league_id:%',v_league_id;
	raise notice 'v_widget_id:%',v_widget_id;
	select 1/0;*/
    
       /* select string_to_array(v_team_id,',')::numeric[] into v_team_arr;
        select array_length(v_team_arr,1) into v_team_count;
        
        if v_team_count =1 
        then
             select array(select list_id
                          from sibot.sibot_list
                          where application_id = p_application_id
                          and league_id = p_league_id
                          and list_type = 'T' and status=1
                          and team_id = p_team_id::numeric)
        else
             select array(select list_id
                             from sibot.sibot_list
                             where application_id = p_application_id
                             and league_id = p_league_id
                             and list_type = 'M' and status=1
                             and (team_a_id in(select unnest(v_team_arr))
                               or team_b_id in(select unnest(v_team_arr))))
       end if;*/
          
   /* if v_application_id=1 then
	--v_league_id=30; /* for ipl*/
     -- v_league_id ='48'; /* for icc world cup*/
	 v_league_id ='49'; /* for Pro Kabaddi*/
    end if;*/
    
    
    case v_widget_id
    	
		when 201 then
		/*raise notice 'v_league_id:%',v_league_id;
						select 1/0;
        	*/
            if v_event_id = 409 then
            	v_followed_league_filter_query := ' join sibot.sibot_user u
                									on u.application_id = alm.application_id
                                                    join sibot.sibot_user_league_team_map ultm
                                                    on ultm.user_id = u.user_id
                                                    and ultm.league_id = alm.league_id ';
            end if;
            drop view if exists league_view;
            execute 'create temporary view league_view as
            			select row_number() over(order by l.league_name) slno, l.league_id, l.league_name, alm.league_image_url
                        from sibot.sibot_application_league_map alm
                        join sibot.sibot_league l
                        on l.league_id = alm.league_id'
                        ||v_followed_league_filter_query||
                        'where alm.application_id = '||v_application_id||
                        ' and alm.show_in_buddy = 1
                        and l.league_end_date >= '''||v_current_date||'''
                        and l.league_name is not null
                        and alm.league_image_url is not null';
            select count(1) into v_count from league_view;
            for i in 1..v_count
            loop
		/*	raise notice 'v_count:%',v_count;
			select 1/0;*/
                select league_id, league_name, league_image_url into v_league_id, v_title, v_image_url
                from league_view where slno = i;
				-- raise notice 'v_league_id:%',v_league_id;
				-- raise notice 'v_title:%',v_title;
				-- raise notice 'v_image_url:%',v_image_url;
				
				
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
				-- raise notice 'v_template_json:%',v_template_json;
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                            		row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            left join sibot.sibot_event e
                            on e.event_id = payload_event_id
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||'
							and widget_id = '||v_widget_id||
                            ' and button_template_id <> 4 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
				-- raise notice 'v_button_count:%',v_button_count;
                	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                   /* if j = 1 then
                    	if exists(select 1 from sibot.sibot_application_league_team_map
                                  where application_id = v_application_id and league_id = v_league_id) then
							v_event_id := 404;
                            v_button_title := 'Un'||lower(v_button_title);
						else
                    		if exists(select 1 from sibot.sibot_user_league_team_map
                                      where user_id = v_user_id and league_id = v_league_id) then
								v_event_id := 403;
                                v_button_title := 'Un'||lower(v_button_title);
							else
                            	v_event_id := 402;
							end if;
                    	end if;
						
                    end if;*/
					
						
                    	select 'GetLUTournamentTeams'||'_null_'||v_league_id||'_null_null' into v_button_payload_text
                    	from sibot.sibot_event where event_id = v_event_id;
					
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
					-- raise notice 'v_button_template_json:%',v_button_template_json;
                    v_button_template_json_arr[j] := v_button_template_json::text;
				end loop;
				
				-- select 1/0;
				
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
			
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
			
		when 202 then
        	/*raise notice 'v_widget_id: %',v_widget_id;
			select 1/0;*/
            select count(1) into v_league_team_count
            from sibot.sibot_application_league_team_map
            where application_id = v_application_id and league_id = v_league_id and team_id <> 0;
			
			
            select count(1) into v_user_league_team_count
            from sibot.sibot_user_league_team_map
            where user_id = v_user_id and league_id = v_league_id and team_id <> 0;
            /*raise notice 'v_league_id : %',v_league_id;
            raise notice 'v_league_team_count : %',v_league_team_count;
            raise notice 'v_user_league_team_count : %',v_user_league_team_count;
             select 1/0;*/
            if v_user_league_team_count = 0 then
            	v_message_condition_id := 1;
            elsif v_user_league_team_count < v_league_team_count then
            	v_message_condition_id := 2;
            elsif v_user_league_team_count = v_league_team_count then
            	v_message_condition_id := 3;
			end if;
               
                 /*raise notice 'v_message_condition_id : %',v_message_condition_id;
                 raise notice 'v_widget_id : %',v_widget_id;
                 select 1/0;*/
			
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_conditional_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id 
			and condition_id = v_message_condition_id;
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            -- raise notice 'p_widget_json : %',p_widget_json;
             -- raise notice 'v_widget_id : %',v_widget_id;
             --  select 1/0;
		when 203 then
		/*raise notice 'v_league_id:%',v_league_id;
		raise notice 'v_application_id:%',v_application_id;
		raise notice 'v_team_id:%',v_team_id;
		select 1/0;*/
        	
            select count(1) into v_league_team_count
          	from sibot.sibot_application_league_team_map where application_id = v_application_id and league_id = v_league_id::numeric;
            if v_team_id is not null and array_length(string_to_array(v_team_id,','),1) <> v_league_team_count then
            	v_filter_query := ' and t.team_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id)) and amltm.team_id <> 0';
		    else 
			    v_filter_query := ' ';
            end if;
            select count(1) into v_league_team_count
            from sibot.sibot_application_league_team_map
            where application_id = v_application_id and league_id = v_league_id and team_id <> 0;
            select count(1) into v_user_league_team_count
            from sibot.sibot_user_league_team_map
            where user_id = v_user_id and league_id = v_league_id and team_id <> 0;
            
           /* raise notice 'v_application_id : %',v_application_id;
             raise notice 'v_module_id : %',v_module_id;
             raise notice 'v_league_id : %',v_league_id;
                          raise notice 'v_team_id : %',v_team_id;

             select 1/0;*/
			 v_i := 1;
            drop view if exists team_view;
           execute 'create temporary view team_view as
		   

select * from (select 1 as slno, t.team_id, t.team_name, amltm.team_image_url
                        from sibot.sibot_application_module_league_team_map amltm
                        join sibot.sibot_team t
                        on t.team_id = amltm.team_id
                       where amltm.application_id ='||v_application_id
                        ||' and amltm.module_id = '||v_module_id
                        ||'
						and amltm.league_id = '||v_league_id::numeric
                        ||'
						and t.team_name is not null
                        and amltm.team_image_url is not null
						'||v_filter_query
						||' 
						and  t.team_name=''All Teams''
                  union

    select row_number() over(order by a.team_name)+ '||v_i||'  slno, a.team_id, a.team_name, a.team_image_url
                           from (select t.team_id, t.team_name, amltm.team_image_url
                        from sibot.sibot_application_module_league_team_map amltm
                        join sibot.sibot_team t
                        on t.team_id = amltm.team_id
                       	where amltm.application_id ='||v_application_id
                        ||' and amltm.module_id = '||v_module_id
                        ||' and amltm.league_id = '||v_league_id::numeric
                        ||' and t.team_name is not null
                        and amltm.team_image_url is not null'||v_filter_query
						||' and  t.team_name <> ''All Teams'' order by team_name)a) b order by team_id';
		   
		   
		   
		   /* execute 'create temporary view team_view as
            			select row_number() over(order by t.team_name) slno, t.team_id, t.team_name, amltm.team_image_url
                        from sibot.sibot_application_module_league_team_map amltm
                        join sibot.sibot_team t
                        on t.team_id = amltm.team_id
                       	where amltm.application_id = '||v_application_id
                        ||' and amltm.module_id = '||v_module_id
                        ||' and amltm.league_id = '||v_league_id::numeric
                        ||' and t.team_name is not null
                        and amltm.team_image_url is not null '||v_filter_query
						||' order by t.team_id '; */
            select count(1) into v_count from team_view;
           /*raise notice 'v_count : %',v_count;
             raise notice 'v_count : %',v_count;
             select 1/0;*/
            for i in 1..v_count
            loop
            	v_button_template_json_arr := null;
                select team_id, team_name, team_image_url into v_team_id, v_title, v_image_url
                from team_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                            		row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            left join sibot.sibot_event e
                            on e.event_id = payload_event_id
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id <> 4 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	 v_button_template_json := null;
                	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    if (exists(select 1 from sibot.sibot_user_league_team_map
                               where user_id = v_user_id and league_id = v_league_id and team_id = v_team_id::numeric)
                        or (v_team_id::numeric = 0 and v_league_team_count = v_user_league_team_count)) then
						v_event_id := 406;
                        v_button_title := 'Un'||lower(v_button_title);
					else
                    	v_event_id := 405;
					end if;
					/*raise notice 'v_event_id:%',v_event_id;
					select 1/0;*/
					
                    select event_payload||'_null_'||v_league_id||'_'||v_team_id||'_null' into v_button_payload_text
                    from sibot.sibot_event where event_id = v_event_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[j] := v_button_template_json::text;
				end loop;
				/*raise notice 'v_team_id:%',v_team_id;
				select 1/0;*/
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
			
			/*raise notice 'v_team_id:%',v_team_id;
			select 1/0;*/
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
            
		when 204 then
        	if not exists (select 1 from sibot.sibot_user_league_team_map where team_id=v_team_id::numeric
						   and user_id =v_user_id and league_id=v_league_id) then
            if v_team_id = '0' then
            	insert into sibot.sibot_user_league_team_map
            	select nextval('sibot.seq_sibot_user_league_team_map_id'),v_user_id,v_league_id,team_id,1,null
                from sibot.sibot_application_module_league_team_map amltm
                where amltm.application_id = v_application_id and amltm.league_id = v_league_id and amltm.team_id <> 0
                and amltm.module_id = v_module_id
                and not exists(select 1 from sibot.sibot_user_league_team_map ultm
                               where ultm.user_id = v_user_id and ultm.league_id = amltm.league_id and ultm.team_id = amltm.team_id);
            else
            	insert into sibot.sibot_user_league_team_map
            	select nextval('sibot.seq_sibot_user_league_team_map_id'),v_user_id,v_league_id,v_team_id::numeric,1,null;
            end if;
			end if;
			--raise notice 'v_team_id:%',v_team_id;
			-- select 1/0;
           if v_application_id=1 then
			   v_message_condition_id := case v_team_id::numeric when 0  then 1 
																 when 64 then 2
																 when 65 then 3
																 when 66 then 4
																 when 67 then 5
																 when 68 then 6
																 when 69 then 7
																 when 70 then 8
																 when 71 then 9
																 when 72 then 10 
																 when 73 then 11 
																 when 74 then 12 
															     else 13 end;
																 
            
		   else 
		   v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
		   end if;
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_conditional_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id 
			and condition_id = v_message_condition_id;
            select team_name into v_team_name from sibot.sibot_team where team_id = v_team_id::numeric
			and team_name is not null;
			/*raise notice 'v_team_name:%',v_team_name;
			select 1/0;*/
            v_message_text := replace(v_message_text,'<team_name>',v_team_name);
            select parent_template_id into v_parent_template_id from sibot.sibot_widget where widget_id = v_widget_id;
            select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
            v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            v_template_json := jsonb_set(v_template_json,'{0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{0,message,text}',('"'||v_message_text||'"')::jsonb,true);
            drop view if exists event_widget_button_view;
                    execute 'create temporary view event_widget_button_view as
                    			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                                		row_number() over(order by button_order) slno
								from sibot.sibot_application_event_widget_button_map aewbm
                                join sibot.sibot_event e
                                on e.event_id = payload_event_id
                                where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                                ' and is_active = 1';
					select count(1) into v_button_count from event_widget_button_view;
                    for j in 1..v_button_count
                    loop
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                        from event_widget_button_view where slno = j;
                        select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                        select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                        v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                        select replace(v_button_payload_text,'v_league_id',v_league_id::text) into v_button_payload_text;
                        v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                    from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                    v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
                    p_template_id := 0;
                    p_widget_json := v_template_json;
            
		when 205 then
        	
            if v_team_id = '0' then
            	delete from sibot.sibot_user_league_team_map where user_id = v_user_id and league_id = v_league_id;
            else
            	delete from sibot.sibot_user_league_team_map 
               where user_id = v_user_id and league_id = v_league_id and team_id = v_team_id::numeric;
            end if;
            select parent_template_id into v_parent_template_id from sibot.sibot_widget 
            where widget_id = v_widget_id;
            select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
            v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_conditional_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id and condition_id = v_message_condition_id;
            select team_name into v_team_name from sibot.sibot_team where team_id = v_team_id::numeric and team_name is not null;
            v_message_text := replace(v_message_text,'<team_name>',v_team_name);
            v_template_json := jsonb_set(v_template_json,'{0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{0,message,text}',('"'||v_message_text||'"')::jsonb,true);
            
           /* raise notice 'v_message_text : %',v_message_text;
          raise notice 'v_template_json : %',v_template_json;
               select 1/0;*/
               
            drop view if exists event_widget_button_view;
                    execute 'create temporary view event_widget_button_view as
                    			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                                		row_number() over(order by button_order) slno
								from sibot.sibot_application_event_widget_button_map aewbm
                                join sibot.sibot_event e
                                on e.event_id = payload_event_id
                                where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                                ' and is_active = 1';
					select count(1) into v_button_count from event_widget_button_view;
                    for j in 1..v_button_count
                    loop
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                        from event_widget_button_view where slno = j;
                        select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                        select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                        v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                        v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                    from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                    v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
                    p_template_id := 0;
					p_widget_json := v_template_json;
                    
		when 206 then
        	
            update sibot.sibot_user_league_team_map
            set alert_status = 0, alert_stopped_till = (current_date + '1 day'::interval)
            where user_id = v_user_id;
            p_widget_json := '{}'::jsonb;
            
		when 207 then
        	
            update sibot.sibot_user_league_team_map
            set alert_status = 1, alert_stopped_till = null
            where user_id = v_user_id;
            p_widget_json := '{}'::jsonb;
            
		when 208 then
        	
            update sibot.sibot_application_match_map set match_alert_status = 1 
            where application_id = v_application_id and match_id = v_match_id;
            select m.match_name, amm.match_alert_image_url into v_title, v_image_url
            from sibot.sibot_match m
            join sibot.sibot_application_match_map amm
            on amm.match_id = m.match_id
            where amm.application_id = v_application_id
            and amm.match_id = v_match_id;
            v_template_json := jsonb_set(v_template_json,'{title}',('"'||coalesce(v_title,'')||'"')::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||coalesce(v_image_url,'')||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
            -- raise notice 'p_widget_json : %',p_widget_json;
   -- raise notice 'v_league_team_count : %',v_league_team_count;
         -- raise notice 'v_user_league_team_count : %',v_user_league_team_count;
              -- select 1/0;
		when 209 then
        	
            drop view if exists league_view;
            execute 'create temporary view league_view as
            			select row_number() over(order by l.league_name) slno, l.league_id, l.league_name, alm.league_image_url
                        from sibot.sibot_application_league_map alm
                        join sibot.sibot_league l
                        on l.league_id = alm.league_id
                        where alm.application_id = '||v_application_id||
                        ' and alm.show_in_buddy = 1
                        and l.league_end_date >= '''||v_current_date||'''
                        and l.league_name is not null
                        and alm.league_image_url is not null
                        and exists(select 1 from sibot.sibot_user_league_team_team ultm
                        			where ultm.league_id = l.league_id and user_id = '||v_user_id||')';
            select count(1) into v_count from league_view;
            for i in 1..v_count
            loop
                select league_id, league_name, league_image_url into v_league_id, v_title, v_image_url
                from league_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                            		row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            left join sibot.sibot_event e
                            on e.event_id = payload_event_id
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id <> 4 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
					if exists(select 1 from sibot.sibot_application_league_team_map
                              where application_id = v_application_id and league_id = v_league_id) then
						v_event_id := 410;
                        v_button_title := 'Un'||lower(v_button_title);
					end if;
                    select event_payload||'_null_'||v_league_id||'_null_null' into v_button_payload_text
                    from sibot.sibot_event where event_id = v_event_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[j] := v_button_template_json::text;
				end loop;
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
               
            when 210 then
        	
            select count(1) into v_league_team_count
          	from sibot.sibot_application_league_team_map where application_id = v_application_id and league_id = v_league_id::numeric;
            if v_team_id is not null and array_length(string_to_array(v_team_id,','),1) <> v_league_team_count then
            	v_all_team_query := ' ';
            	v_filter_query := ' and ultm.team_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id)) ';
                v_i := 0;
			else
            	v_all_team_query := ' union
                						select 1 slno, t.team_id, t.team_name, amltm.team_image_url
                						from sibot.sibot_application_module_league_team_map amltm
                                        join sibot.sibot_team t
                                        on t.team_id = amltm.team_id
                                        where t.team_id = 0
                                        and t.team_name is not null
                                        and application_id = '||v_application_id 
                                        ||'and amltm.team_image_url is not null';
				v_filter_query := ' ';
                v_i := 1;
            end if;
            select count(1) into v_league_team_count
            from sibot.sibot_application_league_team_map
            where application_id = v_application_id and league_id = v_league_id and team_id <> 0;
            select count(1) into v_user_league_team_count
            from sibot.sibot_user_league_team_map
            where user_id = v_user_id and league_id = v_league_id and team_id <> 0;
            if v_league_team_count = v_user_league_team_count then
            
            	v_all_team_query := ' union
                						select 1 slno, t.team_id, t.team_name, amltm.team_image_url
                						from sibot.sibot_application_module_league_team_map amltm
                                        join sibot.sibot_team t
                                        on t.team_id = amltm.team_id
                                        where t.team_id = 0
                                        and t.team_name is not null
										and league_id =' ||v_league_id
										||' and application_id = '||v_application_id 
                                        ||' and amltm.team_image_url is not null';
				v_filter_query := ' ';
                v_i := 1;
            end if;
           /* raise notice 'v_league_team_count : %',v_league_team_count;
            raise notice 'v_user_league_team_count : %',v_user_league_team_count;*/
            /*raise notice 'v_league_id : %',v_league_id;
               raise notice 'v_user_id : %',v_user_id;
               raise notice 'v_widget_id : %',v_widget_id;
              
                select 1/0;*/
            drop view if exists team_view;
            execute 'create temporary view team_view as
            			select row_number() over(order by t.team_name) + '||v_i||' slno, t.team_id, t.team_name, amltm.team_image_url
                        from sibot.sibot_application_module_league_team_map amltm
                        join sibot.sibot_team t
                        on t.team_id = amltm.team_id
                        join sibot.sibot_user_league_team_map ultm
                        on ultm.league_id = amltm.league_id
                        and ultm.team_id = amltm.team_id
                        where amltm.application_id = '||v_application_id
                        ||' and amltm.module_id = '||v_module_id
                        ||' and amltm.league_id = '||v_league_id::numeric
                        ||v_filter_query
                        ||' and ultm.user_id = '||v_user_id
                        ||' and t.team_name is not null
                        and amltm.team_image_url is not null'
                        ||v_all_team_query;
                        
                  /*raise notice 'v_league_id :%',v_league_id;
				  select 1/0;*/
            select count(1) into v_count from team_view;
           /*raise notice 'v_count : %',v_count;
            select 1/0;*/
            for i in 1..v_count
            loop
                select team_id, team_name, team_image_url into v_team_id, v_title, v_image_url
                from team_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                
               /* raise notice 'v_team_id : %',v_team_id;
             raise notice 'v_title : %',v_title;
             raise notice 'v_image_url : %',v_image_url;
             raise notice 'v_template_json : %',v_template_json;
             select 1/0; */
                
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                            		row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            left join sibot.sibot_event e
                            on e.event_id = payload_event_id
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id <> 4 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    v_button_payload_text := replace(v_button_payload_text,'v_league_id',v_league_id::text);
                    v_button_payload_text := replace(v_button_payload_text,'v_team_id',v_team_id::text);
                    v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    v_button_template_json_arr[j] := v_button_template_json::text;
				
              /*       -- raise notice 'v_team_id : %',v_team_id;
             raise notice 'v_button_template_json_arr[j] : 
             %',v_button_template_json_arr[j];
            -- raise notice 'v_image_url : %',v_image_url;
            --  raise notice 'v_template_json : %',v_template_json;*/
              
               
                    end loop;
                    
                    
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
               -- select 1/0; 
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
             
              /*raise notice 'p_widget_json : %',p_widget_json;
              select 1/0;*/
			  
	when 211 then
        	/*raise notice 'v_application_id:%',v_application_id;
			raise notice 'v_event_id:%',v_event_id;
			raise notice 'v_widget_id:%',v_widget_id;
			
			raise notice 'v_league_id:%',v_league_id;
			select 1/0;*/
            drop view if exists bat_bowl_view;
			--,message_text
            execute 'create temporary view bat_bowl_view as
            			select row_number() over(order by application_bat_bowl_mode_id) slno,opt_type as type,image_url,message_text
            			from sibot.sibot_application_bat_bowl_mode
            			where application_id = '||v_application_id||'
            			and is_active = 1';
            select count(1) into v_bat_bowl_count from bat_bowl_view;
            for i in 1..v_bat_bowl_count
            loop
		     /*raise notice 'v_bat_bowl_count:%',v_bat_bowl_count;
			 select 1/0;*/
            	select message_text,type,image_url into v_type,v_title,v_image_url
                from bat_bowl_view where slno = i;
				
            	v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_type||'"')::jsonb,true);
               
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
				/*raise notice 'v_template_json:%',v_template_json;
			   select 1/0;*/
			   
			   
			   
               /* select button_title, event_payload||coalesce(button_payload_text,'') payload_text, button_template_id
                into v_button_title, v_button_payload_text, v_button_widget_id
                from sibot.sibot_application_event_widget_button_map aewbm
                join sibot.sibot_event e
                on e.event_id = payload_event_id
                where application_id = v_application_id and aewbm.event_id = v_event_id and widget_id = v_widget_id and is_active = 1;*/
				
				
				select count(1) into v_count from sibot.sibot_user_league_bat_bowl_mode where user_id=v_user_id and 
				league_id=v_league_id and opt_type=v_title and alert_status=1;
				if v_count =1 then
                
				v_payload_event_id:=418;
				
				
				select button_title, event_payload||coalesce(button_payload_text,'') payload_text, button_template_id
				into v_button_title, v_button_payload_text, v_button_widget_id
                from sibot.sibot_application_event_widget_button_map aewbm
                join sibot.sibot_event e
                on e.event_id = payload_event_id
                 where application_id = v_application_id and aewbm.payload_event_id = v_payload_event_id and widget_id = v_widget_id and is_active = 1;
				/*raise notice 'v_title:%',v_title;
				select 1/0;*/
				-- select event_payload from sibot.sibot_event where event_id=v_payload_event_id;
				else
				v_payload_event_id:=416;
				select button_title, event_payload||coalesce(button_payload_text,'') payload_text, button_template_id
                into v_button_title, v_button_payload_text, v_button_widget_id
                from sibot.sibot_application_event_widget_button_map aewbm
                join sibot.sibot_event e
                on e.event_id = payload_event_id
                where application_id = v_application_id and aewbm.payload_event_id = v_payload_event_id and widget_id = v_widget_id and is_active = 1;
				end if;
				
				/*raise notice 'v_button_payload_text:%',v_button_payload_text;
				select 1/0;*/
				/*if v_button_title='Unsubscribe'then
				v_button_payload_text:=*/
				--raise notice 'v_button_title:%',v_button_title;
				--raise notice 'v_button_payload_text:%',v_button_payload_text;
				--raise notice 'v_button_widget_id:%',v_button_widget_id;
			   
                select replace(v_button_payload_text,'v_title',coalesce(v_title::text,'')) into v_button_payload_text;
				select replace(v_button_payload_text,'v_league_id',coalesce(v_league_id::text,'')) into v_button_payload_text;
				--raise notice 'v_button_payload_text:%',v_button_payload_text;
			  
                select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
				--raise notice 'v_button_template_id:%',v_button_template_id;
			   
                select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
				--raise notice 'v_button_template_json:%',v_button_template_json;
			   
                v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],('['||v_button_template_json::text||']')::jsonb,true);
				--raise notice 'v_template_json:%',v_template_json;
				
                v_template_json_arr[i] := v_template_json::text;
				--raise notice 'v_template_json_arr:%',v_template_json_arr;
				
            end loop;
            /*select string_agg(template_json,',') from(select template_json from unnest(v_template_json_arr) u(template_json))a
            into v_template_json_text;
			raise notice 'v_template_json_text:%',v_template_json_text;
		select 1/0;	 
            p_widget_json := ('['||v_template_json_text||']')::jsonb;*/
			
			select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
			
			--raise notice 'p_widget_json:%',p_widget_json;
			--select 1/0;
  when 212 then
        
        /*raise notice 'v_user_id:%',v_user_id;
        select 1/0;*/
		
		-- select * from sibot.sibot_user_league_bat_bowl_mode
        if not exists(select 1 from sibot.sibot_user_league_bat_bowl_mode 
					  where user_id=v_user_id and league_id=v_league_id and opt_type=v_opt_type) then
        insert into sibot.sibot_user_league_bat_bowl_mode (user_league_bat_bowl_mode_id,application_id,user_id,opt_type,league_id,alert_status,alert_start_date,alert_stopped_date)
        select nextval('sibot.seq_sibot_user_league_bat_bowl_mode_id'),v_application_id,v_user_id,v_opt_type,v_league_id,1,v_current_timestamp,null;
        else
         update sibot.sibot_user_league_bat_bowl_mode
		 set alert_status=1,alert_stopped_till =null
		 where user_id=v_user_id and league_id=v_league_id and opt_type=v_opt_type;
        end if;
		
           if v_application_id=1 then
			   v_message_condition_id := case v_opt_type::text when 'Bat' then 1 
																 else 2 end;
																 
		   end if;
            -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_conditional_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id 
			and condition_id=v_message_condition_id;
            select parent_template_id into v_parent_template_id from sibot.sibot_widget where widget_id = v_widget_id;
            select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
            -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            v_template_json := jsonb_set(v_template_json,'{0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{0,message,text}',('"'||v_message_text||'"')::jsonb,true);
            drop view if exists event_widget_button_view;
                    execute 'create temporary view event_widget_button_view as
                    			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                                		row_number() over(order by button_order) slno
								from sibot.sibot_application_event_widget_button_map aewbm
                                join sibot.sibot_event e
                                on e.event_id = payload_event_id
                                where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                                ' and is_active = 1';
					select count(1) into v_button_count from event_widget_button_view;
                    for j in 1..v_button_count
                    loop
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                        from event_widget_button_view where slno = j;
                        select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                        select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                        v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                        select replace(v_button_payload_text,'v_league_id',v_league_id::text) into v_button_payload_text;
                        v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                    from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                    v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
                    p_template_id := 0;
                    p_widget_json := v_template_json;
        
        when 213 then
        
        /*raise notice 'v_user_id:%',v_user_id;
        select 1/0;*/
        
        -- select * from sibot.sibot_user_league_bat_bowl_mode
        update sibot.sibot_user_league_bat_bowl_mode
		       set alert_status = 0,alert_stopped_date =v_current_timestamp  
			   where application_id=v_application_id and user_id=v_user_id and league_id=v_league_id
			   and opt_type=v_opt_type;
			   
			   
           if v_application_id=1 then
			   v_message_condition_id := case v_opt_type::text when 'Bat' then 1 else 2 end;
			end if;
        	
            -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_conditional_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id
			and condition_id=v_message_condition_id ;
            select parent_template_id into v_parent_template_id from sibot.sibot_widget where widget_id = v_widget_id;
            select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
            -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            v_template_json := jsonb_set(v_template_json,'{0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{0,message,text}',('"'||v_message_text||'"')::jsonb,true);
            drop view if exists event_widget_button_view;
                    execute 'create temporary view event_widget_button_view as
                    			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                                		row_number() over(order by button_order) slno
								from sibot.sibot_application_event_widget_button_map aewbm
                                join sibot.sibot_event e
                                on e.event_id = payload_event_id
                                where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                                ' and is_active = 1';
					select count(1) into v_button_count from event_widget_button_view;
                    for j in 1..v_button_count
                    loop
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                        from event_widget_button_view where slno = j;
                        select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                        select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                        v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                        select replace(v_button_payload_text,'v_league_id',v_league_id::text) into v_button_payload_text;
                        v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                    from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                    v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
                    p_template_id := 0;
                    p_widget_json := v_template_json;
		
		when 214 then
		       
        	-- select * from sibot.sibot_user_league_bat_bowl_mode
            update sibot.sibot_user_league_bat_bowl_mode
            set alert_status = 0, alert_stopped_till = (current_date + '1 day'::interval)
            where user_id = v_user_id ;
            p_widget_json := '{}'::jsonb;
			
		
		when 215 then
		       
        	-- select * from sibot.sibot_user_league_bat_bowl_mode
            update sibot.sibot_user_league_bat_bowl_mode
            set alert_status = 1, alert_stopped_till = null
            where user_id = v_user_id ;
            p_widget_json := '{}'::jsonb;
	   
	   when 216 then 
	        update sibot.sibot_user_league_bat_bowl_mode
            set alert_status = 0, alert_stopped_till = null
            where user_id = v_user_id ;
            p_widget_json := '{}'::jsonb;

    
		 
		else
        	null;
            
    end case;
    
end;

$$;


--
