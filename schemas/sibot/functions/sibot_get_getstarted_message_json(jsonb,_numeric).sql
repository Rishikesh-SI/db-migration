-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_getstarted_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_getstarted_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_getstarted_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_event_id numeric;
	v_widget_id numeric;
    v_template_id numeric;
    v_template_json jsonb;
    v_message_count numeric;
    v_message_text text;
    v_message_sub_text text;
    v_image_url text;
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_url text;
    v_button_template_id numeric;
    v_button_template_json jsonb;
    v_button_template_json_arr text[];
    v_league_id text ;
    v_user_league_team_count numeric;
    v_league_team_count numeric;
    v_no_alerts_team_count numeric;
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'event_id', p_input_json->>'widget_id',
    		p_input_json->>'league_id'
    into v_application_id, v_receiver_id, v_user_id, v_event_id, v_widget_id, v_league_id;
    select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
    
    if v_application_id=1 then
    -- v_league_id :='30';/*for ipl*/
	-- v_league_id= 48;/*for icc world cup*/
	 v_league_id= 49; /*for pkl */
    end if;
    
	-- raise notice 'v_event_id:%',v_event_id;
	
    case v_widget_id
    	
        when 101 then
        	
            drop view if exists event_message_view;
    		execute 'create temporary view event_message_view as
            			select message_text, image_url, message_sub_text, row_number() over(order by message_order) slno
                		from sibot.sibot_application_event_widget_message
                		where application_id = '||v_application_id||' and event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                        ' and is_active = 1';
    		select count(1) into v_message_count from event_message_view;
            for i in 1..v_message_count
            loop
			/*raise notice 'v_message_count:%',v_message_count;
			select 1/0;*/
            	v_button_template_json_arr := null;
            	select message_text,message_sub_text,image_url into v_message_text,v_message_sub_text,v_image_url
                from event_message_view where slno = i;
            	v_template_json := jsonb_set(v_template_json,'{title}',('"'||v_message_text||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{subtitle}',('"'||coalesce(v_message_sub_text,'')||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||v_image_url||'"')::jsonb,true);
                drop view if exists event_widget_button_view;
                execute 'create temporary view event_widget_button_view as
                			select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id, button_url,
                            		row_number() over(order by button_order) slno
							from sibot.sibot_application_event_widget_button_map aewbm
                            left join sibot.sibot_event e
                            on e.event_id = payload_event_id
                            where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||' and widget_id = '||v_widget_id||
                            ' and is_active = 1';
				select count(1) into v_button_count from event_widget_button_view;
                for j in 1..v_button_count
                loop
                	select button_title, payload_text, button_template_id, button_url
                    into v_button_title, v_button_payload_text, v_button_widget_id, v_button_url
                    from event_widget_button_view where slno = j;
                    select template_id into v_button_template_id from sibot.sibot_widget where widget_id = v_button_widget_id;
                    select template_json into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                   if v_event_id = 4 then
                    	if j = 1 then
                         	select count(1) into v_user_league_team_count
            				from sibot.sibot_user_league_team_map
            				where user_id = v_user_id and league_id = v_league_id::numeric;
                         	select count(1) into v_league_team_count
                         	from sibot.sibot_application_league_team_map where application_id = v_application_id
                            and league_id = v_league_id::numeric;
							/*raise notice 'v_user_league_team_count:%',v_user_league_team_count;
							raise notice 'v_league_team_count:%',v_league_team_count;
							select 1/0;*/
                    		/*if v_user_league_team_count = v_league_team_count then
                            	v_button_title := 'Un'||lower(v_button_title);
                                select event_payload||'_null_'||v_league_id||'_null_null' into v_button_payload_text
                                from sibot.sibot_event where event_id = 409;
							end if;*/
							v_button_title := v_button_title;
                               /* select event_payload||'_null_'||v_league_id||'_null_null' into v_button_payload_text
                                from sibot.sibot_event where event_id = 401;*/
						else
                    		select count(1) into v_no_alerts_team_count
                        	from sibot.sibot_user_league_team_map
                        	where user_id = v_user_id
                        	and league_id = v_league_id::numeric
                        	and alert_status = 1
                        	and alert_stopped_till is not null
                        	and alert_stopped_till >= v_current_timestamp;
                        	if v_no_alerts_team_count = 0 then
                        		exit;
							end if;
                    	end if;
                    end if;
                    v_button_template_json := jsonb_set(v_button_template_json,'{title}',('"'||v_button_title||'"')::jsonb,true);
                    case v_button_widget_id
                    	when 3 then
                        	v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
						when 6 then
                        	v_button_template_json := jsonb_set(v_button_template_json,'{url}',('"'||v_button_url||'"')::jsonb,true);
					end case;
                    v_button_template_json_arr[j] := v_button_template_json::text;
				end loop;
                select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
                from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
            end loop;
            p_widget_json := v_template_json;
		else
        	null;
            
    end case;
    
end;

$$;


--
