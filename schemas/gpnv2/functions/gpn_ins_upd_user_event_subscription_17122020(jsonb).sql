-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_ins_upd_user_event_subscription_17122020(jsonb)
-- Type: FUNCTION

-- Name: gpn_ins_upd_user_event_subscription_17122020(jsonb); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_ins_upd_user_event_subscription_17122020(p_input_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_country_code text;
	v_league_code text;
	v_application_id numeric;
	v_device_token text;
	v_language_id numeric;
	v_device_id text;
	v_version text;
	v_event_subscription_json json;
	v_country_id numeric;
	v_user_id numeric;
	v_user_language_id numeric;
	v_user_country_id numeric;
	v_platform_id numeric;
	v_event_subscription json;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	
begin
	
	p_result := 0;
	
	select p_input_json->>'countrycode', p_input_json->'userSetting'->>'leagueID', p_input_json->'userSetting'->>'appID',
			p_input_json->'userSetting'->>'token', p_input_json->'userSetting'->>'langID', p_input_json->'userSetting'->>'deviceid',
			p_input_json->'userSetting'->>'version', (p_input_json->'userSetting'->'settings')::json
	into v_country_code, v_league_code, v_application_id, v_device_token, v_language_id, v_device_id, v_version, v_event_subscription_json;
	
	v_version := coalesce(v_version,'0');
	
	v_event_subscription_json := replace(v_event_subscription_json::text,'eventId','eventID')::json;
	v_event_subscription_json := replace(v_event_subscription_json::text,'Opt','opt')::json;
	
	if v_device_token = '' then
		return;
	end if;
	
	if v_device_id = '' then
		v_device_id := null;
	end if;
	
	if v_country_code <> '' then
		begin
			select country_code_arr[1] from (select string_to_array(v_country_code,',') as country_code_arr) as tab into v_country_code;
			select country_id
			into strict v_country_id
			from gpnv2.gpn_country
			where country_code = v_country_code;
		exception
			when no_data_found then
				v_country_id := 1;
		end;
	else
		v_country_id := 1;
	end if;
	
	if v_league_code <> '' and v_league_code <> '0' then
		begin
			select source_object_id
			into strict v_league_code
			from gpnv2.gpn_league
			where (source_object_id = v_league_code
				   or league_id::text = v_league_code);
		exception
			when no_data_found then
				v_league_code := '0';
		end;
	else
		v_league_code := '0';
	end if;
	
	begin
		
		select user_id
		into strict v_user_id
		from gpnv2.gpn_user
		where application_id = v_application_id
		and device_token = v_device_token;
		
		select language_id, country_id
		into v_user_language_id, v_user_country_id
		from gpnv2.gpn_user
		where application_id = v_application_id
		and user_id = v_user_id;
		
		if v_user_language_id <> v_language_id then
			
			delete from gpnv2.gpn_user_topic_map utm
			where utm.application_id = v_application_id
			and utm.user_id = v_user_id
			and utm.subscription_arn is null
			and utm.status = 0;
			
			insert into gpnv2.gpn_user_topic_change(user_topic_change_id, user_id, application_id, topic_id,
										    	subscription_arn, user_topic_map_id)
			select nextval('gpnv2.seq_gpn_user_topic_change_id'), utm.user_id, v_application_id, utm.topic_id,
					coalesce(utm.subscription_arn,' '), utm.user_topic_map_id
			from gpnv2.gpn_user_topic_map utm
			where utm.application_id = v_application_id
			and utm.user_id = v_user_id
			and ((utm.subscription_arn is not null and utm.status = 1)
				or (utm.subscription_arn is null and utm.status = 4))
			and not exists(select 1
						from gpnv2.gpn_user_topic_change utc1
						   where utc1.application_id = v_application_id
						and utc1.application_id = utm.application_id
						and utc1.user_id = utm.user_id
						and utc1.topic_id = utm.topic_id);
			
			update gpnv2.gpn_user
			set language_id = v_language_id
			where application_id = v_application_id
			and user_id = v_user_id;
			
		end if;
		
		if v_user_country_id <> v_country_id then
			
			delete from gpnv2.gpn_user_topic_map utm
			where utm.application_id = v_application_id
			and utm.user_id = v_user_id
			and exists(select 1
					 from gpnv2.gpn_topic t
					   where t.application_id = v_application_id
					 and t.application_id = utm.application_id
					 and t.topic_id = utm.topic_id
					 and t.country_id = v_user_country_id)
			and utm.subscription_arn is null
			and utm.status = 0;
			
			insert into gpnv2.gpn_user_topic_change(user_topic_change_id, user_id, application_id, topic_id,
										    	subscription_arn, user_topic_map_id)
			select nextval('gpnv2.seq_gpn_user_topic_change_id'), utm.user_id, v_application_id, utm.topic_id,
					coalesce(utm.subscription_arn,' '), utm.user_topic_map_id
			from gpnv2.gpn_user_topic_map utm
			join gpnv2.gpn_topic t
			on t.application_id = utm.application_id
			and t.topic_id = utm.topic_id
			where utm.application_id = v_application_id
			and t.application_id = v_application_id
			and utm.user_id = v_user_id
			and ((utm.subscription_arn is not null and utm.status = 1)
				or (utm.subscription_arn is null and utm.status = 4))
			and t.country_id = v_user_country_id
			and not exists(select 1
						from gpnv2.gpn_user_topic_change utc1
						where utc1.application_id = v_application_id
						and utc1.application_id = utm.application_id
						and utc1.user_id = utm.user_id
						and utc1.topic_id = utm.topic_id);
			
			update gpnv2.gpn_user
			set country_id = v_country_id
			where application_id = v_application_id
			and user_id = v_user_id;
			
		end if;
		
	exception
		when no_data_found then
			
			select platform_id
			into v_platform_id
               from gpnv2.gpn_application
               where application_id = v_application_id;
			
			if v_platform_id = 1 and v_device_id is not null then
				
				begin
					
					select user_id
					into strict v_user_id
					from gpnv2.gpn_user
					where application_id = v_application_id
					and device_id = v_device_id
					and is_active = 1
					and is_deleted = 0;
					
					delete from gpnv2.gpn_user_topic_map utm
					where utm.application_id = v_application_id
					and utm.user_id = v_user_id
					and utm.subscription_arn is null
					and utm.status = 0;
					
					insert into gpnv2.gpn_user_topic_change(user_topic_change_id, user_id, application_id, topic_id, subscription_arn,
															user_topic_map_id)
					select nextval('gpnv2.seq_gpn_user_topic_change_id'), utm.user_id, v_application_id, utm.topic_id,
							coalesce(utm.subscription_arn,' '), utm.user_topic_map_id
					from gpnv2.gpn_user_topic_map utm
					where utm.application_id = v_application_id
					and utm.user_id = v_user_id
					and ((utm.subscription_arn is not null and utm.status = 1)
						 or (utm.subscription_arn is null and utm.status = 4))
					and not exists(select 1
								   from gpnv2.gpn_user_topic_change utc1
								   where utc1.application_id = v_application_id
								   and utc1.application_id = utm.application_id
								   and utc1.user_id = utm.user_id
								   and utc1.topic_id = utm.topic_id);
					
					delete from gpnv2.gpn_user_event_subscription_map
					where application_id = v_application_id
					and user_id = v_user_id;
					
					update gpnv2.gpn_user
					set is_notification_enabled = 0, is_active = 0, is_deleted = 1
					where application_id = v_application_id
					and user_id = v_user_id;
					
					insert into gpnv2.gpn_user(user_id, device_token, device_id, application_id, language_id, app_version)
					select nextval('gpnv2.seq_gpn_user_id'), v_device_token, v_device_id, v_application_id, v_language_id, v_version
					returning user_id into v_user_id;
					
				exception
					
					when no_data_found then
						
						insert into gpnv2.gpn_user(user_id, device_token, device_id, application_id, language_id, app_version)
						select nextval('gpnv2.seq_gpn_user_id'), v_device_token, v_device_id, v_application_id, v_language_id, v_version
						returning user_id into v_user_id;
					
				end;
				
			else
				
				insert into gpnv2.gpn_user(user_id, device_token, device_id, application_id, language_id, app_version)
				select nextval('gpnv2.seq_gpn_user_id'), v_device_token, v_device_id, v_application_id, v_language_id, v_version
				returning user_id into v_user_id;
				
			end if;
		
	end;
	
	if v_event_subscription_json is null then
		
		delete from gpnv2.gpn_user_topic_map utm
		where utm.application_id = v_application_id
		and utm.user_id = v_user_id
		and utm.subscription_arn is null
		and utm.status = 0;
		
		insert into gpnv2.gpn_user_topic_change(user_topic_change_id, user_id, application_id, topic_id,
										subscription_arn, user_topic_map_id)
		select nextval('gpnv2.seq_gpn_user_topic_change_id'), utm.user_id, v_application_id, utm.topic_id,
				coalesce(utm.subscription_arn,' '), utm.user_topic_map_id
		from gpnv2.gpn_user_topic_map utm
		where utm.application_id = v_application_id
		and utm.user_id = v_user_id
		and ((utm.subscription_arn is not null and utm.status = 1)
			or (utm.subscription_arn is null and utm.status = 4))
		and not exists(select 1
					from gpnv2.gpn_user_topic_change utc1
					where utc1.application_id = v_application_id
						and utc1.application_id = utm.application_id
					and utc1.user_id = utm.user_id
					and utc1.topic_id = utm.topic_id);
		
		delete from gpnv2.gpn_user_event_subscription_map
		where application_id = v_application_id
		and user_id = v_user_id;
		
		update gpnv2.gpn_user
		set is_notification_enabled = 0
		where application_id = v_application_id
		and user_id = v_user_id;
		
	else
		
		drop view if exists tab1;
		execute 'create temp view tab1 as
				select l.league_id, (tab.a->>''eventID'')::numeric as event_id,
						(tab.a->>''subID'')::numeric as subscription_id,
						case (tab.a->>''subID'')::numeric
							when 1 then case
										when tab.a->>''value'' = ''1111'' then l.league_id
										when tab.a->>''value'' <> ''0'' then (select league_id
																		from gpnv2.gpn_league
																		where (source_object_id = tab.a->>''value''
																				or league_id::text = tab.a->>''value''))
										else l.league_id
		 					  		  end
		 					when 2 then (select team_id
										from gpnv2.gpn_team
							   			where source_object_id = tab.a->>''value''
										and sport_id::text = tab.a->>''sportID'')
							when 3 then (select team_id
										from gpnv2.gpn_team
							   			where source_object_id = tab.a->>''value''
										and sport_id::text = tab.a->>''sportID'')
		 					when 4 then (select match_id
										from gpnv2.gpn_match
							   			where source_object_id = tab.a->>''value'')
							else ''0''
		 				end as data_value_id, tab.a->>''opt'' opt, tab.a->>''value'' data_value
				from (select json_array_elements('''||v_event_subscription_json||''') as a) as tab
				join gpnv2.gpn_league l
				on l.source_object_id = coalesce((tab.a->>''leagueID''),'''||v_league_code||''')';
		
		delete from gpnv2.gpn_user_topic_map utm
		where utm.application_id = v_application_id
		and utm.user_id = v_user_id
		and utm.subscription_arn is null
		and utm.status = 0
		and exists(select 1
				 from gpnv2.gpn_topic t
				 join tab1 t1
				 on t1.league_id = t.league_id
				 and t1.event_id = t.event_id
				 and t1.subscription_id = t.subscription_id
				 and case t1.subscription_id
			  		when 1 then t.league_id = t1.data_value_id
					when 2 then t.match_id in (select match_id
											   from gpnv2.gpn_match m
											   where (m.team_a_id = t1.data_value_id or m.team_b_id = t1.data_value_id)
											   and m.league_id = t1.league_id
											   and (m.match_start_date::date = (v_current_timestamp + '5.5 hours'::interval)::date
													or m.match_end_date >= (v_current_timestamp + '5.5 hours'::interval)))
			 		when 3 then t.team_id = t1.data_value_id
					when 4 then t.match_id = t1.data_value_id
		    		end
				 where t.application_id = v_application_id
				   and t.application_id = utm.application_id
				 and t.topic_id = utm.topic_id
				 and t1.opt = 'D');
		
		insert into gpnv2.gpn_user_topic_change(user_topic_change_id, user_id, application_id, topic_id,
										subscription_arn, user_topic_map_id)
		select nextval('gpnv2.seq_gpn_user_topic_change_id'), utm.user_id, v_application_id, utm.topic_id,
				coalesce(utm.subscription_arn,' '), utm.user_topic_map_id
		from gpnv2.gpn_user_topic_map utm
		where utm.application_id = v_application_id
		and utm.user_id = v_user_id
		and ((utm.subscription_arn is not null and utm.status = 1)
			or (utm.subscription_arn is null and utm.status = 4))
		and exists(select 1
				 from gpnv2.gpn_topic t
				 join tab1 t1
				 on t1.league_id = t.league_id
				 and t1.event_id = t.event_id
				 and t1.subscription_id = t.subscription_id
				   and case t1.subscription_id
			  		when 1 then t.league_id = t1.data_value_id
					when 2 then t.match_id in (select match_id
											   from gpnv2.gpn_match m
											   where (m.team_a_id = t1.data_value_id or m.team_b_id = t1.data_value_id)
											   and m.league_id = t1.league_id
											   and (m.match_start_date::date = (v_current_timestamp + '5.5 hours'::interval)::date
													or m.match_end_date >= (v_current_timestamp + '5.5 hours'::interval)))
			 		when 3 then t.team_id = t1.data_value_id
					when 4 then t.match_id = t1.data_value_id
		    		end
				 where t.application_id = v_application_id
				   and t.application_id = utm.application_id
				 and t.topic_id = utm.topic_id
				 and t1.opt = 'D')
		and not exists(select 1
					from gpnv2.gpn_user_topic_change utc1
					where utc1.application_id = v_application_id
					   and utc1.application_id = utm.application_id
					and utc1.user_id = utm.user_id
					and utc1.topic_id = utm.topic_id);
		
		delete from gpnv2.gpn_user_event_subscription_map uesm
		where uesm.application_id = v_application_id
		and uesm.user_id = v_user_id
		and exists(select 1
				 from tab1 t1
				 where t1.league_id = uesm.league_id
				 and t1.event_id = uesm.event_id
				 and t1.subscription_id = uesm.subscription_id
				 and (t1.data_value_id = uesm.data_value_id or t1.data_value = uesm.data_value)
				 and t1.opt = 'D');
		
		insert into gpnv2.gpn_user_event_subscription_map(user_event_subscription_map_id, user_id, application_id, league_id, event_id,
														  subscription_id, data_value_id, data_value, lookup_value)
		select nextval('gpnv2.seq_gpn_user_event_subscription_map_id'), v_user_id, v_application_id, league_id, event_id, subscription_id,
				data_value_id, data_value, string_to_array((v_application_id||'-'||league_id||'-'||data_value_id||'-'||event_id||'-'||
															subscription_id||'-'||v_language_id),',')
		from tab1 t1
		where t1.opt = 'I'
		and t1.data_value_id is not null
		and not exists(select 1
					from gpnv2.gpn_user_event_subscription_map uesm
					where uesm.application_id = v_application_id
					and uesm.user_id = v_user_id
					and uesm.league_id = t1.league_id
					and uesm.event_id = t1.event_id
					and uesm.subscription_id = t1.subscription_id
					and uesm.data_value_id = t1.data_value_id);
		
		insert into gpnv2.gpn_user_event_subscription_map(user_event_subscription_map_id, user_id, application_id, league_id, event_id,
														  subscription_id, data_value_id, data_value, lookup_value)
		select nextval('gpnv2.seq_gpn_user_event_subscription_map_id'), v_user_id, v_application_id, league_id, event_id, subscription_id, 0,
				data_value, string_to_array((v_application_id||'-'||league_id||'-'||data_value_id||'-'||event_id||'-'||subscription_id||'-'||
											 v_language_id),',')
		from tab1 t1
		where t1.opt = 'I'
		and t1.subscription_id = 4
		and t1.data_value_id is null;
		
	end if;
	
	if exists(select 1
			from gpnv2.gpn_user_event_subscription_map
			where application_id = v_application_id
			and user_id = v_user_id) then
		
		update gpnv2.gpn_user
		set is_notification_enabled = 1
		where application_id = v_application_id
		and user_id = v_user_id;
		
		insert into gpnv2.gpn_user_topic_map(user_topic_map_id, user_id, application_id, topic_id)
		select nextval('gpnv2.seq_gpn_user_topic_map_id'), v_user_id, v_application_id, topic_id
		from (select distinct t.topic_id
			  from gpnv2.gpn_user u
			  join gpnv2.gpn_user_event_subscription_map uesm
			 on uesm.application_id = u.application_id
			 and uesm.user_id = u.user_id
			 join gpnv2.gpn_topic t
			 on t.application_id = uesm.application_id
			 and t.league_id = uesm.league_id
			 and t.event_id = uesm.event_id
			 and t.subscription_id = uesm.subscription_id
			 and t.language_id = u.language_id
			 and (case t.for_admin_notification when 1 then u.country_id else 1 end) = t.country_id
			 where u.application_id = v_application_id
			  and uesm.application_id = v_application_id
			  and t.application_id = v_application_id
			 and u.user_id = v_user_id
			 and case uesm.subscription_id
			  		when 1 then t.league_id = uesm.data_value_id
					when 2 then t.match_id in (select match_id
											   from gpnv2.gpn_match m
											   where (m.team_a_id = uesm.data_value_id or m.team_b_id = uesm.data_value_id)
											   and m.league_id = uesm.league_id
											   and (m.match_start_date::date = (v_current_timestamp + '5.5 hours'::interval)::date
													or m.match_end_date >= (v_current_timestamp + '5.5 hours'::interval)))
			 		when 3 then t.team_id = uesm.data_value_id
					when 4 then t.match_id = uesm.data_value_id
		    		end
			and not exists(select 1
						from gpnv2.gpn_user_topic_map utm
						where utm.application_id = v_application_id
						   and utm.application_id = u.application_id
						and utm.user_id = u.user_id
						and utm.topic_id = t.topic_id)
			) tab;
		
		delete from gpnv2.gpn_user_topic_change utc
		where utc.application_id = v_application_id
		and utc.user_id = v_user_id
		and utc.subscription_arn = ' '
		and exists(select 1
				 from gpnv2.gpn_user_topic_map utm
				 where utm.application_id = v_application_id
				   and utm.application_id = utc.application_id
				 and utm.user_id = utc.user_id
				 and utm.topic_id = utc.topic_id
				 and utm.status = 0
				 and utm.subscription_arn is null);
		
	else
		
		update gpnv2.gpn_user
		set is_notification_enabled = 0
		where application_id = v_application_id
		and user_id = v_user_id;
		
	end if;
	
	p_result := 1;
	
	update gpnv2.gpn_user
	set call_json = p_input_json,
		updated_date = v_current_timestamp,
		app_version = coalesce(v_version, app_version)
	where application_id = v_application_id
	and user_id = v_user_id;
	
/*exception
	when others then
		p_result := -1;*/
end;
$$;


--
