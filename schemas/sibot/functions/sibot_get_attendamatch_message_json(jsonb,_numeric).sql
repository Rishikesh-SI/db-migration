-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_attendamatch_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_attendamatch_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_attendamatch_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_application_id numeric;
    v_receiver_id text;
    v_user_id numeric;
    v_event_id numeric;
	v_widget_id numeric;
    v_venue_id text;
    v_template_id numeric;
    v_template_json jsonb;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_venue_count numeric;
    v_title text;
    v_image_url text;
    v_button_count numeric;
    v_button_title text;
    v_button_payload_text text;
    v_button_widget_id numeric;
    v_button_template_id numeric;
    v_button_template_json jsonb;
    v_button_template_json_arr text[];
    v_template_json_arr text[];
    v_venue_match_day_count numeric;
    v_url text;
    v_message_text text;
    v_image_attachment_id text;
    v_message_text_arr text[];
    v_message_text_count numeric;
    v_recurring_message_arr text[];
    v_recurring_json_text text;
    v_city_name text;
    
begin
	
    select p_input_json->>'application_id', p_input_json->>'receiver_id', p_input_json->>'user_id', p_input_json->>'event_id', p_input_json->>'widget_id',
    		p_input_json->>'venue_id'
    into v_application_id, v_receiver_id, v_user_id, v_event_id, v_widget_id, v_venue_id;
    
    select template_id into v_template_id from sibot.sibot_widget where widget_id = v_widget_id;
    select template_json into v_template_json from sibot.sibot_template where template_id = v_template_id;
    
    case v_widget_id
    	
		when 501 then
        	
            drop view if exists venue_view;
            execute 'create temporary view venue_view as
            			select row_number() over(order by avm.venue_slno) slno, v.venue_id, v.city, avm.venue_image_url
						from sibot.sibot_venue v
						join sibot.sibot_application_venue_map avm
						on avm.venue_id = v.venue_id
						join sibot.sibot_application_match_map amm
						on amm.application_id = avm.application_id
						join sibot.sibot_match m
						on m.match_id = amm.match_id
						and m.venue_id = avm.venue_id
						where avm.application_id = '||v_application_id||'
						and m.match_end_date >= '''||v_current_timestamp||'''
                        and v.city is not null
                        and avm.venue_image_url is not null
                        and avm.venue_slno is not null
						group by v.venue_id, v.city, avm.venue_image_url, avm.venue_slno
						limit 4';
            select count(1) into v_venue_count from venue_view;
            for i in 1..v_venue_count
            loop
                select venue_id::text, city, venue_image_url into v_venue_id, v_title, v_image_url from venue_view where slno = i;
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
                    select replace(v_button_payload_text,'v_venue_id',v_venue_id) into v_button_payload_text;
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
			
		when 502 then
        	
			drop view if exists venue_match_day_view;
            execute 'create temporary view venue_match_day_view as
            			select row_number() over(order by alvdm.day_id) slno, alvdm.venue_id, alvdm.day_id, alvdm.day_title, alvdm.day_image_url, alvdm.tickets_url
                        from sibot.sibot_application_league_venue_day_map alvdm
                        where alvdm.venue_id in (select venue_id from unnest(string_to_array('''||v_venue_id||''','','')::numeric[]) u(venue_id))
                        and alvdm.application_id = '||v_application_id||'
                        and alvdm.day_title is not null
                        and alvdm.day_image_url is not null
                        and alvdm.tickets_url is not null
                        and exists(select 1
                        			from sibot.sibot_match m
                                    where m.venue_id = alvdm.venue_id
                                    and m.day_id = alvdm.day_id
                                    and m.league_id = alvdm.league_id
                                    and m.match_start_date = (select min(match_start_date)
                                    							from sibot.sibot_match m1
                                                                where m1.league_id = m.league_id
                                                                and m1.venue_id = m.venue_id
                                                                and m1.day_id = m.day_id)
                                    and m.match_start_date >= '''||v_current_timestamp||''')';
            select count(1) into v_venue_match_day_count from venue_match_day_view;
            for i in 1..v_venue_match_day_count
            loop
                select day_title, day_image_url, tickets_url into v_title, v_image_url, v_url from venue_match_day_view where slno = i;
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
                    if v_button_widget_id = 3 then
                    	select replace(v_button_payload_text,'v_venue_id',v_venue_id) into v_button_payload_text;
                    	v_button_template_json := jsonb_set(v_button_template_json,'{payload}',('"'||v_button_payload_text||'"')::jsonb,true);
                    elsif v_button_widget_id = 7 then
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
            
		when 503 then
            
            select v.venue_name, avm.location_image_url, avm.location_url into v_title, v_image_url, v_url
            from sibot.sibot_application_venue_map avm
            join sibot.sibot_venue v
            on v.venue_id = avm.venue_id
            where avm.application_id = v_application_id
            and avm.venue_id = v_venue_id::numeric
            and avm.location_image_url is not null
			and avm.location_url is not null;
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
                v_button_template_json := jsonb_set(v_button_template_json,'{url}',('"'||v_url||'"')::jsonb,true);
                v_button_template_json_arr[j] := v_button_template_json::text;
			end loop;
            select ('['||string_agg(button_template_json,',')||']')::jsonb into v_button_template_json
            from(select button_template_json from unnest(v_button_template_json_arr) u(button_template_json))a;
            v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 504 then
        	
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            select parking_image_attachment_id into v_image_attachment_id
            from sibot.sibot_application_venue_map
            where application_id = v_application_id
            and venue_id = v_venue_id::numeric
            and parking_image_attachment_id is not null;
            v_template_json := jsonb_set(v_template_json,('{message,attachment,payload,attachment_id}')::text[],
                                         ('"'||v_image_attachment_id||'"')::text::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 505 then
        	
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            select facilities_image_attachment_id into v_image_attachment_id
            from sibot.sibot_application_venue_map
            where application_id = v_application_id
            and venue_id = v_venue_id::numeric
            and facilities_image_attachment_id is not null;
            v_template_json := jsonb_set(v_template_json,('{message,attachment,payload,attachment_id}')::text[],
                                         ('"'||v_image_attachment_id||'"')::text::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 506 then
        	
            select message_text into v_message_text
            from sibot.sibot_application_event_widget_message
            where application_id = v_application_id and event_id = v_event_id and widget_id = v_widget_id and is_active = 1;
            select city into v_city_name from sibot.sibot_venue where venue_id = v_venue_id::numeric and city is not null;
            v_message_text := replace(v_message_text,'<city_name>',v_city_name);
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 507 then
        	
            select facilities_text into v_message_text
            from sibot.sibot_application_venue_map
            where application_id = v_application_id
            and venue_id = v_venue_id::numeric
            and facilities_text is not null;
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 508 then
        	
            select v.address into v_message_text
            from sibot.sibot_application_venue_map avm
            join sibot.sibot_venue v
            on v.venue_id = avm.venue_id
            where avm.application_id = v_application_id
            and avm.venue_id = v_venue_id::numeric
            and v.address is not null;
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
            
		when 509 then
        	
            select parking_text into v_message_text
            from sibot.sibot_application_venue_map
            where application_id = v_application_id
            and venue_id = v_venue_id::numeric
            and parking_text is not null;
            v_template_json := jsonb_set(v_template_json,'{recipient,id}',('"'||v_receiver_id||'"')::text::jsonb,true);
            v_template_json := jsonb_set(v_template_json,'{message,text}',('"'||v_message_text||'"')::jsonb,true);
            p_widget_json := ('['||v_template_json::text||']')::jsonb;
			
		else
        	null;
            
    end case;
    
end;

$$;


--
