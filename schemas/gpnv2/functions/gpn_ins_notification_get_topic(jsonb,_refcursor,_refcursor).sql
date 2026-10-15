-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_ins_notification_get_topic(jsonb, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gpn_ins_notification_get_topic(jsonb, refcursor, refcursor); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_ins_notification_get_topic(p_notification_json jsonb, p_notification_detail refcursor, p_topic_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_notification_unique_id character varying(50);
	v_thumbnail text;
     v_deep_link_info text;
     v_asset_type text;
	v_country_ids text;
	v_country_id_arr numeric[];
	v_country_filter_query text := ' ';
	v_client_notifications json;
	v_notification_image_id character varying(50);
	v_league_code character varying(50);
     v_match_code text;
     v_trigger_code character varying(50);
     v_event_id numeric;
     v_language_id numeric;
	v_league_id numeric;
	v_sport_id numeric;
     v_match_id numeric;
     v_team_a_id numeric;
     v_team_b_id numeric;
	v_trigger_id numeric;
	v_notification_id numeric;
	v_client_notification json;
	v_client_id numeric;
     v_notification_text text;
     v_notification_title character varying(500);
	v_topic_query text;
	v_operation_type numeric;
     
begin
	
     select p_notification_json->>'NotificationID', p_notification_json->>'Thumbnail',
			p_notification_json->>'DeepLinkInfo', p_notification_json->>'AssetType',
			p_notification_json->>'TopicGroupIDS', p_notification_json->>'OperationType'
     into v_notification_unique_id, v_thumbnail, v_deep_link_info, v_asset_type, v_country_ids, v_operation_type;
	
	if v_country_ids is not null and v_country_ids <> '' and v_country_ids <> '1' then
		select string_to_array(v_country_ids,',')::numeric[] into v_country_id_arr;
		v_country_filter_query := ' and t.country_id in(select country_id::numeric from unnest($1) u(country_id)) ';
	end if;
	--raise notice '%',v_country_filter_query;
	---select 1/0;
	
     if v_thumbnail = '' or v_thumbnail is null then
     	v_thumbnail := 'na';
     end if;
     
     if not exists(select 1 from gpnv2.gpn_notification where notification_unique_id = v_notification_unique_id) then
          
          select (p_notification_json->'NotificationText')::json, p_notification_json->>'Object_ImageID',
				p_notification_json->>'LeagueID', p_notification_json->>'DeepLinkInfo', p_notification_json->>'TriggerID',
                    p_notification_json->>'EventID', p_notification_json->>'LanguageID'
          into v_client_notifications, v_notification_image_id, v_league_code, v_match_code, v_trigger_code, v_event_id,
			v_language_id;
          
		if v_notification_image_id = '' or v_notification_image_id is null then
     		v_notification_image_id := 'na';
     	end if;
		
		if v_league_code is not null and v_league_code <> '' then
			begin
				select league_id, sport_id
				into strict v_league_id, v_sport_id
				from gpnv2.gpn_league
				where source_object_id = v_league_code;
			exception
				when no_data_found then
					v_league_id := 0;
			end;
		else
			v_league_id := 0;
		end if;
		
		if v_match_code is not null and v_match_code <> '' then
			begin
				select m.match_id, m.team_a_id, m.team_b_id
               	into strict v_match_id, v_team_a_id, v_team_b_id
          		from gpnv2.gpn_match m
          		where m.source_object_id = v_match_code
               	and m.league_id = v_league_id;
			exception
				when no_data_found then
					v_match_id := 0;
					v_team_a_id := 0;
					v_team_b_id := 0;
			end;
		else
			v_match_id := 0;
			v_team_a_id := 0;
			v_team_b_id := 0;
		end if;
		
		if v_trigger_code is not null or v_trigger_code <> '' then
			begin
          		select t.team_id
				into strict v_trigger_id
          		from gpnv2.gpn_team t
          		where t.source_object_id = v_trigger_code
				and sport_id = v_sport_id;
			exception
				when no_data_found then
					v_trigger_id := 0;
			end;
		else
			v_trigger_id := 0;
          end if;
          
          insert into gpnv2.gpn_notification(notification_id, notification_unique_id, notification_image_id,
									notification_json, league_id, match_id, team_a_id, team_b_id, trigger_id,
									event_id, language_id)
		select nextval('gpnv2.seq_gpn_notification_id'), v_notification_unique_id, v_notification_image_id,
				p_notification_json, v_league_id, v_match_id, v_team_a_id, v_team_b_id, v_trigger_id, v_event_id,
				v_language_id
		returning notification_id
		into v_notification_id;
		
          for v_client_notification in select * from json_array_elements(v_client_notifications)
          loop
          	
               select v_client_notification->>'clientId', v_client_notification->>'payloadData', v_client_notification->>'title'
               into v_client_id, v_notification_text, v_notification_title;
               
               if v_client_id = 0 then
               	
				update gpnv2.gpn_notification
                    set notification_title = v_notification_title,
					notification_text = v_notification_text
				where notification_id = v_notification_id;
				
			else
				
				insert into gpnv2.gpn_client_notification_map(client_notification_map_id, client_id,
													 notification_id, notification_title,
													 notification_text,operation_type)
				select nextval('gpnv2.seq_gpn_client_notification_map_id'), v_client_id, v_notification_id,
						v_notification_title, v_notification_text,v_operation_type;
				
               end if;
               
          end loop;
          
     end if;
	 
	 raise notice '%',v_notification_title;
     
     open p_notification_detail for
	select n.notification_id, clm.client_id,
			coalesce(cnm.notification_title, n.notification_title) as notification_title,
			coalesce(cnm.notification_text, n.notification_text) as notification_text, n.event_id,
			cesm.sound_clip, v_deep_link_info as deep_link_info, v_asset_type as asset_type,
			case
				when v_thumbnail <> 'na' then v_thumbnail
               	else case cesm.is_image_available
						when 1 then c.client_configuration->>'event_image_path'||'/'||n.event_id||'.png'
						else v_thumbnail
					end
			end event_image,
			case
				when v_notification_image_id <> 'na' then c.client_configuration->>'event_image_path'||'/'||n.notification_image_id||'.png'
               end object_image, v_sport_id sport_id, v_league_code league_code
	from gpnv2.gpn_notification n
	join gpnv2.gpn_client_notification_map cnm
	on cnm.notification_id = n.notification_id
	join gpnv2.gpn_client_league_map clm
	on clm.league_id = n.league_id
	and clm.client_id = cnm.client_id
	join gpnv2.gpn_client_language_map clangm
	on clangm.language_id = n.language_id
	and clangm.client_id = cnm.client_id
	join gpnv2.gpn_client_event_subscription_map cesm
	on cesm.child_event_id = n.event_id
	and cesm.client_id = cnm.client_id
	join gpnv2.gpn_client c
	on c.client_id = cnm.client_id
	where n.notification_id = v_notification_id
	and n.status = 0;
	
/*	v_topic_query := 'select $2 notification_id, client_id, t.topic_name, t.topic_arn, t.application_id,
						t.language_id, 1 platform_id, ''Beta'' application_stage, 1 is_browser
						from gpnv2.gpn_client_browser_topic cbt
						join gpnv2.gpn_topic t
						on t.topic_id = cbt.topic_id
						where cbt.client_id = $3
						and $4 = 2
						union
						select n.notification_id, clm.client_id, t.topic_name, t.topic_arn, t.application_id,
						t.language_id, a.platform_id, e.environment_name as application_stage, 0 is_browser
					from gpnv2.gpn_notification n
					join gpnv2.gpn_client_notification_map cnm
					on cnm.notification_id = n.notification_id
					join gpnv2.gpn_client_league_map clm
					on clm.league_id = n.league_id
					and clm.client_id = cnm.client_id
					join gpnv2.gpn_client_language_map clangm
					on clangm.language_id = n.language_id
					and clangm.client_id = cnm.client_id
					join gpnv2.gpn_client_event_subscription_map cesm
					on cesm.child_event_id = n.event_id
					and cesm.client_id = cnm.client_id
					join gpnv2.gpn_application a
					on a.client_id = cnm.client_id
					join gpnv2.gpn_environment e
					on e.environment_id = a.environment_id
					join gpnv2.gpn_topic t
					on t.application_id = a.application_id
					and t.league_id = n.league_id
					and case cesm.subscription_id
						when 1 then t.league_id = n.league_id
						when 2 then t.match_id = n.match_id
						/*when 3 then t.team_id = (select team_id from gpnv2.gpn_team
											where source_object_id = n.trigger_id::text
											and sport_id = '||v_sport_id||')*/
						when 3 then t.team_id = n.trigger_id
						when 4 then t.match_id = n.match_id
					    end
					and t.event_id = cesm.event_id
					and t.language_id = n.language_id'
					||v_country_filter_query||'
					where n.notification_id = $2
					and n.status = 0';
	*/
	
	
	
	
	
		v_topic_query := '
						with cte as(select n.notification_id, clm.client_id,a.application_id,n.league_id,
			n.match_id,cesm.event_id,n.trigger_id,e.environment_name ,a.platform_id,
			n.language_id
		   from gpnv2.gpn_notification n
					join gpnv2.gpn_client_notification_map cnm
					on cnm.notification_id = n.notification_id
					join gpnv2.gpn_client_league_map clm
					on clm.league_id = n.league_id
					and clm.client_id = cnm.client_id
					join gpnv2.gpn_client_language_map clangm
					on clangm.language_id = n.language_id
					and clangm.client_id = cnm.client_id
					join gpnv2.gpn_client_event_subscription_map cesm
					on cesm.child_event_id = n.event_id
					and cesm.client_id = cnm.client_id
					join gpnv2.gpn_application a
					on a.client_id = cnm.client_id
					join gpnv2.gpn_environment e
					on e.environment_id = a.environment_id
					
		   where n.notification_id = $2
		   and n.status=0
		    )
 select s.notification_id, s.client_id, t.topic_name, t.topic_arn, t.application_id,
						t.language_id, s.platform_id,
					s.environment_name as application_stage, 0 is_browser
					from cte s
					join gpnv2.gpn_topic t
					on t.application_id = s.application_id
					and t.league_id = s.league_id
					and case t.subscription_id
						when 1 then t.league_id = s.league_id
						when 2 then t.match_id = s.match_id
						 
						when 3 then t.team_id = s.trigger_id
						when 4 then t.match_id = s.match_id
					    end
					 and t.event_id = s.event_id
					and t.language_id = s.language_id
					--and t.topic_id not in (
				---	select topic_id from gpnv2.gpn_client_browser_topic)
					'||v_country_filter_query||'
					union
					 select $2 notification_id, client_id, t.topic_name, t.topic_arn, t.application_id,
						t.language_id, 1 platform_id, ''Beta'' application_stage, 1 is_browser
						from gpnv2.gpn_client_browser_topic cbt
						join gpnv2.gpn_topic t
						on t.topic_id = cbt.topic_id
						where cbt.client_id = $3
						and $4 = 2
						'||v_country_filter_query||'
						';
						
		---raise notice '%,%,%',	v_topic_query,v_country_id_arr,v_notification_id;
		---select 1/0;
     open p_topic_detail for
	execute v_topic_query using v_country_id_arr, v_notification_id, v_client_id, v_operation_type;
    
end;
$_$;


--
