-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labkc_v1_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labkc_v1.labkc_v1_get_user_data
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
	v_poll_id numeric;
	v_json_data jsonb;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labkc_v1.labkc_v1_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labkc_v1.labkc_v1_web_user wu
          join labkc_v1.labkc_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labkc_v1.labkc_v1_web_user wu
          join labkc_v1.labkc_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labkc_v1.labkc_v1_web_user wu
          join labkc_v1.labkc_v1_asset_comment_reaction acr
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
      		from labkc_v1.labkc_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labkc_v1.labkc_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labkc_v1.labkc_v1_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labkc_v1.labkc_v1_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
 
 if v_opt_type = 3 then

select p_input_json->'jsondata'->'poll_id' into v_poll_id;

    	 open p_user_cursor for
		 select a.first_name,a.last_name,a.email_id,a.country_code,a.mobile_no,d.name,(f.option::json->>'answer')::text as answer,a.city
		 from labkc_v1.labkc_v1_user_poll_response g
		 join labkc_v1.labkc_v1_poll_option f
		 on f.poll_option_id=g.response_option_id
		 join labkc_v1.labkc_v1_web_user a
		 on a.user_id=g.user_id
		 left join waf_master.waf_countries d
		 on a.country_id = d.country_id
		 where g.poll_id=v_poll_id;
 end if;
 
 
  if 	v_opt_type = 11 then	
		--select 1/0;
		
		select p_input_json->'jsondata'->'social_id' into v_json_data;

		--raise notice '%',v_json_data;
		--select 1/0;
        open p_user_cursor for
		select client_id, social_user_name, user_full_name, email_id, created_date,dob,gender,mobile_no,user_guid,b.value as social_id		
		from labkc_v1.labkc_v1_web_user a,
		jsonb_array_elements_text(v_json_data) as b
		where  a.user_id=(b.value)::int
		order by created_date desc
		;

		
	end if;

if  v_opt_type = 4 then	
		--select 1/0;

        open p_user_cursor for
		select a.email_id,a.mobile_no,a.first_name,a.last_name,a.country_code,a.gender,a.city,user_id,d.name as country_name,a.created_date::date
		from labkc_v1.labkc_v1_web_user a
		left join waf_master.waf_countries d
		on a.country_id = d.country_id
		where created_date between v_start_date_time and v_end_date_time;
 end if;
 
 
 if v_opt_type = 5 then
	 
	 open p_user_cursor for
	 select datajson->'data'->>'module' as module ,
		datajson->'data'->>'club_name' as club_name,
		datajson->'data'->>'country_id' as club_description,
		datajson->'data'->'user_info'->>'first_name' as first_name,	
		datajson->'data'->'user_info'->>'last_name' as last_name,
		datajson->'data'->'user_info'->>'email_id' as email_id,
		datajson->'data'->'user_info'->>'mobile_no' as mobile_no,	
		datajson->'data'->'user_info'->>'city' as city,
		datajson->'data'->'user_info'->>'country_name' as country,
		datajson->'data'->'user_info'->>'fb_social_id' as address,
		datajson->'data'->'user_info'->>'insta_social_id' as address_line1,
		datajson->'data'->'user_info'->>'twitter_social_id' as address_line2,
		datajson->'data'->>'country_id' as country_id,
		datajson->'data'->>'country_code' as country_code		
	from labkc_v1.labkc_v1_custom_web_json
	where lower(module_name) = 'fanclub' 
	--and (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
	;

	 end if;
     
     if v_opt_type = 6 then

	 open p_user_cursor for
	 select contact_json->'data'->>'module' as module ,
		contact_json->'data'->>'message' as message,
		contact_json->'data'->>'subject' as subject,
		contact_json->'data'->'user_info'->>'first_name' as first_name,	
		contact_json->'data'->'user_info'->>'last_name' as last_name,
		contact_json->'data'->'user_info'->>'email_id' as email_id,
		contact_json->'data'->'user_info'->>'mobile_no' as mobile_no
	from labkc_v1.labkc_v1_contact
	where (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time;

	 end if;	
     
    if v_opt_type = 7 then

	 open p_user_cursor for
	 select first_name,last_name,email_id,mobile_no,profile_picture_url
	from labkc_v1.labkc_v1_web_user
	where (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time;

	 end if;

 
end;
$$;


--
