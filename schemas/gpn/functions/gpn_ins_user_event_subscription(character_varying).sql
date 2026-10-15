-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_ins_user_event_subscription(character varying)
-- Type: FUNCTION

-- Name: gpn_ins_user_event_subscription(character varying); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_ins_user_event_subscription(p_xml_data character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_device_token                   gpn.gpn_user.device_token%type;
  	v_device_id         		     gpn.gpn_user.device_id%type;
  	v_application_id   	 	         numeric;
  	v_league_id         		     numeric;
  	v_language_id       		     numeric;
  	v_user_id           	         numeric;
    v_setting_arr       		     xml[];
    v_setting_arr_length 		     numeric;
    v_device_token_exists            numeric;
    v_user_language_id               numeric;
  	v_option                         char(1);
  	v_event_id                       numeric;
  	v_sport_id                       numeric;
  	v_subscription_id                numeric;
  	v_data_value                     gpn.gpn_user_event_subscription_map.data_value%type;
  	v_user_event_subscription_map_id numeric;
  	v_user_subscription_count        numeric;
    v_current_timestamp              timestamp without time zone := current_timestamp;
    v_platform_id                    numeric;
    v_team_id                        numeric;
    v_team_league_id         		     varchar(20);
begin
	
    select unnest(xpath('//user/@devicetoken', p_xml_data::xml))::text::varchar   into v_device_token;
    select unnest(xpath('//user/@deviceid', p_xml_data::xml))::text::varchar      into v_device_id;
    select unnest(xpath('//user/@applicationid', p_xml_data::xml))::text::numeric into v_application_id;
    select unnest(xpath('//user/@leagueid', p_xml_data::xml))::text::numeric      into v_league_id;
    select unnest(xpath('//user/@languageid', p_xml_data::xml))::text::numeric    into v_language_id;
    select xpath('//user/setting', p_xml_data::xml)                               into v_setting_arr;
    
    begin
    	
        select u.user_id
        into strict v_user_id
        from   gpn.gpn_user u
        where  u.device_token   = v_device_token
        and    u.application_id = v_application_id;
        
      	select language_id
      	into strict v_user_language_id
      	from   gpn.gpn_user
      	where  user_id = v_user_id;
      	
      	p_result := 0;
      	
      	if v_user_language_id <> v_language_id then
        	
        	insert into gpn.gpn_user_topic_change(user_topic_change_id, user_id, topic_id, option, subscription_arn, created_date, updated_date,
                                                  is_active, is_deleted)
        	select nextval('gpn.seq_gpn_user_topic_change_id'), utm.user_id, topic_id, 2, utm.subscription_arn, v_current_timestamp,
            	   v_current_timestamp, 1, 0
        	from   gpn.gpn_user_topic_map utm
        	where  utm.user_id = v_user_id
        	and    utm.status = 1
          and    utm.subscription_arn is not null
        	and    not exists(select 1
                              from   gpn.gpn_user_topic_change utc
                              where  utc.user_id  = utm.user_id
                              and    utc.topic_id = utm.topic_id
                              and    option     = 2);
        	
        	update gpn.gpn_user
        	set    language_id = v_language_id
        	where  user_id     = v_user_id;
        	
        	p_result := 1;
        	
      	end if;
        
	exception
    	
        when no_data_found then
        
        	select platform_id
            into   v_platform_id
            from   gpn.gpn_application
            where  application_id = v_application_id;
            
            if v_platform_id = 2 then
            	
                select nextval('gpn.seq_gpn_user_id') into v_user_id;
                
        		insert into gpn.gpn_user(user_id, device_token, application_id, language_id, notification_enabled, created_date, updated_date,
                                         is_active, is_deleted, device_id)
				values (v_user_id, v_device_token, v_application_id, v_language_id, 0, v_current_timestamp, v_current_timestamp, 1, 0, v_device_id);
                
            end if;
        	
            if v_device_id is not null and v_platform_id <> 2 then
                
                select count(1)
          		into   v_device_token_exists
          		from   gpn.gpn_user
          		where  device_id = v_device_id
              and    application_id= v_application_id;
          		                
          		if v_device_token_exists >= 1 then
                	
                	select user_id
          			into   v_user_id
          			from   gpn.gpn_user
          			where  device_id = v_device_id
                and    application_id= v_application_id;
            		
            		insert into gpn.gpn_user_topic_change(user_topic_change_id, user_id, topic_id, option, subscription_arn, created_date,
                                                          updated_date, is_active, is_deleted)
        			select nextval('gpn.seq_gpn_user_topic_change_id'), utm.user_id, topic_id, 2, utm.subscription_arn, v_current_timestamp,
                    	   v_current_timestamp, 1, 0
        			from   gpn.gpn_user_topic_map utm
        			where  utm.user_id = v_user_id
        			and    utm.status = 1
              and    utm.subscription_arn is not null
        			and    not exists(select 1
                                      from   gpn.gpn_user_topic_change utc
                                      where  utc.user_id  = utm.user_id
                                      and    utc.topic_id = utm.topic_id
                                      and    option     = 2);
					-- check with aayush why to delete all rows
          -- AK note : This is necessariry to be triggered to clean up subscription when token changes on uninstall of app
            		delete 
            		from   gpn.gpn_user_event_subscription_map
            		where  user_id = (select u.user_id
                                      from   gpn.gpn_user u
                                      where  u.device_id = v_device_id
                                      and    u.application_id= v_application_id);
                                      
                delete from gpn.gpn_user_topic_map utm
                where  utm.user_id = v_user_id
                and    utm.status = 1
                and    utm.subscription_arn is null;    
                
            		update gpn.gpn_user
            		set    device_token=v_device_token,notification_enabled = 0,
                    	   is_active  = 0,
                    	   is_deleted = 1
					where  device_id  = v_device_id;
					
				else
                	
                    select nextval('gpn.seq_gpn_user_id') into v_user_id;
                    
                    insert into gpn.gpn_user(user_id, device_token, application_id, language_id, notification_enabled, created_date, updated_date,
                                             is_active, is_deleted, device_id)
					values (v_user_id, v_device_token, v_application_id, v_language_id, 0, v_current_timestamp, v_current_timestamp, 1, 0, v_device_id);
                    
        		end if;
                
			end if;
            
        	p_result := 1;
            
      	when others then
        	p_result := -1;
        
    end;
    
    if v_setting_arr is null then
    	
        delete 
      	from   gpn.gpn_user_event_subscription_map
      	where  user_id = v_user_id;
      	
      	update gpn.gpn_user
      	set    notification_enabled = 0,
        	   is_active            = 0,
               is_deleted           = 1
      	where  user_id              = v_user_id;
      	
      	insert into gpn.gpn_user_topic_change(user_topic_change_id, user_id, topic_id, option, subscription_arn, created_date, updated_date, is_active,
                                              is_deleted)
		select nextval('gpn.seq_gpn_user_topic_change_id'), utm.user_id, topic_id, 2, utm.subscription_arn, v_current_timestamp, v_current_timestamp,
        	   1, 0
		from   gpn.gpn_user_topic_map utm
        where  utm.user_id = v_user_id
        and    utm.status = 1
        and    utm.subscription_arn is not null
        and    not exists(select 1
                          from   gpn.gpn_user_topic_change utc
                          where  utc.user_id  = utm.user_id
                          and    utc.topic_id = utm.topic_id
                          and    option     = 2);
      	
      	p_result := 1;
		
    else
    	
    	select array_length(v_setting_arr, 1) into v_setting_arr_length;
      	
      	for i in 1..v_setting_arr_length
      	loop
        	
            select unnest(xpath('//user/setting['||i||']/@opt', p_xml_data::xml))::text::char               into v_option;
            select unnest(xpath('//user/setting['||i||']/@eventid', p_xml_data::xml))::text::numeric        into v_event_id;
            select unnest(xpath('//user/setting['||i||']/@sportid', p_xml_data::xml))::text::numeric        into v_sport_id;
            select unnest(xpath('//user/setting['||i||']/@subscriptionid', p_xml_data::xml))::text::numeric into v_subscription_id;
            select unnest(xpath('//user/setting['||i||']/@value', p_xml_data::xml))::text::numeric          into v_data_value;
        	  select unnest(xpath('//user/setting['||i||']/@leagueid', p_xml_data::xml))::text                into v_team_league_id;
            v_team_league_id:=COALESCE(v_team_league_id,'');
        	begin
                
                if v_data_value<>'0' and v_subscription_id not in (1) then
                      select team_id
                      into   v_team_id
                      from   gpn.gpn_team
                      where  source_object_id = v_data_value::varchar
                      and sport_id=v_sport_id;
                else   
                      v_team_id:=0;
                end if;
                    
                if v_option = 'I' then
                	
                    /*select uesm.user_event_subscription_map_id
                    into strict v_user_event_subscription_map_id
                    from   gpn.gpn_user_event_subscription_map uesm
                    where  uesm.user_id         = v_user_id
                    and    uesm.league_id        = v_league_id
                    and    uesm.event_id		   = v_event_id
                    and    uesm.subscription_id = v_subscription_id
                    and    uesm.data_value      = v_data_value;*/
                    
                    
                    
                    select uesm.user_event_subscription_map_id
                    into strict v_user_event_subscription_map_id
                    from   gpn.gpn_user_event_subscription_map uesm
                    join   gpn.gpn_client_application_map cam
                    on     cam.application_id = v_application_id
                    join   gpn.gpn_client_league_map clm
                    on     clm.client_id = cam.client_id
                    join   gpn.gpn_league l
                    on     clm.league_id=l.league_id
                    where  uesm.user_id         = v_user_id
                    and    uesm.league_id        in (select case v_league_id when 0 then clm.league_id else v_league_id end)
                    and    l.source_object_id    =  (select case v_team_league_id when '' then l.source_object_id else v_team_league_id end)
                    and    uesm.event_id		   = v_event_id
                    and    uesm.subscription_id = v_subscription_id
                   -- and    uesm.data_value      = v_data_value;
                    and    uesm.data_value      = case v_team_id when 0 then clm.league_id else v_team_id end; 
                    
				elsif v_option = 'D' then
                	
                    /*delete from gpn.gpn_user_event_subscription_map uesm
                    where  uesm.user_id                   = v_user_id
                    and    uesm.league_id                 = v_league_id
                    and    uesm.event_id		    = v_event_id
                    and    uesm.subscription_id = v_subscription_id
                    and    uesm.data_value                = v_data_value;*/
                    
                    delete from gpn.gpn_user_event_subscription_map uesm
                    where  uesm.user_id                   = v_user_id
                    and    uesm.league_id                 in (select clm.league_id
                                                                                  from   gpn.gpn_client_application_map cam
                                                                                  join   gpn.gpn_client_league_map clm
                                                                                  on     clm.client_id = cam.client_id
                                                                                  join   gpn.gpn_league l
                                                                                  on     clm.league_id=l.league_id
                                                                                  where  cam.application_id = v_application_id
                                                                                  and   clm.league_id =
                                                              		case  v_league_id when 0 then clm.league_id  
                                                              	     else v_league_id end
                                                                     and    l.source_object_id    =  (select case v_team_league_id when '' then l.source_object_id else v_team_league_id end)
                                                                     )
                    and    uesm.event_id		    = v_event_id
                    and    uesm.subscription_id = v_subscription_id
                    --and    uesm.data_value                = v_data_value;
                    and    uesm.data_value      = case v_team_id when 0 then uesm.league_id else v_team_id end;
                    
                    insert into gpn.gpn_user_topic_change(user_topic_change_id, user_id, topic_id, option, subscription_arn, created_date, updated_date, is_active,
                                                          is_deleted)
					select nextval('gpn.seq_gpn_user_topic_change_id'), utm.user_id, utm.topic_id, 2, utm.subscription_arn, v_current_timestamp,
                    	   v_current_timestamp, 1, 0
					from   gpn.gpn_user_topic_map utm
                    join   gpn.gpn_topic t
                    on     t.topic_id                  = utm.topic_id
                    and    t.event_id		   = v_event_id
                    and    t.subscription_id = v_subscription_id
        			where  utm.user_id = v_user_id
        			and    utm.status = 1
              and    utm.subscription_arn is not null
        			and    not exists(select 1
                                      from   gpn.gpn_user_topic_change utc
                                      where  utc.user_id  = utm.user_id
                                      and    utc.topic_id = utm.topic_id
                                      and    option       = 2);
					
              		select count(1)
                    into strict v_user_subscription_count
                    from   gpn.gpn_user_event_subscription_map
                    where  user_id = v_user_id;
                    
                    if v_user_subscription_count = 0 then
                    	
                        update gpn.gpn_user
                        set    notification_enabled = 0,
                        	   is_active            = 0,
                               is_deleted           = 1
                        where  user_id              = v_user_id;
                        
					end if;
                    
             	 	p_result := 1;
                    
				else
                	
                    p_result := -3;
                    
				end if;
                
			exception
            	
                when no_data_found then
                	
                    /*insert into gpn.gpn_user_event_subscription_map(user_event_subscription_map_id, user_id, league_id, event_id, subscription_id,
                                                                    data_value, created_date, updated_date, is_active, is_deleted)
					select nextval('gpn.seq_gpn_user_event_subscription_map_id'), v_user_id, v_league_id, v_event_id, v_subscription_id,
                    	   v_data_value, v_current_timestamp, v_current_timestamp, 1, 0;*/
                    
--                    if v_data_value<>'0' then
--                      select team_id
--                      into   v_team_id
--                      from   gpn.gpn_team
--                      where  source_object_id = v_data_value::varchar
--                      and sport_id=v_sport_id;
--                    else   
--                      v_team_id:=0;
--                    end if;
                    insert into gpn.gpn_user_event_subscription_map(user_event_subscription_map_id, user_id, league_id, event_id, subscription_id,
                                                                    data_value, created_date, updated_date, is_active, is_deleted)
					select nextval('gpn.seq_gpn_user_event_subscription_map_id'), user_id, league_id, event_id, subscription_id, data_value,
                    	   created_date, updated_date, is_active, is_deleted
					from
                    (
                        select  distinct v_user_id user_id, 
                        -- case v_league_id when 0 then clm.league_id else v_league_id end league_id,
                         clm.league_id  league_id,
                        	    v_event_id event_id, v_subscription_id subscription_id,
                        	   -- case v_data_value when 0 then clm.league_id else v_data_value end data_value,
                               case v_team_id when 0 then clm.league_id else v_team_id end data_value,
                              v_current_timestamp created_date,
                        		v_current_timestamp updated_date, 1 is_active, 0 is_deleted
                        from   gpn.gpn_client_application_map cam
                        join   gpn.gpn_client_league_map clm
                        on     clm.client_id = cam.client_id
                        join   gpn.gpn_league l
                        on     clm.league_id=l.league_id
                        where  cam.application_id = v_application_id
                        and    clm.league_id        
                              = (select case v_league_id when 0 then clm.league_id else v_league_id end)
                        and    l.source_object_id    =  (select case v_team_league_id when '' then l.source_object_id else v_team_league_id end)
					) tab;
                    
                    update gpn.gpn_user
                    set    notification_enabled = 1,
                    	   is_active            = 1,
                           is_deleted           = 0
                    where  user_id              = v_user_id;
                    
                    p_result := 1;
                    
				/*when others then
                	p_result := -4;*/
                    
			end;
            
      	end loop;
        
	end if;
    
/*exception
	when others then
    	p_result = -1;*/
end;

$$;


--
