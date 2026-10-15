-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_event_json_14022019(jsonb)
-- Type: FUNCTION

-- Name: sibot_get_event_json_14022019(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_event_json_14022019(p_input_json jsonb, OUT p_event_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*
SELECT * from sibot.sibot_get_event_json(
	'{
  "application_key": "166525327336967",
  "receiver_id": "2084743198243936",
  "first_name": null,
  "last_name": null,
  "gender": null,
  "profile_pic": null,
  "timezone": null,
  "event_payload": "GetStarted",
  "sport_id": null,
  "league_id": null,
  "match_id": null,
  "team_id": null,
  "quiz_id": null,
  "question_id": null,
  "option_id": null,
  "venue_id": null,
  "player_id": null,
  "country_id": null
}'::jsonb-- <p_input_json jsonb>
);
*/
declare
	
    v_application_key text;
    v_receiver_id text;
    v_first_name text;
    v_last_name text;
    v_profile_picture text;
    v_gender text;
    v_time_zone text;
    v_event_payload_text text;
    v_league_id text;
    v_sport_id text;
    v_team_id text;
    v_match_id numeric;
    v_quiz_id numeric;
    v_same_event numeric;
    v_question_id numeric;
    v_option_id numeric;
    v_venue_id text;
    v_application_id numeric;
    v_user_id numeric;
    v_event_id numeric;
    v_check_event_change numeric;
    v_event_input_json jsonb;
    v_event_output_json jsonb;
    v_event_count numeric;
    v_widget_id numeric;
    v_template_id numeric;
    v_widget_input_json jsonb;
    v_widget_json jsonb;
    v_template_json jsonb;
    v_carousel_element_index numeric;
    v_json jsonb := '{"data":[]}'::jsonb;
    v_message_text text;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_template_id numeric;
    v_button_template_json jsonb;
    v_button_template_json_arr text[];
    v_recurring_message_arr text[];
    v_recurring_json_text text;
    v_message_count numeric;
    v_module_id numeric;
    v_parent_template_id numeric;
    v_function_name text;
    v_league_name text;
    v_sport_name text;
    v_player_id text;
    v_country_id text;
    v_league_count numeric;
	v_default_event_payload_text text := 'GetDefault';
	v_is_widget_generic numeric;
    
begin
	
    select p_input_json->>'application_key', p_input_json->>'receiver_id', p_input_json->>'event_payload', p_input_json->>'league_id',
			p_input_json->>'sport_id', p_input_json->>'team_id', p_input_json->>'match_id', p_input_json->>'quiz_id',
			p_input_json->>'question_id', p_input_json->>'option_id', p_input_json->>'venue_id', p_input_json->>'player_id',
			p_input_json->>'country_id'
    into v_application_key, v_receiver_id, v_event_payload_text, v_league_id, v_sport_id, v_team_id, v_match_id, v_quiz_id, v_question_id,
			v_option_id, v_venue_id, v_player_id, v_country_id;
    
    select application_id into strict v_application_id from sibot.sibot_application where application_key = v_application_key;
    select count(1) into v_league_count from sibot.sibot_application_league_map where application_id = v_application_id;
    
    if v_league_id is null and v_league_count = 1 then
    	select l.league_id, l.sport_id into v_league_id, v_sport_id
        from sibot.sibot_application_league_map alm
        join sibot.sibot_league l
        on l.league_id = alm.league_id
        where application_id = v_application_id;
    end if;
   
    begin
    	select user_id into strict v_user_id from sibot.sibot_user where receiver_id = v_receiver_id and application_id = v_application_id;
	exception
    	when no_data_found then
        	v_user_id := nextval('sibot.seq_sibot_user_id');
            insert into sibot.sibot_user(user_id,receiver_id,application_id,created_date)
            select v_user_id,v_receiver_id,v_application_id,v_current_timestamp;
	end;
    
    select event_id, check_event_change into strict v_event_id, v_check_event_change from sibot.sibot_event where event_payload = v_event_payload_text;
    
    if v_check_event_change = 1 then
        v_event_input_json := '{
        						"application_id": '||v_application_id||',
                                "user_id": '||v_user_id||',
                                "event_id": '||v_event_id||',
                                "sport_id": '||coalesce('"'||v_sport_id||'"','null')||',
                                "league_id": '||coalesce('"'||v_league_id||'"','null')||',
                                "match_id": '||coalesce(v_match_id,0)||',
                                "team_id": '||coalesce('"'||v_team_id||'"','null')||',
                                "quiz_id": '||coalesce(v_quiz_id,0)||',
                                "venue_id": '||coalesce('"'||v_venue_id||'"','null')||'
                                }';
        select * from sibot.sibot_get_event(v_event_input_json) into v_event_output_json;
        select v_event_output_json->>'event_id', v_event_output_json->>'sport_id', v_event_output_json->>'league_id', v_event_output_json->>'team_id'
        into v_event_id,v_sport_id,v_league_id,v_team_id;
	end if;
    
    drop view if exists event_view;
    execute 'create temporary view event_view as
    			select event_id,widget_id,row_number() over(order by event_order) slno
                from sibot.sibot_application_event_widget_map
                where application_id = '||v_application_id||
                ' and parent_event_id = '||v_event_id||
                ' and is_active = 1
                order by event_order';
    
    select count(1) into v_event_count from event_view;
    
    if v_event_count > 0 then
    	
        for i in 1..v_event_count
        loop
            
            select event_id, widget_id into v_event_id, v_widget_id from event_view where slno = i;
            select template_id, module_id, parent_template_id, case coalesce(module_id,0) when 0 then 1 else 0 end is_widget_generic
			into v_template_id, v_module_id, v_parent_template_id, v_is_widget_generic
            from sibot.sibot_widget where widget_id = v_widget_id;
            
			v_widget_input_json := '{
            						"application_id": '||v_application_id||',
                                    "receiver_id": '||v_receiver_id||',
                                    "user_id": '||v_user_id||',
                                    "module_id": '||v_module_id||',
                                    "event_id": '||v_event_id||',
                                    "widget_id": '||v_widget_id||',
                                    "template_id": '||v_template_id||',
                                    "sport_id": '||coalesce('"'||v_sport_id||'"','null')||',
                                	"league_id": '||coalesce('"'||v_league_id||'"','null')||',
                                    "match_id": '||coalesce(v_match_id,0)||',
                                    "team_id": '||coalesce('"'||v_team_id||'"','null')||',
                                    "quiz_id": '||coalesce(v_quiz_id,0)||',
                                	"question_id": '||coalesce(v_question_id,0)||',
                                	"option_id": '||coalesce(v_option_id,0)||',
                                    "venue_id": '||coalesce('"'||v_venue_id||'"','null')||',
                                    "player_id": '||coalesce('"'||v_player_id||'"','null')||',
                                    "country_id": '||coalesce('"'||v_country_id||'"','null')||'
                                    }';
			
            if v_module_id is not null then
                
				select function_name into v_function_name from sibot.sibot_module where module_id = v_module_id;
                execute 'select * from sibot.'||v_function_name||'('''||v_widget_input_json||''','||v_template_id||')'
                into v_template_id,v_widget_json;
                
				if v_widget_json is null then
					p_result := 0;
					exit;
            	end if;
				
            end if;
            
            if v_template_id = 1 then
            	if v_widget_json <> '{}'::jsonb then
                	v_template_json := v_widget_json;
				else
                	drop view if exists event_message_view;
                    execute 'create temporary view event_message_view as
                    			select message_text, image_url, message_sub_text, row_number() over(order by message_order) slno
                				from sibot.sibot_application_event_widget_message
                				where application_id = '||v_application_id||' and event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                                ' and is_active = 1';
					select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
                    v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
                    select count(1) into v_message_count from event_message_view;
                    for i in 1..v_message_count
                    loop
                    	select message_text into v_message_text from event_message_view where slno = i;
                        v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
                        v_recurring_message_arr[i] := v_template_json::text;
					end loop;
                    select string_agg(recurring_message,',') from(select recurring_message from unnest(v_recurring_message_arr) u(recurring_message))a
                    into v_recurring_json_text;
                    v_template_json := ('['||v_recurring_json_text||']')::jsonb;
				end if;
				p_result := 1;
                v_json := jsonb_set(v_json,('{data,'||(i-1)||'}')::text[],v_template_json,true);
                
			elsif v_template_id = 3 then
                if v_parent_template_id = 2 then
            		if v_same_event is null then
                		select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
                    	v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
                    	if v_widget_json::text not like '[%' then
                    		v_widget_json := ('['||v_widget_json::text||']')::jsonb;
						end if;
                    	v_template_json := jsonb_set(v_template_json,('{0,message,attachment,payload,elements}')::text[],v_widget_json,true);
                    	v_same_event := 1;
                    	v_carousel_element_index := 1;
					else
                		v_template_json := jsonb_set(v_template_json,('{0,message,attachment,payload,elements,'||v_carousel_element_index||'}')::text[],
                                                     v_widget_json,true);
						v_carousel_element_index := v_carousel_element_index + 1;
					end if;
                elsif v_parent_template_id in (6,13) then
                	select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
                	v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
                	v_template_json := jsonb_set(v_template_json,('{0,message,attachment,payload,elements}')::text[],v_widget_json,true);
                	drop view if exists event_widget_button_view;
                	execute 'create temporary view event_widget_button_view as
                    			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                                		row_number() over(order by button_order) slno
								from sibot.sibot_application_event_widget_button_map aewbm
                            	join sibot.sibot_event e
                            	on e.event_id = payload_event_id
                            	where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            	' and button_template_id = 4 and is_active = 1';
					select count(1) into v_button_count from event_widget_button_view;
                	for j in 1..v_button_count
                	loop
                		select button_title,payload_text,button_template_id into v_button_title,v_button_payload_text,v_button_widget_id
                    	from event_widget_button_view where slno = j;
                    	select replace(v_button_payload_text,'v_league_id',coalesce(v_league_id,'')) into v_button_payload_text;
                        select replace(v_button_payload_text,'v_venue_id',coalesce(v_venue_id::text,'')) into v_button_payload_text;
                        select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    	select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                    	v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    	v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    	v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                	select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                	from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                	v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
                end if;
                if i = v_event_count then
					p_result := 1;
                	v_json := jsonb_set(v_json,('{data,'||(i-1)||'}')::text[],v_template_json,true);
				end if;
                
			elsif v_template_id = 5 then
            	select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
                v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
                select message_text into v_message_text
                from sibot.sibot_application_event_widget_message
                where application_id = v_application_id and event_id = v_event_id and is_active = 1
                and widget_id in(select widget_id from sibot.sibot_widget where template_id = v_template_id);
                v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
                if v_widget_json <> '{}'::jsonb then
                	v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_widget_json,true);
				else
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
                        select replace(v_button_payload_text,'v_league_id',coalesce(v_league_id,'')) into v_button_payload_text;
                        select replace(v_button_payload_text,'v_quiz_id',coalesce(v_quiz_id::text,'')) into v_button_payload_text;
                        select replace(v_button_payload_text,'v_venue_id',coalesce(v_venue_id::text,'')) into v_button_payload_text;
                        select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                        select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                        v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                        v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                        v_button_template_json_arr[j] := v_button_template_json::text;
					end loop;
                    select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                    from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                    v_template_json := jsonb_set(v_template_json,('{0,message,quick_replies}')::text[],v_button_template_json,true);
				end if;
				p_result := 1;
                v_json := jsonb_set(v_json,('{data,'||i||'}')::text[],v_template_json,true);
                
			else
				p_result := 1;
            	v_json := jsonb_set(v_json,('{data,'||(i-1)||'}')::text[],v_widget_json,true);
                
			end if;
            
        end loop;
		
    else
    	p_result := 0;
        
    end if;
    
    if p_result = 1 then
    	p_event_json := v_json;
	else
		v_event_input_json := p_input_json;
        v_event_input_json := jsonb_set(v_event_input_json,'{event_payload}',('"'||v_default_event_payload_text||'"')::jsonb,true);
		select * from sibot.sibot_get_default_message_json(v_event_input_json) into p_event_json;
        p_result := 1;
    end if;
    
exception
	when others then
    	v_event_input_json := p_input_json;
        v_event_input_json := jsonb_set(v_event_input_json,'{event_payload}',('"'||v_default_event_payload_text||'"')::jsonb,true);
		select * from sibot.sibot_get_default_message_json(v_event_input_json) into p_event_json;
        p_result := 1;
end;

$$;


--
