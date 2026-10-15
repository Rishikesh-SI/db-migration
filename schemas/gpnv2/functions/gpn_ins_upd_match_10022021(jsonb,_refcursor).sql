-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_ins_upd_match_10022021(jsonb, refcursor)
-- Type: FUNCTION

-- Name: gpn_ins_upd_match_10022021(jsonb, refcursor); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_ins_upd_match_10022021(p_input_json jsonb, p_topic_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
	
	v_league_code text;
	v_team_a_code text;
	v_team_b_code text;
	v_match_name text;
	v_match_start_date timestamp;
	v_match_end_date timestamp;
	v_gmt_offset text;
	v_match_venue text;
	v_match_code text;
	v_sport_id numeric;
	v_match_status character varying(1);
	v_league_id numeric;
	v_team_a_id numeric;
	v_team_b_id numeric;
	v_match_id numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_is_new_match numeric := 0;
	v_application_id_arr numeric[];
	v_application_id numeric;
	v_match_level_events_count numeric;
	v_app_version character varying(5);
	v_topic_id_arr numeric[];
	v_topic_id numeric;
	v_current_timestamp_ist timestamp := v_current_timestamp + '5.5 hours'::interval;
	v_create_topics numeric := 0;
	v_series_id numeric;
	
begin
	
	SET enable_seqscan = OFF;
	
	select p_input_json->>'league_id', p_input_json->>'teama_id', p_input_json->>'teamb_id', p_input_json->>'matchname',
			p_input_json->>'matchstartdate', p_input_json->>'matchenddate', p_input_json->>'gmtoffset', p_input_json->>'matchvenue',
			p_input_json->>'match_id', p_input_json->>'sport_id', p_input_json->>'matchstatus'
	into v_league_code, v_team_a_code, v_team_b_code, v_match_name, v_match_start_date, v_match_end_date, v_gmt_offset, v_match_venue,
			v_match_code, v_sport_id, v_match_status;
	
	select league_id
	into strict v_league_id
	from gpnv2.gpn_league
	where source_object_id = v_league_code;
	
	select t.team_id
	into strict v_team_a_id
	from gpnv2.gpn_team t
	where t.source_object_id = v_team_a_code
	and sport_id = v_sport_id;
	
	select t.team_id
	into strict v_team_b_id
	from gpnv2.gpn_team t
	where t.source_object_id = v_team_b_code
	and sport_id = v_sport_id;
	
	select match_id
	into v_match_id
	from gpnv2.gpn_match
	where league_id = v_league_id
	and (team_a_id = v_team_a_id or team_a_id = v_team_b_id)
	and (team_b_id = v_team_b_id or team_b_id = v_team_a_id)
	and team_a_id <> team_b_id;

	select series_id
	from gpnv2.gpn_series_match_map
	where source_object_id=v_match_code
	into v_series_id;
	
	if v_match_id is null then
		
		insert into gpnv2.gpn_match(match_id, match_name, match_start_date, match_end_date, gmt_offset, match_venue, league_id, team_a_id,
									team_b_id, source_object_id, match_status)
		select nextval('gpnv2.seq_gpn_match_id'), v_match_name, v_match_start_date, v_match_end_date, v_gmt_offset, v_match_venue, v_league_id,
				v_team_a_id, v_team_b_id, v_match_code, v_match_status
		returning match_id into v_match_id;
		
		v_is_new_match := 1;

		
	else
		raise notice '%,%',v_current_timestamp_ist,v_match_id;
		if exists(select 1 from gpnv2.gpn_match where match_id = v_match_id and match_end_date < v_current_timestamp_ist) then
			
			update gpnv2.gpn_match
			set match_name = v_match_name,
				match_start_date = v_match_start_date,
				match_end_date = v_match_end_date,
            	gmt_offset = v_gmt_offset,
				match_venue = v_match_venue,
				source_object_id = v_match_code,
				team_a_id = v_team_a_id,
				team_b_id = v_team_b_id,
				updated_date = v_current_timestamp
				
			where match_id = v_match_id;
			
		end if;
		
	end if;
	
	if exists(select 1
			  from gpnv2.gpn_client_league_map clm
			  join gpnv2.gpn_client_event_subscription_map cesm
			  on cesm.client_id = clm.client_id
			  where clm.league_id = v_league_id
			  and cesm.subscription_id in(2,4)) then
		v_create_topics := 1;
	end if;
	
	if v_is_new_match = 1 or v_create_topics = 1 then
		
		select array(select distinct a.application_id
					 from gpnv2.gpn_client_league_map clm
					 join gpnv2.gpn_application a
					 on a.client_id = clm.client_id
					 join gpnv2.gpn_client_event_subscription_map cesm
					 on cesm.client_id = clm.client_id
					 where clm.league_id = v_league_id
					 and cesm.subscription_id in(2,4)
					 and a.environment_id = 2)
		into v_application_id_arr;
		
		for v_application_id in (select application_id from unnest(v_application_id_arr) u(application_id))
		loop
			
			v_match_level_events_count := 0;

			
			insert into gpnv2.gpn_topic(topic_id, topic_name, application_id, league_id, match_id, team_id, event_id, subscription_id,
										language_id, country_id, for_admin_notification, status)
			select nextval('gpnv2.seq_gpn_topic_id'), 'TOPIC-'||application_id||'-'||league_id||'-'||match_id||'-0-'||event_id||'-'||
					subscription_id||'-'||language_id||'-1-beta', application_id, league_id, match_id, 0, event_id, subscription_id, language_id, 1,
					0, 0
			from (select distinct a.application_id, m.league_id, m.match_id, cesm.event_id, cesm.subscription_id, clangm.language_id
				  from gpnv2.gpn_match m
				  join gpnv2.gpn_league l
				  on l.league_id = m.league_id
				  join gpnv2.gpn_client_league_map clm
				  on clm.league_id = m.league_id
				  join gpnv2.gpn_client_event_subscription_map cesm
				  on cesm.client_id = clm.client_id
				  and cesm.subscription_id in(2,4)
				  join gpnv2.gpn_application a
				  on a.client_id = clm.client_id
				  join gpnv2.gpn_event e
				  on e.event_id = cesm.event_id
				  and e.for_admin_notification = 0
				  and e.sport_id = l.sport_id
				  join gpnv2.gpn_client_language_map clangm
				  on clangm.client_id = clm.client_id
				  where m.match_id = v_match_id
				  and a.application_id = v_application_id
				 ) as tab
			where not exists(select 1
							 from gpnv2.gpn_topic t
							 where t.application_id = tab.application_id
							 and t.league_id = tab.league_id
							 and t.match_id = tab.match_id
							 and t.team_id = 0
							 and t.event_id = tab.event_id
							 and t.subscription_id = tab.subscription_id
							 and t.language_id = tab.language_id
							 and t.country_id = 1);
			
			with tab as
			(select t.topic_id, t.application_id,
			 		case t.subscription_id
		 				when 2 then string_to_array((t.application_id||'-'||t.league_id||'-'||m.team_a_id||'-'||t.event_id||'-'||
													 t.subscription_id||'-'||t.language_id||','||t.application_id||'-'||t.league_id||'-'||
													 m.team_b_id||'-'||t.event_id||'-'||t.subscription_id||'-'||t.language_id),',')
		 				when 4 then string_to_array((t.application_id||'-'||t.league_id||'-'||m.match_id||'-'||t.event_id||'-'||
													 t.subscription_id||'-'||t.language_id),',')
		 				else null
					end as lookup_values
			 from gpnv2.gpn_topic t
			 join gpnv2.gpn_match m
			 on m.match_id = t.match_id
			 where t.application_id = v_application_id
			 and t.match_id = v_match_id
			 and t.subscription_id in(2,4)
			 and t.lookup_values is null
			 order by 1)
			update gpnv2.gpn_topic t
			set lookup_values = t1.lookup_values
			from tab t1
			where t.application_id = v_application_id
			and t.match_id = v_match_id
			and t1.application_id = t.application_id
			and t1.topic_id = t.topic_id;
			
			select app_version
			into v_app_version
			from gpnv2.gpn_application
			where application_id = v_application_id;
			
			select array(select topic_id
						 from gpnv2.gpn_topic
						 where application_id = v_application_id
						 and match_id = v_match_id
						 and status = 0)
			into v_topic_id_arr;
			
			select count(1)
			into v_match_level_events_count
			from gpnv2.gpn_client_event_subscription_map cesm
			join gpnv2.gpn_application a
			on a.client_id = cesm.client_id
			where a.application_id = v_application_id
			and subscription_id = 4;
			
			if v_match_level_events_count <> 0 then
				
				update gpnv2.gpn_user_event_subscription_map uesm
				set data_value_id = v_match_id,
					lookup_value = string_to_array((uesm.application_id||'-'||uesm.league_id||'-'||v_match_id||'-'||uesm.event_id||'-'||
													uesm.subscription_id||'-'||u.language_id),',')
				from gpnv2.gpn_user u
				where u.application_id = v_application_id
				and uesm.application_id = v_application_id
				and u.user_id = uesm.user_id
				and uesm.data_value = v_match_code
				and uesm.data_value_id = 0
				and uesm.league_id = v_league_id
				and uesm.subscription_id = 4;
				
			end if;
			if v_application_id in (4,5,6)
			then
			insert into gpnv2.gpn_user_event_subscription_map(user_event_subscription_map_id, user_id, application_id, league_id, event_id,
														  subscription_id, data_value_id, data_value, lookup_value)
		select nextval('gpnv2.seq_gpn_user_event_subscription_map_id'), t1.user_id, v_application_id, t1.league_id, t1.event_id, t1.subscription_id,
				gm.match_id, t1.data_value, string_to_array((v_application_id||'-'||t1.league_id||'-'||gm.match_id||'-'||t1.event_id||'-'||
															t1.subscription_id||'-'||1),',')
		from gpnv2.gpn_user_series_subscription_map t1
		join gpnv2.gpn_series_match_map sm
		on sm.series_id=t1.data_value_id
		join gpnv2.gpn_match gm
		on gm.source_object_id=sm.source_object_id
		where gm.match_id=v_match_id
		and t1.data_value_id is not null
		and not exists(select 1
					from gpnv2.gpn_user_event_subscription_map uesm
					where uesm.application_id = v_application_id
					and uesm.user_id = t1.user_id
					and uesm.league_id = t1.league_id
					and uesm.event_id = t1.event_id
					and uesm.subscription_id = t1.subscription_id
					and uesm.data_value_id = gm.match_id);

			end if;
			
			for v_topic_id in (select topic_id from unnest(v_topic_id_arr) u(topic_id))
			loop
				
				insert into gpnv2.gpn_user_topic_map(user_topic_map_id, user_id, application_id, topic_id)
				select nextval('gpnv2.seq_gpn_user_topic_map_id'), u.user_id, u.application_id, t.topic_id
				from gpnv2.gpn_user_event_subscription_map uesm
				join gpnv2.gpn_topic t
				on t.application_id = v_application_id
				and uesm.application_id = v_application_id
				and uesm.application_id = t.application_id
				and uesm.lookup_value <@ t.lookup_values
				join gpnv2.gpn_user u
				on u.application_id = v_application_id
				and u.application_id = uesm.application_id
				and u.user_id = uesm.user_id
				where u.app_version = v_app_version
				and u.is_notification_enabled = 1
				and t.topic_id = v_topic_id
				/*and not exists(select 1
							   from gpnv2.gpn_user_topic_map utm
							   where utm.application_id = v_application_id
							   and utm.application_id = u.application_id
							   and utm.user_id = u.user_id
							   and utm.topic_id = t.topic_id);*/;
				
			end loop;
			
		end loop;
		
	end if;
	
	open p_topic_detail for
	select topic_id, topic_name, application_id
    	from gpnv2.gpn_topic
    	where match_id = v_match_id
    	and topic_arn is null
    	and status = 0;
	/*
exception when others then
	open p_topic_detail for
	select null as topic_id, null as topic_name, null as application_id
	where 1 = 2;*/
	
end;
$$;


--
