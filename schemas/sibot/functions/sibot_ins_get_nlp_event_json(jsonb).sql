-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins__get_nlp_event_json(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins__get_nlp_event_json(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins__get_nlp_event_json(p_input_json jsonb, OUT p_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from sibot.sibot_ins__get_nlp_event_json(
	'{
  "application_key": "279110732761400",
  "receiver_id": "2061427977268954",
  "first_name": "Shaan",
  "last_name": "Khan",
  "gender": null,
  "profile_pic": "https://platform-lookaside.fbsbx.com/platform/profilepic/?psid=2061427977268954&width=1024&ext=1555144216&hash=AeQxpjRpRTuoTWp0\nhttps://platform-lookaside.fbsbx.com/platform/profilepic/?psid=2061427977268954&width=1024&ext=1555144216&hash=AeQxpjRpRTuoTWp0\n",
  "timezone": "0",
  "event_payload": "GetUploadAVideo",
  "sport_id": null,
  "league_id": null,
  "match_id": null,
  "team_id": null,
  "quiz_id": null,
  "question_id": null,
  "option_id": null,
  "notification_text": null,
  "notification_image_url": null,
  "venue_id": null,
  "bs_category": null,
  "bs_category_id": null,
  "bs_change_option": null,
  "bs_change_value": null,
  "bs_mobile_number": null,
  "bs_email_id": null,
  "opt_type": "G",
  "video_id": null,
  "image_id": null,
  "video_url": "https://video.xx.fbcdn.net/v/t42.3356-2/55383436_2151177398304363_2325426215064529756_n.mp4/video-1552552213.mp4?_nc_cat=102&vabr=208780&_nc_ht=video.xx&oh=5bbc315890ce8b0f00a34859a969e508&oe=5C8BAE3D",
  "status": "1",
  "type": "V"
}'::jsonb-- <p_input_json jsonb>
);
*/

declare
	v_opt_type character(2);
	v_application_key text;
    v_application_id numeric;
    v_user_id numeric;
    v_receiver_id text;
    v_video_id text;
    v_video_url text;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_type character(2);
    v_status numeric;
    v_event_payload text;
    v_event_count numeric;
    v_widget_id numeric;
     v_template_id numeric;
     v_is_widget_generic numeric;
     v_json jsonb := '{"data":[]}'::jsonb;
     v_image_id text;
     v_event_id numeric;
     v_check_event_change numeric;
     v_image_attachment_id text;
     v_module_id numeric;
     v_parent_template_id numeric;
     v_template_json jsonb;
     v_message_count numeric;
     v_message_text text;
      v_recurring_message_arr text[];
    	v_recurring_json_text text;
begin
	select p_input_json->>'opt_type', p_input_json->>'application_key', p_input_json->>'receiver_id',
           p_input_json->>'video_id',p_input_json->>'image_id',p_input_json->>'video_url',p_input_json->>'type',
           p_input_json->>'status', p_input_json->>'event_payload'
    	into v_opt_type,v_application_key, v_receiver_id, v_video_id,v_image_id,v_video_url,v_type,v_status,v_event_payload;
    	
    	select application_id into strict v_application_id from sibot.sibot_application 
        where application_key = v_application_key;
        begin
        
        select user_id into strict v_user_id from sibot.sibot_user where receiver_id = v_receiver_id 
                                                                     and application_id= v_application_id;
       
        exception
     	when no_data_found then
        		v_user_id := nextval('sibot.seq_sibot_user_id');
            	insert into sibot.sibot_user(user_id,receiver_id,application_id,created_date)
            	select v_user_id,v_receiver_id,v_application_id,v_current_timestamp;
      
      end;
      
      
      select event_id, check_event_change into strict v_event_id, v_check_event_change from 
      sibot.sibot_event where event_payload = v_event_payload;
	if v_opt_type = 'I' then
        insert into sibot.sibot_nlp_user(nlp_user_id,type,user_id,application_id,image_id,video_id,video_url,
                                             created_date,status)
        select nextval('sibot.seq_sibot_nlp_user_id'),v_type,v_user_id,v_application_id,
               v_image_id,v_video_id,v_video_url,v_current_timestamp,v_status;
                
                
     
    
        
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
          	
            	select event_id, widget_id, image_attachment_id into 
                v_event_id, v_widget_id, v_image_attachment_id from event_view where slno = i;
            	
               select template_id, module_id, parent_template_id, case coalesce(module_id,0) when 0 then 1 else 0 end is_widget_generic
			into v_template_id, v_module_id, v_parent_template_id, v_is_widget_generic
               from sibot.sibot_widget where widget_id = v_widget_id;     
               
               
         if v_template_id = 1 
         then
             
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
        end loop;
      end if;
        
   elseif v_opt_type = 'G' then
   p_result =  0;
   end if;
   if p_result = 1 then
    		p_json := v_json;
	elsif p_result = 0 then
		
    	select ('{"nlp_users":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		from (select user_id,type,video_url
              from sibot.sibot_nlp_user order by created_date 
             )row
		into p_json;
    else
    	p_json := '{}'::jsonb;
    end if;
                   
                   
exception
	when others then
    	p_result := -1;
        p_json := '{}'::jsonb;
end;

$$;


--
