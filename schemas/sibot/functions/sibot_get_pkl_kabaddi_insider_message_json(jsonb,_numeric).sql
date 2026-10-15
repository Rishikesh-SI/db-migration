-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_pkl_kabaddi_insider_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_pkl_kabaddi_insider_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_pkl_kabaddi_insider_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_module_id numeric := 13;
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
    v_league_team_count numeric;
    v_user_league_team_count numeric;
    v_message_condition_id numeric;
    v_team_name text;
    v_followed_league_filter_query text := ' ';
    v_followed_team_filter_query text := ' ';
    v_parent_template_id numeric;
    v_all_team_query text := ' ';
    v_i numeric;
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'module_id', p_input_json->>'event_id',
    		p_input_json->>'widget_id', p_input_json->>'league_id', p_input_json->>'team_id', p_input_json->>'match_id'
    into v_application_id, v_receiver_id, v_user_id, v_module_id, v_event_id, v_widget_id, v_league_id, v_team_id,v_match_id;
	
    select user_id into v_user_id from sibot.sibot_user where receiver_id = v_receiver_id;
    select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
    
    case v_widget_id
    	
		    
		when 1301 then
        
        /*raise notice 'v_user_id:%',v_user_id;
        select 1/0;*/
        if not exists(select 1 from sibot.sibot_user_kabaddi_insider where user_id=v_user_id) then
        insert into sibot.sibot_user_kabaddi_insider (user_kabaddi_insider_id,user_id,alert_status,alert_start_date,alert_stopped_date)
        select nextval('sibot.seq_sibot_user_kabaddi_insider_id'),v_user_id,1,v_current_timestamp,null;
        else
         update sibot.sibot_user_kabaddi_insider 
		 set alert_status=1,alert_stopped_till =null
		 where user_id=v_user_id;
        end if;
            -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id ;
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
        
        when 1302 then
        
        /*raise notice 'v_user_id:%',v_user_id;
        select 1/0;*/
        
        -- select * from sibot.sibot_user_kabaddi_insider
        update sibot.sibot_user_kabaddi_insider set alert_status = 0,alert_stopped_date =v_current_timestamp  where user_id=v_user_id;
        	
            -- v_message_condition_id := case v_team_id::numeric when 0 then 1 else 2 end;
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id ;
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
        when 1303 then
        	-- select * from sibot.sibot_user_kabaddi_insider
            update sibot.sibot_user_kabaddi_insider
            set alert_status = 0, alert_stopped_till = (current_date + '1 day'::interval)
            where user_id = v_user_id;
            p_widget_json := '{}'::jsonb;
		       
		       
		else
        	null;
            
    end case;
    
end;

$$;


--
