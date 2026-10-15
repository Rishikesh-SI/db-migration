-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_tournamentguide_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_tournamentguide_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_tournamentguide_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_module_id numeric := 6;
    v_event_id numeric;
	v_widget_id numeric;
    v_template_id numeric;
    v_template_json jsonb;
    v_template_json_arr text[];
    v_team_count numeric;
    v_team_id text;
    v_title text;
    v_image_url text;
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_template_id numeric;
    v_button_url text;
    v_button_template_json jsonb;
    v_button_template_json_arr text[];
    v_match_count numeric;
    v_match_id numeric;
    v_match_status numeric;
    v_matchcentre_url text;
    v_matchstory_url text;
    v_url text;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_image_attachment_id text;
    v_message_condition_id numeric;
    v_message_text text;
    v_team_name text;
    v_team_a_id numeric;
    v_team_b_id numeric;
    v_team_a_name text;
    v_team_b_name text;
    v_league_id numeric;
    v_filter_query text := ' ';
    v_upcoming_match_limit numeric;
    v_teams_array numeric[];
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'event_id', p_input_json->>'widget_id',
    		p_input_json->>'team_id', p_input_json->>'league_id'
    into v_application_id, v_receiver_id, v_user_id, v_event_id, v_widget_id, v_team_id, v_league_id;
    
    select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
    
    case v_widget_id
    	
        when 601 then
        	
            drop view if exists team_view;
            execute 'create temporary view team_view as
            			select row_number() over(order by t.team_name) slno, t.team_id, t.team_name, amltm.team_image_url
                        from sibot.sibot_team t
                        join sibot.sibot_application_league_team_map altm
                        on altm.team_id = t.team_id
                        join sibot.sibot_application_module_league_team_map amltm
                        on amltm.application_id = altm.application_id
                        and amltm.league_id = altm.league_id
                        and amltm.team_id = altm.team_id
                        where altm.application_id = '||v_application_id
                        ||' and amltm.module_id = '||v_module_id
                        ||' and t.team_name is not null
                        and amltm.team_image_url is not null';
            select count(1) into v_team_count from team_view;
            for i in 1..v_team_count
            loop
                select team_id, team_name, team_image_url into v_team_id, v_title, v_image_url from team_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                            		row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            join sibot.sibot_event e
                            on e.event_id = payload_event_id
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id = 3 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    select replace(v_button_payload_text,'v_team_id',coalesce(v_team_id::text,'')) into v_button_payload_text;
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
			
		when 602 then
        	
			drop view if exists match_view;
            execute 'create temporary view match_view as
            			select row_number() over (order by match_end_date desc) slno, match_id, match_name, match_schedule_image_url, matchcentre_url,
                        		matchstory_url, match_status
						from (select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status, match_end_date
                        	  from (select row_number() over (order by m.match_end_date desc) slno, m.match_id, m.match_name,
                              				amm.match_schedule_image_url, amm.matchcentre_url, amm.matchstory_url, 0 match_status, m.match_end_date
									from sibot.sibot_application_match_map amm
                                    join sibot.sibot_match m
                                    on m.match_id = amm.match_id
                                    where amm.application_id = '||v_application_id||'
                                    and (m.team_a_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id))
                                    	 or m.team_b_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id)))
									and m.match_end_date <= '''||v_current_timestamp||''')a
								where slno <= 4
                        		union
                        		select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status, match_end_date
                        		from (select row_number() over (order by m.match_end_date desc) slno, m.match_id, m.match_name,
                                				replace(amm.match_schedule_image_url,''upcoming'',''live'') match_schedule_image_url, amm.matchcentre_url,
                                                amm.matchstory_url, 1 match_status, m.match_end_date
                        				from sibot.sibot_application_match_map amm
                                		join sibot.sibot_match m
                                		on m.match_id = amm.match_id
                                		where amm.application_id = '||v_application_id||'
                                		and (m.team_a_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id))
                                                  	or m.team_b_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id)))
                                		and '''||v_current_timestamp||''' between m.match_start_date and m.match_end_date)a
								where slno = 1
                        		union
                        		select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status, match_end_date
                        		from (select row_number() over (order by m.match_end_date) slno, m.match_id, m.match_name,
                                				amm.match_schedule_image_url, amm.matchcentre_url, amm.matchstory_url, 2 match_status, m.match_end_date
                        				from sibot.sibot_application_match_map amm
                                		join sibot.sibot_match m
                                		on m.match_id = amm.match_id
                                		where amm.application_id = '||v_application_id||'
                                        and (m.team_a_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id))
                                                  	or m.team_b_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id)))
                                		and m.match_start_date >= '''||v_current_timestamp||''')a
								where slno <= 4
                        	)tab
                            where match_name is not null
                            and match_schedule_image_url is not null
                            and matchcentre_url is not null';
            select count(1) into v_match_count from match_view;
            for i in 1..v_match_count
            loop
				select match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                into v_match_id, v_title, v_image_url, v_matchcentre_url, v_matchstory_url, v_match_status
                from match_view where slno = i;
                select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_button_template_json_arr := null;
                v_button_template_json := null;
                if v_match_status in(0,1) then
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
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                    	from event_widget_button_view where slno = j;
                    	select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    	select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    	v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    	if v_button_title = 'Play-by-Play' then
                    		v_url := v_matchcentre_url;
						elsif v_button_title = 'Match Story' then
                    		v_url := v_matchstory_url;
						end if;
                        if (v_match_status = 0 and j = 2 and v_matchstory_url is null) or (v_match_status = 1 and j = 2) then
                        	exit;
						else
                        	v_button_template_json := jsonb_set(v_button_template_json,'{url}',('"'||coalesce(v_url,'')||'"')::jsonb,true);
						end if;
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                	from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                	v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                end if;
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
            
		when 603 then
        	
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            select league_schedule_image_attachment_id into v_image_attachment_id
            from sibot.sibot_application_league_map
            where application_id = v_application_id
            and league_id = v_league_id
            and league_schedule_image_attachment_id is not null;
            v_template_json := jsonb_set(v_template_json,('{message,attachment,payload,attachment_id}')::text[],
                                         ('"'||v_image_attachment_id||'"')::text::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 604 then
        	
            select m.match_id, m.team_a_id, m.team_b_id into v_match_id, v_team_a_id, v_team_b_id
            from sibot.sibot_application_match_map amm
            join sibot.sibot_match m
            on m.match_id = amm.match_id
            where amm.application_id = v_application_id
            and v_current_timestamp between m.match_start_date and m.match_end_date;
            if v_match_id is not null then
            	v_message_condition_id := 2;
                select team_name into v_team_a_name from sibot.sibot_team where team_id = v_team_a_id;
            	select team_name into v_team_b_name from sibot.sibot_team where team_id = v_team_b_id;
            else
            	v_message_condition_id := 1;
                select team_name into v_team_name from sibot.sibot_team where team_id = v_team_id::numeric;
            end if;
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_conditional_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id and condition_id = v_message_condition_id;
            if v_message_condition_id = 1 then
            	v_message_text := replace(v_message_text,'<team_name>',v_team_name);
			elsif v_message_condition_id = 2 then
            	v_message_text := replace(v_message_text,'<team_a_name>',v_team_a_name);
            	v_message_text := replace(v_message_text,'<team_b_name>',v_team_b_name);
			end if;
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 605 then
        	
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id;
            select string_agg(team_name,', ') into v_team_name from sibot.sibot_team
          	where team_id in (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id))
            and team_name is not null;
          	v_team_name := regexp_replace(v_team_name,'(, )(?!.*, )',' and ','g');
            v_message_text := replace(v_message_text,'<team_name>',v_team_name);
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 606 then
        	
          if v_event_id = 906 then
          	v_filter_query := ' and (m.team_a_id = '||v_team_id::numeric||' or m.team_b_id = '||v_team_id::numeric||') ';
          end if;
          
          drop view if exists match_view;
          execute 'create temporary view match_view as
          			select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                    from (select row_number() over (order by match_end_date desc) slno, m.match_id, m.match_name, amm.match_schedule_image_url,
                    				amm.matchcentre_url, amm.matchstory_url, 0 match_status
							from sibot.sibot_application_match_map amm
                            join sibot.sibot_match m
                            on m.match_id = amm.match_id
                            where amm.application_id = '||v_application_id
                            ||v_filter_query||
                            ' and m.match_end_date <= '''||v_current_timestamp||'''
                            and m.match_name is not null
                            and amm.match_schedule_image_url is not null
                            and amm.matchcentre_url is not null)a
					where slno <= 10';
            select count(1) into v_match_count from match_view;
            for i in 1..v_match_count
            loop
				select match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                into v_match_id, v_title, v_image_url, v_matchcentre_url, v_matchstory_url, v_match_status
                from match_view where slno = i;
                select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
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
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                    	from event_widget_button_view where slno = j;
                    	select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    	select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    	v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    	if v_button_title = 'Play-by-Play' then
                    		v_url := v_matchcentre_url;
						elsif v_button_title = 'Match Story' then
                    		v_url := v_matchstory_url;
						end if;
                        if j = 2 and v_matchstory_url is null then
                        	exit;
						else
                        	v_button_template_json := jsonb_set(v_button_template_json,'{url}',('"'||coalesce(v_url,'')||'"')::jsonb,true);
						end if;
                        v_button_template_json_arr[j] := v_button_template_json::text;
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
            
		when 607 then
        	
          	if v_event_id = 908 then
				v_filter_query := ' and (m.team_a_id in(select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id))
                					or m.team_b_id in(select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id))
                					) ';
                v_upcoming_match_limit := 4;
			else
               	v_upcoming_match_limit := 9;
			end if;
            drop view if exists match_view;
            execute 'create temporary view match_view as
            			select row_number() over (order by match_status, slno) slno, match_id, match_name, match_schedule_image_url, matchcentre_url,
                        		matchstory_url, match_status
						from (select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                        		from (select row_number() over (order by match_end_date desc) slno, m.match_id, m.match_name,
                                				replace(amm.match_schedule_image_url,''upcoming'',''live'') match_schedule_image_url,amm.matchcentre_url, amm.matchstory_url, 1 match_status
                        				from sibot.sibot_application_match_map amm
                                		join sibot.sibot_match m
                                		on m.match_id = amm.match_id
                                		where amm.application_id = '||v_application_id
                                        ||v_filter_query||
                                        ' and '''||v_current_timestamp||''' between m.match_start_date and m.match_end_date)a
                        		union
                        		select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                        		from (select row_number() over (order by match_end_date) slno, m.match_id, m.match_name,
                                				amm.match_schedule_image_url, amm.matchcentre_url, amm.matchstory_url, 2 match_status
                        				from sibot.sibot_application_match_map amm
                                		join sibot.sibot_match m
                                		on m.match_id = amm.match_id
                                		where amm.application_id = '||v_application_id
                                        ||v_filter_query||
                                		' and m.match_start_date >= '''||v_current_timestamp||''')a
								where slno <= '||v_upcoming_match_limit||'
                        	)tab
                            where match_name is not null
                            and match_schedule_image_url is not null
                            and matchcentre_url is not null';
            select count(1) into v_match_count from match_view;
            for i in 1..v_match_count
            loop
				select match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                into v_match_id, v_title, v_image_url, v_matchcentre_url, v_matchstory_url, v_match_status
                from match_view where slno = i;
                select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_button_template_json_arr := null;
                v_button_template_json := null;
                if v_match_status = 1 then
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
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                    	from event_widget_button_view where slno = j;
                    	select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    	select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    	v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                        if j = 2 and v_matchstory_url is null then
                        	exit;
						end if;
                        v_button_template_json := jsonb_set(v_button_template_json,'{url}',('"'||coalesce(v_matchcentre_url,'')||'"')::jsonb,true);
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                	from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                	v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                end if;
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
            
		when 609 then
        	
            select string_to_array(v_team_id,',')::numeric[] into v_teams_array;
            drop view if exists match_view;
            execute 'create temporary view match_view as
            			select row_number() over (order by match_status, slno) slno, match_id, match_name, match_schedule_image_url, matchcentre_url,
                        		matchstory_url, match_status
						from (select row_number() over (order by slno desc) slno, match_id, match_name, match_schedule_image_url, matchcentre_url,
                        				matchstory_url, match_status
								from (select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                                		from (select row_number() over (order by match_end_date desc) slno, m.match_id, m.match_name,
                                        				amm.match_schedule_image_url, amm.matchcentre_url, amm.matchstory_url, 0 match_status
                                				from sibot.sibot_application_match_map amm
                                				join sibot.sibot_match m
                                        		on m.match_id = amm.match_id
                                				where amm.application_id = '||v_application_id||'
                                				and ((m.team_a_id = '||v_teams_array[1]||' and m.team_b_id = '||v_teams_array[2]||')
                                                		or (m.team_a_id = '||v_teams_array[2]||' and m.team_b_id = '||v_teams_array[1]||'))
                                				and m.match_end_date <= '''||v_current_timestamp||''')a
										where slno <= 4
                        		)b
                        		union
                        		select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                        		from (select row_number() over (order by match_end_date desc) slno, m.match_id, m.match_name,
                                				replace(amm.match_schedule_image_url,''upcoming'',''live'') match_schedule_image_url, amm.matchcentre_url, amm.matchstory_url, 1 match_status
                        				from sibot.sibot_application_match_map amm
                                		join sibot.sibot_match m
                                		on m.match_id = amm.match_id
                                		where amm.application_id = '||v_application_id||'
                                		and ((m.team_a_id = '||v_teams_array[1]||' and m.team_b_id = '||v_teams_array[2]||')
												or (m.team_a_id = '||v_teams_array[2]||' and m.team_b_id = '||v_teams_array[1]||'))
                                		and '''||v_current_timestamp||''' between m.match_start_date and m.match_end_date)a
								where slno = 1
                        		union
                        		select slno, match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                        		from (select row_number() over (order by match_end_date) slno, m.match_id, m.match_name,
                                				amm.match_schedule_image_url, amm.matchcentre_url, amm.matchstory_url, 2 match_status
                        				from sibot.sibot_application_match_map amm
                                		join sibot.sibot_match m
                                		on m.match_id = amm.match_id
                                		where amm.application_id = '||v_application_id||'
                                        and ((m.team_a_id = '||v_teams_array[1]||' and m.team_b_id = '||v_teams_array[2]||')
												or (m.team_a_id = '||v_teams_array[2]||' and m.team_b_id = '||v_teams_array[1]||'))
                                		and m.match_start_date >= '''||v_current_timestamp||''')a
								where slno <= 4
                        	)tab
                            where match_name is not null
                            and match_schedule_image_url is not null
                            and matchcentre_url is not null';
            select count(1) into v_match_count from match_view;
            for i in 1..v_match_count
            loop
				select match_id, match_name, match_schedule_image_url, matchcentre_url, matchstory_url, match_status
                into v_match_id, v_title, v_image_url, v_matchcentre_url, v_matchstory_url, v_match_status
                from match_view where slno = i;
                select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||coalesce(v_image_url,'')||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||coalesce(v_title,'')||'"')::jsonb,true);
                v_button_template_json_arr := null;
                v_button_template_json := null;
                if v_match_status in(0,1) then
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
                    	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                    	from event_widget_button_view where slno = j;
                    	select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    	select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    	v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    	if v_button_title = 'Play-by-Play' then
                    		v_url := v_matchcentre_url;
						elsif v_button_title = 'Match Story' then
                    		v_url := v_matchstory_url;
						end if;
                        if (v_match_status = 0 and j = 2 and v_matchstory_url is null) or (v_match_status = 1 and j = 2) then
                        	exit;
						else
                        	v_button_template_json := jsonb_set(v_button_template_json,'{url}',('"'||coalesce(v_url,'')||'"')::jsonb,true);
						end if;
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                	from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                	v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
                end if;
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select ('['||string_agg(template_json,',')||']')::jsonb into v_template_json
            from(select template_json from unnest(v_template_json_arr) u(template_json))a;
            p_widget_json := v_template_json;
            
		else
        	null;
            
    end case;
    
end;

$$;


--
