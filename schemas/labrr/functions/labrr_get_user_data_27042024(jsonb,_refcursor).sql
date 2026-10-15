-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_user_data_27042024(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labrr_get_user_data_27042024(jsonb, refcursor); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_user_data_27042024(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
/*
 select * from labRR.labRR_get_user_data
(
    '{
    "opt_type": 1,
  "start_date_time": "2023-02-01 00:00:00",
  "end_date_time": "2023-03-03 23:20:02"
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
	i record;
	v_options json;
	v_question text;
	v_contact_id jsonb;
	q jsonb;
	options_array jsonb;
			v_polloption_array jsonb;
	v_polloption_id numeric[];
		b jsonb;
	j jsonb;
		v_ans_array numeric[];
	v_ans character varying;
		v_correct_ans text[];
	d jsonb;
    o numeric;
    v_json_data jsonb;
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
          from labRR.labRR_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labRR.labRR_web_user wu
          join labRR.labRR_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labRR.labRR_web_user wu
          join labRR.labRR_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labRR.labRR_web_user wu
          join labRR.labRR_asset_comment_reaction acr
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
      		from labRR.labRR_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labRR.labRR_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labRR.labRR_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labRR.labRR_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
*/

if v_opt_type = 1 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->>'first_name' as first_name,contact_json->'data'->>'last_name' as last_name,contact_json->'data'->>'email_id' as email_id,
		 contact_json->'data'->>'mobile_no' as mobile_no,contact_json->'data'->>'country_code' as country_code
		 from labrr.labrr_contact 
		 where created_date::date between v_start_date_time and v_end_date_time;
 
 
 	end if;
 if v_opt_type = 2 then
    
    	 open p_user_cursor for
		 select user_id,first_name,last_name,email_id,mobile_no,country_code,gender,dob,city,pincode,
		 (a.created_date + '5.5 hours'::interval) as created_date,jersey_number,b.entity_display_name as favourite_player_name,
		 (case when campaign_json is not null then 'YES' else 'NO' end ) as membership_purchased,
		 campaign_json->>'membership_expiry_date' as membership_expiry_date,
         (a.updated_date + '5.5 hours'::interval) as updated_date,
         a.state_name,
		 c.name as country_name
		 from labrr.labrr_web_user a
		 left join waf_master.waf_players b
		 on a.favourite_player_id=b.source_object_id
		 left join waf_master.waf_countries c
		 on c.country_id = a.country_id
		 where created_date::date between v_start_date_time and v_end_date_time; 
 
 	end if;
    
    if v_opt_type = 3 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	--contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
		 	contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='rr_fan_army_2023' and
         created_date::date between v_start_date_time and v_end_date_time;
 
 
 	end if;
    
    if v_opt_type = 4 then /*Register and Login Data*/
   open p_user_cursor for 
    select distinct(email_id) as email_id,'registered' as type from labrr.labrr_web_user where (created_date  + '5.5 hours'::interval)::date >= v_start_date_time
   UNION ALL
   select distinct(email_id),'login' as type from labrr.labrr_web_user where user_id in (
   select user_id from labrr.labrr_web_user_audit where (audit_date + '5.5 hours'::interval)::date >=v_start_date_time  and option_type=4 and user_id is not null)
   UNION ALL
   select distinct(email_id),'login' as type from labrr.labrr_web_user where user_id in (
   select user_id from labrr.labrr_web_user_audit where (audit_date + '5.5 hours'::interval)::date >=v_start_date_time  and option_type in (1,20));
    end if;
	
	if v_opt_type = 5 then
	
	open p_user_cursor for 
	select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
			'India' as country_name,
			'+91'as phone_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
		 	contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date,
			contact_json->'data'->>'campaign_name' as campaign_name
		 from labrr.labrr_contact 
		 where page_flag = 10 and contact_json->'data'->>'campaign_name' = 'royals_trivia_2023' and created_date::date between v_start_date_time and v_end_date_time ;
	
	end if;
    
	
	if v_opt_type = 6 then
	
	open p_user_cursor for 
	select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
			'India' as country_name,
			'+91'as phone_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
		 	contact_json->'data'->'user_info'->>'description' as address_line1,
			'https://www.rajasthanroyals.com'||(contact_json->'data'->'imagejson'->>'imageUrl') as imageUrl,
		 	contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date,
			contact_json->'data'->>'campaign_name' as campaign_name
		 from labrr.labrr_contact 
		 where page_flag = 10 and contact_json->'data'->>'campaign_name' = 'aapno_rajasthan' and created_date::date between v_start_date_time and v_end_date_time ;
	
	end if;
    
    if v_opt_type = 7 then
	
	open p_user_cursor for 
	select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
            contact_json->'data'->'user_info'->>'phone_code' as name_on_card,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state'as state,
            contact_json->'data'->'user_info'->>'stadium_name' as landmark,
            contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
            (created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and contact_json->'data'->>'campaign_name' = 'ticket_purchase_intent' and created_date::date between v_start_date_time and v_end_date_time ;
	
	end if;
    
    if v_opt_type = 8 then
	
	open p_user_cursor for 
	select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
            contact_json->'data'->'user_info'->>'country_id' as name_on_card,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state'as state,
            --contact_json->'data'->'user_info'->>'stadium_name' as landmark,
            contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
            (created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and contact_json->'data'->>'campaign_name' = 'guwahati_practice_camp' and created_date::date between v_start_date_time and v_end_date_time ;
	
	end if;
    
    if v_opt_type = 9 then
	
	open p_user_cursor for 
	select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
            contact_json->'data'->'user_info'->>'country_id' as name_on_card,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state'as state,
            --contact_json->'data'->'user_info'->>'stadium_name' as landmark,
            contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
            (created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and contact_json->'data'->>'campaign_name' = 'jaipur_practice_camp' and created_date::date between v_start_date_time and v_end_date_time ;
	
	end if;
	
	if v_opt_type = 10 then /*Download All User Data*/
    
    	 open p_user_cursor for
		 select case a.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source,
         a.first_name,a.last_name,a.email_id,a.email_verified,a.country_code,a.mobile_no,a.mobile_verified,a.dob,a.gender,
		 b.name as country,c.entity_name as favourite_player,a.jersey_number,a.created_date::timestamp,a.updated_date::timestamp
		 from labrr.labrr_web_user a
		 left join waf_master.waf_countries b
		 on a.country_id = b.country_id
		 left join labrr.labrr_entity_role_map d
		 on d.source_object_id = a.favourite_player_id
		 left join labrr.labrr_entity_master c
		 on d.entity_master_id = c.entity_master_id
		 --where a.is_deleted=1
		 ;
 	end if;
    
    if v_opt_type = 11 then
	
	open p_user_cursor for 
	select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
            contact_json->'data'->'user_info'->>'country_id' as name_on_card,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state'as state,
            --contact_json->'data'->'user_info'->>'stadium_name' as landmark,
            contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
            (created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and contact_json->'data'->>'campaign_name' = 'longest_six_campaign' and created_date::date between v_start_date_time and v_end_date_time ;
	
	end if;
    
    if v_opt_type = 12 then
	
	open p_user_cursor for 
	select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
            contact_json->'data'->'user_info'->>'country_id' as name_on_card,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state'as state,
            --contact_json->'data'->'user_info'->>'stadium_name' as landmark,
            contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
            (created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and contact_json->'data'->>'campaign_name' = 'predict_and_win_campaign' and created_date::date between v_start_date_time and v_end_date_time ;
	
	end if;
    if v_opt_type = 13 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	--contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
		 	contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='sweepstakes_raffle_campaign' and
         created_date::date between v_start_date_time and v_end_date_time;
         
         end if;
         
         if v_opt_type = 14 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	--contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
		 	contact_json->'data'->>'utm_source' as utm_source,
		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='royal_genius_campaign' and
         created_date::date between v_start_date_time and v_end_date_time;
         
         end if;

if v_opt_type = 15 then
    
		select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
 delete from labrr.labrr_poll_temp;

	
	for i in 
	select poll_option_id,option from labrr.labrr_poll_option
	where poll_id = v_poll_id
	loop

	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;

	raise notice 'v_options%',v_options;
	raise notice 'v_question%',v_question;
    
	insert into labrr.labrr_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
     
     	--raise notice 'v_poll_id %',v_poll_id;
	
	delete from labrr.labrr_poll_temp_1;
				
				    insert into labrr.labrr_poll_temp_1
	                select   contact_id::text,question,
					answer_display_value 
					from labrr.labrr_poll_response pr
					left join labrr.labrr_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.answer_id=pt.answer_id
					left join labrr.labrr_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					and contact_id is not null
					order by 1,2;
					
--update labrr.labrr_poll_temp_1 set user_id = '0' where user_id is null;

			
perform colpivot('data1', $$ select contact_id,question,answer_display_value from labrr.labrr_poll_temp_1 $$, array['contact_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';

    open p_user_cursor for
	select contact_json->'data'->'user_info'->>'state' as state_name,
	contact_json->'data'->'user_info'->>'email_id' as email_id,
	contact_json->'data'->'user_info'->>'first_name' as first_name,
	contact_json->'data'->'user_info'->>'last_name' as last_name,
	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,	
	contact_json->'data'->'user_info'->>'dob' as dob,
	contact_json->'data'->'user_info'->>'gender' as gender,
	contact_json->'data'->'user_info'->>'country_code' as pincode,
	contact_json->'data'->'user_info'->>'country_name' as country,
	contact_json->'data'->>'page_flag' as page_flag,
	contact_json->'data'->>'utm_campaign' as utm_campaign,
	contact_json->'data'->>'utm_source' as utm_source,
	contact_json->'data'->>'utm_medium' as utm_medium,	
	contact_json->'data'->>'campaign_name' as campaign_name,
contact_json->'data'->'user_info'->>'city' as city,
wu.created_date::date,
a.*
--a.answer_display_value
from data1 a
	left join labrr.labrr_contact wu on a.contact_id::numeric = wu.contact_id
	--join (select distinct created_date,contact_id from labrr.labrr_poll_response ) b on a.contact_id::numeric = b.contact_id
;
end if;

if v_opt_type = 16 then

    open p_user_cursor for
 (select  ab.billing_name as full_name,
          ab.delivery_mobile_no as mobile_no,
          ab.billing_user_emailid as email_id,
          total_price as bill_amount,
          ab.billing_address as address,
		  ab.billing_state,
		  ab.billing_city,
		  ab.billing_country,
		  ab.billing_pincode,
		   p.product_name  as  membership_type,
          b.order_status as order_status,
		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
		  b.bank_ref_no as transaction_id,
          b.tracking_id::text as tracking_id,   
          pc.description as jersey_size,
          b.final_payment_json->'data'->>'trans_date' as transaction_date,
          p.add_info->>'gst' as GST,
          p.add_info->>'cgst' as CGST,
          p.add_info->>'sgst' as SGST,
          wum.campaign_json->>'membership_start_date'as membership_start_date,
		  wum.campaign_json->>'membership_expiry_date'as membership_expiry_date,
		  wum.campaign_json->>'membership_coupon_code'as membership_coupon_code,
		  wum.campaign_json->>'membership_code'as membership_code,
          ab.discount_code,
          ab.discount_type,
          initiated_payment_json->'data'->>'type' as service_provider,
		  'Active' as "Membership Status"
           from labrr.labrr_product_shipment_user ab
           join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
           join labrr.labrr_product_cart c on b.product_cart_id=c.product_cart_id
		   join labrr.labrr_product p on c.product_id=p.product_id
           join labrr.labrr_product_cart_details pcd on c.product_cart_id=pcd.product_cart_id
           join labrr.labrr_product_customize_map pcm on pcd.product_customize_map_id=pcm.product_customize_map_id
           join labrr.labrr_product_customize pc on pcm.product_customize_id=pc.product_customize_id
		   join labrr.labrr_web_user_membership wum on b.user_guid=wum.user_guid 
		   and wum.campaign_id=c.product_id and (wum.campaign_json->>'membership_start_date')::timestamp=b.transaction_date
           where lower(b.order_status) = lower('success') and 
             b.module_name='membership' and c.product_id=5
			 and coalesce(wum.is_expiry,0)=0 and
            (b.updated_date+'5.5 hours'::interval)::date 
            between v_start_date_time and v_end_date_time)
			UNION ALL
			(select  ab.billing_name as full_name,
          ab.delivery_mobile_no as mobile_no,
          ab.billing_user_emailid as email_id,
          total_price as bill_amount,
          ab.billing_address as address,
		  ab.billing_state,
		  ab.billing_city,
		  ab.billing_country,
		  ab.billing_pincode,
		   p.product_name  as  membership_type,
          b.order_status as order_status,
		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
		  b.bank_ref_no as transaction_id,
          b.tracking_id::text as tracking_id,   
          pc.description as jersey_size,
          b.final_payment_json->'data'->>'trans_date' as transaction_date,
          p.add_info->>'gst' as GST,
          p.add_info->>'cgst' as CGST,
          p.add_info->>'sgst' as SGST,
          wum.campaign_json->>'membership_start_date'as membership_start_date,
		  wum.campaign_json->>'membership_expiry_date'as membership_expiry_date,
		  wum.campaign_json->>'membership_coupon_code'as membership_coupon_code,
		  wum.campaign_json->>'membership_code'as membership_code,
          ab.discount_code,
          ab.discount_type,
          initiated_payment_json->'data'->>'type' as service_provider,
		  'Expired' as "Membership Status"
           from labrr.labrr_product_shipment_user_archive ab
           join labrr.labrr_product_cart_paydetails_archive b on b.product_cart_id=ab.product_cart_id
           join labrr.labrr_product_cart_archive c on b.product_cart_id=c.product_cart_id
		   join labrr.labrr_product p on c.product_id=p.product_id
           join labrr.labrr_product_cart_details_archive pcd on c.product_cart_id=pcd.product_cart_id
           join labrr.labrr_product_customize_map pcm on pcd.product_customize_map_id=pcm.product_customize_map_id
           join labrr.labrr_product_customize pc on pcm.product_customize_id=pc.product_customize_id
		   join labrr.labrr_web_user_membership wum on b.user_guid=wum.user_guid 
		   and wum.campaign_id=c.product_id and (wum.campaign_json->>'membership_start_date')::timestamp=b.transaction_date
           where lower(b.order_status) = lower('success') and 
             b.module_name='membership' and c.product_id=5
			 and coalesce(wum.is_expiry,0)=1 and
            (b.updated_date+'5.5 hours'::interval)::date 
            between v_start_date_time and v_end_date_time);

end if;

if v_opt_type = 17 then
    open p_user_cursor for
            select  ab.billing_name as full_name,
          ab.delivery_mobile_no as mobile_no,
          ab.billing_user_emailid as email_id,
          total_price as bill_amount,
          ab.billing_address as address,
		  ab.billing_state,
          ab.pancard,
		  ab.billing_city,
		  ab.billing_country,
		   p.product_name  as  membership_type,
		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
		  b.bank_ref_no as transaction_id,
          b.tracking_id::text as tracking_id,
          c.donation_cause as donation_cause,
          b.order_status as payment_status,
          b.final_payment_json->'data'->>'trans_date' as transaction_date,
          initiated_payment_json->'data'->>'type' as service_provider
           from labrr.labrr_product_shipment_user ab
           join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
           join labrr.labrr_product_cart c on b.product_cart_id=c.product_cart_id
		   join labrr.labrr_product p on c.product_id=p.product_id
           where 
           --lower(b.order_status) = lower('success') and 
             b.module_name='donation' and
            (b.updated_date+'5.5 hours'::interval)::date 
            between v_start_date_time and v_end_date_time;

end if;

	if v_opt_type = 18 then
		    
    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labrr.labrr_poll_temp_1;
   
	select json_agg(x) from 
	(select distinct(a.contact_id)
	from labrr.labrr_contact a
	join labrr.labrr_poll_response b
	on a.contact_id=b.contact_id
	where b.poll_id=v_poll_id)x
	into v_contact_id;
	
	
    select json_agg(x) from 
	(select option::json->'question_text' as question_text,poll_option_id,option::json->'options' as options  
	from labrr.labrr_poll_option
	where poll_id=v_poll_id
	order by poll_option_id asc)x
	into v_polloption_array;
    
   for b in select * from jsonb_array_elements(v_contact_id)
	loop
    
    for j in select * from jsonb_array_elements(v_polloption_array)
		loop
    
        
        	select poll_ans into v_ans_array
			from labrr.labrr_poll_response
			where response_option_id=(j->>'poll_option_id')::numeric
			and contact_id=(b->>'contact_id')::numeric and poll_id=v_poll_id;
--:=uniq(sort(v_tagged_entity::int[]))::numeric[];

            v_ans_array:= sort(v_ans_array::int[])::numeric[];
            raise notice 'v_ans_array:%',v_ans_array;
           raise notice 'v_correct_ans:%',j->>'options';
            v_correct_ans:=null;
			
		if v_ans_array is not null then
			
         	foreach o in array(v_ans_array)
			loop
			select j->>'options' into options_array;
				for q in select * from jsonb_array_elements(options_array)
				loop
				
					if o = (select q->>'answer_id')::int THEN
						v_correct_ans:= array_append(v_correct_ans,(SELECT q->>'answer_display_value')::text);
					end if;
					
				end loop;
				
				
			end loop;
	 end if;		
        --raise notice 'contact_id:%',b->'contact_id';    
        --raise notice 'question:%',j->>'question_text';    
        insert into labrr.labrr_poll_temp_1(contact_id,question,answer_display_value) values ((b->'contact_id')::numeric,j->>'question_text',v_correct_ans);
        end loop;
        
    
    end loop;
	
    perform colpivot('poll_data',$$ select contact_id,question,answer_display_value from labrr.labrr_poll_temp_1 $$,array['contact_id'], array['question'], '#.answer_display_value','question');

                
    	 open p_user_cursor for
         select a.*,c.contact_json->'data'->>'campaign_name' as campaign_name,
		 c.contact_json->'data'->>'page_flag' as page_flag,
		 c.contact_json->'data'->'user_info'->>'dob' as dob,
		 c.contact_json->'data'->'user_info'->>'city' as city,
		 c.contact_json->'data'->'user_info'->>'state' as state,
		 c.contact_json->'data'->'user_info'->>'gender' as gender,
		 c.contact_json->'data'->'user_info'->>'email_id' as email_id,
		 c.contact_json->'data'->'user_info'->>'first_name' as first_name,
		 c.contact_json->'data'->'user_info'->>'last_name' as last_name,
		 c.contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
		 c.contact_json->'data'->'user_info'->>'country_code' as country
		 from labrr.labrr_contact c join (select * from poll_data)a on a.contact_id::numeric=c.contact_id;

		
	end if;
    
     if v_opt_type = 19 then
    
    	 open p_user_cursor for
		 select first_name,last_name,email_id,mobile_no,country_code,wc.name as country,gender
         ,wu.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as registration_date,--,country
         cwj.datajson->'data'->>'event_type' as button_name,cwj.datajson->'data'->>'event_url' as button_url
         ,cwj.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as response_date 
		 from labrr.labrr_web_user wu
         join labrr.labrr_custom_web_json cwj on cwj.user_guid=wu.user_guid
         left join waf_master.waf_countries wc on wc.phone_code=wu.country_code
         where cwj.module_name='royalsmatchdayscoop';
         
    end if;
    
    if 	v_opt_type = 20 then	
		--select 1/0;
		
		select p_input_json->'jsondata'->'social_id' into v_json_data;

		--raise notice '%',v_json_data;
		--select 1/0;
        open p_user_cursor for
		select client_id, social_user_name, user_full_name, email_id, created_date,dob,gender,mobile_no,user_guid,b.value as social_id		
		from labrr.labrr_web_user a,
		jsonb_array_elements_text(v_json_data) as b
		where  a.user_id=(b.value)::int
		order by created_date desc
		;

		
	end if;
    
    if v_opt_type = 21 then
    
    	 open p_user_cursor for
		 select case (contact_json->'data'->>'academy')::numeric when 1 then 'Guwahati (India)' 
         when 2 then 'Nagpur (India)' when 3 then 'Dubai (UAE)' when 4 then 'Conrwall (UK)' 
         when 5 then 'Surrey (UK)' else null end as academy_name,
         contact_json->'data'->>'first_name' as first_name,
	 		contact_json->'data'->>'last_name' as last_name,
	 		contact_json->'data'->>'email_id' as email_id,
		 	contact_json->'data'->>'mobile_no' as mobile_no,
		 	contact_json->'data'->>'country' as country,
		 	contact_json->'data'->>'birth_date' as birth_date,
		 	contact_json->'data'->>'city' as city,
		 	contact_json->'data'->>'state' as state,
            contact_json->'data'->>'language' as language
		 from labrr.labrr_contact 
		 where page_flag = 2 and created_date::date between v_start_date_time and v_end_date_time;
 
 
 	end if;
    
    if v_opt_type = 22 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	--contact_json->'data'->'user_info'->>'country_name' as country,
			'+971'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
-- 		 	contact_json->'data'->>'utm_source' as utm_source,
-- 		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- 		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='auction_contest_dubai' and
         created_date::date between v_start_date_time and v_end_date_time;
         
         end if;
         
         if v_opt_type = 23 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
-- 		 	contact_json->'data'->>'utm_source' as utm_source,
-- 		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- 		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='membership_pre_registrations' and
         created_date::date between v_start_date_time and v_end_date_time;
         
         end if;
         
         if v_opt_type = 24 then
        open p_user_cursor for
         (select  ab.billing_name as full_name,
        c.cart_json->'data'->'user_info'->>'billing_dob' as user_dob,
        c.cart_json->'data'->'user_info'->>'billing_gender' as user_gender,
        case when c.product_id=23 then ab.delivery_firstname else null end as junior_first_name,
        case when c.product_id=23 then ab.delivery_lastname else null end as junior_last_name,
        case when c.product_id=23 then c.cart_json->'data'->'user_info'->>'delivery_dob'  else null end as junior_dob,
        case when c.product_id=23 then c.cart_json->'data'->'user_info'->>'delivery_gender' else null end as junior_gender,
          ab.delivery_mobile_no as mobile_no,
          ab.billing_user_emailid as email_id,
          total_price as bill_amount,
          ab.billing_address as address,
		  ab.billing_state,
		  ab.billing_city,
		  ab.billing_country,
		  ab.billing_pincode,
		   p.product_name  as  membership_type,
          b.order_status as order_status,
		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
		  b.bank_ref_no as transaction_id,
          b.tracking_id::text as tracking_id,   
          pc.description as jersey_size,
          b.final_payment_json->'data'->>'trans_date' as transaction_date,
          p.add_info->>'gst' as GST,
          p.add_info->>'cgst' as CGST,
          p.add_info->>'sgst' as SGST,
          wum.campaign_json->>'membership_start_date'as membership_start_date,
		  wum.campaign_json->>'membership_expiry_date'as membership_expiry_date,
		  wum.campaign_json->>'membership_coupon_code'as membership_coupon_code,
		  wum.campaign_json->>'membership_code'as membership_code,
          wum.campaign_json->>'membership_pdf_path'as membership_pdf_path,
          ab.discount_code,
          ab.discount_type,
          initiated_payment_json->'data'->>'type' as service_provider,
		  'Active' as "Membership Status"
           from labrr.labrr_product_shipment_user ab
           join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
           join labrr.labrr_product_cart c on b.product_cart_id=c.product_cart_id
		   join labrr.labrr_product p on c.product_id=p.product_id
           join labrr.labrr_product_cart_details pcd on c.product_cart_id=pcd.product_cart_id
           left join labrr.labrr_product_customize_map pcm on pcd.product_customize_map_id=pcm.product_customize_map_id
           left join labrr.labrr_product_customize pc on pcm.product_customize_id=pc.product_customize_id
		   join labrr.labrr_web_user_membership wum on b.user_guid=wum.user_guid 
		   and wum.campaign_id=c.product_id and (wum.campaign_json->>'membership_start_date')::timestamp=b.transaction_date
           where lower(b.order_status) = lower('success') and
             b.module_name='membership' and p.product_id in (21,22,23) 
             and coalesce(wum.is_expiry,0)=0 and (b.updated_date+'5.5 hours'::interval)::date 
            between v_start_date_time and v_end_date_time)
			 union all 
			 (select  ab.billing_name as full_name,
        c.cart_json->'data'->'user_info'->>'billing_dob' as user_dob,
        c.cart_json->'data'->'user_info'->>'billing_gender' as user_gender,
        case when c.product_id=23 then ab.delivery_firstname else null end as junior_first_name,
        case when c.product_id=23 then ab.delivery_lastname else null end as junior_last_name,
        case when c.product_id=23 then c.cart_json->'data'->'user_info'->>'delivery_dob'  else null end as junior_dob,
        case when c.product_id=23 then c.cart_json->'data'->'user_info'->>'delivery_gender' else null end as junior_gender,
          ab.delivery_mobile_no as mobile_no,
          ab.billing_user_emailid as email_id,
          total_price as bill_amount,
          ab.billing_address as address,
		  ab.billing_state,
		  ab.billing_city,
		  ab.billing_country,
		  ab.billing_pincode,
		   p.product_name  as  membership_type,
          b.order_status as order_status,
		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
		  b.bank_ref_no as transaction_id,
          b.tracking_id::text as tracking_id,   
          pc.description as jersey_size,
          b.final_payment_json->'data'->>'trans_date' as transaction_date,
          p.add_info->>'gst' as GST,
          p.add_info->>'cgst' as CGST,
          p.add_info->>'sgst' as SGST,
          wum.campaign_json->>'membership_start_date'as membership_start_date,
		  wum.campaign_json->>'membership_expiry_date'as membership_expiry_date,
		  wum.campaign_json->>'membership_coupon_code'as membership_coupon_code,
		  wum.campaign_json->>'membership_code'as membership_code,
          wum.campaign_json->>'membership_pdf_path'as membership_pdf_path,
          ab.discount_code,
          ab.discount_type,
          initiated_payment_json->'data'->>'type' as service_provider,
		  'Expired' as "Membership Status"
           from labrr.labrr_product_shipment_user_archive ab
           join labrr.labrr_product_cart_paydetails_archive b on b.product_cart_id=ab.product_cart_id
           join labrr.labrr_product_cart_archive c on b.product_cart_id=c.product_cart_id
		   join labrr.labrr_product p on c.product_id=p.product_id
           join labrr.labrr_product_cart_details_archive pcd on c.product_cart_id=pcd.product_cart_id
           left join labrr.labrr_product_customize_map pcm on pcd.product_customize_map_id=pcm.product_customize_map_id
           left join labrr.labrr_product_customize pc on pcm.product_customize_id=pc.product_customize_id
		   join labrr.labrr_web_user_membership wum on b.user_guid=wum.user_guid and wum.campaign_id=c.product_id 
		   and (wum.campaign_json->>'membership_start_date')::timestamp=b.transaction_date
           where lower(b.order_status) = lower('success') and
             b.module_name='membership' and p.product_id in (21,22,23) 
             and coalesce(wum.is_expiry,0)=1  and (b.updated_date+'5.5 hours'::interval)::date 
            between v_start_date_time and v_end_date_time); 

        end if;

if v_opt_type = 25 then
    
		--v_poll_id = 281;
	select p_input_json->'jsondata'->'poll_id' into v_poll_id;
 delete from labrr.labrr_poll_temp;

	
	for i in 
	select poll_option_id,option from labrr.labrr_poll_option
	where poll_id = v_poll_id
	loop

	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;

	raise notice 'v_options%',v_options;
	raise notice 'v_question%',v_question;
    
	insert into labrr.labrr_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
     
     	--raise notice 'v_poll_id %',v_poll_id;
	
	delete from labrr.labrr_poll_temp_1;
				
				    insert into labrr.labrr_poll_temp_1
	                select   contact_id::text,question,
					answer_display_value 
					from labrr.labrr_poll_response pr
					left join labrr.labrr_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.answer_id=pt.answer_id
					left join labrr.labrr_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					and contact_id is not null
					and pr.answer_id is not null
					order by 1,2;
					
--update labrr.labrr_poll_temp_1 set user_id = '0' where user_id is null;

			
perform colpivot('data1', $$ select contact_id,question,answer_display_value from labrr.labrr_poll_temp_1 $$, array['contact_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';

    open p_user_cursor for
	select contact_json->'data'->'user_info'->>'state' as state_name,
	contact_json->'data'->'user_info'->>'email_id' as email_id,
	contact_json->'data'->'user_info'->>'first_name' as first_name,
	contact_json->'data'->'user_info'->>'last_name' as last_name,
	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,	
	contact_json->'data'->'user_info'->>'dob' as dob,
	contact_json->'data'->'user_info'->>'gender' as gender,
	contact_json->'data'->'user_info'->>'country_code' as pincode,
	contact_json->'data'->'user_info'->>'country_name' as country,
	contact_json->'data'->>'page_flag' as page_flag,
-- 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- 	contact_json->'data'->>'utm_source' as utm_source,
-- 	contact_json->'data'->>'utm_medium' as utm_medium,
	contact_json->'data'->>'campaign_name' as campaign_name,
contact_json->'data'->'user_info'->>'city' as city,
a.*
--a.answer_display_value
from data1 a
	left join labrr.labrr_contact wu on a.contact_id::numeric = wu.contact_id
;
end if;
		 
		 if v_opt_type = 26 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
-- 		 	contact_json->'data'->>'utm_source' as utm_source,
-- 		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- 		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='ticket_interest_2024' and
         created_date::date between v_start_date_time and v_end_date_time;
         
         end if;

if v_opt_type = 27 then

--  open p_user_cursor for
-- select * from (
-- select  ab.billing_name as full_name,
-- --         c.cart_json->'data'->'user_info'->>'billing_dob' as user_dob,
-- --         c.cart_json->'data'->'user_info'->>'billing_gender' as user_gender,
-- --         case when c.product_id=23 then ab.delivery_firstname else null end as junior_first_name,
-- --         case when c.product_id=23 then ab.delivery_lastname else null end as junior_last_name,
-- --         case when c.product_id=23 then c.cart_json->'data'->'user_info'->>'delivery_dob'  else null end as junior_dob,
-- --         case when c.product_id=23 then c.cart_json->'data'->'user_info'->>'delivery_gender' else null end as junior_gender,
--           ab.delivery_mobile_no as mobile_no,
--           ab.billing_user_emailid as email_id,
--           total_price as bill_amount,
--           ab.billing_address as address,
-- 		  ab.billing_state,
-- 		  ab.billing_city,
-- 		  ab.billing_country,
-- 		  ab.billing_pincode,
-- 		   p.product_name  as  membership_type,
--           b.order_status as order_status,
-- 		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
-- 		  b.bank_ref_no as transaction_id,
--           b.tracking_id::text as tracking_id,   
--           pc.description as jersey_size,
--           b.final_payment_json->'data'->>'trans_date' as transaction_date,
--           p.add_info->>'gst' as GST,
--           p.add_info->>'cgst' as CGST,
--           p.add_info->>'sgst' as SGST,
--           elements->>'membership_start_date'as membership_start_date,
-- 		  elements->>'membership_expiry_date'as membership_expiry_date,
-- 		  elements->>'membership_coupon_code'as membership_coupon_code,
-- 		  elements->>'membership_code'as membership_code,
--           elements->>'membership_pdf_path'as membership_pdf_path,
--           ab.discount_code,
--           ab.discount_type,
--           initiated_payment_json->'data'->>'type' as service_provider
--            from labrr.labrr_product_shipment_user ab
--            join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
--            join labrr.labrr_product_cart c on b.product_cart_id=c.product_cart_id
-- 		   join labrr.labrr_product p on c.product_id=p.product_id
--            join labrr.labrr_product_cart_details pcd on c.product_cart_id=pcd.product_cart_id
--            left join labrr.labrr_product_customize_map pcm on pcd.product_customize_map_id=pcm.product_customize_map_id
--            left join labrr.labrr_product_customize pc on pcm.product_customize_id=pc.product_customize_id
-- 		   join labrr.labrr_web_user_membership wum on b.user_guid=wum.user_guid,
--            --join labrr.labrr_web_user wu on wum.user_guid=wu.user_guid, 
--            --join labrr.labrr_web_user_membership wum on c.user_cart_guid=wum.user_guid,
-- 		   LATERAL jsonb_array_elements(wum.campaign_json->'membership_details') AS elements
--            where lower(b.order_status) = lower('success') and
--              b.module_name='membership' and p.product_id in (21,22,23) 
--              and (elements->>'campaign_id')::int=p.product_id
-- union all
-- select  ab.billing_name as full_name,
--           ab.delivery_mobile_no as mobile_no,
--           ab.billing_user_emailid as email_id,
--           total_price as bill_amount,
--           ab.billing_address as address,
-- 		  ab.billing_state,
-- 		  ab.billing_city,
-- 		  ab.billing_country,
-- 		  ab.billing_pincode,
-- 		   p.product_name  as  membership_type,
--           b.order_status as order_status,
-- 		  coalesce(b.invoice_id,p.product_code||ab.product_cart_id) as invoice_id,
-- 		  b.bank_ref_no as transaction_id,
--           b.tracking_id::text as tracking_id,   
--           pc.description as jersey_size,
--           b.final_payment_json->'data'->>'trans_date' as transaction_date,
--           p.add_info->>'gst' as GST,
--           p.add_info->>'cgst' as CGST,
--           p.add_info->>'sgst' as SGST,
--           wu.campaign_json->>'membership_start_date' as membership_start_date,
--           wu.campaign_json->>'membership_expiry_date' as membership_expiry_date,
--           wu.campaign_json->>'membership_coupon_code' as membership_coupon_code,
--           wu.membership_code as membership_code,
--           wu.campaign_json->>'membership_pdf_path'as membership_pdf_path,
--           ab.discount_code,
--           ab.discount_type,
--           initiated_payment_json->'data'->>'type' as service_provider
--            from labrr.labrr_product_shipment_user ab
--            join labrr.labrr_product_cart_paydetails b on b.product_cart_id=ab.product_cart_id
--            join labrr.labrr_product_cart c on b.product_cart_id=c.product_cart_id
-- 		   join labrr.labrr_product p on c.product_id=p.product_id
--            join labrr.labrr_product_cart_details pcd on c.product_cart_id=pcd.product_cart_id
--            join labrr.labrr_product_customize_map pcm on pcd.product_customize_map_id=pcm.product_customize_map_id
--            join labrr.labrr_product_customize pc on pcm.product_customize_id=pc.product_customize_id
--            join labrr.labrr_web_user wu on c.user_guid=wu.user_guid and wu.campaign_json is not null and wu.campaign_id is not null
--            where lower(b.order_status) = lower('success') and 
--              b.module_name='membership' and c.product_id=5)tab order by tab.full_name;

end if;

if v_opt_type = 28 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
-- 		 	contact_json->'data'->>'utm_source' as utm_source,
-- 		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- 		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='impact_match_jersey_interest' and
         created_date::date between v_start_date_time and v_end_date_time;
   end if;
    
 if v_opt_type = 29 then
 
 	open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
-- 		 	contact_json->'data'->>'utm_source' as utm_source,
-- 		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- 		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='fan_toss_contest' and
         created_date::date between v_start_date_time and v_end_date_time;
 
 end if;
 
 if v_opt_type =30 then  
			 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
-- 		 	contact_json->'data'->>'utm_source' as utm_source,
-- 		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- 		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='guwahati_ticket_interest_2024' and
         created_date::date between v_start_date_time and v_end_date_time;
         end if;
         
      if v_opt_type =31 then  
			 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
	 		contact_json->'data'->'user_info'->>'email_id' as email_id,
		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
            contact_json->'data'->'user_info'->>'gender' as gender,
		 	contact_json->'data'->'user_info'->>'country_name' as country,
			'+91'as country_code,
		 	contact_json->'data'->'user_info'->>'dob' as dob,
		 	contact_json->'data'->'user_info'->>'city' as city,
		 	contact_json->'data'->'user_info'->>'state' as state,
-- 		 	contact_json->'data'->>'utm_source' as utm_source,
-- 		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- 		 	contact_json->'data'->>'utm_medium' as utm_medium,
			contact_json->'data'->>'accept_tnc' as accept_tnc,
			(created_date + '5.5 hours'::interval) as created_date
		 from labrr.labrr_contact 
		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='rrmi_early_access_2024' and
         created_date::date between v_start_date_time and v_end_date_time;
         end if;
         
      if v_opt_type =32 then
  
  	open p_user_cursor for 
  		select * from labrr.labrr_otp_details order by created_date desc limit 10;
	
  end if;

end;
$_$;


--
