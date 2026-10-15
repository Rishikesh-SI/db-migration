-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labdsg_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labdsg; Owner: -
--

CREATE FUNCTION labdsg.labdsg_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labdsg.labdsg_get_user_data
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
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
  /*  
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labdsg.labdsg_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labdsg.labdsg_web_user wu
          join labdsg.labdsg_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labdsg.labdsg_web_user wu
          join labdsg.labdsg_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labdsg.labdsg_web_user wu
          join labdsg.labdsg_asset_comment_reaction acr
          on acr.user_id = wu.user_id
          where acr.reaction_date between v_start_date_time and v_end_date_time
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
         ) as tab
	left join waf_master.waf_cities c
     on c.city_id = tab.city_id
     left join waf_master.waf_states s
     on s.state_id = tab.state_id
     left join waf_master.waf_countries co
     on co.country_id = tab.country_id;
 end if;
 
	if v_opt_type = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labdsg.labdsg_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labdsg.labdsg_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labdsg.labdsg_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labdsg.labdsg_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
    
    
    if v_opt_type = 3 then 
  open p_user_cursor for
select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source, 
first_name, last_name,
    			 email_id, dob, mobile_no, gender,city,pincode,favourite_player_id,d.name as country,is_verified,created_date at time zone 'utc' at time zone 'Asia/Calcutta',
				 subscribe_for_email
    from (select client_id, first_name, last_name, email_id, dob, mobile_no,gender,city,pincode,favourite_player_id,country_id,is_verified,created_date,subscribe_for_email
          from labgt.labgt_web_user a
           where created_date between v_start_date_time and v_end_date_time)as tab
   			--left join waf_master.waf_players f 
			--on tab.favourite_player_id=f.source_object_id
			left join waf_master.waf_countries d 
			on tab.country_id=d.country_id;		  
end if;*/
 	if v_opt_type = 1 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
         contact_json->'data'->'user_info'->>'last_name' as last_name,
         contact_json->'data'->'user_info'->>'email_id' as email_id,
         contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
         contact_json->'data'->>'country_code' as country_code
         ,contact_json->'data'->>'message' as feedback,created_date+'5.5 hours'::interval as created_date
		 from labdsg.labdsg_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and page_flag=1;
 
 
 	end if;
    if v_opt_type = 2 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
         contact_json->'data'->'user_info'->>'last_name' as last_name,
         contact_json->'data'->'user_info'->>'email_id' as email_id,
         contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
         contact_json->'data'->>'country_code' as country_code
         ,contact_json->'data'->>'message' as feedback,created_date+'5.5 hours'::interval as created_date
		 from labdsg.labdsg_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and page_flag=2;
 
 
 	end if;
    if v_opt_type = 3 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
         contact_json->'data'->'user_info'->>'last_name' as last_name,
         contact_json->'data'->'user_info'->>'email_id' as email_id,
         contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
         contact_json->'data'->>'country_code' as country_code
         ,contact_json->'data'->>'message' as feedback,created_date+'5.5 hours'::interval as created_date
		 from labdsg.labdsg_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and page_flag=3;
 
 
 	end if;
    
    if v_opt_type = 4 then
    
    	 open p_user_cursor for
         select first_name as first_name,last_name as last_name,email_id as email_id,
         mobile_no as mobile_no,dob as dob,gender as gender,address as address,
         country as country,city as city,pincode as pincode,jersey_number as jersey_number,
         jersey_name as jersey_name,created_date
		 from labdsg.labdsg_web_user 
		 where created_date::date between v_start_date_time and v_end_date_time;
 
 
 	end if;
	
	 if v_opt_type = 5 then
    
    	 open p_user_cursor for
		 select datajson->'data'->'user_info'->>'first_name' as first_name,
         datajson->'data'->'user_info'->>'last_name' as last_name,
         datajson->'data'->'user_info'->>'email_id' as email_id,
		 datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
		 datajson->'data'->'country_code'->>'phone_code' as phone_code,
		 created_date + '5.5 hours'::interval as created_date
		 from labdsg.labdsg_custom_web_json 
		 where created_date::date between v_start_date_time and v_end_date_time and module_name = 'fanarmyrecruitment';
 
 
 	end if;
	
	if v_opt_type = 6 then
    
    	 open p_user_cursor for
		 select datajson->'data'->'user_info'->>'first_name' as first_name,
         datajson->'data'->'user_info'->>'last_name' as last_name,
         datajson->'data'->'user_info'->>'email_id' as email_id,
		 datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
		 datajson->'data'->'country_code'->>'phone_code' as phone_code,
		 created_date + '5.5 hours'::interval as created_date
		 from labdsg.labdsg_custom_web_json 
		 where created_date::date between v_start_date_time and v_end_date_time and module_name = 'superfans';
 
 
 	end if;
 
 
 
 
end;

$$;


--
