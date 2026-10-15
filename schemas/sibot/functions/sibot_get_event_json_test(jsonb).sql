-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_event_json_test(jsonb)
-- Type: FUNCTION

-- Name: sibot_get_event_json_test(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_event_json_test(p_input_json jsonb, OUT p_event_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*
SELECT * from sibot.sibot_get_event_json(
	'{
  "application_key": "241355436749374",
  "receiver_id": "2523844414295560",
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
  "country_id": null,
  "bs_category": null,
  "bs_category_id": null,
  "bs_change_option": null,
  "bs_change_value": null,
  "bs_mobile_number": null,
  "bs_email_id": null
}'::jsonb-- <p_input_json jsonb>
);
*/
declare
	
	v_application_key text;
    	v_receiver_id text;
     v_event_payload_text text;
     v_application_id numeric;
    	v_league_id text;
    	v_sport_id text;
    	v_team_id text;
    	v_match_id numeric;
    	v_quiz_id numeric;
    	v_question_id numeric;
    	v_option_id numeric;
    	v_venue_id text;
    	v_player_id text;
    	v_country_id text;
    	v_league_count numeric;
     v_first_name text;
     v_last_name text;
     v_profile_picture text;
     v_gender text;
    	v_bs_category char(1);
    	v_bs_category_id numeric;
    	v_bs_change_option char(1);
   	v_bs_change_value numeric;
    	v_bs_mobile_number text;
    	v_bs_email_id text;
     v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    	v_user_id numeric;
    	v_event_id numeric;
    	v_check_event_change numeric;
     v_event_input_json jsonb;
    	v_event_output_json jsonb;
     v_event_count numeric;
     v_widget_id numeric;
     v_image_attachment_id text;
     v_template_id numeric;
     v_module_id numeric;
    	v_parent_template_id numeric;
     v_is_widget_generic numeric;
     v_widget_input_json jsonb;
     v_function_name text;
    	v_widget_json jsonb;
     v_template_json jsonb;
     v_message_count numeric;
    	v_message_text text;
     v_recurring_message_arr text[];
    	v_recurring_json_text text;
     v_json jsonb := '{"data":[]}'::jsonb;
     v_same_event numeric;
     v_carousel_element_index numeric;
     v_title text;
     v_image_url text;
     v_button_count numeric;
    	v_button_title text;
    	v_button_payload_text text;
     v_button_widget_id numeric;
     v_url text;
    	v_button_template_id numeric;
    	v_button_template_json jsonb;
     v_button_template_json_arr text[];
     v_bs_scenario_id numeric;
     
     v_time_zone text;
    	v_league_name text;
    	v_sport_name text;
    	v_default_event_payload_text text := 'GetDefault';
	
begin
	
     select p_input_json->>'application_key', p_input_json->>'receiver_id', p_input_json->>'event_payload'
    	into v_application_key, v_receiver_id, v_event_payload_text;
    	
    	select application_id into strict v_application_id from sibot.sibot_application where application_key = v_application_key;
    	
     if v_application_id in(1,2) then
          select p_input_json->>'league_id', p_input_json->>'sport_id', p_input_json->>'team_id', p_input_json->>'match_id', p_input_json->>'quiz_id',
          		p_input_json->>'question_id', p_input_json->>'option_id', p_input_json->>'venue_id', p_input_json->>'player_id',
                    p_input_json->>'country_id'
		into v_league_id, v_sport_id, v_team_id, v_match_id, v_quiz_id, v_question_id, v_option_id, v_venue_id, v_player_id, v_country_id;
          select count(1) into v_league_count from sibot.sibot_application_league_map where application_id = v_application_id;
          if v_league_id is null and v_league_count = 1 then
               select l.league_id, l.sport_id into v_league_id, v_sport_id
        		from sibot.sibot_application_league_map alm
        		join sibot.sibot_league l
        		on l.league_id = alm.league_id
        		where application_id = v_application_id;
    		end if;
	elsif v_application_id = 3 then
          select p_input_json->>'first_name', p_input_json->>'last_name', p_input_json->>'profile_pic', p_input_json->>'gender',
          		p_input_json->>'bs_category', p_input_json->>'bs_category_id', p_input_json->>'bs_change_option', p_input_json->>'bs_change_value',
          		p_input_json->>'bs_mobile_number', p_input_json->>'bs_email_id' 
          into v_first_name, v_last_name, v_profile_picture, v_gender, v_bs_category, v_bs_category_id, v_bs_change_option, v_bs_change_value,
          	v_bs_mobile_number, v_bs_email_id;
    	end if;
     
    	begin
          select user_id into strict v_user_id from sibot.sibot_user where receiver_id = v_receiver_id and application_id = v_application_id;
	exception
     	when no_data_found then
        		v_user_id := nextval('sibot.seq_sibot_user_id');
            	insert into sibot.sibot_user(user_id,receiver_id,application_id,created_date)
            	select v_user_id,v_receiver_id,v_application_id,v_current_timestamp;
               if v_application_id = 3 then
               	update sibot.sibot_user
                    set first_name = v_first_name, last_name = v_last_name, profile_picture = v_profile_picture, gender = v_gender
                    where user_id = v_user_id;
               end if;
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
                                	"venue_id": '||coalesce('"'||v_venue_id||'"','null')||',
                                	"bs_category": '||coalesce('"'||v_bs_category||'"','null')||',
                                   "bs_category_id": '||coalesce(v_bs_category_id,0)||',
                                   "bs_change_option": '||coalesce('"'||v_bs_change_option||'"','null')||',
                                   "bs_mobile_number": '||coalesce('"'||v_bs_mobile_number||'"','null')||',
                                   "bs_email_id": '||coalesce('"'||v_bs_email_id||'"','null')||'
                                 }';
        	select * from sibot.sibot_get_event(v_event_input_json) into v_event_output_json;
        	select v_event_output_json->>'event_id' into v_event_id;
          if v_application_id in(1,2) then
          	select v_event_output_json->>'sport_id', v_event_output_json->>'league_id', v_event_output_json->>'team_id'
               into v_sport_id, v_league_id, v_team_id;
		elsif v_application_id = 3 then
          	select v_event_output_json->>'bs_scenario_id' into v_bs_scenario_id;
          end if;
	end if;
    	
    	drop view if exists event_view;
    	execute 'create temporary view event_view as
     		select event_id,widget_id,image_attachment_id,row_number() over(order by event_order) slno
               from sibot.sibot_application_event_widget_map
               where application_id = '||v_application_id||
               'and parent_event_id = '||v_event_id||
               'and is_active = 1
               order by event_order';
	
    	select count(1) into v_event_count from event_view;
    	
    	if v_event_count > 0 then
     	
        	for i in 1..v_event_count
        	loop
          	
            	select event_id, widget_id, image_attachment_id into v_event_id, v_widget_id, v_image_attachment_id from event_view where slno = i;
            	
                -- raise notice 'v_widget_id : %',v_widget_id;
                
               select template_id, coalesce(module_id,1), parent_template_id, case coalesce(module_id,0) when 0 then 1 else 0 end is_widget_generic
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
                                    	"parent_template_id": '||coalesce(v_parent_template_id,0)||',
                                    	"sport_id": '||coalesce('"'||v_sport_id||'"','null')||',
                                		"league_id": '||coalesce('"'||v_league_id||'"','null')||',
                                    	"match_id": '||coalesce(v_match_id,0)||',
                                    	"team_id": '||coalesce('"'||v_team_id||'"','null')||',
                                    	"quiz_id": '||coalesce(v_quiz_id,0)||',
                                		"question_id": '||coalesce(v_question_id,0)||',
                                		"option_id": '||coalesce(v_option_id,0)||',
                                    	"venue_id": '||coalesce('"'||v_venue_id||'"','null')||',
                                    	"player_id": '||coalesce('"'||v_player_id||'"','null')||',
                                    	"country_id": '||coalesce('"'||v_country_id||'"','null')||',
                                    	"bs_category": '||coalesce('"'||v_bs_category||'"','null')||',
                                   	"bs_category_id": '||coalesce(v_bs_category_id,0)||',
                                        "bs_change_option": '||coalesce('"'||v_bs_change_option||'"','null')||',
                                        "bs_change_value": '||coalesce(v_bs_change_value,0)||',
                                        "bs_scenario_id": '||coalesce(v_bs_scenario_id,0)||'
                                       }';
				
                -- raise notice 'v_module_id : %',v_module_id;
                
            	if v_module_id is not null then
               	select function_name into v_function_name from sibot.sibot_module where module_id = v_module_id;
                
                    execute 'select * from sibot.'||v_function_name||'('''||v_widget_input_json||''','||v_template_id||')'
                    into v_template_id, v_widget_json;
                   -- raise notice 'v_widget_input_json : %',v_widget_input_json;
               
                    if v_widget_json is null then
                    	p_result := 0;
					exit;
            		end if;
			else
               	v_widget_json := null;
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
                                   'and is_active = 1';
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
                			v_template_json := jsonb_set(v_template_json,('{0,message,attachment,payload,elements,'||v_carousel_element_index||'}')::text[],v_widget_json,true);
						v_carousel_element_index := v_carousel_element_index + 1;
					end if;
                	elsif v_parent_template_id in (6,13) then
                    	select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_parent_template_id;
                		v_template_json := jsonb_set(v_template_json,('{0,recipient,id}')::text[],('"'||v_receiver_id||'"')::text::jsonb,true);
                    	if v_widget_json is null then
                    		select ('['||template_json::text||']')::jsonb into v_widget_json from sibot.sibot_template where template_id = v_template_id;
                    		select message_text, image_url into v_title, v_image_url
                              from sibot.sibot_application_event_widget_message
                              where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id;
                			v_widget_json := jsonb_set(v_widget_json,'{0,title}',('"'||v_title||'"')::jsonb,true);
                			v_widget_json := jsonb_set(v_widget_json,'{0,image_url}',('"'||v_image_url||'"')::jsonb,true);
                			drop view if exists event_widget_button_view;
                			execute 'create temporary view event_widget_button_view as
                              		select button_title, event_payload||coalesce(button_payload_text,'''') payload_text, button_template_id,
                                        		button_url, row_number() over(order by button_order) slno
								from sibot.sibot_application_event_widget_button_map aewbm
                            			left join sibot.sibot_event e
                            			on e.event_id = payload_event_id
                            			where application_id = '||v_application_id||' and aewbm.event_id = '||v_event_id||
                                        ' and widget_id = '||v_widget_id||' and button_template_id <> 4 and is_active = 1';
						select count(1) into v_button_count from event_widget_button_view;
                			for j in 1..v_button_count
                			loop
                				select button_title, payload_text, button_template_id, button_url
                                   into v_button_title, v_button_payload_text, v_button_widget_id, v_url
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
                			v_widget_json := jsonb_set(v_widget_json,('{0,buttons}')::text[],v_button_template_json,true);  
					end if;
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
                                	' and is_active = 1
                                   group by button_title, event_payload||coalesce(button_payload_text,''''), button_template_id, button_order';
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
                	
                elsif v_template_id = 9 then
                	if v_widget_json is null then
                		select ('['||template_json::text||']')::jsonb into v_template_json from sibot.sibot_template where template_id = v_template_id;
                    	v_template_json := jsonb_set(v_template_json,'{0,recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
                    	if v_is_widget_generic = 1 and v_image_attachment_id is not null then
                    		v_template_json := jsonb_set(v_template_json,'{0,message,attachment,payload,attachment_id}',('"'||v_image_attachment_id||'"')::text::jsonb,true);
					end if;
				else
                    	v_template_json := v_widget_json;
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
    	-- select 1/0;
/*exception
	when others then
    	v_event_input_json := p_input_json;
        v_event_input_json := jsonb_set(v_event_input_json,'{event_payload}',('"'||v_default_event_payload_text||'"')::jsonb,true);
		select * from sibot.sibot_get_default_message_json(v_event_input_json) into p_event_json;
        p_result := 1;*/
end;

$$;


--
