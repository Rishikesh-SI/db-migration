-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_pklretainedplayer_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_pklretainedplayer_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_pklretainedplayer_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_module_id numeric := 10;
    v_event_id numeric;
	v_widget_id numeric;
    v_league_id numeric;
    v_team_id text;
    v_player_id text;
    v_country_id text;
    v_template_id numeric;
    v_template_json jsonb;
    v_count numeric;
    v_title text;
    v_image_url text;
    v_url text;
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_template_id numeric;
    v_button_template_json jsonb;
    v_button_template_json_arr text[];
    v_template_json_arr text[];
    v_message_text text;
    v_filter_query text := ' ';
    v_sub_title text;
    v_player_profile_url text;
    v_team_fixtures_url text;
    v_names text;
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'module_id', p_input_json->>'event_id',
    		p_input_json->>'widget_id', p_input_json->>'league_id', p_input_json->>'team_id', p_input_json->>'player_id', p_input_json->>'country_id'
    into v_application_id, v_receiver_id, v_user_id, v_module_id, v_event_id, v_widget_id, v_league_id, v_team_id, v_player_id, v_country_id;
            
    select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
    
    case v_widget_id
    	
		when 1001 then
        	
            if v_event_id = 1007 then
            	v_filter_query := ' and t.team_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id))';
            end if;
            
            drop view if exists team_view;
            execute 'create temporary view team_view as
            			select row_number() over(order by t.team_name) slno, t.team_id, t.team_name, amltm.team_image_url, altm.team_information_url
                        from sibot.sibot_team t
                        join sibot.sibot_application_league_team_map altm
                        on altm.team_id = t.team_id
                        join sibot.sibot_application_module_league_team_map amltm
                        on amltm.application_id = altm.application_id
                        and amltm.league_id = altm.league_id
                        and amltm.team_id = altm.team_id
                        where altm.application_id = '||v_application_id||
                        ' and amltm.module_id = '||v_module_id||
                        ' and t.team_name is not null
                        and amltm.team_image_url is not null
                        and altm.team_information_url is not null '
                        ||v_filter_query;
            select count(1) into v_count from team_view;
            for i in 1..v_count
            loop
                select team_id::text, team_name, team_image_url, team_information_url into v_team_id, v_title, v_image_url, v_url
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
                	select button_title, payload_text, button_template_id into v_button_title, v_button_payload_text, v_button_widget_id
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    select replace(v_button_payload_text,'v_team_id',v_team_id) into v_button_payload_text;
                    if v_button_widget_id = 3 then
                    	v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    elsif v_button_widget_id = 6 then
                    	v_button_template_json := jsonb_set(v_button_template_json,'{url}',('"'||v_url||'"')::jsonb,true);
                    end if;
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
			
		when 1002 then
        	
            select team_text into v_message_text
            from sibot.sibot_application_module_league_team_map
            where application_id = v_application_id and module_id = v_module_id and league_id = v_league_id and team_id = v_team_id::numeric;
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 1003 then
        	
            if v_event_id = 1302 then
            	v_filter_query := ' and altm.team_id = '||v_team_id::numeric;
            elsif v_event_id in(1003,1004) then
                v_filter_query := ' and pl.player_id in (select player_id from unnest(string_to_array('''||v_player_id||''','','')::numeric[]) u(player_id))';
            elsif v_event_id = 1005 then
            	v_filter_query := ' and altm.team_id in (select team_id from unnest(string_to_array('''||v_team_id||''','','')::numeric[]) u(team_id)) and pl.is_captain = 1';
			elsif v_event_id = 1006 then
            	v_filter_query := ' and pl.country_id in (select country_id from unnest(string_to_array('''||v_country_id||''','','')::numeric[]) u(country_id))';
            end if;
            drop view if exists player_view;
            execute 'create temporary view player_view as
            			select row_number() over(order by altpm.team_id,pl.is_captain desc,po.position_order,pl.player_name) slno,
                         		pl.player_name player_name,
                                   po.position_name,altpm.player_image_url,altpm.player_profile_url,altm.team_fixtures_url
						from sibot.sibot_player pl
						join sibot.sibot_application_league_team_player_map altpm
						on altpm.player_id = pl.player_id
						join sibot.sibot_position po
						on po.position_id = pl.position_id
                        join sibot.sibot_application_league_team_map altm
                        on altm.application_id = altpm.application_id
                        and altm.league_id = altpm.league_id
                        and altm.team_id = altpm.team_id
						where altpm.application_id = '||v_application_id||
                        ' and pl.player_name is not null
                        and po.position_name is not null
                        and altpm.player_image_url is not null
                        and altpm.player_profile_url is not null
                        and altm.team_fixtures_url is not null '
                        ||v_filter_query;
            select count(1) into v_count from player_view;
            for i in 1..v_count
            loop
                select player_name, position_name, player_image_url, player_profile_url, team_fixtures_url
                into v_title, v_sub_title, v_image_url, v_player_profile_url, v_team_fixtures_url
                from player_view where slno = i;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_title||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{subtitle}',('"'||v_sub_title||'"')::jsonb,true);
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
                	select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    if v_button_title = 'Know More' then
                    	v_url := v_player_profile_url;
					elsif v_button_title = 'Upcoming Matches' then
                    	v_url := v_team_fixtures_url;
					end if;
                    v_button_template_json := jsonb_set(v_button_template_json,'{url}',('"'||v_url||'"')::jsonb,true);
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
            
		when 704 then
        	
            drop view if exists event_message_view;
            execute 'create temporary view event_message_view as
            			select message_text, image_url, message_sub_text, row_number() over(order by message_order) slno
                        from sibot.sibot_application_event_widget_message
                        where application_id = '||v_application_id||' and event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                        ' and is_active = 1';
			v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            select count(1) into v_count from event_message_view;
            for i in 1..v_count
            loop
            	select message_text into v_message_text from event_message_view where slno = i;
                if v_event_id in(1003,1004) then
            		select string_agg(player_name,', ') into v_names from sibot.sibot_player
                	where player_id in (select player_id from unnest(string_to_array(v_player_id,',')::numeric[]) u(player_id))
                    and player_name is not null;
                    v_names := regexp_replace(v_names,'(, )(?!.*, )',' and ','g');
            		v_message_text := replace(v_message_text,'<player_name>',v_names);
				elsif v_event_id = 1006 then
            		select string_agg(country_name,', ') into v_names from sibot.sibot_country
                	where country_id in (select country_id from unnest(string_to_array(v_country_id,',')::numeric[]) u(country_id))
                    and country_name is not null;
                    v_names := regexp_replace(v_names,'(, )(?!.*, )',' and ','g');
            		v_message_text := replace(v_message_text,'<country_name>',v_names);
				elsif v_event_id = 1007 then
                	select string_agg(team_name,', ') into v_names from sibot.sibot_team
                	where team_id in (select team_id from unnest(string_to_array(v_team_id,',')::numeric[]) u(team_id))
                    and team_name is not null;
                    v_names := regexp_replace(v_names,'(, )(?!.*, )',' and ','g');
            		v_message_text := replace(v_message_text,'<team_name>',v_names);
            	end if;
                v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
                v_template_json_arr[i] := v_template_json::text;
			end loop;
            select ('['||string_agg(template_json,',')||']')::jsonb from(select template_json from unnest(v_template_json_arr) u(template_json))a
            into v_template_json;
            p_widget_json := v_template_json;
        	
		else
        	null;
            
    end case;
    
end;

$$;


--
