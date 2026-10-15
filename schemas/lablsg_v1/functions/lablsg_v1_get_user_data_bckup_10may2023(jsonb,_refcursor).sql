-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_user_data_bckup_10may2023(jsonb, refcursor)
-- Type: FUNCTION

-- Name: lablsg_v1_get_user_data_bckup_10may2023(jsonb, refcursor); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_user_data_bckup_10may2023(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

/*
select * from lablsg_v1.lablsg_v1_get_user_data
(
    '{
    "opt_type": 10,
  "start_date_time": "2022-12-12 00:00:00",
  "end_date_time": "2023-04-15 23:20:02"
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
    v_map_id numeric;
	i record;
	v_options json;
	v_question text;
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
          from lablsg_v1.lablsg_v1_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from lablsg_v1.lablsg_v1_web_user wu
          join lablsg_v1.lablsg_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from lablsg_v1.lablsg_v1_web_user wu
          join lablsg_v1.lablsg_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from lablsg_v1.lablsg_v1_web_user wu
          join lablsg_v1.lablsg_v1_asset_comment_reaction acr
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
      		from lablsg_v1.lablsg_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from lablsg_v1.lablsg_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from lablsg_v1.lablsg_v1_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join lablsg_v1.lablsg_v1_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
 
 */
     if v_opt_type = 1 then
    
    	 open p_user_cursor for
         
         select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,
         wu.first_name as first_name,wu.last_name as last_name,wu.email_id as email_id,
         wu.mobile_no as mobile_no,wu.dob as dob,wu.gender as gender,
         wc.name as country1,wu.country_code as country_code,wu.city as city,wu.pincode as pincode,wu.jersey_number as jersey_number,
         wu.jersey_name as name_on_card,wu.address as address,
         wu.membership_code as social_user_name,
         wp.entity_name as favourite_player_name,
         wu.created_date as created_date
		 from lablsg_v1.lablsg_v1_web_user wu 
        left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
         left join waf_master.waf_countries wc on wc.country_id= wu.country_id
		 where   wu.created_date::date between v_start_date_time and v_end_date_time;
 	end if;
    
    if v_opt_type = 2 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
         contact_json->'data'->'user_info'->>'last_name' as last_name,
         contact_json->'data'->'user_info'->>'email_id' as email_id,
         contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
         contact_json->'data'->>'country_code' as country_code
         ,contact_json->'data'->>'message' as feedback,created_date+'5.5 hours'::interval as created_date
		 from lablsg_v1.lablsg_v1_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and (contact_json->'data'->>'page_flag')::numeric=1;
 
 
 	end if;
    if v_opt_type = 3 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
         contact_json->'data'->'user_info'->>'last_name' as last_name,
         contact_json->'data'->'user_info'->>'email_id' as email_id,
         contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
         contact_json->'data'->>'country_code' as country_code
         ,contact_json->'data'->>'message' as feedback,created_date+'5.5 hours'::interval as created_date
		 from lablsg_v1.lablsg_v1_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and (contact_json->'data'->>'page_flag')::numeric=2;
 
 
 	end if;
    if v_opt_type = 4 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
         contact_json->'data'->'user_info'->>'last_name' as last_name,
         contact_json->'data'->'user_info'->>'email_id' as email_id,
         contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
         contact_json->'data'->>'country_code' as country_code
         ,contact_json->'data'->>'message' as feedback,created_date+'5.5 hours'::interval as created_date
		 from lablsg_v1.lablsg_v1_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and (contact_json->'data'->>'page_flag')::numeric=3;
    end if;
    
        if v_opt_type = 5 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->>'first_name' as first_name,
         contact_json->'data'->>'last_name' as last_name,
         contact_json->'data'->>'email_id' as email_id,
         contact_json->'data'->>'mobile' as mobile_no,
         contact_json->'data'->>'message' as feedback
		 from lablsg_v1.lablsg_v1_contact 
		 where created_date::date between v_start_date_time and v_end_date_time;
    end if;
 
 
 if v_opt_type = 6 then
    
		select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
 delete from lablsg_v1.lablsg_v1_poll_temp;

	
	for i in 
	select poll_option_id,option from lablsg_v1.lablsg_v1_poll_option
	where poll_id = v_poll_id
	loop

	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;

	--raise notice 'v_options%',v_options;
	--raise notice 'v_question%',v_question;
    
	insert into lablsg_v1.lablsg_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
     
     	--raise notice 'v_poll_id %',v_poll_id;
	
	delete from lablsg_v1.lablsg_v1_poll_temp_1;
				
				    insert into lablsg_v1.lablsg_v1_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||'('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from lablsg_v1.lablsg_v1_user_poll_response pr
					left join lablsg_v1.lablsg_v1_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join lablsg_v1.lablsg_v1_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
					
update lablsg_v1.lablsg_v1_poll_temp_1 set user_id = '0' where user_id is null;

			
perform colpivot('data1', $$ select user_id,question,answer_display_value from lablsg_v1.lablsg_v1_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';

    open p_user_cursor for
	select distinct upr.response_date,wu.first_name,wu.last_name,wu.email_id,wu.dob,wu.mobile_no,ct.name as country_name,city,pincode,address,a.*
      from data1 a
	left join lablsg_v1.lablsg_v1_web_user wu on a.user_id::numeric = wu.user_id
	left join waf_master.waf_countries ct on wu.country_id=ct.country_id
	join lablsg_v1.lablsg_v1_user_poll_response upr on upr.user_id = wu.user_id;
/*
    open p_user_cursor for
	select first_name,last_name,email_id,mobile_no,dob,ct.name as country_name,city,pincode,address,a.*
      from data1 a
	left join lablsg_v1.lablsg_v1_web_user wu on a.user_id::numeric = wu.user_id
	left join waf_master.waf_countries ct on wu.country_id=ct.country_id;
*/ 
 
 end if; 
 

 if v_opt_type = 7 then
    
    	 open p_user_cursor for
		 select datajson->'data'->'user_info'->>'first_name' as first_name,
         datajson->'data'->'user_info'->>'last_name' as last_name,
         datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
         datajson->'data'->'user_info'->>'email_id' as email_id,
         datajson->'data'->>'dob' as date_of_birth,
         datajson->'data'->>'gender' as person_gender,
         datajson->'data'->>'city' as city1,
         datajson->'data'->>'occupation' as occupation,
         datajson->'data'->>'name_of_instituation' as name_of_instituation,
         datajson->'data'->>'about_yourself' as about_yourself,
         datajson->'data'->'user_info'->>'ig_handle' as social_user_name,
         datajson->'data'->>'ig_followers' as insta_followers,
         datajson->'data'->'user_info'->>'other_social' as name_on_card,
         datajson->'data'->>'reason_of_participation' as reason_of_participation,
         datajson->'data'->>'media_path' as media_path,
		  (created_date +'5.5 hours'::interval)::date as created_date
         from lablsg_v1.lablsg_v1_custom_web_json
		 where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 and lower(module_name) = lower('fanarmyrecruitment') ;
         
         
    end if;
	
	if v_opt_type = 8 then
	
	   select p_input_json->'jsondata'->'social_id' into v_json_data;
	   
	   --raise notice '%',v_json_data;

        open p_user_cursor for
		select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,
         wu.first_name as first_name,wu.last_name as last_name,wu.email_id as email_id,
         wu.mobile_no as mobile_no,wu.dob as dob,wu.gender as gender,
         wc.name as country1,wu.country_code as country_code,wu.city as city,wu.pincode as pincode,wu.jersey_number as jersey_number,
         wu.jersey_name as name_on_card,wu.address as address,
         wu.membership_code as social_user_name,
         wp.entity_name as favourite_player_name,
         wu.created_date as created_date
		from lablsg_v1.lablsg_v1_web_user wu
		join jsonb_array_elements_text(v_json_data) as b on wu.user_id = b.value::numeric
		left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
		left join waf_master.waf_countries wc on wc.country_id= wu.country_id
		order by created_date desc;
			
	
	end if;
    
    if v_opt_type = 9 then
    
    	 open p_user_cursor for
         
         select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,
         wu.first_name as first_name,wu.last_name as last_name,wu.email_id as email_id,
         wu.mobile_no as mobile_no,wu.dob as dob,wu.gender as gender,
         wc.name as country1,wu.country_code as country_code,wu.city as city,wu.pincode as pincode,wu.jersey_number as jersey_number,
         wu.jersey_name as name_on_card,
         wu.membership_code as social_user_name,
         wp.entity_name as favourite_player_name,
         TO_CHAR(wu.created_date::date, 'yyyy/mm/dd') as created_date,
         TO_CHAR(wu.updated_date::date, 'yyyy/mm/dd') as updated_date,
         case  when created_date=updated_date then 'registered user' when created_date<>updated_date then 'updated user' end as remarks
		 from lablsg_v1.lablsg_v1_web_user wu 
        left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
         left join waf_master.waf_countries wc on wc.country_id= wu.country_id
		 where   wu.updated_date::date between v_start_date_time and v_end_date_time
         or wu.created_date::date between v_start_date_time and v_end_date_time;
 	end if;

 if v_opt_type = 10 then
    
    	 open p_user_cursor for
		 select datajson->'data'->'user_info'->>'first_name' as first_name,
         datajson->'data'->'user_info'->>'last_name' as last_name,
         datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
         datajson->'data'->'user_info'->>'email_id' as email_id,
         datajson->'data'->>'dob' as date_of_birth,
         datajson->'data'->>'gender' as person_gender,
         datajson->'data'->>'city' as city1,
         datajson->'data'->>'occupation' as occupation,
         --datajson->'data'->>'name_of_instituation' as name_of_institution,
         --datajson->'data'->>'about_yourself' as about_yourself,
         datajson->'data'->'user_info'->>'ig_handle' as social_user_name,
         datajson->'data'->>'ig_followers' as insta_followers,
         --datajson->'data'->'user_info'->>'other_social' as name_on_card,
         --datajson->'data'->>'reason_of_participation' as reason_of_participation,
         --datajson->'data'->>'media_path' as media_path,
		  ((created_date +'5.5 hours'::interval)::date)::text as created_date
         from lablsg_v1.lablsg_v1_custom_web_json
		 where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 and lower(module_name) = lower('fanarmyrecruitment') ;
         
         
    end if;
    
    if v_opt_type = 11 then
    
    	 open p_user_cursor for
		 
		   
		   select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,
         wu.first_name as first_name,wu.last_name as last_name,wu.email_id as email_id,
         wu.mobile_no as mobile_no,wu.dob as dob,wu.gender as gender,
         wc.name as country1,wu.country_code as country_code,wu.city as city,wu.pincode as pincode,wu.jersey_number as jersey_number,
         wu.jersey_name as name_on_card,
         wu.membership_code as social_user_name,
         wp.entity_name as favourite_player_name,
		 case wua.platform_type when 0 then 'website' when 1 then 'website' else 'app' end as platform_type,
         TO_CHAR(wu.created_date::date, 'yyyy/mm/dd') as created_date,
         TO_CHAR(wu.updated_date::date, 'yyyy/mm/dd') as updated_date,
         case  when created_date=updated_date then 'registered user' when created_date<>updated_date then 'updated user' end as remarks
		 from lablsg_v1.lablsg_v1_web_user wu
		 join lablsg_v1.lablsg_v1_web_user_audit wua on wu.user_guid=wua.user_guid
        left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
         left join waf_master.waf_countries wc on wc.country_id= wu.country_id
		 where   (wu.updated_date::date between v_start_date_time and v_end_date_time
         or wu.created_date::date between v_start_date_time and v_end_date_time)
		 and option_type in (1,2) order by audit_date desc;
end if;
    
end;
$_$;


--
