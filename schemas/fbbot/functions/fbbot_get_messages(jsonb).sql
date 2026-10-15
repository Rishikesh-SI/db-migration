-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_get_messages(jsonb)
-- Type: FUNCTION

-- Name: fbbot_get_messages(jsonb); Type: FUNCTION; Schema: fbbot; Owner: -
--

CREATE FUNCTION fbbot.fbbot_get_messages(p_input_json jsonb, OUT p_response_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*
SELECT * from fbbot.fbbot_get_messages(
	'{
		"application_id": "166525327336967",
		"receiver_id": "2282896621724380",
  		"social_id": "12345",
		"team_id": "0",
		"match_id":"",
		"sport_id":"",
		"tour_id":"",
		"event_payload_text":""
	}'::jsonb-- <p_input_json jsonb>
);
*/

declare
	
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_client_unique_id text;
	v_receiver_id text;
	v_social_id text;
	v_event_id numeric;
	v_event_payload_text text;
	v_client_id numeric;
	v_user_id numeric;
	v_response_json jsonb;
	v_events_arr numeric[];
	v_events_arr_len numeric;
	v_i numeric;
	v_child_event_id numeric;
	v_child_message_json_template jsonb;
	v_message_count numeric;
	v_message_json_template jsonb;
	v_x numeric;
	v_message_text text;
	v_message_arr text[];
	v_message text;
	v_json_text text;
	v_message_image_url text;
	v_ordering_condition text := ' ';
	v_team_count numeric;
	v_team_name text;
	v_payload_text text;
	v_team_id numeric;
    v_current_team_name text;		
	v_previous_team_name text;
	v_team_selection_text text;
	v_match_id numeric;
	v_match_name text;
	v_alert_image_url text;
	v_list_arr text;
	v_alert_stopped_till timestamp without time zone;
	v_sport_count numeric;
	v_sport_name text;
	v_sport_id numeric;
	v_league_count numeric;
	v_league_name text;
	v_league_id numeric;
	v_schedule_image_url text;
	v_match_count numeric;
	v_y numeric;
	v_match_image_url text;
    v_input_json jsonb;
    v_current_date date := (v_current_timestamp + '5.5 hours'::interval)::date;
	
begin
	
	select p_input_json->>'application_id',
		p_input_json->>'receiver_id',
		p_input_json->>'social_id',
		p_input_json->>'event_payload_text'
	into v_client_unique_id,
		v_receiver_id,
		v_social_id,
		v_event_payload_text;
	
	begin
		
		select client_id into strict v_client_id from fbbot.fbbot_clients where client_unique_id = v_client_unique_id;
		
		begin
			select user_id into strict v_user_id from fbbot.fbbot_users where receiver_id = v_receiver_id;
		exception
			when no_data_found then
				v_user_id := nextval('fbbot.seq_fbbot_user_id');
				insert into fbbot.fbbot_users(user_id,social_id,receiver_id,created_date)
				select v_user_id,v_social_id,v_receiver_id,v_current_timestamp;
				insert into fbbot.fbbot_user_client_map(user_client_map_id,user_id,client_id)
				select nextval('fbbot.seq_fbbot_user_client_map_id'),v_user_id,v_client_id;
		end;
		
		select event_id into v_event_id from fbbot.fbbot_events where payload_text = v_event_payload_text;
		
		case v_event_id
			
			-- event_id -> 1 (Get Started)
			when 1 then
				
				select array(select event_id from fbbot.fbbot_events where parent_id = v_event_id) into v_events_arr;
				select array_length(v_events_arr,1) into v_events_arr_len;
				if v_events_arr_len > 0 then
					v_i := 1;
					loop
						exit when v_i > v_events_arr_len;
						v_child_event_id := v_events_arr[v_i];
						select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_child_event_id;
						drop view if exists message_view;
						execute 'create temporary view message_view as
									select message_text,ordering,message_json,message_image_url
									from fbbot.fbbot_event_messages
									where event_id = '||v_child_event_id||'
									and is_active = 1';
						select count(1) into v_message_count from message_view where ordering is not null;
						if v_child_event_id = 2 then
							select message_json into v_message_json_template from message_view where ordering is null;
							v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							v_x := 1;
							loop
								exit when v_x > v_message_count;
								select message_text into v_message_text from message_view where ordering = v_x;
								v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
								v_message_arr[v_x] := v_message_json_template::text;
								v_x := v_x + 1;
							end loop;
							v_message := '['||array_to_string(v_message_arr,',')||']';
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
							v_json_text := substring(v_child_message_json_template::text,2);
						elsif v_child_event_id = 3 then
							v_message_arr := null;
							v_x := 1;
							loop
								exit when v_x > v_message_count;
								select message_image_url,message_json into v_message_image_url,v_message_json_template from message_view where ordering = v_x;
                                if exists(select 1 from fbbot.fbbot_user_team_map where user_id = v_user_id) then
									if v_x = 1 then
										v_message_json_template := jsonb_set(v_message_json_template,'{buttons,0,title}',('"'||'UNSUBSCRIBE'||'"')::text::jsonb,true);
										v_message_json_template := jsonb_set(v_message_json_template,'{buttons,0,payload}',('"'||'UNSUBSCRIBE'||'"')::text::jsonb,true);
										v_message_json_template := jsonb_set(v_message_json_template,'{buttons,1}','{"type":"postback","title":"CHANGE SETTINGS","payload":"CHANGE_SETTINGS"}'::jsonb,true);
									end if;
								end if;
								v_message_json_template := jsonb_set(v_message_json_template,'{image_url}',('"'||v_message_image_url||'"')::text::jsonb,true);
								v_message_arr[v_x] := v_message_json_template::text;
								v_x := v_x + 1;
							end loop;
							v_message := '['||array_to_string(v_message_arr,',')||']';
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,message,attachment,payload,elements}',v_message::jsonb,true);
							v_json_text := v_json_text||','||substring(v_child_message_json_template::text,2);
						end if;
						v_json_text := substring(v_json_text,1,length(v_json_text)-1);
						v_i := v_i + 1;
					end loop;
					p_result := 1;
				end if;
				v_response_json := '{'||v_json_text||'}';
				
			-- event_id -> 4 (Help), 5 (Buddy), 6(TV Guide)
			when 4,5,6 then
				
				select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_event_id;
				if v_event_id = 5 then
					v_ordering_condition := 'and ordering = 1';
				elsif v_event_id = 6 then
					v_ordering_condition := 'and ordering = 2';
				end if;
				v_event_id := 3;
				drop view if exists message_view;
				execute 'create temporary view message_view as
							select message_text,ordering,message_json,message_image_url
							from fbbot.fbbot_event_messages
							where event_id = '||v_event_id||'
							and is_active = 1 '
							||v_ordering_condition;
				select count(1) into v_message_count from message_view where ordering is not null;
				v_x := 1;
				loop
					exit when v_x > v_message_count;
					if v_message_count = 1 then
						select ordering into v_x from message_view;
					end if;
					select message_image_url,message_json into v_message_image_url,v_message_json_template from message_view where ordering = v_x;
					if exists(select 1 from fbbot.fbbot_user_team_map where user_id = v_user_id) then
						if v_x = 1 then
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,0,title}',('"'||'UNSUBSCRIBE'||'"')::text::jsonb,true);
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,0,payload}',('"'||'UNSUBSCRIBE'||'"')::text::jsonb,true);
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,1}','{"type":"postback","title":"CHANGE SETTINGS","payload":"CHANGE_SETTINGS"}'::jsonb,true);
						end if;
					end if;
					v_message_json_template := jsonb_set(v_message_json_template,'{image_url}',('"'||v_message_image_url||'"')::text::jsonb,true);
					v_message_arr[v_x] := v_message_json_template::text;
					v_x := v_x + 1;
				end loop;
				v_message := '['||array_to_string(v_message_arr,',')||']';
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,message,attachment,payload,elements}',v_message::jsonb,true);
				v_response_json := v_child_message_json_template;
				p_result := 1;
				
			-- event_id -> 7 (Subscribe)
			when 7 then
				
                if exists(select 1 from fbbot.fbbot_user_team_map where user_id = v_user_id) then
                	v_input_json := p_input_json;
                    v_input_json := jsonb_set(v_input_json,'{event_id}',('"'||'12'||'"')::text::jsonb,true);
                    select * from fbbot.fbbot_get_messages(v_input_json) s1 into v_response_json, p_result;
                else
                	select p_input_json->>'tour_id' into v_league_id;
					select array(select event_id from fbbot.fbbot_events where parent_id = v_event_id) into v_events_arr;
					select array_length(v_events_arr,1) into v_events_arr_len;
					if v_events_arr_len > 0 then
						v_i := 1;
						loop
							exit when v_i > v_events_arr_len;
							v_child_event_id := v_events_arr[v_i];
							select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_child_event_id;
							drop view if exists message_view;
							execute 'create temporary view message_view as
                            			select message_text,ordering,message_json,message_image_url
										from fbbot.fbbot_event_messages
										where event_id = '||v_child_event_id||'
										and is_active = 1';
							select count(1) into v_message_count from message_view where ordering is not null;
							select message_json into v_message_json_template from message_view where ordering is null;
							if v_child_event_id = 8 then
								v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
								v_x := 1;
								loop
									exit when v_x > v_message_count;
									select message_text into v_message_text from message_view where ordering = v_x;
									v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
									v_message_arr[v_x] := v_message_json_template::text;
									v_x := v_x + 1;
								end loop;
								v_message := '['||array_to_string(v_message_arr,',')||']';
								v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
								v_json_text := substring(v_child_message_json_template::text,2);
							elsif v_child_event_id = 9 then
								v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
								drop view if exists teams_view;
								execute 'create temporary view teams_view as
                                			select t.team_id,t.team_short_code,t.payload_text
											from fbbot.fbbot_league_team_map ltm
											join fbbot.fbbot_teams t
											on t.team_id = ltm.team_id
											where ltm.league_id = '||v_league_id;
								select count(1) into v_team_count from teams_view;
								v_message_arr := null;
								v_x := 1;
								loop
									exit when v_x > v_team_count;
									select team_short_code,'Teams_'||payload_text||'_'||team_id into v_team_name,v_payload_text from teams_view where team_id = v_x;
									v_message_json_template := jsonb_set(v_message_json_template,'{payload}',('"'||v_payload_text||'"')::text::jsonb,true);
									v_message_json_template := jsonb_set(v_message_json_template,'{content_type}',('"'||'text'||'"')::text::jsonb,true);
									v_message_json_template := jsonb_set(v_message_json_template,'{title}',('"'||v_team_name||'"')::text::jsonb,true);
									v_message_arr[v_x] := v_message_json_template::text;
									v_x := v_x + 1;
								end loop;
								v_message := '['||array_to_string(v_message_arr,',')||']';
								v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,message,quick_replies}',v_message::jsonb,true);
								v_json_text := v_json_text||','||substring(v_child_message_json_template::text,2);
							end if;
							v_json_text := substring(v_json_text,1,length(v_json_text)-1);
							v_i := v_i + 1;
						end loop;
						p_result := 1;
					end if;
					v_response_json := '{'||v_json_text||'}';
				end if;
                
			-- event_id -> 10 (Team Selection)
			when 10 then
				
				select p_input_json->>'team_id' into v_team_id;
                select team_name into v_current_team_name from fbbot.fbbot_teams where team_id = v_team_id;
				select team_name into v_previous_team_name
				from fbbot.fbbot_user_team_map utm
				join fbbot.fbbot_teams t
				on t.team_id = utm.team_id
				where user_id = v_user_id
				and utm.status = 2;
				if not exists(select 1 from fbbot.fbbot_user_team_map where user_id = v_user_id and team_id = v_team_id) then
					insert into fbbot.fbbot_user_list_change(user_list_change_id,user_id,list_id,status)
					select nextval('fbbot.seq_fbbot_user_list_change'),v_user_id,ltm.list_id,0
					from fbbot.fbbot_user_team_map utm
					join fbbot.fbbot_list_team_map ltm
					on ltm.team_id = utm.team_id
					where user_id = v_user_id
					and utm.status = 2;
					delete from fbbot.fbbot_user_team_map where user_id = v_user_id;
					insert into fbbot.fbbot_user_team_map(user_team_map_id,user_id,team_id,status)
					select nextval('fbbot.seq_fbbot_user_team_map_id'),v_user_id,v_team_id,0;
				end if;
				select team_selection_text into v_team_selection_text from fbbot.fbbot_teams where team_id = v_team_id;
				select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_event_id;
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt,0,message,text}',('"'||v_team_selection_text||'"')::text::jsonb,true);
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
				v_event_id = 3;
				drop view if exists message_view;
				execute 'create temporary view message_view as
							select message_text,ordering,message_json,message_image_url
							from fbbot.fbbot_event_messages
							where event_id = '||v_event_id||'
							and is_active = 1';
				select count(1) into v_message_count from message_view where ordering is not null;
				v_x := 1;
				loop
					exit when v_x > v_message_count;
					if v_message_count = 1 then
						select ordering into v_x from message_view;
					end if;
					select message_image_url,message_json into v_message_image_url,v_message_json_template from message_view where ordering = v_x;
					if exists(select 1 from fbbot.fbbot_user_team_map where user_id = v_user_id) then
						if v_x = 1 then
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,0,title}',('"'||'UNSUBSCRIBE'||'"')::text::jsonb,true);
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,0,payload}',('"'||'UNSUBSCRIBE'||'"')::text::jsonb,true);
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,1}','{"type":"postback","title":"CHANGE SETTINGS","payload":"CHANGE_SETTINGS"}'::jsonb,true);
						end if;
					end if;
					v_message_json_template := jsonb_set(v_message_json_template,'{image_url}',('"'||v_message_image_url||'"')::text::jsonb,true);
					v_message_arr[v_x] := v_message_json_template::text;
					v_x := v_x + 1;
				end loop;
				v_message := '['||array_to_string(v_message_arr,',')||']';
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,message,attachment,payload,elements}',v_message::jsonb,true);
				v_response_json := v_child_message_json_template;
                v_response_json := jsonb_set(v_response_json,'{teamchanges}','[]'::text::jsonb,true);
				v_response_json := jsonb_set(v_response_json,'{teamchanges,0}',('{"currentteam":"'||v_current_team_name||'"}')::text::jsonb,true);
				if v_previous_team_name is not null then
					v_response_json := jsonb_set(v_response_json,'{teamchanges,1}',('{"previousteam":"'||v_previous_team_name||'"}')::text::jsonb,true);
				else
					v_response_json := jsonb_set(v_response_json,'{teamchanges,1}',('{"previousteam":"null"}')::text::jsonb,true);
				end if;
				p_result := 1;
				
			-- event_id -> 11 (Unsubscribe)
			when 11 then
				
				insert into fbbot.fbbot_user_list_change(user_list_change_id,user_id,list_id,status)
				select nextval('fbbot.seq_fbbot_user_list_change'),v_user_id,ltm.list_id,0
				from fbbot.fbbot_user_team_map utm
				join fbbot.fbbot_list_team_map ltm
				on ltm.team_id = utm.team_id
				where user_id = v_user_id
				and utm.status = 2;
				delete from fbbot.fbbot_user_team_map where user_id = v_user_id;
				select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_event_id;
				drop view if exists message_view;
				execute 'create temporary view message_view as
							select message_text,ordering,message_json,message_image_url
							from fbbot.fbbot_event_messages
							where event_id = '||v_event_id||'
							and is_active = 1';
				select count(1) into v_message_count from message_view where ordering is not null;
				select message_json into v_message_json_template from message_view where ordering is null;
				v_x := 1;
				loop
					exit when v_x > v_message_count;
					select message_text into v_message_text from message_view where ordering = v_x;
					v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
					v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
					v_message_arr[v_x] := v_message_json_template::text;
					v_x := v_x + 1;
				end loop;
				v_message := '['||array_to_string(v_message_arr,',')||']';
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
				v_event_id = 3;
				drop view if exists message_view;
				execute 'create temporary view message_view as
							select message_text,ordering,message_json,message_image_url
							from fbbot.fbbot_event_messages
							where event_id = '||v_event_id||'
							and is_active = 1';
				select count(1) into v_message_count from message_view where ordering is not null;
				v_x := 1;
				loop
					exit when v_x > v_message_count;
					if v_message_count = 1 then
						select ordering into v_x from message_view;
					end if;
					select message_image_url,message_json into v_message_image_url,v_message_json_template from message_view where ordering = v_x;
					if exists(select 1 from fbbot.fbbot_user_team_map where user_id = v_user_id) then
						if v_x = 1 then
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,0,title}',('"'||'UNSUBSCRIBE'||'"')::text::jsonb,true);
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,0,payload}',('"'||'UNSUBSCRIBE'||'"')::text::jsonb,true);
							v_message_json_template := jsonb_set(v_message_json_template,'{buttons,1}','{"type":"postback","title":"CHANGE SETTINGS","payload":"CHANGE_SETTINGS"}'::jsonb,true);
						end if;
					end if;
					v_message_json_template := jsonb_set(v_message_json_template,'{image_url}',('"'||v_message_image_url||'"')::text::jsonb,true);
					v_message_arr[v_x] := v_message_json_template::text;
					v_x := v_x + 1;
				end loop;
				v_message := '['||array_to_string(v_message_arr,',')||']';
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,message,attachment,payload,elements}',v_message::jsonb,true);
				v_response_json := v_child_message_json_template;
				p_result := 1;
				
			-- event_id -> 12 (Change Setting)
			when 12 then
				
				select p_input_json->>'tour_id' into v_league_id;
				select array(select event_id from fbbot.fbbot_events where parent_id = v_event_id order by event_id) into v_events_arr;
				select array_length(v_events_arr,1) into v_events_arr_len;
				if v_events_arr_len > 0 then
					v_i := 1;
					loop
						exit when v_i > v_events_arr_len;
						v_child_event_id := v_events_arr[v_i];
						select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_child_event_id;
						drop view if exists message_view;
						execute 'create temporary view message_view as
									select message_text,ordering,message_json,message_image_url
									from fbbot.fbbot_event_messages
									where event_id = '||v_child_event_id||'
									and is_active = 1';
						select count(1) into v_message_count from message_view where ordering is not null;
						select message_json into v_message_json_template from message_view where ordering is null;
						if v_child_event_id = 13 then
							v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							v_x := 1;
							select t.team_name into v_team_name
							from fbbot.fbbot_user_team_map utm
							join fbbot.fbbot_teams t
							on t.team_id = utm.team_id
							where utm.user_id = v_user_id;
							loop
								exit when v_x > v_message_count;
								select message_text into v_message_text from message_view where ordering = v_x;
								v_message_text := replace(v_message_text,'<first selected team>',v_team_name);
								v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
								v_message_arr[v_x] := v_message_json_template::text;
								v_x := v_x + 1;
							end loop;
							v_message := '['||array_to_string(v_message_arr,',')||']';
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
							v_json_text := substring(v_child_message_json_template::text,2);
                            v_json_text := substring(v_json_text,1,length(v_json_text)-1);
						elsif v_child_event_id = 14 then
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							drop view if exists teams_view;
							execute 'create temporary view teams_view as
										select t.team_id,t.team_short_code,t.payload_text
										from fbbot.fbbot_league_team_map ltm
										join fbbot.fbbot_teams t
										on t.team_id = ltm.team_id
										where ltm.league_id = '||v_league_id;
							select count(1) into v_team_count from teams_view;
							v_message_arr := null;
							v_x := 1;
							loop
								exit when v_x > v_team_count;
								select team_short_code,'Teams_'||payload_text||'_'||team_id into v_team_name,v_payload_text from teams_view where team_id = v_x;
								v_message_json_template := jsonb_set(v_message_json_template,'{payload}',('"'||v_payload_text||'"')::text::jsonb,true);
								v_message_json_template := jsonb_set(v_message_json_template,'{content_type}',('"'||'text'||'"')::text::jsonb,true);
								v_message_json_template := jsonb_set(v_message_json_template,'{title}',('"'||v_team_name||'"')::text::jsonb,true);
								v_message_arr[v_x] := v_message_json_template::text;
								v_x := v_x + 1;
							end loop;
							v_message := '['||array_to_string(v_message_arr,',')||']';
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,message,quick_replies}',v_message::jsonb,true);
							v_json_text := v_json_text||','||substring(v_child_message_json_template::text,2);
                            v_json_text := substring(v_json_text,1,length(v_json_text)-1);
						end if;
						v_i := v_i + 1;
					end loop;
					p_result := 1;
				end if;
				v_response_json := '{'||v_json_text||'}';
				p_result := 1;
				
			-- event_id -> 15 (Alerts & Notifications)
			when 15 then
				
				select json_template into v_response_json from fbbot.fbbot_events where event_id = v_event_id;
				select p_input_json->>'match_id' into v_match_id;
				select replace(match_name,'vs.','vs'),alert_image_url into v_match_name,v_alert_image_url from fbbot.fbbot_matches where match_id = v_match_id;
				v_response_json := jsonb_set(v_response_json,'{chatbottmt,0,message,attachment,payload,elements,0,title}',('"'||v_match_name||'"')::jsonb,true);
				v_response_json := jsonb_set(v_response_json,'{chatbottmt,0,message,attachment,payload,elements,0,image_url}',('"'||v_alert_image_url||'"')::jsonb,true);
				select '['||string_agg(u.receiver_id::text,',')||']'
				from fbbot.fbbot_league_team_map ltm
				join fbbot.fbbot_matches m
				on m.league_id = ltm.league_id
				and (m.team_a_id = ltm.team_id
					or m.team_b_id = ltm.team_id
					or ltm.is_team_common = 1)
				join fbbot.fbbot_user_team_map utm
				on utm.team_id = ltm.team_id
				join fbbot.fbbot_users u
				on u.user_id = utm.user_id
				where m.match_id = v_match_id
				into v_list_arr;
				update fbbot.fbbot_matches set alert_status = 1 where match_id = v_match_id;
				v_response_json := jsonb_set(v_response_json,'{receiverids}',v_list_arr::jsonb,true);
				p_result := 1;
				
			-- event_id -> 16 (Stop Game Alerts)
			when 16 then
				
                /*select match_end_date into v_alert_stopped_till
                from fbbot.fbbot_matches
                where match_start_date >= current_timestamp at time zone 'utc'
                and match_end_date::date = current_date
                order by match_start_date
                limit 1;
                if v_alert_stopped_till is null then*/
                	select TIMESTAMP 'tomorrow' - '1 minutes'::interval into v_alert_stopped_till;
                -- end if;
				insert into fbbot.fbbot_user_list_change(user_list_change_id,user_id,list_id,status,alert_stopped_till)
				select nextval('fbbot.seq_fbbot_user_list_change'),v_user_id,ltm.list_id,0,v_alert_stopped_till
				from fbbot.fbbot_user_team_map utm
				join fbbot.fbbot_list_team_map ltm
				on ltm.team_id = utm.team_id
				where user_id = v_user_id
				and utm.status = 2;
				delete from fbbot.fbbot_user_team_map where user_id = v_user_id;
				select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_event_id;
				drop view if exists message_view;
				execute 'create temporary view message_view as
							select message_text,ordering,message_json,message_image_url
							from fbbot.fbbot_event_messages
							where event_id = '||v_event_id||'
							and is_active = 1';
				select count(1) into v_message_count from message_view where ordering is not null;
				select message_json into v_message_json_template from message_view where ordering is null;
				v_x := 1;
				loop
					exit when v_x > v_message_count;
					select message_text into v_message_text from message_view where ordering = v_x;
					v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
					v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
					v_message_arr[v_x] := v_message_json_template::text;
					v_x := v_x + 1;
				end loop;
				v_message := '['||array_to_string(v_message_arr,',')||']';
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
				v_response_json := v_child_message_json_template;
				p_result := 1;
				
			-- event_id -> 17 (Restart Game Alerts)
			when 17 then
				
				insert into fbbot.fbbot_user_team_map
    			select nextval('fbbot.seq_fbbot_user_team_map_id'),user_id,team_id,0
    			from fbbot.fbbot_user_list_change ulc
    			join fbbot.fbbot_list_team_map ltm
    			on ltm.list_id = ulc.list_id
    			where ulc.user_id = v_user_id
				and status = 2
                and alert_stopped_till is not null;
				delete from fbbot.fbbot_user_list_change ulc where user_id = v_user_id;
				select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_event_id;
				drop view if exists message_view;
				execute 'create temporary view message_view as
							select message_text,ordering,message_json,message_image_url
							from fbbot.fbbot_event_messages
							where event_id = '||v_event_id||'
							and is_active = 1';
				select count(1) into v_message_count from message_view where ordering is not null;
				select message_json into v_message_json_template from message_view where ordering is null;
				v_x := 1;
				loop
					exit when v_x > v_message_count;
					select message_text into v_message_text from message_view where ordering = v_x;
					v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
					v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
					v_message_arr[v_x] := v_message_json_template::text;
					v_x := v_x + 1;
				end loop;
				v_message := '['||array_to_string(v_message_arr,',')||']';
				v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
				v_response_json := v_child_message_json_template;
				p_result := 1;
				
			-- event_id -> 18 (TV Guide View)
			when 18 then
				if exists(select * from fbbot.fbbot_matches
                          where v_current_date between (match_start_date + '5.5 hours'::interval)::date and (match_end_date + '5.5 hours'::interval)::date
                          and v_current_timestamp <= match_end_date) then
					select array(select event_id from fbbot.fbbot_events where parent_id = v_event_id and is_active = 1) into v_events_arr;
					select array_length(v_events_arr,1) into v_events_arr_len;
					if v_events_arr_len > 0 then
						v_i := 1;
						loop
							exit when v_i > v_events_arr_len;
							v_child_event_id := v_events_arr[v_i];
							select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_child_event_id;
							drop view if exists message_view;
							execute 'create temporary view message_view as
                            			select message_text,ordering,message_json,message_image_url
										from fbbot.fbbot_event_messages
										where event_id = '||v_child_event_id||'
										and is_active = 1';
							select count(1) into v_message_count from message_view where ordering is not null;
							select message_json into v_message_json_template from message_view where ordering is null;
							/*if v_child_event_id = 19 then
								v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
								v_x := 1;
								loop
									exit when v_x > v_message_count;
									select message_text into v_message_text from message_view where ordering = v_x;
									v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
									v_message_arr[v_x] := v_message_json_template::text;
									v_x := v_x + 1;
								end loop;
								v_message := '['||array_to_string(v_message_arr,',')||']';
								v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
								v_json_text := substring(v_child_message_json_template::text,2);
							elsif v_child_event_id = 20 then*/
								v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
								drop view if exists sports_view;
								create temporary view sports_view as
								select row_number() over() slno,s.sport_id,s.sport_name,s.payload_text
								from fbbot.fbbot_sports s
                                where exists(select 1
                                             from fbbot.fbbot_tv_schedule tvs
                                             join fbbot.fbbot_matches m
                                             on m.match_id = tvs.match_id
                                             where tvs.sport_id = s.sport_id
                                             and tvs.schedule_date = v_current_date
                                             and m.match_end_date >= v_current_timestamp
                                             and v_current_date between (match_start_date + '5.5 hours'::interval)::date and (match_end_date + '5.5 hours'::interval)::date
											);
								select count(1) into v_sport_count from sports_view;
								v_message_arr := null;
								v_x := 1;
								loop
									exit when v_x > v_sport_count;
									select sport_name,'Sports_'||payload_text||'_'||sport_id into v_sport_name,v_payload_text from sports_view where slno = v_x;
									v_message_json_template := jsonb_set(v_message_json_template,'{payload}',('"'||v_payload_text||'"')::text::jsonb,true);
									v_message_json_template := jsonb_set(v_message_json_template,'{content_type}',('"'||'text'||'"')::text::jsonb,true);
									v_message_json_template := jsonb_set(v_message_json_template,'{title}',('"'||v_sport_name||'"')::text::jsonb,true);
									v_message_arr[v_x] := v_message_json_template::text;
									v_x := v_x + 1;
								end loop;
								v_message := '['||array_to_string(v_message_arr,',')||']';
								v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,message,quick_replies}',v_message::jsonb,true);
								-- v_json_text := v_json_text||','||substring(v_child_message_json_template::text,2);
                                v_json_text := substring(v_child_message_json_template::text,2);
							-- end if;
							v_json_text := substring(v_json_text,1,length(v_json_text)-1);
							v_i := v_i + 1;
						end loop;
						p_result := 1;
					end if;
					v_response_json := '{'||v_json_text||'}';
					p_result := 1;
                else
                	p_result := 0;
                end if;
				
			-- event_id -> 21 (TV Guide Select Sport)
			when 21 then
				
				select array(select event_id from fbbot.fbbot_events where parent_id = v_event_id and is_active = 1 order by event_id) into v_events_arr;
				select array_length(v_events_arr,1) into v_events_arr_len;
				if v_events_arr_len > 0 then
					v_i := 1;
					loop
						exit when v_i > v_events_arr_len;
						v_child_event_id := v_events_arr[v_i];
						select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_child_event_id;
						drop view if exists message_view;
						execute 'create temporary view message_view as
									select message_text,ordering,message_json,message_image_url
									from fbbot.fbbot_event_messages
									where event_id = '||v_child_event_id||'
									and is_active = 1';
						select count(1) into v_message_count from message_view where ordering is not null;
						select message_json into v_message_json_template from message_view where ordering is null;
						/*if v_child_event_id = 22 then
							v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							v_x := 1;
							loop
								exit when v_x > v_message_count;
								select message_text into v_message_text from message_view where ordering = v_x;
								v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
								v_message_arr[v_x] := v_message_json_template::text;
								v_x := v_x + 1;
							end loop;
							v_message := '['||array_to_string(v_message_arr,',')||']';
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
							v_json_text := substring(v_child_message_json_template::text,2);
						elsif v_child_event_id = 23 then*/
							select p_input_json->>'sport_id' into v_sport_id;
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							drop view if exists leagues_view;
							execute 'create temporary view leagues_view as
									select row_number() over() slno,league_id,league_short_code league_name,payload_text
									from fbbot.fbbot_leagues l
									where l.sport_id = '||v_sport_id||
                                    'and exists(select 1 from fbbot.fbbot_tv_schedule tvs
                                    			join fbbot.fbbot_matches m
                                                on m.league_id = tvs.league_id
                                                and m.match_id = tvs.match_id
                                    			where tvs.league_id = l.league_id
                                                and tvs.schedule_date = '''||v_current_date||'''
												 and m.match_end_date >= '''||v_current_timestamp||'''
                                                 and '''||v_current_date||''' between (match_start_date + ''5.5 hours''::interval)::date and (match_end_date + ''5.5 hours''::interval)::date)';
							select count(1) into v_league_count from leagues_view;
							v_message_arr := null;
							v_x := 1;
							loop
								exit when v_x > v_league_count;
								select league_name,'Tournaments_'||payload_text||'_'||league_id into v_league_name,v_payload_text from leagues_view where slno = v_x;
								v_message_json_template := jsonb_set(v_message_json_template,'{payload}',('"'||v_payload_text||'"')::text::jsonb,true);
								v_message_json_template := jsonb_set(v_message_json_template,'{content_type}',('"'||'text'||'"')::text::jsonb,true);
								v_message_json_template := jsonb_set(v_message_json_template,'{title}',('"'||v_league_name||'"')::text::jsonb,true);
								v_message_arr[v_x] := v_message_json_template::text;
								v_x := v_x + 1;
							end loop;
							v_message := '['||array_to_string(v_message_arr,',')||']';
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt,0,message,quick_replies}',v_message::jsonb,true);
							-- v_json_text := v_json_text||','||substring(v_child_message_json_template::text,2);
                            v_json_text := substring(v_child_message_json_template::text,2);
						-- end if;
						v_json_text := substring(v_json_text,1,length(v_json_text)-1);
						v_i := v_i + 1;
					end loop;
					p_result := 1;
				end if;
				v_response_json := '{'||v_json_text||'}';
				p_result := 1;
				
			-- event_id -> 24 (TV Guide Select Tournament)
			when 24 then
				
                select p_input_json->>'tour_id' into v_league_id;
				select array(select event_id from fbbot.fbbot_events where parent_id = v_event_id order by event_id) into v_events_arr;
				select array_length(v_events_arr,1) into v_events_arr_len;
				if v_events_arr_len > 0 then
					v_i := 1;
					loop
						exit when v_i > v_events_arr_len;
						v_child_event_id := v_events_arr[v_i];
						select json_template into v_child_message_json_template from fbbot.fbbot_events where event_id = v_child_event_id;
						drop view if exists message_view;
						execute 'create temporary view message_view as
									select message_text,ordering,message_json,message_image_url
									from fbbot.fbbot_event_messages
									where event_id = '||v_child_event_id||'
									and is_active = 1';
						select count(1) into v_message_count from message_view where ordering is not null;
						select message_json into v_message_json_template from message_view where ordering is null;
						if v_child_event_id = 25 then
							v_message_json_template := jsonb_set(v_message_json_template,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							v_x := 1;
							loop
								exit when v_x > v_message_count;
								select message_text into v_message_text from message_view where ordering = v_x;
								v_message_json_template := jsonb_set(v_message_json_template,'{message,text}',('"'||v_message_text||'"')::text::jsonb,true);
								v_message_arr[v_x] := v_message_json_template::text;
								v_x := v_x + 1;
							end loop;
							v_message := '['||array_to_string(v_message_arr,',')||']';
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottxt}',v_message::jsonb,true);
							v_json_text := substring(v_child_message_json_template::text,2);
						elsif v_child_event_id = 26 then
							v_message_arr := null;
							v_x := 1;
							loop
								exit when v_x > v_message_count;
								select message_image_url,message_json into v_message_image_url,v_message_json_template from message_view where ordering = v_x;
                                drop view if exists match_view;
								execute 'create temporary view match_view as
								select row_number() over(order by start_time) slno,match_name,schedule_image_url
								from(select distinct tvs.match_name,ls.schedule_image_url,tvs.start_time
									from fbbot.fbbot_tv_schedule tvs
									join fbbot.fbbot_league_schedule ls
									on ls.schedule_date = tvs.schedule_date
                                    join fbbot.fbbot_matches m
                                    on m.match_id = tvs.match_id
									and ls.sport_id = tvs.sport_id
									and ls.league_id = tvs.league_id
									and ls.match_id = tvs.match_id
                                    where tvs.schedule_date = '''||v_current_date||'''
                                    and m.match_end_date >= '''||v_current_timestamp||'''
                                    and '''||v_current_date||''' between (match_start_date + ''5.5 hours''::interval)::date and (match_end_date + ''5.5 hours''::interval)::date
                                    and tvs.league_id = '||v_league_id||') a';
								select count(1) into v_match_count from match_view;
								v_y := 1;
								loop
									exit when v_y > v_match_count;
									select replace(match_name,'vs.','vs'),schedule_image_url into v_match_name,v_match_image_url from match_view where slno = v_y;
									v_message_json_template := jsonb_set(v_message_json_template,'{title}',('"'||v_match_name||'"')::text::jsonb,true);
									v_message_json_template := jsonb_set(v_message_json_template,'{image_url}',('"'||v_match_image_url||'"')::text::jsonb,true);
									v_message_arr[v_y] := v_message_json_template::text;
									v_y := v_y + 1;
								end loop;
								v_x := v_x + 1;
							end loop;
							v_message := '['||array_to_string(v_message_arr,',')||']';
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt1,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt1,0,message,attachment,payload,elements}',v_message::jsonb,true);
							v_json_text := v_json_text||','||substring(v_child_message_json_template::text,2);
						elsif v_child_event_id = 27 then
							v_child_message_json_template := jsonb_set(v_child_message_json_template,'{chatbottmt2,0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
							v_json_text := v_json_text||','||substring(v_child_message_json_template::text,2);
						end if;
						v_json_text := substring(v_json_text,1,length(v_json_text)-1);
						v_i := v_i + 1;
					end loop;
					p_result := 1;
				end if;
				v_response_json := '{'||v_json_text||'}';
				p_result := 1;
				
			-- event_id -> 28 (TV Guide Continue Yes)
			when 28 then
				
				v_input_json := p_input_json;
				v_input_json := jsonb_set(v_input_json,'{event_payload_text}',('"'||'TVguide'||'"')::text::jsonb,true);
				select * from fbbot.fbbot_get_messages(v_input_json) s1 into v_response_json, p_result;
				v_response_json := jsonb_set(v_response_json,'{chatbottmt,0,message,text}',('"'||'Now we’re talking! Get picking again.'||'"')::text::jsonb,true);
                
			else
				null;
			
		end case;
		
		p_response_json := v_response_json;
		
	exception
		when no_data_found then
			p_result := -1;
	end;
	
/*exception
	when others then
		p_result := -2;*/
	
end;

$$;


--
