-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_nlp_intent_message_json_test(text, text, jsonb)
-- Type: FUNCTION

-- Name: sibot_get_nlp_intent_message_json_test(text, text, jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_nlp_intent_message_json_test(p_application_key text, p_receiver_id text, p_input_json jsonb, OUT p_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*
SELECT * from sibot.sibot_get_nlp_intent_message_json(
	'166525327336967',-- <p_application_key text>, 
	'1676861172394185',-- <p_receiver_id text>, 
	'{
  "_text": "Where is the Location of the match <Player X>",
  "entities": {
    "intent": [
      {
        "confidence": 0.98710224459216,
        "value": "FacilitiesVenue"
      }
    ],
    "players": [
      {
        "confidence": 0.94351301727103,
        "value": "<Player X>",
        "type": "value"
      }
    ]
  },
  "msg_id": "1oMbVRQpxFEJuh2q3"
}'-- <p_input_json jsonb>, 
);
*/
declare
	
    v_application_id numeric;
    v_intent_name text;
    rec1 record;
    v_intent_id numeric;
    v_entity_name text;
    v_nlp_event_id numeric;
    v_keywords text;
    v_allkeywords text;
    v_keywords_arr text[];
    v_ids_arr numeric[];
    v_ids text;
    v_player_ids text;
    v_nlp_event_payload_text text;
    v_event_input_json jsonb;
    v_league_ids text;
    v_team_ids text;
    v_sport_ids text;
    v_venue_ids text;
    v_country_ids text;
    v_i numeric;
begin
    
    select application_id into v_application_id from sibot.sibot_application where application_key = p_application_key;
    select a->'entities'->'intent'->0->>'value' into v_intent_name from (select p_input_json::json a)b;
    
    for rec1 in select nlpi.intent_id, nlpi.entity_name, nlpi.event_id, e.event_payload
    			from sibot.sibot_nlp_intent nlpi
    			join sibot.sibot_event e
    			on e.event_id = nlpi.event_id
                where nlpi.intent_name = v_intent_name
                and nlpi.entity_name is not null
	loop
        select rec1.intent_id, rec1.entity_name, rec1.event_id, rec1.event_payload
    	into v_intent_id, v_entity_name, v_nlp_event_id, v_nlp_event_payload_text;
        if v_entity_name is not null then
        	select string_to_array(string_agg(keyword,','),',') into v_keywords_arr
        	from (select lower(json_array_elements(a->'entities'->v_entity_name)->>'value') keyword
                  from (select p_input_json::json a)b)c;
			if v_keywords_arr is not null then
            	exit;
			end if;
        end if;
    end loop;
    
    if v_keywords_arr is null then
    	select event_id into v_nlp_event_id from sibot.sibot_nlp_intent where intent_name = v_intent_name and entity_name is null;
	else
    	select string_to_array(string_agg(ids,','),',')::numeric[] into v_ids_arr
    	from sibot.sibot_nlp_assets
    	where lower(synonyms) in(select keywords from unnest(v_keywords_arr) u(keywords));
        
        if v_ids_arr is null then
    		select event_id into v_nlp_event_id from sibot.sibot_nlp_intent where intent_name = v_intent_name and entity_name is null;
		else
    		if v_intent_id in (1,2) then
        		select string_agg(player_id::text,',') into v_player_ids
                from sibot.sibot_application_league_team_player_map
                where player_id in(select ids from unnest(v_ids_arr) u(ids)) and application_id = v_application_id;
                v_ids := v_player_ids;
			elsif v_intent_id in (3,12,13,14,15,38,40) then
                select string_agg(team_id::text,',') into v_team_ids
                from sibot.sibot_application_league_team_map
                where team_id in(select ids from unnest(v_ids_arr) u(ids)) and application_id = v_application_id;
                v_ids := v_team_ids;
			elsif v_intent_id in (4,17) then
            	v_country_ids := array_to_string(v_ids_arr,',');
                v_ids := v_country_ids;
			elsif v_intent_id in(6,7,8,9,18,19,20,21) then
            	select string_agg(venue_id::text,',') into v_venue_ids
                from sibot.sibot_application_venue_map
                where venue_id in(select ids from unnest(v_ids_arr) u(ids)) and application_id = v_application_id;
                v_ids := v_venue_ids;
			end if;
		end if;
    end if;
    
    if v_ids is null then
    	select event_id into v_nlp_event_id from sibot.sibot_nlp_intent where intent_name = v_intent_name and entity_name is null;
    end if;
    
    select event_payload into v_nlp_event_payload_text from sibot.sibot_event where event_id = v_nlp_event_id;
    
    v_event_input_json := '{
    						"application_key": "'||p_application_key||'",
                            "receiver_id": "'||p_receiver_id||'",
                            "event_payload": "'||v_nlp_event_payload_text||'",
                            "league_id": '||coalesce('"'||v_league_ids||'"','null')||',
                            "team_id": '||coalesce('"'||v_team_ids||'"','null')||',
                            "sport_id": '||coalesce('"'||v_sport_ids||'"','null')||',
                            "venue_id": '||coalesce('"'||v_venue_ids||'"','null')||',
                            "player_id": '||coalesce('"'||v_player_ids||'"','null')||',
                            "country_id": '||coalesce('"'||v_country_ids||'"','null')||'
                            }';
	
    select * from sibot.sibot_get_event_json(v_event_input_json) into p_json, p_result;
    
    if p_json is null then
    	v_nlp_event_payload_text := 'GetHelp';
		v_event_input_json := '{
        						"application_key": "'||p_application_key||'",
                                "receiver_id": "'||p_receiver_id||'",
                            	"event_payload": "'||v_nlp_event_payload_text||'"
                                }';
		select * from sibot.sibot_get_event_json(v_event_input_json) into p_json, p_result;
    end if;
    
end;

$$;


--
