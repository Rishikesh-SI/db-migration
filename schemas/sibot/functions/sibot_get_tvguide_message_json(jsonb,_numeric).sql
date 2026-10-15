-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_tvguide_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_tvguide_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_tvguide_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_event_id numeric;
    v_widget_id numeric;
    v_sport_id text;
    v_league_id text;
    v_match_id numeric;
    v_team_id text;
    v_template_id numeric;
    v_parent_template_id numeric;
    v_template_json jsonb;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_current_date date := v_current_timestamp::date;
    v_sport_count numeric;
    v_sport_name text;
    v_sport_payload_text text;
    v_template_json_arr text[];
    v_template_json_text text;
    v_parent_template_json jsonb;
    v_league_count numeric;
    v_league_name text;
    v_league_payload_text text;
    v_message_count numeric;
    v_message_text text;
    v_recurring_message_arr text[];
    v_recurring_json_text text;
    v_match_count numeric;
    v_element_template_json jsonb;
    v_match_name text;
    v_match_schedule_image_url text;
    v_element_template_json_arr text[];
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_template_id numeric;
    v_button_template_json jsonb;
    v_button_template_json_arr text[];
    v_league_schedule_image_attachment_id text;
    v_48_hours_date date := (v_current_timestamp + '48 hours'::interval)::date;
    v_team_id_arr numeric[];
    v_team_count numeric;
    v_team_name text;
    v_sport_id_arr numeric[];
    
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'event_id', p_input_json->>'widget_id',
    		p_input_json->>'sport_id', p_input_json->>'league_id', p_input_json->>'match_id', p_input_json->>'team_id'
    into v_application_id, v_receiver_id, v_user_id, v_event_id, v_widget_id, v_sport_id, v_league_id, v_match_id, v_team_id;
    
    select template_id, parent_template_id into v_template_id, v_parent_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
    
    case v_widget_id
    	
		when 301 then
        	
            drop view if exists sport_view;
            execute 'create temporary view sport_view as
            			select row_number() over() slno,s.sport_id,s.sport_name,s.sport_payload_text
                        from sibot.sibot_application_league_map alm
                        join sibot.sibot_league l
                        on l.league_id = alm.league_id
                        join sibot.sibot_sport s
                        on s.sport_id = l.sport_id
                        where alm.application_id = '||v_application_id||'
                        and l.league_end_date >= '''||v_current_date||'''
                        and s.status = 1
                        group by s.sport_id,s.sport_name,s.sport_payload_text';
			select count(1) into v_sport_count from sport_view;
            for i in 1..v_sport_count
            loop
            	select sport_name,'GetTVGuideTournament_'||sport_payload_text||'_'||sport_id||'_null_null'
                into v_sport_name,v_sport_payload_text
                from sport_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_sport_name||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{payload}',('"'||v_sport_payload_text||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{content_type}',('"text"')::jsonb,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select string_agg(template_json,',') from(select template_json from unnest(v_template_json_arr) u(template_json))a
            into v_template_json_text;
            p_widget_json := ('['||v_template_json_text||']')::jsonb;
            
		when 302 then
            
            select ('['||template_json::text||']')::jsonb into v_parent_template_json from sibot.sibot_template where template_id = v_parent_template_id;
            v_parent_template_json := jsonb_set(v_parent_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id and is_active = 1 and widget_id = v_widget_id;
            select sport_name into v_sport_name from sibot.sibot_sport where sport_id = v_sport_id::numeric;
            select replace(v_message_text,'<sport_name>',coalesce(v_sport_name,'')) into v_message_text;
            v_parent_template_json := jsonb_set(v_parent_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
            drop view if exists league_view;
            execute 'create temporary view league_view as
                        select row_number() over() slno,l.league_id,l.league_short_name league_name,l.league_payload_text
                        from sibot.sibot_application_league_map alm
                        join sibot.sibot_league l
                        on l.league_id = alm.league_id
                        where alm.application_id = '||v_application_id||'
                        and l.sport_id in (select sport_id from unnest(string_to_array('''||v_sport_id||''','','')::numeric[]) u(sport_id))
                        and l.league_end_date >= '''||v_current_date||'''
                        and l.is_active = 1
                        group by l.league_id,l.league_short_name,l.league_payload_text';
            select count(1) into v_league_count from league_view;
            for i in 1..v_league_count
            loop
            	select league_name,'GetTVGuideMatchSchedule_'||league_payload_text||'_'||league_id||'_null_null'
                into v_league_name,v_league_payload_text
                from league_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_league_name||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{payload}',('"'||v_league_payload_text||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{content_type}',('"text"')::jsonb,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select string_agg(template_json,',') from(select template_json from unnest(v_template_json_arr) u(template_json))a
            into v_template_json_text;
            v_parent_template_json := jsonb_set(v_parent_template_json,('{0,message,quick_replies}')::text[],('['||v_template_json_text||']')::jsonb,true);
            p_template_id := 1;
            p_widget_json := v_parent_template_json;
            
		when 303 then
        	
            drop view if exists match_view;
            execute 'create temporary view match_view as
            			select row_number() over(order by m.match_start_date) slno,m.match_name,amm.match_schedule_image_url
                        from sibot.sibot_application_match_map amm
                        join sibot.sibot_match m
                        on m.match_id = amm.match_id
                        join sibot.sibot_application_league_map alm
                        on alm.application_id = amm.application_id
                        where alm.league_id = m.league_id
                        and amm.application_id = '||v_application_id||'
                        and alm.league_id in (select league_id from unnest(string_to_array('''||v_league_id||''','','')::numeric[]) u(league_id))
                        and m.match_end_date >= '''||v_current_timestamp||'''
                        and m.status = 1
                        and m.match_start_date::date between '''||v_current_date||''' and '''||v_48_hours_date||'''';
            select count(1) into v_match_count from match_view;
            for i in 1..v_match_count
            loop
            	select match_name, match_schedule_image_url into v_match_name, v_match_schedule_image_url from match_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||coalesce(v_match_name,'')||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||coalesce(v_match_schedule_image_url,'')||'"')::jsonb,true);
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_template_id, row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id = 5 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	select button_template_id into v_button_widget_id from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
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
            
		when 304,308 then
        	
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id and is_active = 1;
            select league_short_name into v_league_name from sibot.sibot_league where league_id = v_league_id::numeric;
            v_message_text := replace(v_message_text,'<league_name>',v_league_name);
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
        	
		when 305 then
        	
            v_template_json := jsonb_set(v_template_json,('{recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
            select league_schedule_image_attachment_id into v_league_schedule_image_attachment_id
            from sibot.sibot_application_league_map
            where application_id = v_application_id
            and league_id in (select league_id from unnest(string_to_array(v_league_id,',')::numeric[]) u(league_id));
            v_template_json := jsonb_set(v_template_json,('{message,attachment,payload,attachment_id}')::text[],
                                         ('"'||v_league_schedule_image_attachment_id||'"')::text::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 306 then
            
            drop view if exists league_view;
            execute 'create temporary view league_view as
                        select row_number() over() slno,l.league_id,l.league_short_name league_name,l.league_payload_text
                        from sibot.sibot_application_league_map alm
                        join sibot.sibot_league l
                        on l.league_id = alm.league_id
                        where l.league_id in (select league_id from unnest(string_to_array('''||v_league_id||''','','')::numeric[]) u(league_id))
                        and l.league_end_date >= '''||v_current_date||'''
                        and l.is_active = 1
                        group by l.league_id,l.league_short_name,l.league_payload_text';
            select count(1) into v_league_count from league_view;
            for i in 1..v_league_count
            loop
            	select league_name,'GetTVGuideMatchSchedule_'||league_payload_text||'_'||league_id||'_null_null'
                into v_league_name,v_league_payload_text
                from league_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_league_name||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{payload}',('"'||v_league_payload_text||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{content_type}',('"text"')::jsonb,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select string_agg(template_json,',') from(select template_json from unnest(v_template_json_arr) u(template_json))a
            into v_template_json_text;
            p_widget_json := ('['||v_template_json_text||']')::jsonb;
        	
        when 307 then
        	
            drop view if exists match_view;
            execute 'create temporary view match_view as
            			select row_number() over(order by m.match_start_date) slno,m.match_name,amm.match_schedule_image_url
                        from sibot.sibot_application_match_map amm
                        join sibot.sibot_match m
                        on m.match_id = amm.match_id
                        join sibot.sibot_application_league_map alm
                        on alm.application_id = amm.application_id
                        where alm.league_id = m.league_id
                        and m.status =1
                        and amm.application_id = '||v_application_id||'
                        and alm.league_id in (select league_id from unnest(string_to_array('''||v_league_id||''','','')::numeric[]) u(league_id))
                        and (m.team_a_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id))
                        		or m.team_b_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id)))
                        and m.match_end_date::date between '''||v_current_date||''' and '''||v_48_hours_date||'''
                        limit 9';
            select count(1) into v_match_count from match_view;
            for i in 1..v_match_count
            loop
            	select match_name, match_schedule_image_url into v_match_name, v_match_schedule_image_url from match_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||coalesce(v_match_name,'')||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||coalesce(v_match_schedule_image_url,'')||'"')::jsonb,true);
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_template_id, row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and button_template_id = 5 and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	select button_template_id into v_button_widget_id from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
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
            
		when 309 then
        	
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id and is_active = 1;
            -- select string_to_array(v_team_id,',')::numeric[] into v_team_id_arr;
            select string_agg(distinct team_id::text,',')
            from
            (
            	select m.team_a_id team_id
            	from sibot.sibot_application_match_map amm
            	join sibot.sibot_match m
            	on m.match_id = amm.match_id
            	join sibot.sibot_application_league_map alm
            	on alm.application_id = amm.application_id
            	where alm.league_id = m.league_id
            	and amm.application_id = v_application_id
            	and alm.league_id in (select league_id from unnest(string_to_array(v_league_id,',')::numeric[]) u(league_id))
            	and m.team_a_id in (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id))
            	and m.match_end_date >= v_current_timestamp
            	and m.match_end_date::date between v_current_date and v_48_hours_date
            	union
            	select m.team_b_id team_id
            	from sibot.sibot_application_match_map amm
            	join sibot.sibot_match m
            	on m.match_id = amm.match_id
            	join sibot.sibot_application_league_map alm
            	on alm.application_id = amm.application_id
            	where alm.league_id = m.league_id
            	and amm.application_id = v_application_id
            	and alm.league_id in (select league_id from unnest(string_to_array(v_league_id,',')::numeric[]) u(league_id))
            	and m.team_b_id in (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id))
            	and m.match_end_date >= v_current_timestamp
            	and m.match_end_date::date between v_current_date and v_48_hours_date
			)a
            into v_team_id;
            select string_agg(team_name,', ') into v_team_name
            from sibot.sibot_team where team_id in (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id));
            v_team_name := regexp_replace(v_team_name,'(, )(?!.*, )',' and ','g');
            /*select array_length(v_team_id_arr,1) into v_team_count;
            if v_team_count = 1 then
            	select team_name into v_team_name from sibot.sibot_team where team_id = v_team_id_arr[1];
			else
            	select string_agg(team_name,', ') into v_team_name
                from sibot.sibot_team where team_id in(select team_id from unnest(v_team_id_arr) u(team_id));
                v_team_name := regexp_replace(v_team_name,'(, )(?!.*, )',' and ','g');
            end if;*/
            v_message_text := replace(v_message_text,'<team_name>',v_team_name);
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 310 then
        	
            drop view if exists league_view;
            execute 'create temporary view league_view as
                        select row_number() over() slno,l.league_id,l.league_short_name league_name,l.league_payload_text
                        from sibot.sibot_application_league_map alm
                        join sibot.sibot_league l
                        on l.league_id = alm.league_id
                        where alm.application_id = '||v_application_id||'
                        and l.league_end_date >= '''||v_current_date||'''
                        and l.is_active = 1
                        group by l.league_id,l.league_short_name,l.league_payload_text';
            select count(1) into v_league_count from league_view;
            for i in 1..v_league_count
            loop
            	select league_name,'GetTVGuideMatchSchedule_'||league_payload_text||'_'||league_id||'_null_null'
                into v_league_name,v_league_payload_text
                from league_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_league_name||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{payload}',('"'||v_league_payload_text||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{content_type}',('"text"')::jsonb,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select string_agg(template_json,',') from(select template_json from unnest(v_template_json_arr) u(template_json))a
            into v_template_json_text;
            p_widget_json := ('['||v_template_json_text||']')::jsonb;
            
        else
        	null;
		
    end case;
    
end;

$$;


--
