-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labisl_v1_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labisl_v1.labisl_v1_get_user_data
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
	v_entity_id numeric;
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
--           from labisl_v1.labisl_v1_web_user wu
--           where created_date between v_start_date_time and v_end_date_time
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
--           		count(1) as reaction_count, 0 as comment_count
--           from labisl_v1.labisl_v1_web_user wu
--           join labisl_v1.labisl_v1_user_asset_reaction uar
--           on uar.user_id = wu.user_id
--           where uar.reaction_date between v_start_date_time and v_end_date_time
--           and uar.reaction_id <> 4
--           group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
--           		count(1) as comment_count
--           from labisl_v1.labisl_v1_web_user wu
--           join labisl_v1.labisl_v1_user_asset_reaction uar
--           on uar.user_id = wu.user_id
--           where uar.reaction_date between v_start_date_time and v_end_date_time
--           and uar.reaction_id = 4
--           group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
--           union
--           select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
--           		count(1) as reaction_count, 0 as comment_count
--           from labisl_v1.labisl_v1_web_user wu
--           join labisl_v1.labisl_v1_asset_comment_reaction acr
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
--       		from labisl_v1.labisl_v1_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		and reaction_id <> 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
--       		from labisl_v1.labisl_v1_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--      		 and reaction_id = 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labisl_v1.labisl_v1_asset_comment_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		group by asset_id, asset_type_id) as tab
-- 			join labisl_v1.labisl_v1_asset_list al
-- 			on al.asset_id = tab.asset_id
-- 			and al.asset_type_id = tab.asset_type_id
-- 			group by al.asset_type_id, al.asset_title, al.title_alias
-- 			order by al.asset_type_id, al.asset_title;
--     end if;

if v_opt_type = 1 then
open p_user_cursor for
select case when ((first_name is null) or (last_name is null) or country_id is null or 
					(email_id is null) or (state_id is null) or (dob is null) or (gender is null)
					or (mobile_no is null) or profile_picture_url is null) then 'No' else 'YES' end as "COMPLETED PROFILE"
,first_name,last_name,email_id,mobile_no,created_date::date,email_verified,mobile_verified
from labisl_v1.labisl_v1_web_user 
where created_date::date between v_start_date_time and v_end_date_time;

end if;

if v_opt_type = 2 then
		
				select p_input_json->'jsondata'->'entity_id' into v_entity_id;
	
   open p_user_cursor for
    select p.title as "Poll",po.option::jsonb->>'player_name' as "Player Name",tab.count as "Total Users Count"
 from labisl_v1.labisl_v1_poll p join labisl_v1.labisl_v1_poll_option po on po.poll_id=p.poll_id
 left join (select count(po.*) as "count",po.poll_id,po.poll_option_id from labisl_v1.labisl_v1_user_poll_response pr 
  join labisl_v1.labisl_v1_poll_option po on po.poll_id=pr.poll_id and po.poll_option_id=pr.response_option_id 
 where po.poll_id in (select asset_id from labisl_v1.labisl_v1_asset_entity_map 
 where asset_Type_id=6 and entity_role_map_id=v_entity_id) 
       group by po.poll_id,po.poll_option_id)tab on (tab.poll_id=po.poll_id and tab.poll_option_id=po.poll_option_id)
 where p.poll_id in (select asset_id from labisl_v1.labisl_v1_asset_entity_map 
 where asset_Type_id=6 and entity_role_map_id=v_entity_id) and p.is_active=1 and p.is_deleted=0 order by p.title,tab.count;
 
 
    
	end if;

if v_opt_type = 3 then 

  
   
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'module' as module_name , b.mobile_no,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as Date,a.updated_date at time zone 'utc' at time zone 'Asia/Calcutta' as Time
  from labisl_v1.labisl_v1_custom_web_json a
  join labisl_v1.labisl_v1_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='sunil-chettri-campaign';
  
  end if;
------------------------------------------------------------------------
 if v_opt_type = 4 then 

  
   
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'module' as module_name , b.mobile_no,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as Date,a.updated_date at time zone 'utc' at time zone 'Asia/Calcutta' as Time
  from labisl_v1.labisl_v1_custom_web_json a
  join labisl_v1.labisl_v1_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='isl-100th-signed-pennat';
  
  end if;
   
----------------------------------------------------------------------------
		
if v_opt_type = 5 then 

  
   
  open p_user_cursor for
  select a.datajson->'data'->>'module' as module_name,b.mobile_no, a.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as Date,a.updated_date at time zone 'utc' at time zone 'Asia/Calcutta' as Time
  from labisl_v1.labisl_v1_custom_web_json a
  join labisl_v1.labisl_v1_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='Otp_data';
  
  end if;
 
 
 
 
end;

$$;


--
