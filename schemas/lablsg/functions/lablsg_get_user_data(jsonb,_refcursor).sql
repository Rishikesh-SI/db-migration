-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: lablsg_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: lablsg; Owner: -
--

CREATE FUNCTION lablsg.lablsg_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

/*
select * from lablsg.lablsg_get_user_data
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
          from lablsg.lablsg_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from lablsg.lablsg_web_user wu
          join lablsg.lablsg_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from lablsg.lablsg_web_user wu
          join lablsg.lablsg_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from lablsg.lablsg_web_user wu
          join lablsg.lablsg_asset_comment_reaction acr
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
      		from lablsg.lablsg_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from lablsg.lablsg_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from lablsg.lablsg_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join lablsg.lablsg_asset_list al
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
		 from lablsg.lablsg_web_user wu 
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
		 from lablsg.lablsg_contact 
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
		 from lablsg.lablsg_contact 
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
		 from lablsg.lablsg_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and (contact_json->'data'->>'page_flag')::numeric=3;
    end if;
    
        if v_opt_type = 5 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->>'first_name' as first_name,
         contact_json->'data'->>'last_name' as last_name,
         contact_json->'data'->>'email_id' as email_id,
         contact_json->'data'->>'mobile' as mobile_no,
         contact_json->'data'->>'message' as feedback
		 from lablsg.lablsg_contact 
		 where created_date::date between v_start_date_time and v_end_date_time;
    end if;
 
 
 if v_opt_type = 6 then
    
		select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
 delete from lablsg.lablsg_poll_temp;

	
	for i in 
	select poll_option_id,option from lablsg.lablsg_poll_option
	where poll_id = v_poll_id
	loop

	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;
raise notice 'v_question:%',v_question;
	--raise notice 'v_options%',v_options;
	--raise notice 'v_question%',v_question;
    
	insert into lablsg.lablsg_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
     
     	--raise notice 'v_poll_id %',v_poll_id;
	
	delete from lablsg.lablsg_poll_temp_1;
				
				    insert into lablsg.lablsg_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||'('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from lablsg.lablsg_user_poll_response pr
					left join lablsg.lablsg_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join lablsg.lablsg_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
					
update lablsg.lablsg_poll_temp_1 set user_id = '0' where user_id is null;

			
perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value from lablsg.lablsg_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';

    open p_user_cursor for
	select distinct upr.response_date,wu.first_name,wu.last_name,wu.email_id,wu.dob,wu.mobile_no,ct.name as country_name,city,pincode,address,a.*
      from data1 a
	left join lablsg.lablsg_web_user wu on a.user_id::numeric = wu.user_id
	left join waf_master.waf_countries ct on wu.country_id=ct.country_id
	join lablsg.lablsg_user_poll_response upr on upr.user_id = wu.user_id;
/*
    open p_user_cursor for
	select first_name,last_name,email_id,mobile_no,dob,ct.name as country_name,city,pincode,address,a.*
      from data1 a
	left join lablsg.lablsg_web_user wu on a.user_id::numeric = wu.user_id
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
         from lablsg.lablsg_custom_web_json
		 where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 and lower(module_name) = lower('fanarmyrecruitment') ;
         
         
    end if;
    
    if v_opt_type = 8 then
    
    	 open p_user_cursor for
         
         select case wu.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' when 12 then 'Whatsapp' end as source,
         wu.first_name as first_name,wu.last_name as last_name,wu.email_id as email_id,
         wu.mobile_no as mobile_no,wu.dob as dob,wu.gender as gender,
         wc.name as country1,wu.country_code as country_code,wu.city as city,wu.pincode as pincode,wu.jersey_number as jersey_number,
         wu.jersey_name as name_on_card,wu.address as address,
         wu.membership_code as social_user_name,
         wp.entity_name as favourite_player_name,
         TO_CHAR(wu.created_date::date, 'yyyy/mm/dd') as created_date,
         TO_CHAR(wu.updated_date::date, 'yyyy/mm/dd') as updated_date,
         case  when created_date=updated_date then 'registered user' when created_date<>updated_date then 'updated user' end as remarks
		 from lablsg.lablsg_web_user wu 
        left join waf_master.waf_players wp on wp.source_object_id=wu.favourite_player_id
         left join waf_master.waf_countries wc on wc.country_id= wu.country_id
		 where   wu.updated_date::date between v_start_date_time and v_end_date_time
         or wu.created_date::date between v_start_date_time and v_end_date_time;
 	end if;
	
	
	if v_opt_type = 9 then
	
	   select p_input_json->'jsondata'->'social_id' into v_json_data;

        open p_user_cursor for
		select client_id, social_user_name, user_full_name, 
		email_id, created_date,dob,gender,mobile_no,user_guid,first_name,last_name,updated_date
		from lablsg.lablsg_web_user a,
		jsonb_array_elements_text(v_json_data) as b
		where  a.user_id = b.value::numeric
		order by created_date desc
		;
			
	
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
         --datajson->'data'->>'name_of_instituation' as name_of_instituation,
         --datajson->'data'->>'about_yourself' as about_yourself,
         datajson->'data'->'user_info'->>'ig_handle' as social_user_name,
         datajson->'data'->>'ig_followers' as insta_followers,
         --datajson->'data'->'user_info'->>'other_social' as name_on_card,
         --datajson->'data'->>'reason_of_participation' as reason_of_participation,
         --datajson->'data'->>'media_path' as media_path,
		  ((created_date +'5.5 hours'::interval)::date)::text as created_date
         from lablsg.lablsg_custom_web_json
		 where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 and lower(module_name) = lower('fanarmyrecruitment') ;
         
         
    end if;
 
 	if v_opt_type = 11 then
    
    	 open p_user_cursor for
		 select	datajson->'data'->>'academy_region' as academy_name,
		 		datajson->'data'->'user_info'->>'first_name' as first_name,
		 		datajson->'data'->'user_info'->>'last_name' as last_name,
				datajson->'data'->'user_info'->>'email_id' as email,
				datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
				datajson->'data'->'user_info'->>'dob' as dob,
				--datajson->'data'->>'country_id' as country_id,
				datajson->'data'->>'country_code' as country_code,
				datajson->'data'->>'state_name' as state,		
				datajson->'data'->'user_info'->>'city' as city,
				datajson->'data'->>'lang' as preferred_languages,
				--datajson->'data'->>'module' as module,
				--datajson->'data'->>'captcha' as captcha,
				created_date as created_date
         from lablsg.lablsg_custom_web_json
		 where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 		and lower(module_name) = lower('academy-registration') ;
	end if;
	
	     if v_opt_type = 12 then
    
    	 open p_user_cursor for
		 select mobile_no,datajson->'data'->>'module' as module,datajson->'data'->>'day' as day,
		 created_date +'5.5 hours'::interval as created_date,datajson->'data'->>'score' as score,datajson->'data'->>'country_code' as country_code
		 from lablsg.lablsg_custom_web_json
		 where created_date::date between v_start_date_time and v_end_date_time
		 and module_name='quiz';
    end if;
	
		if v_opt_type = 13 then
    
    	 open p_user_cursor for
		 select mobile_no,datajson->'data'->>'module' as module,datajson->'data'->>'day' as day,
		 created_date +'5.5 hours'::interval as created_date,datajson->'data'->>'score' as score,
		 datajson->'data'->>'country_code' as country_code,datajson->'data'->>'player_name' as player_name
		 from lablsg.lablsg_custom_web_json
		 where created_date::date between v_start_date_time and v_end_date_time
		 and module_name='predictor';
    end if;
		
		if v_opt_type = 14 then
		
				select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from lablsg.lablsg_poll_temp;

	
	for i in 
	select poll_option_id,option from lablsg.lablsg_poll_option
	where poll_id = v_poll_id
	loop
	
	
	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;
	
	 raise notice 'v_options %',v_options;
	
	insert into lablsg.lablsg_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	
	delete from lablsg.lablsg_poll_temp_1;
				
				    insert into lablsg.lablsg_poll_temp_1
	                select   user_id::text,question,
					answer_display_value 
					from lablsg.lablsg_user_poll_response pr
					left join lablsg.lablsg_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join lablsg.lablsg_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
	
	
	perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value from lablsg.lablsg_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
   --  raise notice '2';

    open p_user_cursor for
	select wu.first_name,wu.last_name,wu.email_id,wu.mobile_no,wu.dob,wu.city,wu.address,a.*,wu.created_date
      from data1 a
	left join lablsg.lablsg_web_user wu on a.user_id::numeric = wu.user_id;
	end if;	 
	
	if v_opt_type = 15 then
    
    	 open p_user_cursor for
		 select contact_json->'data'->'user_info'->>'email_id' as email_id,
         created_date+'5.5 hours'::interval as created_date
		 from lablsg.lablsg_contact 
		 where created_date::date between v_start_date_time and v_end_date_time and (contact_json->'data'->>'page_flag')::numeric=3;

    end if;
	
	if v_opt_type = 16 then
    
    	 open p_user_cursor for
		 select pr.user_id,wu.first_name,wu.last_name,wu.email_id,po.option::json->>'player' player
		 from lablsg.lablsg_user_poll_response pr 
		 join lablsg.lablsg_poll_option po on pr.response_option_id=po.poll_option_id
		 join lablsg.lablsg_web_user wu using(user_id)
		 where pr.response_date::date between v_start_date_time and v_end_date_time and pr.poll_id=461;

    end if;
	
	if v_opt_type = 17 then
    
    	 open p_user_cursor for
		 	select datajson->'data'->'user_info'->>'first_name' as first_name,
		 		datajson->'data'->'user_info'->>'last_name' as last_name,
				datajson->'data'->'user_info'->>'email_id' as email,
				datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
				datajson->'data'->'user_info'->>'country' as country,
				datajson->'data'->'user_info'->>'state' as state,
				datajson->'data'->'user_info'->>'city' as city,
				datajson->'data'->'user_info'->>'date_of_birth'  as Date_of_Birth,
                datajson
			from lablsg.lablsg_custom_web_json
			where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 	and lower(module_name) = lower('brigade');

    end if;
	
	 if v_opt_type = 18 then
    
    	 open p_user_cursor for
		 
		 	select custom_id,datajson->'data'->'user_info'->>'first_name' as first_name,
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
				 end) as intrested
			from lablsg.lablsg_custom_web_json
			where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time and 
			lower(module_name) = lower('preregistration') ;
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
-- 		 from lablsg.lablsg_contact 
-- 		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='lsg_ticket_interest_2024' and
--          created_date::date between v_start_date_time and v_end_date_time;
		 end if;

        if v_opt_type =20 then

        open p_user_cursor for
        select * from lablsg.lablsg_transaction_logs order by created_date desc limit 200;

        end if;
		
		
		if v_opt_type =21 then

        open p_user_cursor for
        select first_name, last_name , email_id , mobile_no, created_date :: date , user_guid "external peppo ID", city,country,pincode
		from lablsg.lablsg_web_user;
		end if;
		
		
		if v_opt_type = 22 then

	
	select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from lablsg.lablsg_poll_temp;

	
	for i in 
	select poll_option_id,option from lablsg.lablsg_poll_option
	where poll_id = v_poll_id
	loop

		select options into v_options from (
	select b->'options' as options from (
	select b
	from json_array_elements((i.option)::json->'questions') b)as a )c
	where options is not null ;

	select question_text into v_question from (
	select b->>'question_text' as question_text from (
	select b
	from json_array_elements((i.option)::json->'questions') b)as a )c
	where question_text is not null ;

	insert into lablsg.lablsg_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	                delete from lablsg.lablsg_poll_temp_1;
				
				    insert into lablsg.lablsg_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from lablsg.lablsg_user_poll_response pr
					left join lablsg.lablsg_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join lablsg.lablsg_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
	
	perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value from lablsg.lablsg_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';

    open p_user_cursor for
	select first_name,last_name,email_id,dob,a.*,tab.score
      from data1 a
	left join lablsg.lablsg_web_user wu on a.user_id::numeric = wu.user_id
	left join (select user_id,sum(score) as score from
					(select distinct user_id,question,
					answer_display_value,case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 1 else 0 end as score
					from lablsg.lablsg_user_poll_response pr
					left join lablsg.lablsg_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join lablsg.lablsg_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id 
					order by 1 desc) a
					group by 1
					order by 2 desc) tab on a.user_id::numeric = tab.user_id 
	order by tab.score desc	;

	end if;
	
	
		if v_opt_type = 23 then
    
    	 open p_user_cursor for
		 
		 	select custom_id,datajson->'data'->'user_info'->>'first_name' as first_name,
		 		datajson->'data'->'user_info'->>'last_name' as last_name,
				datajson->'data'->'user_info'->>'email_id' as email,
				datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
				datajson->'data'->'user_info'->>'city' as city,
				datajson->'data'->'user_info'->>'dob'  as Date_of_Birth,
				(created_date + '5.5 hours'::interval) as created_date
			from lablsg.lablsg_custom_web_json
			where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time and 
			lower(module_name) = lower('lsgpracticematch') ;
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
-- 		 from lablsg.lablsg_contact 
-- 		 where page_flag = 10 and (contact_json->'data'->>'campaign_name')='lsg_ticket_interest_2024' and
--          created_date::date between v_start_date_time and v_end_date_time;
		 end if;
		 
		 if v_opt_type = 24 then
    
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
						   else null end) as opportunity_matrix4
			from lablsg.lablsg_custom_web_json
			where (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 
		 	and lower(module_name) = lower('brigadeform');

    end if;
	
	if v_opt_type = 25 then

    select p_input_json->'jsondata'->>'poll_id' into v_poll_id;
	
   delete from lablsg.lablsg_poll_temp;
	--raise notice '1';

	
	for i in 
	select poll_option_id,option from lablsg.lablsg_poll_option
	where poll_id = v_poll_id and is_active=1 and is_deleted=0
	loop
    
	--raise notice 'option %',i.option;
    
		select options into v_options from (
	select b->'options' as options from (
	select b
	from json_array_elements((i.option)::json->'questions') b)as a )c
	where options is not null ;

	select question_text into v_question from (
	select b->>'question_text' as question_text from (
	select b
	from json_array_elements((i.option)::json->'questions') b)as a )c
	where question_text is not null ;

        --raise notice 'v_question %',v_question;

	insert into lablsg.lablsg_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);
	end loop;
	                delete from lablsg.lablsg_poll_temp_1;
				
	
				    insert into lablsg.lablsg_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from lablsg.lablsg_user_poll_response pr
					left join lablsg.lablsg_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join lablsg.lablsg_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id --and pr.response_option_id <> 1142
					order by 1,2;
	
	perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value from lablsg.lablsg_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');

    open p_user_cursor for
	select first_name,last_name,email_id,dob,a.*,ab.response_date+'5.5hours'::interval as response_date
      from data1 a
	left join lablsg.lablsg_web_user wu on a.user_id::numeric = wu.user_id
    join (select response_date,user_id from lablsg.lablsg_user_poll_response where poll_id=v_poll_id group by response_date,user_id,poll_id) 
    ab on ab.user_id=wu.user_id;

 end if;
		
	
end;

$_$;


--
