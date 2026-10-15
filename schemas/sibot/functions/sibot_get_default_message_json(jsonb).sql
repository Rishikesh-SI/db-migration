-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_default_message_json(jsonb)
-- Type: FUNCTION

-- Name: sibot_get_default_message_json(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_default_message_json(p_input_json jsonb, OUT p_widget_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

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
    v_message_sub_text text;
    v_image_url text;
    v_button_url text;
    v_user_league_team_count numeric;
    v_league_team_count numeric;
    v_no_alerts_team_count numeric;
    
begin
	
    select p_input_json->>'application_key', p_input_json->>'receiver_id', p_input_json->>'event_payload'
    into v_application_key, v_receiver_id, v_event_payload_text;
    select event_id into v_event_id from sibot.sibot_event where event_payload = v_event_payload_text;
    select application_id into v_application_id from sibot.sibot_application where application_key = v_application_key;
    select user_id into v_user_id from sibot.sibot_user where receiver_id = v_receiver_id and application_id = v_application_id;
  	
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
            select template_id, parent_template_id into v_template_id, v_parent_template_id
            from sibot.sibot_widget where widget_id = v_widget_id;
            
            if v_template_id = 5 then
            	select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
                v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
                select message_text into v_message_text
                from sibot.sibot_application_event_widget_message
                where application_id = v_application_id and event_id = v_event_id and is_active = 1
                and widget_id in(select widget_id from sibot.sibot_widget where template_id = v_template_id);
                v_template_json := jsonb_set(v_template_json,('{0,message,text}')::text[],('"'||coalesce(v_message_text,'')||'"')::text::jsonb,true);
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
                v_json := jsonb_set(v_json,('{data,1}')::text[],v_template_json,true);
			end if;
        end loop;
    end if;
    p_widget_json := v_json;
    
exception
	when others then
		null;
end;

$$;


--
