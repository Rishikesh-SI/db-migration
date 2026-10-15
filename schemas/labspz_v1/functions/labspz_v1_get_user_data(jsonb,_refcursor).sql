-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labspz_v1_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labspz_v1; Owner: -
--

CREATE FUNCTION labspz_v1.labspz_v1_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labspz_v1.labspz_v1_get_user_data
(
    '{
    "opt_type": 1,
  "start_date_time": "2019-03-23 00:00:00",
  "end_date_time": "2019-03-23 23:20:02"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
	v_client_name varchar;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
--  if v_opt_type = 1 then
--     open p_user_cursor for
--     select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
--     			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
--     from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
--           		0 as comment_count
--           from labspz_v1.labspz_v1_web_user wu
--           where created_date between v_start_date_time and v_end_date_time
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
--           		count(1) as reaction_count, 0 as comment_count
--           from labspz_v1.labspz_v1_web_user wu
--           join labspz_v1.labspz_v1_user_asset_reaction uar
--           on uar.user_id = wu.user_id
--           where uar.reaction_date between v_start_date_time and v_end_date_time
--           and uar.reaction_id <> 4
--           group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
--           		count(1) as comment_count
--           from labspz_v1.labspz_v1_web_user wu
--           join labspz_v1.labspz_v1_user_asset_reaction uar
--           on uar.user_id = wu.user_id
--           where uar.reaction_date between v_start_date_time and v_end_date_time
--           and uar.reaction_id = 4
--           group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
--           		count(1) as reaction_count, 0 as comment_count
--           from labspz_v1.labspz_v1_web_user wu
--           join labspz_v1.labspz_v1_asset_comment_reaction acr
--           on acr.user_id = wu.user_id
--           where acr.reaction_date between v_start_date_time and v_end_date_time
--           group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
--          ) as tab
-- 	left join waf_master.waf_cities c
--      on c.city_id = tab.city_id
--      left join waf_master.waf_states s
--      on s.state_id = tab.state_id
--      left join waf_master.waf_countries co
--      on co.country_id = tab.country_id;
--  end if;
 
-- 	if v_opt_type = 2 then
    
--     	 open p_user_cursor for
--          	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
-- 			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
-- 			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labspz_v1.labspz_v1_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		and reaction_id <> 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
--       		from labspz_v1.labspz_v1_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--      		 and reaction_id = 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labspz_v1.labspz_v1_asset_comment_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		group by asset_id, asset_type_id) as tab
-- 			join labspz_v1.labspz_v1_asset_list al
-- 			on al.asset_id = tab.asset_id
-- 			and al.asset_type_id = tab.asset_type_id
-- 			group by al.asset_type_id, al.asset_title, al.title_alias
-- 			order by al.asset_type_id, al.asset_title;
--     end if;
 
 	if v_opt_type = 3 then
    
    	 open p_user_cursor for
		 select 
         datajson->'data'->'user_info'->>'email_id' as email_id,
         created_date+'5.5hours'::interval as "IST Date"
		 from labspz_v1.labspz_v1_custom_web_json 
		 where created_date between v_start_date_time and v_end_date_time and module_name = 'newsletter';
	end if;
	
	if v_opt_type = 4 then
    
    	 open p_user_cursor for
		 select datajson->'data'->'user_info'->>'email_id' as email_id,
		 datajson->'data'->'user_info'->>'full_name' as full_name,
		 datajson->'data'->'user_info'->>'job_title' as job_title,
         created_date+'5.5hours'::interval as "IST Date"
		 from labspz_v1.labspz_v1_custom_web_json 
		 where created_date between v_start_date_time and v_end_date_time and module_name = 'careers';
	end if;
	
	if v_opt_type = 5 then
    
    	 open p_user_cursor for
		 select datajson->'data'->'user_info'->>'first_name' as first_name,
         datajson->'data'->'user_info'->>'last_name' as last_name,
		 datajson->'data'->'user_info'->>'organization_name' as organization_name,
		 datajson->'data'->'user_info'->>'organization_type' as organization_type,
		 datajson->'data'->'user_info'->>'country' as country,
         datajson->'data'->'user_info'->>'email_id' as email_id,
         datajson->'data'->'user_info'->>'mobile' as mobile,
		 datajson->'data'->'user_info'->>'custom_message' as custom_message,
         --datajson->'data'->>'message' as message,
         created_date+'5.5hours'::interval as "IST Date"
		 from labspz_v1.labspz_v1_custom_web_json 
		 where created_date between v_start_date_time and v_end_date_time and module_name = 'contactus';
	end if;
	
	if v_opt_type = 6 then
		select p_input_json->'jsondata'->>'client_name' into v_client_name;
		raise notice '%', v_client_name;
		--select * from siwaf.siwaf_send_notification_id where client_name = v_client_name
		--when v_client_name = (SELECT client_name FROM siwaf.siwaf_send_notification_id);
		
		open p_user_cursor for
		
		select to_char(created_date + '5.5 hours'::interval, 'DD-MM-YYYY HH24:MI:SS') as "created date",
		       notification_json , notification_id , title , 
			   notification_json->'data'->>'subscriptions_count' subscriptions_count, notification_json->'data'->>'ios_subscriptions_count' ios_subscriptions_count,
			   notification_json->'data'->>'android_subscriptions_count' android_subscriptions_count, notification_json->'data'->>'notification_sent_count' notification_sent_count,
			   notification_json->'data'->>'ios_notification_sent_count' ios_notification_sent_count, notification_json->'data'->>'android_notification_sent_count' android_notification_sent_count
		from siwaf.siwaf_send_notification
		where client_name = v_client_name
		and created_date between v_start_date_time and v_end_date_time;
	end if;

	if v_opt_type = 7 then
    
    	 open p_user_cursor for
		 select datajson->'data'->'user_info'->>'first_name' as first_name,
         datajson->'data'->'user_info'->>'last_name' as last_name,
		 datajson->'data'->'user_info'->>'org_name' as organization_name,
		 datajson->'data'->'user_info'->>'country' as country,
         datajson->'data'->'user_info'->>'email_id' as email_id,
         created_date+'5.5hours'::interval as "IST Date"
		 from labspz_v1.labspz_v1_custom_web_json 
		 where created_date between v_start_date_time and v_end_date_time and module_name = 'ebook';
	end if;
 
 
end;

$$;


--
