-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_ins_upd_del_user_subscription(jsonb)
-- Type: FUNCTION

-- Name: gpn_ins_upd_del_user_subscription(jsonb); Type: FUNCTION; Schema: gpn_v2; Owner: -
--

CREATE FUNCTION gpn_v2.gpn_ins_upd_del_user_subscription(p_user_subscription_json jsonb, OUT p_user_id numeric, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_application_id numeric;
	v_device_token varchar(500);
     v_language_id numeric;
     v_country_code text;
     v_device_id varchar(100);
     v_settings json;
     v_league_id numeric;
     v_ga_code varchar(100);
	v_topic_id numeric;
	v_country_id numeric;
	v_user_id numeric;
	v_user_language_id numeric;
     v_user_country_id numeric;
	v_platform character varying(10);
	v_notification_enabled numeric := 0;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_setting json;
	v_option char(1);
     v_event_id numeric;
     v_subscription_id numeric;
     v_event_league_id varchar(50);
     v_data_value varchar(50);
     v_sport_id numeric;
	v_match_id numeric;
	v_team_id numeric;
	v_user_policy text;
	v_applied_user_policy text;
	v_status numeric;
	v_new_user_policy text;
	
begin
	
	set enable_seqscan = off;
	
     select p_user_subscription_json->'userSetting'->>'appID', p_user_subscription_json->'userSetting'->>'token',
     		p_user_subscription_json->'userSetting'->>'langID',
			p_user_subscription_json->'userSetting'->>'countrycode',
			p_user_subscription_json->'userSetting'->>'deviceid',
			(p_user_subscription_json->'userSetting'->'settings')::json,
			p_user_subscription_json->'userSetting'->>'leagueID',
			p_user_subscription_json->'userSetting'->>'ga_client_id'
     into v_application_id, v_device_token, v_language_id, v_country_code, v_device_id, v_settings, v_league_id,
		v_ga_code;
	
	/*to be removed*/
	v_language_id := 1;
	/*to be removed*/
	
     select topic_id into v_topic_id
     from gpn_v2.gpn_topic
     where application_id = v_application_id;
     
     if coalesce(v_country_code,'0') <> '0' then
     	begin
               select country_id into strict v_country_id
               from gpn_v2.gpn_country
               where country_code = v_country_code;
		exception
          	when no_data_found then
               	v_country_id := 1;
		end;
	else
     	v_country_id := 1;
	end if;
     
     begin
     	
          select user_id into strict v_user_id
          from gpn_v2.gpn_user
          where application_id = v_application_id
          and device_token = v_device_token;
     	
          select language_id, coalesce(country_id,0)
     	into v_user_language_id, v_user_country_id
     	from gpn_v2.gpn_user
     	where application_id = v_application_id
     	and user_id = v_user_id;
          
          if v_user_language_id <> v_language_id then
          	update gpn_v2.gpn_user
               set language_id = v_language_id
               where application_id = v_application_id
               and user_id = v_user_id;
          end if;
          
          if v_user_country_id <> v_country_id then
          	update gpn_v2.gpn_user
               set country_id = v_country_id
               where application_id = v_application_id
               and user_id = v_user_id;
          end if;
          
	exception
     	when no_data_found then
          	
               select platform into v_platform
               from gpn_v2.gpn_application
               where application_id = v_application_id;
               
               if v_platform = 'iOS' then
                    
                    select nextval('gpn_v2.seq_gpn_user_id') into v_user_id;
                    
        			insert into gpn_v2.gpn_user(user_id, device_token, device_id, application_id, language_id,
									   country_id, ga_code, notification_enabled, created_date, updated_date,
									   is_active, is_deleted)
				select v_user_id, v_device_token, v_device_id, v_application_id, v_language_id, v_country_id,
						v_ga_code, v_notification_enabled, v_current_timestamp, v_current_timestamp, 1, 0;
				
			else
                    
                    if v_device_id is not null then
                    	
                         begin
                         	
                              select user_id into strict v_user_id
                              from gpn_v2.gpn_user
                        		where application_id = v_application_id
                              and device_id = v_device_id
						and is_active = 1
						and is_deleted = 0;
                              
                              update gpn_v2.gpn_user
                        		set notification_enabled = 0,
                                   is_active = 0,
                                   is_deleted = 1
                        		where application_id = v_application_id
                              and user_id = v_user_id;
                              
                              delete from gpn_v2.gpn_user_event_subscription_map
                              where application_id = v_application_id
                              and user_id = v_user_id;
                              
                              select nextval('gpn_v2.seq_gpn_user_id') into v_user_id;
                              
                              insert into gpn_v2.gpn_user(user_id, device_token, device_id, application_id, language_id,
											   country_id, ga_code, notification_enabled, created_date,
											   updated_date, is_active, is_deleted)
						select v_user_id, v_device_token, v_device_id, v_application_id, v_language_id,
								v_country_id, v_ga_code, v_notification_enabled, v_current_timestamp,
								v_current_timestamp, 1, 0;
                              
                         exception
                         	when no_data_found then
                              	
                                   select nextval('gpn_v2.seq_gpn_user_id') into v_user_id;
                    			
        						insert into gpn_v2.gpn_user(user_id, device_token, device_id, application_id,
												   language_id, country_id, ga_code, notification_enabled,
												   created_date, updated_date, is_active, is_deleted)
							select v_user_id, v_device_token, v_device_id, v_application_id, v_language_id,
									v_country_id, v_ga_code, v_notification_enabled, v_current_timestamp,
									v_current_timestamp, 1, 0;
                                   
                         end;
                         
                    end if;
                    
               end if;
               
     end;
     
     if v_settings is null then
     	
          delete from gpn_v2.gpn_user_event_subscription_map
          where application_id = v_application_id
          and user_id = v_user_id;
          
     else
     	
          for v_setting in select * from json_array_elements(v_settings)
     	loop
          	
          	select v_setting->>'opt', v_setting->>'eventID', v_setting->>'subID', v_setting->>'leagueID',
					v_setting->>'value', v_setting->>'sportID'
          	into v_option, v_event_id, v_subscription_id, v_event_league_id, v_data_value, v_sport_id;
               
               begin
               	select league_id into strict v_league_id
               	from gpn_v2.gpn_league
               	where source_object_id = v_event_league_id;
			exception
               	when no_data_found then
                    	v_league_id := 0;
               end;
               
          	if v_data_value <> '0' and v_data_value <> '' then
               	if v_subscription_id = 2 then
                    	begin
                    		select match_id into strict v_match_id
               			from gpn_v2.gpn_match
               			where source_object_id = v_data_value;
					exception
                    		when others then
                         		v_match_id := 0;
                    	end;
                    elsif v_subscription_id = 3 then
                    	begin
                    		select team_id into strict v_team_id
               			from gpn_v2.gpn_team
               			where source_object_id = v_data_value
                    		and sport_id = v_sport_id;
					exception
                    		when others then
                         		v_team_id := 0;
                    	end;
                    end if;
			else
               	v_match_id := 0;
               	v_team_id := 0;
			end if;
               
               select case v_subscription_id when 2 then v_match_id when 3 then v_team_id else 0 end into v_data_value;
               
               if v_option = 'I' then
               	
                    if not exists(select 1
                                  from gpn_v2.gpn_user_event_subscription_map uesm
                                  where uesm.application_id = v_application_id
                                  and uesm.user_id = v_user_id
                                  and uesm.league_id = v_league_id
                                  and uesm.event_id = v_event_id
                                  and uesm.subscription_id = v_subscription_id
                                  and uesm.data_value = case v_subscription_id when 2 then v_match_id
						    										when 3 then v_team_id
						    										else 0 end) then
					insert into gpn_v2.gpn_user_event_subscription_map(user_event_subscription_map_id, user_id,
															 application_id, league_id, event_id,
															 subscription_id, data_value, created_date,
															 updated_date)
					select nextval('gpn_v2.seq_gpn_user_event_subscription_map_id'), v_user_id, v_application_id,
							v_league_id, v_event_id, v_subscription_id, v_data_value::numeric,
							v_current_timestamp, v_current_timestamp;
				end if;
               	     
			elsif v_option = 'D' then
	          		
				delete from gpn_v2.gpn_user_event_subscription_map uesm
                    where uesm.application_id = v_application_id
                    and uesm.user_id = v_user_id
                    and uesm.league_id = v_league_id
                    and uesm.event_id = v_event_id
                    and uesm.subscription_id = v_subscription_id
                    and uesm.data_value = v_data_value::numeric;
				
			end if;
          	
     	end loop;
          
     end if;
     
     if exists(select 1 from gpn_v2.gpn_user_event_subscription_map
               where application_id = v_application_id
               and user_id = v_user_id) then
          
		with tab as
          (select 'A'||application_id||'L'||league_id||'M'||match_id||'T'||team_id||'E'||event_id||'S'||subscription_id
		 		||'Lan'||language_id||'C'||country_id as policy_string
           from (select u.application_id, uesm.league_id, case uesm.subscription_id when 2 then uesm.data_value
			  														else 0 end as match_id,
                 		case uesm.subscription_id when 3 then uesm.data_value else 0 end as team_id, uesm.event_id,
                 		uesm.subscription_id, u.language_id, u.country_id
                 from gpn_v2.gpn_user u
                 join gpn_v2.gpn_user_event_subscription_map uesm
                 on uesm.application_id = u.application_id
                 and uesm.user_id = u.user_id
                 where u.application_id = v_application_id
                 and u.user_id = v_user_id
                ) a
		 order by policy_string
          )
          select string_agg(policy_string,',')
          into v_user_policy
          from tab;
		
		v_notification_enabled := 1;
		
	else
          
		v_user_policy := 'noeventsapplicable';
		v_notification_enabled := 0;
		
	end if;
     
	update gpn_v2.gpn_user
	set notification_enabled = v_notification_enabled
	where application_id = v_application_id
	and user_id = v_user_id;
	
     if exists(select 1 from gpn_v2.gpn_user_topic_map
               where application_id = v_application_id
               and user_id = v_user_id
               and topic_id = v_topic_id) then
		
		select applied_user_policy, status, new_user_policy
		into v_applied_user_policy, v_status, v_new_user_policy
		from gpn_v2.gpn_user_topic_map
		where application_id = v_application_id
		and user_id = v_user_id
		and topic_id = v_topic_id;
		
		if ((v_status = 1 and v_applied_user_policy <> v_user_policy)
		    or (v_status <> 4 and v_new_user_policy is not null and v_new_user_policy <> v_user_policy)) then
			
			update gpn_v2.gpn_user_topic_map
          	set status = 2, new_user_policy = v_user_policy, updated_date = v_current_timestamp
          	where application_id = v_application_id
          	and user_id = v_user_id
          	and topic_id = v_topic_id;
			
		end if;
		
	else
     	
          insert into gpn_v2.gpn_user_topic_map(user_topic_map_id, user_id, application_id, topic_id,
									   applied_user_policy, subscription_arn, endpoint, status,
									   new_user_policy, failed_attempts, created_date, updated_date)
		select nextval('gpn_v2.seq_gpn_user_topic_map_id'), v_user_id, v_application_id, v_topic_id, null, null, null,
				0, v_user_policy, 0, v_current_timestamp, v_current_timestamp;
		
     end if;
     
     p_user_id := v_user_id;
     p_result := 1;
     
/*exception
	when others then
     	p_user_id := null;
     	p_result := -1;*/
	
end;

$$;


--
