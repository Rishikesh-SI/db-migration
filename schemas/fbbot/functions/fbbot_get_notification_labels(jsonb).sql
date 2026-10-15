-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_get_notification_labels(jsonb)
-- Type: FUNCTION

-- Name: fbbot_get_notification_labels(jsonb); Type: FUNCTION; Schema: fbbot; Owner: -
--

CREATE FUNCTION fbbot.fbbot_get_notification_labels(p_input_json jsonb, OUT p_response_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_team_ids text;
	v_title text;
	v_image_url text;
	v_event_payload_text text;
	v_event_id numeric;
	v_teams_arr numeric[];
	v_response_json jsonb;
	v_list_arr text;
	
begin
	
	select p_input_json->>'team_id',
		p_input_json->>'title',
		p_input_json->>'image_url',
		p_input_json->>'event_payload_text'
	into v_team_ids,
		v_title,
		v_image_url,
		v_event_payload_text;
	
	select event_id into v_event_id from fbbot.fbbot_events where payload_text = v_event_payload_text;
	
	select regexp_split_to_array(v_team_ids,',')::int[] into v_teams_arr;
	select json_template into v_response_json from fbbot.fbbot_events where event_id = v_event_id;
	
	v_response_json := jsonb_set(v_response_json,'{chatbottmt,0,message,attachment,payload,elements,0,title}',('"'||v_title||'"')::jsonb,true);
	v_response_json := jsonb_set(v_response_json,'{chatbottmt,0,message,attachment,payload,elements,0,image_url}',('"'||v_image_url||'"')::jsonb,true);
	
	select '['||string_agg(u.receiver_id::text,',')||']'
	from fbbot.fbbot_league_team_map ltm
	join fbbot.fbbot_list_team_map litm
	on litm.team_id = ltm.team_id
	join fbbot.fbbot_user_team_map utm
	on utm.team_id = litm.team_id
	join fbbot.fbbot_users u
	on u.user_id = utm.user_id
	where (litm.team_id in(select unnest(v_teams_arr))
			or ltm.is_team_common = 1)
	into v_list_arr;
	
	v_response_json := jsonb_set(v_response_json,'{receiverids}',v_list_arr::jsonb,true);
	
	p_response_json := v_response_json;
	
	p_result := 1;
	
end;

$$;


--
