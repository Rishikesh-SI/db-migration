-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_ins_notification_get_topic_filter_policy(jsonb, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gpn_ins_notification_get_topic_filter_policy(jsonb, refcursor, refcursor); Type: FUNCTION; Schema: gpn_v2; Owner: -
--

CREATE FUNCTION gpn_v2.gpn_ins_notification_get_topic_filter_policy(p_notification_json jsonb, p_notification_detail refcursor, p_topic_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
	v_notification_unique_id character varying(50);
     v_notification_image_id character varying(50);
     v_league_code character varying(50);
     v_match_code character varying(50);
     v_team_a_code character varying(50);
     v_team_b_code character varying(50);
     v_trigger_code character varying(50);
     v_event_id numeric;
     v_language_id numeric;
     v_league_id numeric;
     v_match_id numeric;
     v_team_a_id numeric;
     v_team_b_id numeric;
     v_trigger_id numeric;
     v_current_timestamp timestamp := current_timestamp at time zone 'utc';
     v_client_notifications json;
     v_client_notification json;
     v_notification_id numeric;
     v_client_id numeric;
     v_notification_text text;
     v_notification_title character varying(500);
     v_client_subscription_level numeric;
     v_i numeric;
     v_thumbnail text;
     v_deep_link_info text;
     v_asset_type text;
	v_option numeric;
     
begin
	
     drop table if exists v_topic_filter_policy_temp;
     
     create temp table v_topic_filter_policy_temp
     (
         topic_id numeric,
         filter_policy text
     );
     
     select p_notification_json->>'NotificationID'
     into v_notification_unique_id;
     
     if not exists(select 1 from gpn_v2.gpn_notification where notification_unique_id = v_notification_unique_id) then
          
          select (p_notification_json->'NotificationText')::json, p_notification_json->>'Object_ImageID',
          		p_notification_json->>'LeagueID', p_notification_json->>'MatchID', p_notification_json->>'TriggerID',
                    p_notification_json->>'EventID', p_notification_json->>'LanguageID'
          into v_client_notifications, v_notification_image_id, v_league_code, v_match_code, v_trigger_code, v_event_id, v_language_id;
          
          if v_match_code is not null or v_match_code <> '' then
          	select m.league_id, m.match_id, m.team_a_id, m.team_b_id
               into v_league_id, v_match_id, v_team_a_id, v_team_a_id
          	from gpn_v2.gpn_match m
          	join gpn_v2.gpn_league l
          	on l.league_id = m.league_id
          	where m.source_object_id = v_match_code
               and l.source_object_id = v_league_code;
		else
          	select p_notification_json->>'OperationType' into v_option;
          	if v_option = 2 then
               	select p_notification_json->'NotificationText'->0->>'clientId' into v_client_id;
                    select m.match_id into v_match_id
                    from gpn_v2.gpn_match m
                    join gpn_v2.gpn_league l
                    on l.league_id = m.league_id
                    join gpn_v2.gpn_client_league_map clm
                    on clm.league_id = l.league_id
                    where clm.client_id = v_client_id
                    and l.is_editorial = 1;
                    select league_id into v_league_id
                    from gpn_v2.gpn_league
                    where source_object_id = v_league_code;
               end if;
          end if;
          
          if v_trigger_code is not null or v_trigger_code <> '' then
          	select t.team_id into v_trigger_id
          	from gpn_v2.gpn_team t
          	where t.source_object_id = v_trigger_code;
          end if;
          
          v_notification_id := nextval('gpn_v2.seq_gpn_notification_id');
          
          insert into gpn_v2.gpn_notification(notification_id, notification_unique_id, notification_title, notification_text,
                                              notification_image_id, notification_json, league_id, match_id, team_a_id, team_b_id,
                                              trigger_id, event_id, language_id, status, created_date, updated_date)
		select v_notification_id, v_notification_unique_id, null, null, v_notification_image_id, p_notification_json, v_league_id,
          		v_match_id, v_team_a_id, v_team_b_id, v_trigger_id, v_event_id, v_language_id, 0, v_current_timestamp,
                    v_current_timestamp;
		
          for v_client_notification in select * from json_array_elements(v_client_notifications)
          loop
          	
               select v_client_notification->>'clientId', v_client_notification->>'payloadData', v_client_notification->>'title'
               into v_client_id, v_notification_text, v_notification_title;
               
               if v_client_id = 0 then
               	update gpn_v2.gpn_notification
                    set notification_title = v_notification_title, notification_text = v_notification_text
				where notification_id = v_notification_id;
               end if;
               
               insert into gpn_v2.gpn_client_notification_map(client_notification_map_id, client_id, notification_id,
                                                              notification_title, notification_text, created_date)
			select nextval('gpn_v2.seq_gpn_client_notification_map_id'), v_client_id, v_notification_id, v_notification_title,
               		v_notification_text, v_current_timestamp;
			
               if v_client_id <> 0 then
               	
               	select notification_setting->>'subscription_level' into v_client_subscription_level
               	from gpn_v2.gpn_client where client_id = v_client_id;
	               
               	if v_client_subscription_level = 2 then
               		
                    	insert into v_topic_filter_policy_temp
                    	select topic_id, 'A'||application_id||'L'||league_id||'M'||match_id||'T'||team_id||'E'||event_id||'S'||
                         		subscription_id||'Lan'||language_id||'C'||country_id as filter_policy
					from (select t.topic_id, cam.application_id, n.league_id, n.match_id, 0 as team_id, n.event_id,
                               		2 as subscription_id, n.language_id, ccm.country_id
                               from gpn_v2.gpn_notification n
                               join gpn_v2.gpn_client_notification_map cnm
                               on cnm.notification_id = n.notification_id
                               join gpn_v2.gpn_client_application_map cam
                               on cam.client_id = cnm.client_id
                               join gpn_v2.gpn_client_country_map ccm
                               on ccm.client_id = cnm.client_id
                               join gpn_v2.gpn_topic t
                               on t.application_id = cam.application_id
                               where n.notification_id = v_notification_id
                              ) as tab;
					
				elsif v_client_subscription_level = 3 then
               		
                         insert into v_topic_filter_policy_temp
                         select topic_id, 'A'||application_id||'L'||league_id||'M'||match_id||'T'||team_id||'E'||event_id||'S'||
                         		subscription_id||'Lan'||language_id||'C'||country_id as filter_policy
					from (select t.topic_id, cam.application_id, tab1.league_id, tab1.match_id, tab1.team_id, tab1.event_id,
                               		3 as subscription_id, tab1.language_id, ccm.country_id
                               from (select n.league_id, 0 as match_id, n.team_a_id as team_id, n.event_id, n.language_id
                                     from gpn_v2.gpn_notification n
                                     where n.notification_id = v_notification_id
                                     union
                                     select n.league_id, 0 as match_id, n.team_b_id as team_id, n.event_id, n.language_id
                                     from gpn_v2.gpn_notification n
                                     where n.notification_id = v_notification_id
                                    )as tab1
                               join gpn_v2.gpn_client_notification_map cnm
                               on cnm.notification_id = tab1.notification_id
                               join gpn_v2.gpn_client_application_map cam
                               on cam.client_id = cnm.client_id
                               join gpn_v2.gpn_client_country_map ccm
                               on ccm.client_id = cnm.client_id
                               join gpn_v2.gpn_topic t
                               on t.application_id = cam.application_id
                         ) as tab;
                         
               	end if;
                    
               end if;
               
          end loop;
          
     end if;
     
     select p_notification_json->>'Thumbnail', p_notification_json->>'DeepLinkInfo', p_notification_json->>'AssetType'
     into v_thumbnail, v_deep_link_info, v_asset_type;
     
     if v_thumbnail = '' or v_thumbnail is null then
     	v_thumbnail := 'na';
     end if;
     
     if v_notification_image_id = '' or v_notification_image_id is null then
     	v_notification_image_id := 'na';
     end if;
     
     open p_notification_detail for
	select n.notification_id, cnm.client_id,
     		case cnm.client_id when '0' then n.notification_text else cnm.notification_text end notification_text,
			case when v_thumbnail <> 'na' then v_thumbnail
               	else case cem.is_image_available when 1 then c.image_json->>'event_image_path'||'/'||n.event_id||'.png'
                    							else v_thumbnail
					end
			end event_image, n.event_id, v_deep_link_info as deep_link_info, v_asset_type as asset_type,
			case cnm.client_id when 0 then n.notification_title else cnm.notification_title end notification_title,
               case when v_notification_image_id <> 'na' then c.image_json->>'event_image_path'||'/'||n.notification_image_id||'.png'
               end object_image, cem.sound_clip
    	from gpn_v2.gpn_notification n
    	join gpn_v2.gpn_client_notification_map cnm
    	on cnm.notification_id = n.notification_id
    	join gpn_v2.gpn_client_event_map cem
    	on cem.client_id = cnm.client_id
     and cem.event_id = n.event_id
    	join gpn_v2.gpn_client c
    	on cnm.client_id = c.client_id
    	where n.notification_id = v_notification_id
    	and status = 0;
    	
     open p_topic_detail for
    	select n.notification_id, cnm.client_id, t.topic_name, t.topic_arn, tab.filter_policy, a.environment as application_stage,
     		case a.platform when 'Android' then 1 when 'iOS' then 2 else null end as platform_id
    	from gpn_v2.gpn_notification n
    	join gpn_v2.gpn_client_notification_map cnm
    	on cnm.notification_id = n.notification_id
    	join gpn_v2.gpn_client_application_map cam
    	on cam.client_id = cnm.client_id
    	join gpn_v2.gpn_topic t
    	on t.application_id = cam.application_id
    	join (select * from v_topic_filter_policy_temp) tab
    	on tab.topic_id = t.topic_id
     join gpn_v2.gpn_application a
     on a.application_id = t.application_id
    	where n.notification_id = v_notification_id
    	and status = 0;
    
end;

$$;


--
