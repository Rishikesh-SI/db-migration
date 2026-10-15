-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: lablsg_v1_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
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
         ,case wua.platform_type when 0 then 'website' when 1 then 'website' else 'app' end as platform_type
		 from lablsg_v1.lablsg_v1_web_user wu 
         join lablsg_v1.lablsg_v1_web_user_audit wua on wua.user_guid=wu.user_guid
        left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
         left join waf_master.waf_countries wc on wc.country_id= wu.country_id
		 where   wu.created_date::date between v_start_date_time and v_end_date_time 
         and wua.option_type in (1,2)
         ;
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
         left join waf_master.waf_countries wc on wc.phone_code= wu.country_code::numeric
		 where   (wu.updated_date::date between v_start_date_time and v_end_date_time
         or wu.created_date::date between v_start_date_time and v_end_date_time)
		 and option_type in (1,2) order by audit_date desc;
end if;
    if v_opt_type = 12 then
    
    	 open p_user_cursor for
		 select	datajson->'data'->>'academy_region' as academy_name,
		 		datajson->'data'->'user_info'->>'first_name' as first_name,
		 		datajson->'data'->'user_info'->>'last_name' as last_name,
				datajson->'data'->'user_info'->>'email_id' as email,
				datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
				datajson->'data'->'user_info'->>'dob' as dob,
				datajson->'data'->>'country_code' as country_code,
				datajson->'data'->>'state_name' as state,		
				datajson->'data'->'user_info'->>'city' as city,
				datajson->'data'->>'lang' as preferred_languages,
				created_date :: TEXT as created_date
         from lablsg_v1.lablsg_v1_custom_web_json
		 where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 		and lower(module_name) = lower('academy-registration') ;
	end if;
	
		
	     if v_opt_type = 13 then
    
    	 open p_user_cursor for
		 select mobile_no,datajson->'data'->>'module' as module,datajson->'data'->>'day' as day,
		 created_date +'5.5 hours'::interval as created_date,datajson->'data'->>'score' as score,datajson->'data'->>'country_code' as country_code
		 from lablsg_v1.lablsg_v1_custom_web_json
		 where created_date::date between v_start_date_time and v_end_date_time
		 and module_name='quiz';
    end if;
	
		if v_opt_type = 14 then
    
    	 open p_user_cursor for
		 select cw.mobile_no,datajson->'data'->>'module' as module,datajson->'data'->>'day' as day,
		 cw.created_date +'5.5 hours'::interval as created_date,datajson->'data'->>'score' as score,
		 datajson->'data'->>'country_code' as country_code,datajson->'data'->>'player_name' as player_name
         ,wu.address,wu.jersey_name,wu.jersey_number
		 from lablsg_v1.lablsg_v1_custom_web_json cw  
         left join lablsg_v1.lablsg_v1_web_user wu on wu.mobile_no=cw.mobile_no
		 where cw.created_date::date between v_start_date_time and v_end_date_time and
         module_name='predictor';
    end if;

			if v_opt_type = 15 then
		
				select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from lablsg_v1.lablsg_v1_poll_temp;

	
	for i in 
	select poll_option_id,option from lablsg_v1.lablsg_v1_poll_option
	where poll_id = v_poll_id
	loop
	
	
	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;
	
	 raise notice 'v_options %',v_options;
	
	insert into lablsg_v1.lablsg_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	
	delete from lablsg_v1.lablsg_v1_poll_temp_1;
				
				    insert into lablsg_v1.lablsg_v1_poll_temp_1
	                select   user_id::text,question,
					answer_display_value 
					from lablsg_v1.lablsg_v1_user_poll_response pr
					left join lablsg_v1.lablsg_v1_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join lablsg_v1.lablsg_v1_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
	
	
	perform colpivot('data1', $$ select user_id,question,answer_display_value from lablsg_v1.lablsg_v1_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
   --  raise notice '2';

    open p_user_cursor for
	select wu.first_name,wu.last_name,wu.email_id,wu.mobile_no,wu.dob,wu.city,wu.address,a.*,wu.created_date+'5.5hours'::interval as created_date
      from data1 a
	left join lablsg_v1.lablsg_v1_web_user wu on a.user_id::numeric = wu.user_id
    order by wu.created_date;
	end if;	
	
	if v_opt_type = 16 then
    
    	 open p_user_cursor for
		 
		 	select datajson->'data'->'user_info'->>'first_name' as first_name,
		 		datajson->'data'->'user_info'->>'last_name' as last_name,
				datajson->'data'->'user_info'->>'email_id' as email,
				datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
				datajson->'data'->'user_info'->>'city' as city,
				datajson->'data'->'user_info'->>'dob'  as Date_of_Birth,
				(case datajson->'data'->>'interested' when '' then 'General seating' 
				when '1' then 'Hospitality Seating/Corporate Box'
				when '2' then 'Super Hospitality Seating'
				when '3' then 'Season Tickets' 
				else datajson->'data'->>'interested'
				 end) as intrested,
				(created_date +'5.5 hours'::interval)::date as created_date
			from lablsg_v1.lablsg_v1_custom_web_json
			where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 	and lower(module_name) = lower('preRegistration') ;
-- 		 select contact_json->'data'->'user_info'->>'first_name' as first_name,
-- 	 		contact_json->'data'->'user_info'->>'last_name' as last_name,
-- 			contact_json->'data'->'user_info'->>'dob' as dob,
-- 			contact_json->'data'->'user_info'->>'email_id' as email_id,
-- 		 	contact_json->'data'->'user_info'->>'mobile_no' as mobile_no,
-- 		 	contact_json->'data'->'user_info'->>'city' as city,
-- 			contact_json->'data'->'user_info'->>'gender' as gender,
-- -- 		 	contact_json->'data'->>'utm_source' as utm_source,
-- -- 		 	contact_json->'data'->>'utm_campaign' as utm_campaign,
-- -- 		 	contact_json->'data'->>'utm_medium' as utm_medium,
-- 			(created_date + '5.5 hours'::interval) as created_date
-- 		 from lablsg_v1.lablsg_v1_contact 
-- 		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='lsg_ticket_interest_2024' and
--          created_date::date between v_start_date_time and v_end_date_time;
		 end if;

    if v_opt_type = 17 then
    
    	 open p_user_cursor for
         
         select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,
         wu.first_name as first_name,wu.last_name as last_name,wu.email_id as email_id,
		 wu.user_guid as external_peppo_id,
         wu.mobile_no as mobile_no,wu.dob as dob,wu.gender as gender,
         wc.name as country1,wu.country_code as country_code,wu.city as city,
		 wu.pincode as pincode,wu.jersey_number as jersey_number,
         wu.jersey_name as name_on_card,wu.address as address,
         wu.membership_code as social_user_name,
         wp.entity_name as favourite_player_name,
         wu.created_date as created_date
		 from lablsg_v1.lablsg_v1_web_user wu 
        left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
         left join waf_master.waf_countries wc on wc.country_id= wu.country_id
		 where   wu.created_date::date between v_start_date_time and v_end_date_time 
         ;
 	end if;

	if v_opt_type = 18 then
    
    	 open p_user_cursor for
		 	select datajson->'data'->'user_info'->>'first_name' as first_name,
		 		datajson->'data'->'user_info'->>'last_name' as last_name,
				datajson->'data'->'user_info'->>'email_id' as email,
				datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
				datajson->'data'->'user_info'->>'country' as country,
				datajson->'data'->'user_info'->>'state' as state,
				datajson->'data'->'user_info'->>'city' as city,
				datajson->'data'->'user_info'->>'dob'  as Date_of_Birth,
				(created_date +'5.5 hours'::interval)::date as created_date
			from lablsg_v1.lablsg_v1_custom_web_json
			where 
			--(created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time and 
			lower(module_name) = lower('brigade')
			order by 1 desc;

    end if; 

	if v_opt_type = 19 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'email_id' as email_id,
         created_date+'5.5 hours'::interval as created_date
		 from lablsg_v1.lablsg_v1_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and (contact_json->'data'->>'page_flag')::numeric=3;

    end if;
    
    if 	v_opt_type = 20 then

    open p_user_cursor for
    select * from lablsg_v1.lablsg_v1_transaction_logs order by created_date desc limit 50;

    end if;
	
	if v_opt_type = 21 then
	
	     open p_user_cursor for
		 select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,
		 user_guid,
         wu.first_name as first_name,wu.last_name as last_name,wu.email_id as email_id,
         wu.mobile_no as mobile_no,wu.dob as dob,wu.gender as gender,
         wc.name as country1,wu.country_code as country_code,wu.city as city,wu.pincode as pincode,wu.jersey_number as jersey_number,
         wu.jersey_name as name_on_card,wu.address as address,
         wu.membership_code as social_user_name,
         wp.entity_name as favourite_player_name,
         wu.created_date as created_date,
		 subscribe_for_email
		 from lablsg_v1.lablsg_v1_web_user wu 
		 left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
		 left join waf_master.waf_countries wc on wc.country_id= wu.country_id
		 where subscribe_for_email='true';
	
	end if;
	
	
	if v_opt_type = 22 then
	    	 open p_user_cursor for
		 
		 	select custom_id,datajson->'data'->'user_info'->>'first_name' as first_name,
		 		datajson->'data'->'user_info'->>'last_name' as last_name,
				datajson->'data'->'user_info'->>'email_id' as email,
				datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
				datajson->'data'->'user_info'->>'city' as city,
				datajson->'data'->'user_info'->>'dob'  as Date_of_Birth,
				(created_date + '5.5 hours'::interval) as created_date
			from lablsg_v1.lablsg_v1_custom_web_json
			where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time and 
			lower(module_name) = lower('lsgpracticematch') ;
			
		end if;	

	 if v_opt_type = 23 then
    
    	 open p_user_cursor for
		 	select custom_id,
				datajson->'data'->'user_info'->>'first_name' as first_name,
		 		datajson->'data'->'user_info'->>'last_name' as last_name,
				datajson->'data'->'user_info'->>'email_id' as email,
				datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
				datajson->'data'->'user_info'->>'state' as state,
				datajson->'data'->'user_info'->>'city' as city,
				datajson->'data'->'user_info'->>'dob'  as Date_of_Birth,
				datajson->'data'->'demographic_details'->>'city' as demographic_city,
				datajson->'data'->'demographic_details'->>'original_city' as original_city,
				datajson->'data'->'demographic_details'->>'engaged' as engaged,
				(select string_agg(value::text, ',') 
         		from jsonb_array_elements_text(datajson->'data'->'demographic_details'->'social_channel') AS arr(value)) AS social_channel,
				(select string_agg(value::text, ',') 
         		from jsonb_array_elements_text(datajson->'data'->'demographic_details'->'interests') AS arr(value)) AS interests,

				(select case when (datajson->'data'->'opportunity_matrix1'->>'is_selected')::boolean 
               				then (datajson->'data'->'opportunity_matrix1'->>'selected') || ' - ' || (datajson->'data'->'opportunity_matrix1'->>'message')
               				else null end) as opportunity_matrix1,
				(select case when (datajson->'data'->'opportunity_matrix2'->>'is_selected')::boolean 
						   then (datajson->'data'->'opportunity_matrix2'->>'selected') || ' - ' || (datajson->'data'->'opportunity_matrix2'->>'message')
						   else null end) as opportunity_matrix2,
				(select case when (datajson->'data'->'opportunity_matrix3'->>'is_selected')::boolean 
						   then (datajson->'data'->'opportunity_matrix3'->>'selected') || ' - ' || (datajson->'data'->'opportunity_matrix3'->>'message')
						   else null end) as opportunity_matrix3,
				(select case when (datajson->'data'->'opportunity_matrix4'->>'is_selected')::boolean 
						   then (datajson->'data'->'opportunity_matrix4'->>'selected') || ' - ' || (datajson->'data'->'opportunity_matrix4'->>'message')
						   else null end) as opportunity_matrix4,
            created_date +'5.5 hours'::interval as created_date
			from lablsg_v1.lablsg_v1_custom_web_json
			where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 	and lower(module_name) = lower('brigadeform');

    end if;
    
    if v_opt_type = 24 then
    
    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
    
    	 open p_user_cursor for
		 select wpr.mobile_no,wpr.response_date+'5.5hours'::interval as response_date,(po.option::jsonb->>'player')||(case when po.is_ans=1 then '(Correct)' else '(Wrong)' end) as user_opted_answer from 
         lablsg_v1.lablsg_v1_poll_option po
         join lablsg_v1.lablsg_v1_whatsapp_poll_response wpr on wpr.response_option_id=po.poll_option_id
         where po.poll_id=v_poll_id
         order by wpr.response_date;

    end if;

    if v_opt_type = 25 then
    
    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
    
    	 open p_user_cursor for
		 select gallery_id,gallery_type,additional_info,source,video_url,user_info->>'city' as city,
		 user_info->>'name' as name,user_info->>'address' as address,user_info->>'mobile_no' as mobile_no,
		 user_info->>'address' as address,created_date::date as created_date
		 from lablsg_v1.lablsg_v1_gallery
         order by 1 asc;
-- open p_user_cursor for
-- select user_id as "Social ID",mobile_no,email_id,address,jersey_number,jersey_name from lablsg_v1.lablsg_v1_web_user where user_id in (429381,
-- 620421,
-- 59441,
-- 514341,
-- 82401,
-- 615981,
-- 625561,
-- 627901,
-- 537801,
-- 161461,
-- 161441,
-- 595801,
-- 596041,
-- 598741,
-- 521761,
-- 25101,
-- 186421,
-- 217181,
-- 158841,
-- 512201
-- );

    end if;

   if v_opt_type = 26 then
    		--select 1/0;
		
		select p_input_json->'jsondata'->'data' into v_json_data;

		raise notice '%',v_json_data;
		--select 1/0;
        open p_user_cursor for
		
		select mobile_no,email_id,a.user_id,address,jersey_number,jersey_name
		from lablsg_v1.lablsg_v1_web_user a,
		(select user_id from jsonb_to_recordset(v_json_data) as x("user_id" text))b
		where  a.user_id=b.user_id::numeric
		order by created_date desc
		;
	
	end if;

  if v_opt_type = 27 then
    		--select 1/0;
		
		select p_input_json->'jsondata'->'data' into v_json_data;

		raise notice '%',v_json_data;
		--select 1/0;
        open p_user_cursor for
		
		select mobile_no,email_id,a.user_guid--b.*,email_id, created_date,dob,gender,mobile_no,address,jersey_number,jersey_name
		from lablsg_v1.lablsg_v1_web_user a,
		(select user_guid from jsonb_to_recordset(v_json_data) as x("user_guid" text))b
		where  a.user_guid=b.user_guid
		order by created_date desc
		;
	
	end if;

end;
$_$;


--
