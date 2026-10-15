-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_nlp_message_json(text, text, jsonb)
-- Type: FUNCTION

-- Name: sibot_get_nlp_message_json(text, text, jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_nlp_message_json(p_application_key text, p_receiver_id text, p_input_json jsonb, OUT p_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

/*
SELECT * from sibot.sibot_get_nlp_message_json(
	'166525327336967',-- <p_application_key text>, 
	'1676861172394185',-- <p_receiver_id text>, 
	'{
  "_text": "india and pakistan",
  "entities": {
    "sports": [
      {
        "metadata": "1",
        "confidence": 1,
        "value": "India",
        "type": "value"
      }
    ]
  },
  "msg_id": "0lyU7Psr9RkapnsfL"
}'-- <p_input_json jsonb>, 
);
*/
declare
	
    v_application_id numeric;
    v_entity_count numeric;
    v_entity_id numeric;
    v_ids text;
    v_league_ids text;
    v_team_ids text;
    v_sport_ids text;
    v_league_filter_query text := ' ';
    v_team_filter_query text := ' ';
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_current_date date := v_current_timestamp::date;
    v_sport_filter_query text := ' ';
    v_league_count numeric;
    v_nlp_event_id numeric;
    v_nlp_event_payload_text text;
    v_event_input_json jsonb;
    v_48_hours_date date := (v_current_timestamp + '48 hours'::interval)::date;
    
begin
	
    select application_id into v_application_id from sibot.sibot_application where application_key = p_application_key;
                
    drop view if exists nlp_input_data_view;
    execute 'create temporary view nlp_input_data_view as
    			select e.entity, e.ids, nlpe.entity_id, aem.entity_priority, aem.event_id,
                		row_number() over(order by aem.entity_priority) slno
    			from (select entity, string_agg(ids,'','') ids
          				from (select entity, (json_array_elements(a->''entities''->entity)->>''metadata'') ids
                				from (select a, json_object_keys(a->''entities'') entity
                      					from (select '''||p_input_json::text||'''::json a)b
                     				)c
               				)d
          				group by entity
         			)e
				join sibot.sibot_nlp_entity nlpe
				on nlpe.entity_name = e.entity
				join sibot.sibot_application_entity_map aem
				on aem.entity_id = nlpe.entity_id
				where aem.application_id = '||v_application_id||'
				order by aem.entity_priority';
    
    select count(1) into v_entity_count from nlp_input_data_view;
    
    for i in 1..v_entity_count
    loop
    	select entity_id, ids into v_entity_id, v_ids from nlp_input_data_view where slno = i;
        if v_entity_id = 1 then
        	v_league_ids := v_ids;
        elsif v_entity_id = 2 then
        	v_team_ids := v_ids;
		elsif v_entity_id = 3 then
        	v_sport_ids := v_ids;
        end if;
    end loop;
    
    if v_league_ids is not null then
    	v_league_filter_query := ' and l.league_id in (select league_id from unnest(string_to_array($1,'','')::numeric[]) u(league_id)) ';
    end if;
    
    if v_team_ids is not null then
    	v_team_filter_query := ' and exists(select 1 from sibot.sibot_match m
        									where m.league_id = l.league_id
                                            and m.match_end_date >= '''||v_current_timestamp||'''
                                            and m.match_end_date::date between '''||v_current_date||''' and '''||v_48_hours_date||'''
                                             and ((team_a_id in (select team_id from unnest(string_to_array($2,'','')::numeric[]) u(team_id)))
                                             		or (team_b_id in (select team_id from unnest(string_to_array($2,'','')::numeric[]) u(team_id))))) ';
    end if;
    
    if v_sport_ids is not null then
    	v_sport_filter_query := ' and l.sport_id in (select sport_id from unnest(string_to_array($3,'','')::numeric[]) u(sport_id)) ';
    end if;
    
    execute 'select string_agg(distinct l.league_id::text,'','')
    			from sibot.sibot_league l
                join sibot.sibot_application_league_map aam
                on aam.league_id = l.league_id
				where aam.application_id = '||v_application_id||'
                and league_end_date >= '''||v_current_timestamp::date||''''
				||v_league_filter_query
                ||v_team_filter_query
                ||v_sport_filter_query
	into v_league_ids
	using v_league_ids,v_team_ids,v_sport_ids;
    
    select coalesce(array_length(string_to_array(v_league_ids,','),1),0) into v_league_count;
    
    if v_league_count = 1 then
    	if v_team_ids is not null then
        	v_nlp_event_id := 511;
        else
        	v_nlp_event_id := 510;
        end if;
    elsif v_league_count > 1 then
    	v_nlp_event_id := 509;
    else
    	v_nlp_event_id := 512;
    end if;
    
    select event_payload into v_nlp_event_payload_text from sibot.sibot_event where event_id = v_nlp_event_id;
    
    v_event_input_json := '{
    						"application_key": "'||p_application_key||'",
                            "receiver_id": "'||p_receiver_id||'",
                            "event_payload": "'||v_nlp_event_payload_text||'",
                            "league_id": '||coalesce('"'||v_league_ids||'"','null')||',
                            "team_id": '||coalesce('"'||v_team_ids||'"','null')||',
                            "sport_id": '||coalesce('"'||v_sport_ids||'"','null')||'
                            }';
    
	select * from sibot.sibot_get_event_json(v_event_input_json) into p_json;
    
    p_result := 1;
    
end;

$_$;


--
