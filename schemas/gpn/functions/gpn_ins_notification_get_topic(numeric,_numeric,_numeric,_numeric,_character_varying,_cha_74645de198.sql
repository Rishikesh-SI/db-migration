-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_ins_notification_get_topic(numeric, numeric, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying[], character varying[], character varying[], jsonb, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gpn_ins_notification_get_topic(numeric, numeric, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying[], character varying[], character varying[], jsonb, refcursor, refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_ins_notification_get_topic(p_operation_type numeric, p_event_id numeric, p_sport_id numeric, p_language_id numeric, p_deep_link_info character varying, p_thumbnail character varying, p_asset_type character varying, p_trigger_id character varying, p_league_id character varying, p_notification_id character varying, p_object_image_id character varying, p_client_id character varying[], p_notification_text character varying[], p_notification_title character varying[], p_notification_payload jsonb, p_notification_detail refcursor, p_topic_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
  	v_exists numeric;
    v_league_id numeric;
    v_match_id numeric;
    v_source_object_id character varying(50);
  	v_notification_id numeric;
    v_current_timestamp timestamp without time zone := current_timestamp;
    v_is_image_available numeric;
    v_image_path character varying(500);
    v_index numeric;
    v_notification_text text;
    v_notification_title character varying(255);
begin
	
    insert into gpn.gpn_notification_payload(notification_payload_id, notification_id, notification_payload, created_date, updated_date, is_active,
                                             is_deleted)
    select nextval('gpn.seq_gpn_notification_payload_id'), p_notification_id, p_notification_payload, v_current_timestamp, v_current_timestamp, 1, 0;
    
    select count(1)
    into   v_exists
    from   gpn.gpn_notification
    where  unique_id = p_notification_id;
    
    if v_exists = 0 then
    	
        begin
        	
        	select m.league_id, m.match_id, m.source_object_id
        	into strict v_league_id, v_match_id, v_source_object_id
        	from   gpn.gpn_match m
        	join   gpn.gpn_league l
        	on     l.league_id = m.league_id
        	where  l.source_object_id = p_league_id
        	and    m.source_object_id = p_deep_link_info;
            
		exception
        	when no_data_found then
            	
            	select m.league_id, m.match_id, m.source_object_id
        		into   v_league_id, v_match_id, v_source_object_id
        		from   gpn.gpn_match m
        		join   gpn.gpn_league l
        		on     l.league_id = m.league_id
        		where  l.source_object_id = p_league_id
        		and    m.source_object_id = '0';
                
        end;
		
        if v_match_id is not null then
        	
            v_notification_id := nextval('gpn.seq_gpn_notification_id');
            
            select array_position(p_client_id,'0') into v_index;
            
            select p_notification_text[v_index],p_notification_title[v_index]
            into v_notification_text,v_notification_title;
            
            if v_notification_text is null then
            v_notification_text:='';
            v_notification_title:='';
            
            end if;
            insert into gpn.gpn_notification(notification_id, notification_text, league_id, match_id, team_a_id, team_b_id, trigger_id, event_id,
                                             language_id, status, unique_id, created_date, updated_date, is_active, is_deleted,
                                             title,object_image_id)
			select v_notification_id, v_notification_text, v_league_id, v_match_id, team_a_id, team_b_id, p_trigger_id, p_event_id, p_language_id, 0,
            	   p_notification_id, v_current_timestamp, v_current_timestamp, 1, 0,v_notification_title,p_object_image_id
			from   gpn.gpn_match m
        	where  m.match_id = v_match_id
            and    m.league_id = v_league_id;
            
            insert into gpn.gpn_client_notification_map(client_notification_map_id, notification_id, league_id, client_id, notification_text,
                                                        created_date, updated_date, is_active, is_deleted,title)
            select nextval('gpn.seq_gpn_client_notification_map_id'), p_notification_id, v_league_id, client_id::numeric, notification_text, v_current_timestamp,
            	   v_current_timestamp, 1, 0,notification_title
			from   unnest(p_client_id, p_notification_text,p_notification_title) u(client_id, notification_text,notification_title);
			
        end if;
        
	end if;
    
	perform 1;
    
    open p_notification_detail for
	select n.notification_id, case cnm.client_id
    						  	when '0' then n.notification_text
                                else cnm.notification_text
    						  end notification_text, case
                              						 	when p_thumbnail is not null and p_thumbnail <>'' then p_thumbnail
                                                     	else
                                                        	case cei.is_image_available
                                                            	when 1 then c.image_path||'/'||n.event_id||'.png'
                                                            	else p_thumbnail
                                                            end
													 end event_image, n.event_id, p_deep_link_info as deep_link_info, p_asset_type as asset_type,
                           case cnm.client_id
    						  	when '0' then n.title
                                else cnm.title
    						  end notification_title,
                  case
                              						 	when p_object_image_id is not null and p_object_image_id <>'' then 
                                                      c.object_image_path||'/'||n.object_image_id||'.png'
                                                            end
													 
                  object_image,
                  ces.sound_clip
    from   gpn.gpn_notification n
    join   gpn.gpn_client_league_map clm
    on     ( clm.league_id = n.league_id 
             or
             exists (select 1 from gpn.gpn_application_event_subscription_map aesmi
                     join gpn.gpn_client_application_map   cami
                     on   aesmi.application_id=cami.application_id
                     and  cami.client_id=clm.client_id
                     and  aesmi.subscription_id=1)
           )  
    join gpn.gpn_client_notification_map cnm
    on     cnm.league_id = n.league_id
    and    cnm.client_id = clm.client_id
    and    cnm.notification_id = n.unique_id
    join   gpn.gpn_client c
    on     c.client_id = clm.client_id
    left join gpn.gpn_client_event_image cei
    on     cei.client_id = clm.client_id
    and    cei.event_id = n.event_id
    left join gpn.gpn_client_event_image ces
    on     ces.client_id = clm.client_id
    and    ces.event_id = n.event_id
    where  n.league_id = v_league_id
    and    n.match_id  = v_match_id
    and    n.status   = 0
    and    n.notification_id =v_notification_id;
    
    open p_topic_detail for
    select distinct n.notification_id, case cnm.client_id
    						  	when '0' then n.notification_text
                                else cnm.notification_text
    						  end notification_text, t.topic_id, t.topic_arn, t.application_id, a.platform_id, a.application_stage, n.language_id,
                  case cnm.client_id
    						  	when '0' then n.title
                                else cnm.title
    						  end notification_title
    from   gpn.gpn_notification n
    join   gpn.gpn_client_league_map clm
    on     ( clm.league_id = n.league_id
            or
            exists (select 1 from gpn.gpn_application_event_subscription_map aesmi
                   join gpn.gpn_client_application_map   cami
                   on   aesmi.application_id=cami.application_id
                   and  cami.client_id=clm.client_id
                   and  aesmi.subscription_id=1)
           )
    join   gpn.gpn_client_application_map cam
    on     cam.client_id = clm.client_id
    join   gpn.gpn_topic t
    on     ( t.league_id = n.league_id
               or
            exists (select 1 from gpn.gpn_application_event_subscription_map aesmi
                   join gpn.gpn_client_application_map   cami
                   on   aesmi.application_id=cami.application_id
                   and  cami.client_id=clm.client_id
                   and  aesmi.subscription_id=1)
           )
    and    t.application_id = cam.application_id
    and    (t.match_id = n.match_id
            or t.match_id = 0)
    and    t.language_id = n.language_id
    and    (t.event_id = n.event_id
            or  exists(select 1
                       from   gpn.gpn_client_event_composition cec
                       where  cec.client_id = clm.client_id
                       and    cec.child_event_id = n.event_id
                       and    cec.event_id = t.event_id
                      )
           )
    and    n.status = 0
    and    n.notification_id =v_notification_id
    join   gpn.gpn_application_event_subscription_map aesm
    on     aesm.application_id = cam.application_id
    and    (aesm.event_id = n.event_id
            or  exists(select 1
                       from   gpn.gpn_client_event_composition cec
                       where  cec.client_id = clm.client_id
                       and    cec.child_event_id = n.event_id
                       and    cec.event_id = aesm.event_id
                      )
           )
    join   gpn.gpn_application a
    on     a.application_id = t.application_id
    join   gpn.gpn_league l
    on     l.league_id = t.league_id
           
    join   gpn.gpn_match m
     on     ( m.league_id = t.league_id or aesm.subscription_id = 3)
   -- on    m.league_id = t.league_id
    and    (m.match_id = t.match_id
            or (m.source_object_id = t.match_id::varchar
                and m.source_object_id = '0'))
	join   gpn.gpn_team tm
    on     ((tm.team_id = t.team_id
             or ( (tm.team_id = m.team_a_id
                  or tm.team_id = m.team_b_id)  and m.source_object_id <> '0'
                 )
                 
                 )
            or (tm.source_object_id = t.team_id::varchar
                and tm.source_object_id = '0'))
	join   gpn.gpn_client c
    on     c.client_id = clm.client_id
     join gpn.gpn_client_notification_map cnm
    on     cnm.client_id = clm.client_id
    and   ( cnm.league_id = clm.league_id
            or
            exists (select 1 from gpn.gpn_application_event_subscription_map aesmi
                   join gpn.gpn_client_application_map   cami
                   on   aesmi.application_id=cami.application_id
                   and  cami.client_id=clm.client_id
                   and  aesmi.subscription_id=1)
          )
    and    cnm.notification_id = n.unique_id
    where  case
            when aesm.subscription_id = 3 then tm.source_object_id
            else coalesce(n.trigger_id,'')
           end = coalesce(n.trigger_id,'');
    
end;

$$;


--
