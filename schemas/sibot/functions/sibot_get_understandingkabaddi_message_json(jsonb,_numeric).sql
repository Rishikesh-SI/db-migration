-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_understandingkabaddi_message_json(jsonb, numeric)
-- Type: FUNCTION

-- Name: sibot_get_understandingkabaddi_message_json(jsonb, numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_understandingkabaddi_message_json(p_input_json jsonb, INOUT p_template_id numeric, OUT p_widget_json jsonb) RETURNS record
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
    	
		when 801 then
        	
            select message_text,image_url into v_title,v_image_url
            from sibot.sibot_application_event_widget_message where application_id = v_application_id
            and event_id = 8;
                v_template_json := jsonb_set(v_template_json,'{title}',('"'||coalesce(v_title,'')||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,'{image_url}',('"'||coalesce(v_image_url,'')||'"')::jsonb,true);
                select button_title, button_url into v_button_title,v_url from sibot.sibot_application_event_widget_button_map
                where application_id = v_application_id and event_id = v_event_id and button_template_id = 6;
                select template_id into v_button_template_id from sibot.sibot_widget where widget_id = 6;
                select ('['||template_json::text||']')::jsonb into v_button_template_json from sibot.sibot_template where template_id = v_button_template_id;
                v_button_template_json := jsonb_set(v_button_template_json,'{0,title}',('"'||v_button_title||'"')::jsonb,true);
                v_button_template_json := jsonb_set(v_button_template_json,'{0,url}',('"'||v_url||'"')::jsonb,true);
                v_template_json := jsonb_set(v_template_json,('{buttons}')::text[],v_button_template_json,true);
            		p_widget_json := ('['||v_template_json::text||']')::jsonb;
		
		else
        	null;
            
    end case;
    
end;

$$;


--
