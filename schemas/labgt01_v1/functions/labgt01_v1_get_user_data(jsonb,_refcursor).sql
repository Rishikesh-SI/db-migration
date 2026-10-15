-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labgt01_v1_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
/*
select * from labgt01_v1.labgt01_v1_get_user_data
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
	i record;
	v_options json;
	v_question text;
	v_opt_type_1 numeric;
    v_map_id numeric;
    v_json_data jsonb;
    v_option numeric;
    v_module_name character varying;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time;
    v_end_date_time := v_end_date_time;

 if v_opt_type = 1 then 
 open p_user_cursor for
   select case a.client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source, 
  a.first_name,user_id as CustomerId, a.last_name,a.email_id, a.dob, a.mobile_no, a.gender,a.city,a.pincode,f.entity_name as favourite_player_name,b.name as country,a.is_verified,(a.created_date +'5.5 hours'::interval) as created_date,
  a.subscribe_for_email,a.user_guid,a.updated_date +'5.5 hours'::interval as updated_date
  from labgt01_v1.labgt01_v1_web_user a  
  left join waf_master.waf_countries b on a.country_id=b.country_id
  left join waf_master.waf_players f on a.favourite_player_id=f.source_object_id
  where (updated_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
  order by created_date desc;
   end if; 

/*

  
 open p_user_cursor for
 select * from labgt01_v1.labgt01_v1_nilesh;

 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from(select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labgt01_v1.labgt01_v1_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labgt01_v1.labgt01_v1_web_user wu
          join labgt01_v1.labgt01_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labgt01_v1.labgt01_v1_web_user wu
          join labgt01_v1.labgt01_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labgt01_v1.labgt01_v1_web_user wu
          join labgt01_v1.labgt01_v1_asset_comment_reaction acr
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
      		from labgt01_v1.labgt01_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labgt01_v1.labgt01_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labgt01_v1.labgt01_v1_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labgt01_v1.labgt01_v1_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
	
*/

if v_opt_type = 2 then 
  open p_user_cursor for
select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source, 
first_name, last_name,
    			 email_id, dob, mobile_no, gender,city,pincode,favourite_player_id,d.name as country,country_code,is_verified,(created_date at time zone 'utc' at time zone 'Asia/Calcutta') as created_date,
				 subscribe_for_email,tab.user_guid,case wu.platform_type when 0 then 'website' when 1 then 'website' else 'app' end as platform_type,wu.platform_version,wu.device_name
                 --,coalesce(c.platform_type,'Web')
    from (select client_id, first_name, last_name, email_id, dob, user_guid,mobile_no,gender,city,pincode,favourite_player_id,country_id,is_verified,created_date,subscribe_for_email,country_code
          from labgt01_v1.labgt01_v1_web_user a
           where created_date between v_start_date_time and v_end_date_time)as tab
   			--left join waf_master.waf_players f 
			--on tab.favourite_player_id=f.source_object_id
			left join waf_master.waf_countries d on tab.country_id=d.country_id
            join labgt01_v1.labgt01_v1_web_user_audit wu on wu.user_guid=tab.user_guid
           where option_type in (1,2) order by audit_date desc;
			/*left join (select user_guid,case platform_type when 1 then 'web'
					   when 2 then 'Android'
					   when 3 then 'IOS'
					   else 'web' end as platform_type
					   from (select user_guid,platform_type,
							 row_number()over (partition by user_id order by user_id,audit_date) as rno 
							 from labgt01_v1.labgt01_v1_web_user_audit where platform_type is not null ) row
					   where rno = 1 and user_guid is not null) c on c.user_guid = tab.user_guid;	*/	  
end if;

if v_opt_type = 3 then 
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'club_name' as club_name ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'
  from labgt01_v1.labgt01_v1_custom_web_json a
  join labgt01_v1.labgt01_v1_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='fanclub';
  
  end if;
  
  if v_opt_type = 4 then 
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'player_name' as player_name ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'
  from labgt01_v1.labgt01_v1_custom_web_json a
  join labgt01_v1.labgt01_v1_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='playerofthematch';

end if;

  if v_opt_type = 5 then 
  
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,
  a.datajson->'data'->>'msg' as msg ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta',
  b.pincode,b.city,b.mobile_no,d.name as country
  from labgt01_v1.labgt01_v1_custom_web_json a
  left join labgt01_v1.labgt01_v1_web_user b
  left join waf_master.waf_countries d 
	on b.country_id=d.country_id
  on a.user_guid=b.user_guid
  where (a.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
  and a.module_name='fanticket';

end if;

  if v_opt_type = 6 then 
  
  select p_input_json->'jsondata'->'poll_id' into v_poll_id;
   --v_poll_id:=81; 
  open p_user_cursor for
	select a.first_name,a.last_name,a.email_id,a.mobile_no,(c.option)::json->>'pid' as pid,(c.option)::json->>'player' as player_name,
	b.response_date at time zone 'utc' at time zone 'Asia/Calcutta' as vote_time
	from labgt01_v1.labgt01_v1_web_user a
	join labgt01_v1.labgt01_v1_user_poll_response b
	on a.user_id=b.user_id
	join labgt01_v1.labgt01_v1_poll_option c
	on b.poll_id=c.poll_id
	and c.poll_option_id = b.response_option_id
	where --(b.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
	 c.poll_id=v_poll_id
	and b.poll_id=v_poll_id;

end if;
 if v_opt_type = 7 then 
  
   --v_poll_id:=81; 
  open p_user_cursor for
  select name as user_full_name,email_address as email_id,feedback as message
  from labgt01_v1.labgt01_v1_contact
  where (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time;
  	
  
 end if;  
 
 
 if v_opt_type = 8 then 
 
  
 
 select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labgt01_v1.labgt01_v1_poll_temp;

	
	for i in 
	select poll_option_id,option from labgt01_v1.labgt01_v1_poll_option
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
	
	

	insert into labgt01_v1.labgt01_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	                delete from labgt01_v1.labgt01_v1_poll_temp_1;
					
				
				
				    insert into labgt01_v1.labgt01_v1_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||'('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')',pr.response_date::date
					from labgt01_v1.labgt01_v1_user_poll_response pr
					left join labgt01_v1.labgt01_v1_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labgt01_v1.labgt01_v1_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id and question is not null and answer_display_value is not null
					order by 1,2;
	
	perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value,response_date from labgt01_v1.labgt01_v1_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   

    open p_user_cursor for
	select first_name,last_name,email_id,mobile_no,dob,a.*,b.response_date
      from data1 a
	left join labgt01_v1.labgt01_v1_web_user wu on a.user_id::numeric = wu.user_id
	inner join (select distinct user_id,response_date from labgt01_v1.labgt01_v1_poll_temp_1) b on a.user_id::numeric=b.user_id::numeric ;

 
 end if;

  if v_opt_type = 9 then 
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'player_name' as player_name ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'
  from labgt01_v1.labgt01_v1_custom_web_json a
  join labgt01_v1.labgt01_v1_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='virtualplayermeet';

end if;
  if v_opt_type = 10 then 
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'field_1' as department ,a.datajson->'data'->>'field_2' as answer_here ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'  as created_date 
  from labgt01_v1.labgt01_v1_custom_web_json a
  join labgt01_v1.labgt01_v1_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='fantership';

end if;

  if v_opt_type = 11 then 
  open p_user_cursor for
  select a.client_id, a.user_full_name,b.option_type, a.email_id, b.platform_version,b.platform_type,b.device_name,a.created_date::date
  from labgt01_v1.labgt01_v1_web_user a
  left join labgt01_v1.labgt01_v1_web_user_audit b
  on a.user_id=b.user_id and b.user_id is not null
  where b.audit_date::date between v_start_date_time and v_end_date_time;
  end if;

 if v_opt_type = 12 then   
 
 select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labgt01_v1.labgt01_v1_poll_temp;

	
	for i in 
	select poll_option_id,option from labgt01_v1.labgt01_v1_poll_option
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
	
	

	insert into labgt01_v1.labgt01_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	                delete from labgt01_v1.labgt01_v1_poll_temp_1;
					
				
				
				    insert into labgt01_v1.labgt01_v1_poll_temp_1
	                select   user_id::text,question,
					answer_display_value,pr.response_date::date
					from labgt01_v1.labgt01_v1_user_poll_response pr
					left join labgt01_v1.labgt01_v1_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labgt01_v1.labgt01_v1_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id and question is not null and answer_display_value is not null
					order by 1,2;
	
	perform siwaf.colpivot('data1', $$ select user_id,question,answer_display_value,response_date from labgt01_v1.labgt01_v1_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   

    open p_user_cursor for
	select first_name,last_name,email_id,mobile_no,dob,a.*,b.response_date--,count(a.answer_display_value)
      from data1 a
	left join labgt01_v1.labgt01_v1_web_user wu on a.user_id::numeric = wu.user_id
	inner join (select distinct user_id,response_date from labgt01_v1.labgt01_v1_poll_temp_1) b on a.user_id::numeric=b.user_id::numeric ;

 
 end if;

if v_opt_type = 13 then  
    	 open p_user_cursor for
		 select email_id ,count(1),client_id from labgt01_v1.labgt01_v1_Web_user
		 where email_id in (
		 select email_id from labgt01_v1.labgt01_v1_Web_user where email_id is not null 
         group by email_id having count(email_id) > 1)
		 group by email_id,client_id;
end if;

if v_opt_type = 14 then
    
    	 open p_user_cursor for
		 select user_guid ,first_name , last_name ,mobile_no ,
         email_id ,gender ,dob ,city,membership_code as name_on_card 
		 from labgt01_v1.labgt01_v1_web_user where is_deleted=0 and is_active=1; 
 	end if;
    
    if v_opt_type = 15 then
    
    	 open p_user_cursor for
		 select user_guid ,first_name , last_name ,mobile_no ,
         email_id ,gender ,dob ,city 
		 from labgt01_v1.labgt01_v1_web_user where is_deleted=1 and is_active=0; 
 	end if;

    if v_opt_type = 16 then
    
    	 open p_user_cursor for
		 select user_guid ,first_name , last_name ,mobile_no ,
         email_id ,gender ,dob ,city,membership_code as name_on_card,created_date 
		 from labgt01_v1.labgt01_v1_web_user where user_id in 
         (select user_id from labgt01_v1.labgt01_v1_web_user_audit where option_type=12); 
 	end if;
    
     if v_opt_type = 17 then
    
    	 open p_user_cursor for
		  select user_guid ,first_name , last_name ,mobile_no ,
         email_id ,gender ,dob ,city,membership_code as name_on_card,error 
		 from labgt01_v1.labgt01_v1_web_user where user_guid in 
         (select user_guid from labgt01_v1.labgt01_v1_transaction_logs where method = 'SIGN_UP'
          and eventtype='Create' and status='false');
 	end if;

     if v_opt_type = 18 then
	  open p_user_cursor for
	 select user_guid from labgt01_v1.labgt01_v1_web_user where client_id=2 and email_id is null;
	 
	 end if;

     if v_opt_type = 19 then
	  open p_user_cursor for
	 select user_guid,email_id,first_name,last_name,mobile_no from labgt01_v1.labgt01_v1_web_user where client_id=2 and email_id is not null ;	 
	 end if;

     
     if v_opt_type = 20 then 
  open p_user_cursor for
select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' when 9 then 'Apple' end as source,
                 tab.user_id as CustomerId,first_name, last_name,
    			 email_id, dob, mobile_no, gender,city,pincode,f.entity_name as favourite_player_name,d.name as country,is_verified,tab.created_date+'5.5 hours'::interval as created_date,
				 subscribe_for_email,tab.user_guid, wu.platform_type,tab.updated_date +'5.5 hours'::interval as updated_date
    from (select client_id,user_id, first_name, last_name, email_id, dob, mobile_no,gender,city,pincode,favourite_player_id,country_id,is_verified,created_date,subscribe_for_email,user_guid,updated_date
          from labgt01_v1.labgt01_v1_web_user a
           where (a.updated_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time)as tab
   			left join waf_master.waf_players f 
			on tab.favourite_player_id=f.source_object_id
			left join waf_master.waf_countries d 
			on tab.country_id=d.country_id
            --left join (select user_guid,platform_type
			--		   from (select user_guid,platform_type,
			--				 row_number()over (partition by user_id order by user_id,audit_date) as rno 
			--				 from labgt01_v1.labgt01_v1_web_user_audit where platform_type is not null order by audit_date desc ) row
			--		   where rno = 1 and user_guid is not null ) c on c.user_guid = tab.user_guid 
            --           order by created_date desc;
            left join labgt01_v1.labgt01_v1_web_user_audit wu on wu.user_guid=tab.user_guid
           where option_type in (1,2) order by audit_date desc;		  
end if;

			if v_opt_type = 21 then 

	open p_user_cursor for
	select user_info->>'city' as city,
		user_info->>'name' as name,
		user_info->>'address' as address,
		user_info->>'mobile_no' as mobile_no,
		'https://www.gujarattitansipl.com/static-assets/'||gallery_path||'/'||gallery_name as path,
        created_date
    from labgt01_v1.labgt01_v1_gallery;

	end if;
    
    if v_opt_type= 22 then
    open p_user_cursor for
    select al.asset_id as content_id,CONCAT(em.canonical_url,'/',al.title_alias) as content_slug,al.asset_type_id as content_type_id,
case when al.asset_type_id=1 then 'Article'
when al.asset_type_id=2 then 'Photos'
when al.asset_type_id=4 then 'Video'
end as content_type_name,em.entity_name as category_name,em.canonical_url as category_canonical_url,tab.tagged_entity as content_entity_tags,
TO_CHAR(al.published_date,'yyyymmdd') as content_published_date,tab.player_source_object_id as players_source_object_id 
from labgt01_v1.labgt01_v1_asset_list al
join
(SELECT asset_id,asset_type_id, coalesce (string_agg(distinct((select entity_name from labgt01_v1.labgt01_v1_entity_master where entity_master_id in (select entity_master_id from labgt01_v1.labgt01_v1_entity_role_map where entity_role_map_id=tagged_entity_id::numeric) )), ','),null) as tagged_entity,
string_agg(distinct((select source_object_id from labgt01_v1.labgt01_v1_entity_role_map where entity_role_map_id=tagged_entity_id::numeric and entity_role_id=181)), ',') as player_source_object_id
            FROM labgt01_v1.labgt01_v1_asset_list al1
           LEFT JOIN LATERAL unnest(tagged_entity) AS tagged_entity_id ON TRUE
             where asset_type_id in (1,2,4)
            group by tagged_entity,asset_id,asset_type_id)tab
      on tab.asset_id=al.asset_id and tab.asset_type_id=al.asset_type_id
      
     left join labgt01_v1.labgt01_v1_entity_role_map erm on erm.entity_role_map_id=al.secondary_entity_role_map_id
     left join labgt01_v1.labgt01_v1_entity_master em on em.entity_master_id=erm.entity_master_id
     left join labgt01_v1.labgt01_v1_entity_role_map erm1 on erm1.entity_role_map_id=al.primary_entity_role_map_id
     left join labgt01_v1.labgt01_v1_entity_master em1 on em1.entity_master_id=erm1.entity_master_id
       where al.asset_type_id in (1,2,4) and al.title_alias != '' and al.is_published=1 and  
       al.is_trashed=0
       order by al.updated_date desc;
    
    end if;
    
    if v_opt_type= 23 then
    open p_user_cursor for
    select al.asset_id as content_id, CONCAT(em.canonical_url,'/',al.title_alias) as content_slug,al.asset_type_id as content_type_id,
case when al.asset_type_id=1 then 'Article'
when al.asset_type_id=2 then 'Photos'
when al.asset_type_id=4 then 'Video'
end as content_type_name,em.entity_name as category_name,em.canonical_url as category_canonical_url,tab.tagged_entity as content_entity_tags,
TO_CHAR(al.published_date,'yyyymmdd') as content_published_date,tab.player_source_object_id as players_source_object_id 
from labgt01_v1.labgt01_v1_asset_list al
join
(SELECT asset_id,asset_type_id, coalesce (string_agg(distinct((select entity_name from labgt01_v1.labgt01_v1_entity_master where entity_master_id in (select entity_master_id from labgt01_v1.labgt01_v1_entity_role_map where entity_role_map_id=tagged_entity_id::numeric) )), ','),null) as tagged_entity,
string_agg(distinct((select source_object_id from labgt01_v1.labgt01_v1_entity_role_map where entity_role_map_id=tagged_entity_id::numeric and entity_role_id=181)), ',') as player_source_object_id
            FROM labgt01_v1.labgt01_v1_asset_list al1
           LEFT JOIN LATERAL unnest(tagged_entity) AS tagged_entity_id ON TRUE
             where asset_type_id in (1,2,4)
            group by tagged_entity,asset_id,asset_type_id)tab
      on tab.asset_id=al.asset_id and tab.asset_type_id=al.asset_type_id
      
     left join labgt01_v1.labgt01_v1_entity_role_map erm on erm.entity_role_map_id=al.secondary_entity_role_map_id
     left join labgt01_v1.labgt01_v1_entity_master em on em.entity_master_id=erm.entity_master_id
     left join labgt01_v1.labgt01_v1_entity_role_map erm1 on erm1.entity_role_map_id=al.primary_entity_role_map_id
     left join labgt01_v1.labgt01_v1_entity_master em1 on em1.entity_master_id=erm1.entity_master_id
       where al.updated_date between v_start_date_time and v_end_date_time and
       al.asset_type_id in (1,2,4) and al.title_alias != '' and al.is_published=1 and  
       al.is_trashed=0 order by al.updated_date desc;
    
    end if;

/*	if v_opt_type = 22 then 

	open p_user_cursor for
	select user_id,client_id as source_id ,first_name,last_name,gender,city,wc.name,email_id,
	is_verified as is_email_verified,mobile_no as phone,mobile_verified as is_phone_verified,favourite_player_id,
	case when first_name is not null and last_name is not null and email_id is not null then 'Yes' 
	ELSE 'No' 
	end as is_profile_complete , created_date as registered_date
    from labgt01_v1.labgt01_v1_web_user wu
	left join waf_master.waf_countries wc
	on wc.country_id = wu.country_id
	order by created_date desc;

	end if; */
    if v_opt_type= 24 then
    open p_user_cursor for
    select first_name,last_name,email_id,user_guid,country_code,mobile_no,dob,b.name as country,city,pincode,f.entity_name as favourite_player_name,gender,
    jersey_name,jersey_number,subscribe_for_email,(case when client_id in (2,4,9) and email_id is not null then 1 
												  when client_id = 5 then email_verified end) as is_email_verified, 
	(case when first_name is not null and last_name is not null and email_id is not null then 'YES' else 'NO' end) as is_profile_complete,
	created_date as registered_date
    from labgt01_v1.labgt01_v1_web_user a
    left join waf_master.waf_players f on a.favourite_player_id=f.source_object_id
    left join waf_master.waf_countries b on a.country_id=b.country_id
    where a.updated_date::date between v_start_date_time and v_end_date_time
    order by a.created_date desc;
    end if;

	if v_opt_type= 25 then
    open p_user_cursor for
    	select p.poll_id,wu.user_guid,TO_CHAR(upr.response_date,'yyyymmdd') as date_key,1 as attempt_count,(case when is_quiz = 0 or is_quiz is null then 
																	(case when p.no_of_ans_allowed = upr1.cnt then 1 else 0 end) 
																   when is_quiz = 1 then -1 end )as complete_status,
		case when is_quiz = 1 then 3 else 4 end as game_id,p.no_of_ans_allowed as no_of_ans_allowed,upr1.cnt as user_voted_count														   
		from labgt01_v1.labgt01_v1_poll p
		join (select DISTINCT(user_id),max(response_date) as response_date,avg(gaming_minutes) as gaming_minutes, poll_id 
			  from labgt01_v1.labgt01_v1_user_poll_response
			 group by user_id,poll_id)upr 
		on upr.poll_id=p.poll_id
		join labgt01_v1.labgt01_v1_web_user wu
		on wu.user_id = upr.user_id
		join (select count(user_poll_response_id) as cnt,poll_id,user_id from labgt01_v1.labgt01_v1_user_poll_response up
		-- 	  join labgt01_v1.labgt01_v1_poll po
		-- 	  on up.poll_id = p.poll_id
			 group by poll_id,user_id)upr1
		on upr1.poll_id = p.poll_id
		and upr1.user_id=wu.user_id
		where p.no_of_ans_allowed >= cnt;
    end if;
	
	if v_opt_type = 26 then 
  open p_user_cursor for
  select datajson->'data'->'user_info'->>'first_name' as first_name , 
  		 datajson->'data'->'user_info'->>'last_name' as  last_name ,
-- 		 datajson->'data'->'user_info'->>'email_id'	as email_id,
		 datajson->'data'->>'message' as message,
		 (created_date +'5.5 hours'::interval)::date as created_date
  from labgt01_v1.labgt01_v1_custom_web_json
  where module_name = 'uttarayan'
  and (created_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time;

-- select wj.datajson->'data'->'user_info'->>'email_id' as email_id,
-- wu.mobile_no,
-- wj.datajson->'data'->>'message' as message
-- from labgt01_v1.labgt01_v1_custom_web_json wj
-- join labgt01_v1.labgt01_v1_web_user wu on wj.datajson->'data'->'user_info'->>'email_id'=wu.email_id
-- where wj.module_name = 'uttarayan' and wj.datajson->'data'->>'message' in ('Jem Chikki ne Laadu Ane Firki ne Patang
-- Evo J Rishto Che GT no Trophy Ni Sang !!!! 🏆❤️',
--      'Century Marse Gill,
-- E dheel de Dheel',
--       'Titans ki patang dekh kar pagal ho gaya mohalla !  
-- Ipl 2024 me Titans machayegi Halla !  🏏    #aavade ❤️');
  
  end if;

	if v_opt_type = 27 then 
  open p_user_cursor for
--   select case when p.is_quiz=1 then count(DISTINCT(upr.poll_id)) else count(DISTINCT(upr.poll_id)) end as count,
--   case when p.is_quiz=1 then 'QUIZ' else 'POLL' end as type,p.is_quiz AS TYPE
--   from labgt01_v1.labgt01_v1_user_poll_response upr
--   join (select poll_id,case when is_quiz = 1 then 1 
-- 					   				when is_quiz is null then 0
-- 									when is_quiz = 0 then 0
-- 					   				end as is_quiz
-- 	   from labgt01_v1.labgt01_v1_poll) p
--   on p.poll_id = upr.poll_id
--   where response_date::date between v_start_date_time and v_end_date_time
--   group by is_quiz
--   ;
select case when is_quiz = 1 then 'QUIZ' 
					   				when is_quiz is null then 'POLL'
									when is_quiz = 0 then 'POLL'
					   				end as type,
  count(upr.*) as count
  from labgt01_v1.labgt01_v1_poll p
  join
  (select distinct(poll_id) from labgt01_v1.labgt01_v1_user_poll_response 
   where response_date::date between v_start_date_time and v_end_date_time group by poll_id) upr 
  on upr.poll_id =p.poll_id
  group by "type";
    
  
  end if;

if v_opt_type = 28 then 
  open p_user_cursor for
  select datajson->'data'->>'user_guid' as "user guid",
  		 datajson->'data'->'user_info'->>'child_full_name' as "child full name" , 
  		 datajson->'data'->'user_info'->>'mobile_no'  as mobile_no,
		 datajson->'data'->'user_info'->>'school_name' as school_name,
		 datajson->'data'->'user_info'->>'child_dob' as child_DOB,
		 datajson->'data'->'user_info'->>'city'      as city,
		 abc.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date
-- 		 wu.email_id as "email id"
  from labgt01_v1.labgt01_v1_custom_web_json abc
--   left join labgt01_v1.labgt01_v1_web_user wu
--   using(user_guid)
  where module_name = 'waiverform';
  
end if;
if v_opt_type = 29 then 
open p_user_cursor for
select page_id as content_id,alias as content_slug,
asset_type_id as content_type_id,'Static Page' as content_type_name,
'English' as content_entity_tags,
TO_CHAR(updated_date,'yyyymmdd') as content_published_date from
labgt01_v1.labgt01_v1_page
where asset_type_id=38 and is_published=1 and is_active=1;
end if;

if v_opt_type = 30 then 

open p_user_cursor for
select Distinct(mobile_no),case when country_code is null then '91' else country_code end as country_code 
from labgt01_v1.labgt01_v1_web_user  where mobile_no is not null group by mobile_no,country_code; 

end if;

if v_opt_type = 31 then 

open p_user_cursor for
select ID,first_name,last_name,email,email_verified,mobile,mobile_verified,waf_user_guid,country_code,country_name,city,
pincode,gender,dob,favourite_player_name,jersey_name,jersey_number,created_date,updated_date,subscribe_for_email,accept_tnc,accept_disclaimer 
from (select user_id as ID,first_name,last_name,email_id as email,coalesce(email_verified,0) as email_verified,mobile_no as mobile,coalesce(mobile_verified,0) as mobile_verified,user_guid as waf_user_guid,country_code,city,
pincode,gender,w.dob as dob,jersey_name,jersey_number,created_date,updated_date,case when subscribe_for_email is null then 'false' else subscribe_for_email end as subscribe_for_email
      ,'True' as accept_tnc,'True' as accept_disclaimer
      ,c.name as country_name,b.entity_display_name as favourite_player_name,ROW_NUMBER() OVER( PARTITION BY mobile_no
        ORDER BY updated_date desc ) AS row_num
from labgt01_v1.labgt01_v1_web_user w
left join waf_master.waf_players b
on w.favourite_player_id=b.source_object_id 
left join waf_master.waf_countries c
on c.country_id = w.country_id
where mobile_no is not null order by created_date desc) sub where  row_num=1 limit 5000;
 --and (updated_date +'5.5 hours'::interval)::date between v_start_date_time and v_end_date_time 

end if;

if v_opt_type = 32 then 

open p_user_cursor for
-- Select email_id,subscribe_for_email from labgt01_v1.labgt01_v1_web_user where subscribe_for_email='True'
-- and email_id is not null and is_active=1;

-- select distinct(email_id) as email
-- from labgt01_v1.labgt01_v1_web_user where subscribe_for_email=true
-- and email_id is not null and is_active=1 and ( client_id in (2,4,9) or (client_id=5 and is_verified=1));

select user_guid,coalesce(country_code,'91') as country_code,mobile_no from labgt01_v1.labgt01_v1_web_user;

end if;

if v_opt_type = 33 then 

-- select ID,first_name,last_name,email,email_verified,mobile,mobile_verified,waf_user_guid,country_code,country_name,city,
-- pincode,gender,dob,favourite_player_name,jersey_name,jersey_number,created_date,updated_date,subscribe_for_email,accept_tnc,accept_disclaimer 
-- from (select user_id as ID,first_name,last_name,email_id as email,coalesce(email_verified,0) as email_verified,mobile_no as mobile,coalesce(mobile_verified,0) as mobile_verified,user_guid as waf_user_guid,country_code,city,
-- pincode,gender,w.dob as dob,jersey_name,jersey_number,created_date,updated_date,case when subscribe_for_email is null then 'false' else subscribe_for_email end as subscribe_for_email
--       ,'True' as accept_tnc,'True' as accept_disclaimer
--       ,c.name as country_name,b.entity_display_name as favourite_player_name
-- from labgt01_v1.labgt01_v1_web_user w
-- left join waf_master.waf_players b
-- on w.favourite_player_id=b.source_object_id 
-- left join waf_master.waf_countries c
-- on c.country_id = w.country_id
-- where mobile_no is null and email_id is not null order by created_date desc) sub limit 5000;
-----------------------------------------------------------------------
open p_user_cursor for
/*select --case platform_type when 0 then 'WEB' when 1 then 'WEB' else 'APP' end
'NA' as source,
ID,coalesce(first_name,'NA') as first_name,coalesce(last_name,'NA') as last_name,
coalesce(email,'NA') as email,coalesce(email_verified,0) as email_verified,coalesce(mobile,'NA') as mobile,coalesce(mobile_verified,0) as mobile_verified,waf_user_guid,coalesce(country_code,'91') as country_code,coalesce(country_name,'NA') as country_name
,coalesce(city,'NA') as city,coalesce(pincode,'NA') as pincode ,coalesce(gender,'NA') as gender,coalesce(dob,'NA') as dob,coalesce(favourite_player_name,'NA') as favourite_player_name,
coalesce(jersey_name,'NA') as jersey_name,coalesce(jersey_number,0) as jersey_number,created_date,updated_date,subscribe_for_email,accept_tnc,accept_disclaimer 
from (select --wu.platform_type,
w.user_id as ID,first_name,last_name,email_id as email,coalesce(email_verified,0) as email_verified,mobile_no as mobile,coalesce(mobile_verified,0) as mobile_verified,w.user_guid as waf_user_guid,country_code,city,
pincode,gender,w.dob as dob,jersey_name,jersey_number,created_date,updated_date,case when subscribe_for_email is null then 'false' else subscribe_for_email end as subscribe_for_email
      ,true as accept_tnc,true as accept_disclaimer
      ,c.name as country_name,b.entity_display_name as favourite_player_name
from labgt01_v1.labgt01_v1_web_user w
left join waf_master.waf_players b
on w.favourite_player_id=b.source_object_id 
left join waf_master.waf_countries c
on c.country_id = w.country_id
--join labgt01_v1.labgt01_v1_web_user_audit wu 
--	  on wu.user_guid=w.user_guid
where --option_type in (1,2)	  
--and  
mobile_no is null and email_id is not null)s;*/

select distinct(email_id) as email from labgt01_v1.labgt01_v1_web_user
where created_date::date<'2024-02-24' and email_id is not null;

end if;

if v_opt_type = 34 then 
open p_user_cursor for
select count(*),created_date::date from siwaf.siwaf_client_logs where client_name in ('labgt01_v1','gt01') 
and log_method_name='PaytmPayload' 
group by created_date::date order by created_date;
end if;

if 	v_opt_type = 35 then
    select p_input_json->'jsondata'->'externalCustomerId' into v_json_data;

        open p_user_cursor for
		SELECT
    COALESCE(a.first_name, b.first_name) AS firstName,
    COALESCE(a.last_name, b.last_name) AS lastName,
    COALESCE(a.email_id, b.email_id) AS email,
    COALESCE(a.mobile_no, b.mobile_no) AS phoneNumber,
    COALESCE(a.gender, b.gender) AS gender,
    COALESCE(a.user_guid, b.user_guid) AS externalCustomerId,
    COALESCE(a.dob, b.dob) AS dateOfBirth,
    COALESCE(a.city, b.city) AS city
FROM
    jsonb_array_elements_text(v_json_data) AS c
LEFT JOIN
    labgt01_v1.labgt01_v1_web_user AS a ON c.value = a.user_guid
LEFT JOIN
    labgt01_v1.labgt01_v1_web_user_old_data AS b ON c.value = b.user_guid
ORDER BY
    COALESCE(a.created_date, b.created_date) DESC;
		
		end if;

if 	v_opt_type = 37 then

open p_user_cursor for
select * from labgt01_v1.labgt01_v1_transaction_logs order by created_date desc limit 50;
-- select email_id,mobile_no,city from labgt01_v1.labgt01_v1_web_user where email_id in ('1TGCvxx7cSXTyTL5unHdsfV3vaZ8ddtaPDH/L2Yj6FBcWsqbw6dIn5ctETOipw2e',
--                                                       '9sUjskPHvnPMsnD7vcTq2/3vtmIE1mgDpd3ovv4sK+qzqZ7opIcPDKduOivv1hk9cKcnKdKELjd/ClWz7VmQQw==',
--                                                       'xlqK4BIfQB4XlZzw6oO47FXEJu/w0ZXG0RegwibH+8Kwq1f2NIHgVyqzzuA0hTJ4BziiQ6K9cmsB9gmyXaffpg==',
--                                                      'n/Gwgs8G5DVb9e33sQkzWM2a2KDIMJnHLnihI1/ZPvFvkumwFX9UwRtppQq/ImYFZCDqP/OwLr1wXvIKewamog==',
--                                                      'PQxS+n9eGoqLDRphsx33PyOcvRnguK11fJ75KqkElG5YyOW6/eHvOaaYH+QEckfg',
--                                                      'F30OFUqJxquQSjy4Y2Nj5sByPH+Nu91iAtrmtxzn6BjMfs4l4jKww7sTML3Rb4v3UAfsQGXIKlRgFqZAjRe2Aw==',
--                                                      'jgFiklT22BBM0IaeoD9p1Qeqn3mSNage241aeIUVmrQbuN0v8G86kvFLFEkkBTuJVZgTVDtnN9Tyc5lr1G8bEw==',
--                                                      'weWnFzEFBm2qDUNr+q4leJVZJ9CXgavaEYRjtnZhBq7gaiayzrstXPF1j5E8H629AmrJpvHViIcW3tELhXXm5g==',
--                                                      'L4hQlk8xAFkQfhHgftsk2bOZpWwowZPfoeh80/jmg7TcGlXGd5/b7r/GpqGkijcH',
--                                                      '69wF1QhtcsIOHiY7vHw4wSLi78nt6rOcz1rcKNTjmBaFFO6oXxAnjhArhwNMzxPU',
--                                                       'x6lPlRXnwQHCNDGnxGoUAkyAUjbUgJRhgu0QbaXrLBcCauE2emmo6JIMyvhHfZp1',
--                                                      'mA3PYpXunhURPEmoRtkYHtRopluO6vekMI3avRI+rEZDDUsulhjeojyntXm5SbiqKpQnp3FF1u7ZV3xpPFNCXQ==',
--                                                      'y/JZDIks4OP5eAOrC3AGNNMMMNXdMtm7RGeth7nxQBOSQuX3THi8lxkEttc8OE9I',
--                                                      '/zo5/W8i3lp3qoqiaUb1vP7sXDMiwGj+o2etiwIQYhVETJgZwvCz2xb94IREaKYnVzSadHy+ltr7jwbIhiIueA==',
--                                                      'ku3fL/icZZj2sR7wvUitGapl9igcKofc4/KZv9ID9JxCDjiart8AbmRmX+c1DbPJ');
end if;

if 	v_opt_type = 38 then

    select p_input_json->'jsondata'->>'option' into v_option;

    if v_option=1 then --New Registered App Users

        open p_user_cursor for
        select wu.created_date::date, 
        sum(case when wua.platform_type in (2,3) then 1 end) as  "New Registered App Users",
        sum(case when wua.platform_type in (0,1) then 1 end) as "New Registered Website Users"
        from labgt01_v1.labgt01_v1_web_user wu join
        labgt01_v1.labgt01_v1_web_user_audit wua on wua.user_guid=wu.user_guid or wua.user_id=wu.user_id
        where wua.option_type in (2) and
        wua.audit_date::date>'2024-02-27' group by wu.created_date::date;

    elsif v_option=3 then --Existing user relogin
        open p_user_cursor for
        select wua.audit_date::date, 
        sum(case when wua.platform_type in (2,3) then 1 end) as  "Relogin App Users",
        sum(case when wua.platform_type in (0,1) then 1 end) as "Relogin Website Users"
        from labgt01_v1.labgt01_v1_web_user wu join
        labgt01_v1.labgt01_v1_web_user_audit wua on wua.user_guid=wu.user_guid or wua.user_id=wu.user_id
        where wua.option_type in (4) and
        wua.audit_date::date>'2024-02-27' and wu.created_date::date<'2024-02-27' 
        group by wua.audit_date::date;
--         select wu.created_date::date, count(wu.*) from labgt01_v1.labgt01_v1_web_user wu join
--         labgt01_v1.labgt01_v1_otp_details od on od.mobile_no=wu.email_id 
--         join labgt01_v1.labgt01_v1_web_user_audit wua on wua.user_guid=od.user_guid
--         where od.opt=2 and od.is_verified=1 and wua.audit_date::date>'2024-02-27'
--         and wua.platform_type in (2,3) group by wu.created_date::date;

    elsif v_option=2 then --Relogin App Users

        open p_user_cursor for
        select wua.audit_date::date, 
        sum(case when wua.platform_type in (2,3) then 1 end) as  "Relogin App Users",
        sum(case when wua.platform_type in (0,1) then 1 end) as "Relogin Website Users"
        from labgt01_v1.labgt01_v1_web_user wu join
        labgt01_v1.labgt01_v1_web_user_audit wua on wua.user_guid=wu.user_guid or wua.user_id=wu.user_id
        where wua.option_type in (4) and
        wua.audit_date::date>'2024-02-27' group by wua.audit_date::date;

    end if;

end if;

if v_opt_type = 39 then 
  open p_user_cursor for
  select datajson->'data'->>'user_guid' as "user guid",
  		 datajson->'data'->'user_info'->>'first_name' as "first name" , 
		 datajson->'data'->'user_info'->>'last_name' as "last name",
		 datajson->'data'->'user_info'->>'email_id' as "email id",
		 datajson->'data'->'user_info'->>'mobile_no'  as mobile_no,
		 datajson->'data'->'user_info'->>'address' as address,
		 datajson->'data'->'user_info'->>'dob'	as dob,
		 datajson->'data'->'user_info'->>'address_line_1' as address_line_1,
		 datajson->'data'->'user_info'->>'address_line_2' as address_line_2,
		 datajson->'data'->'user_info'->>'city'      as city,
		 datajson->'data'->'user_info'->>'state'	as state,
		 datajson->'data'->'user_info'->>'zip_code'		as zip_code,
		 abc.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date
-- 		 wu.email_id as "email id"
  from labgt01_v1.labgt01_v1_custom_web_json abc
--   left join labgt01_v1.labgt01_v1_web_user wu
--   using(user_guid)
  where module_name = 'ticketsluckydraw';

end if;

if v_opt_type = 40 then 
  open p_user_cursor for
  select datajson->'data'->>'user_guid' as "user guid",
  		 datajson->'data'->'user_info'->>'first_name' as "first name" , 
		 datajson->'data'->'user_info'->>'last_name' as "last name",
		 datajson->'data'->'user_info'->>'email_id' as "email id",
		 datajson->'data'->'user_info'->>'mobile_no'  as mobile_no,
		 datajson->'data'->'user_info'->>'address' as address,
		 datajson->'data'->'user_info'->>'dob'	as dob,
		 datajson->'data'->'user_info'->>'address_line_1' as address_line_1,
		 datajson->'data'->'user_info'->>'address_line_2' as address_line_2,
		 datajson->'data'->'user_info'->>'city'      as city,
		 datajson->'data'->'user_info'->>'state'	as state,
		 datajson->'data'->'user_info'->>'zip_code'		as zip_code,
		 abc.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date
-- 		 wu.email_id as "email id"
  from labgt01_v1.labgt01_v1_custom_web_json abc
--   left join labgt01_v1.labgt01_v1_web_user wu
--   using(user_guid)
  where module_name = 'ticketsluckydrawforlogin'; 
 
end if;

if v_opt_type = 41 then 
  open p_user_cursor for
  select * from labgt01_v1.labgt01_v1_otp_details order by created_date desc limit 10;
  end if;
  
  
  if v_opt_type = 42 then 
  
    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
    
  --Contest name : Ticket Giveaway GTvDC
  --user_info->>'contest_name'='ROhSI6FgsGHmikntxl/P3xP96VnsY67PvEL/Lg9zjsREpXdWy6f77R+jaRJSpb0W' 
    delete from labgt01_v1.labgt01_v1_poll_temp;

	
	for i in 
	select poll_option_id,option from labgt01_v1.labgt01_v1_poll_option
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

	insert into labgt01_v1.labgt01_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	
	open p_user_cursor for 
    select pr.user_info->>'email_id' as email_id,
					pr.user_info->>'mobile_no' as mobile_no,
					pr.user_info->>'first_name' as first_name,
					pr.user_info->>'last_name' as last_name,
					pr.user_info->>'city' as city,
					pr.user_info->>'state' as state,
                    pr.user_info->>'address' as address,
                    pr.user_info->>'address_line1' as address1,
                    pr.user_info->>'address_line2' as address2,
                    pr.user_info->>'pincode' as pincode,
					pr.user_info->>'contest_name' as contest_name,
-- 					(po.option ::jsonb->>'player'):: varchar as user_answer_player_name 
                    answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					as user_answer
                    from labgt01_v1.labgt01_v1_poll_option po  
join labgt01_v1.labgt01_v1_user_poll_response pr on 
(po.poll_option_id = pr.response_option_id) 
left join labgt01_v1.labgt01_v1_poll_temp pt on pr.poll_id = pt.poll_id 
and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
where po.poll_id = v_poll_id order by pr.response_date;
  end if;
  
if v_opt_type = 43 then 
  open p_user_cursor for
  select datajson->'data'->'user_info'->>'first_name' as name,
		 datajson->'data'->'user_info'->>'mobile_no' as phone_number
  from labgt01_v1.labgt01_v1_custom_web_json
  where module_name = 'merchgiveawaycontest';
end if;

if v_opt_type = 44 then 
  open p_user_cursor for
  select datajson->'data'->'user_info'->>'first_name' as name,
		 datajson->'data'->'user_info'->>'mobile_no' as phone_number
  from labgt01_v1.labgt01_v1_custom_web_json
  where module_name = 'signed_team_jersey';
end if;

if v_opt_type = 45 then 
  open p_user_cursor for
  select datajson->'data'->'user_info'->>'first_name' as name,
		 datajson->'data'->'user_info'->>'mobile_no' as phone_number
  from labgt01_v1.labgt01_v1_custom_web_json
  where module_name = 'signed_jersey';
end if;

if v_opt_type = 46 then 
  open p_user_cursor for
  select datajson->'data'->'user_info'->>'first_name' as name,
		 datajson->'data'->'user_info'->>'mobile_no' as phone_number
  from labgt01_v1.labgt01_v1_custom_web_json
  where module_name = 'signed_cap';
end if;

if v_opt_type = 47 then 
  open p_user_cursor for
  select datajson->'data'->'user_info'->>'first_name' as name,
		 datajson->'data'->'user_info'->>'mobile_no' as phone_number
  from labgt01_v1.labgt01_v1_custom_web_json
  where module_name = 'merchandise';
end if;

if v_opt_type = 48 then 
  open p_user_cursor for
  select datajson->'data'->'user_info'->>'first_name' as name,
		 datajson->'data'->'user_info'->>'mobile_no' as phone_number
  from labgt01_v1.labgt01_v1_custom_web_json
  where module_name = 'lavendar_day';
end if;

if v_opt_type = 49 then 
  open p_user_cursor for
  select datajson->'data'->>'user_guid' as "user guid",
  		 datajson->'data'->'user_info'->>'first_name' as "first name" , 
		 datajson->'data'->'user_info'->>'last_name' as "last name",
		 datajson->'data'->'user_info'->>'email_id' as "email id",
		 datajson->'data'->'user_info'->>'mobile_no'  as mobile_no,
		 datajson->'data'->'user_info'->>'address' as address,
		 datajson->'data'->'user_info'->>'dob'	as dob,
		 datajson->'data'->'user_info'->>'address_line_1' as address_line_1,
		 datajson->'data'->'user_info'->>'address_line_2' as address_line_2,
		 datajson->'data'->'user_info'->>'city'      as city,
		 datajson->'data'->'user_info'->>'state'	as state,
		 datajson->'data'->'user_info'->>'zip_code'		as zip_code,
		 abc.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date
-- 		 wu.email_id as "email id"
  from labgt01_v1.labgt01_v1_custom_web_json abc
--   left join labgt01_v1.labgt01_v1_web_user wu
--   using(user_guid)
  where module_name = 'ticket_giveaway_gtvkkr'; 
 
end if;

if v_opt_type = 50 then 
  open p_user_cursor for
  select datajson->'data'->'user_info'->>'first_name' as "first name", 
		 --datajson->'data'->'user_info'->>'last_name' as "last name",
		 datajson->'data'->'user_info'->>'mobile_no'  as mobile_no,
		 datajson->'data'->'user_info'->>'email_id' as "email id",
		 datajson->'data'->'user_info'->>'dob'	as dob,
		 datajson->'data'->'user_info'->>'city' as city
  from labgt01_v1.labgt01_v1_custom_web_json 
  where lower(module_name) = 'match_travel'; 
  
  end if;
  
if v_opt_type = 51 then 

  open p_user_cursor for
	select wu.user_id,wu.first_name,wu.last_name,wu.user_full_name,wu.email_id,wu.mobile_no
	from labgt01_v1.labgt01_v1_daywise_user_activity ua
	join labgt01_v1.labgt01_v1_web_user wu on ua.user_guid = wu.user_guid
	where is_successful = 1 
	  and module_name in ('watch-video', 'dandiya-sticks', 'play-quiz', 
						  'wordle-activity', 'refer-5-friends', 'shubman-gill', 
						  'decode-message', 'play-poll', 'fam-wall-upload')
	group by ua.user_guid, wu.user_id,wu.first_name,wu.last_name, wu.user_full_name
	having count(distinct module_name) = 9;
  
  end if;
  
  
if v_opt_type = 52 then 

  open p_user_cursor for
	select 
    wu.user_id,wu.first_name,wu.last_name,wu.user_full_name,ua.user_guid,ua.is_successful,pr.poll_id, 
	q->>'question_text' as question,
    opt->>'answer_display_value' as user_answer, 
    opt->>'answer_id' as answer_id  
	from labgt01_v1.labgt01_v1_user_poll_response pr
	join labgt01_v1.labgt01_v1_poll_option po on pr.poll_id = po.poll_id
	join labgt01_v1.labgt01_v1_web_user wu on pr.user_id = wu.user_id  
	join labgt01_v1.labgt01_v1_daywise_user_activity ua on wu.user_guid = ua.user_guid 
	cross join jsonb_array_elements(po.option::jsonb->'questions') q
	cross join jsonb_array_elements(q->'options') opt 
	where ua.module_name = 'play-quiz'
	  and ua.is_successful = 1
	  and ua.asset_id = pr.poll_id
	  and opt->>'answer_id' = pr.ans::text
	order by pr.poll_id asc;
  end if;
  
if v_opt_type = 53 then 

  open p_user_cursor for
  
	select upr.user_id, wu.first_name,wu.last_name,wu.user_full_name,wu.email_id,wu.mobile_no,po.option::jsonb->>'player' as answer
	from labgt01_v1.labgt01_v1_user_poll_response upr
	join labgt01_v1.labgt01_v1_poll_option po on po.poll_id = upr.poll_id 
	join labgt01_v1.labgt01_v1_web_user wu on upr.user_id = wu.user_id
	join labgt01_v1.labgt01_v1_daywise_user_activity ua on wu.user_guid = ua.user_guid
	where upr.poll_id = ua.asset_id
  and ua.module_name = 'play-poll'
  and ua.is_successful = 1
  and upr.response_option_id = po.poll_option_id;
  end if;  
  
  
  if v_opt_type = 54 then 
  
--   select p_input_json->'jsondata'->>'module' into v_module_name;
  
--   open p_user_cursor for
--   select datajson->'data'->>'player_names',user_guid,created_date as response_date
--   from labgt01_v1.labgt01_v1_custom_web_json where module_name=v_module_name and
--   created_date::date between v_start_date_time and v_end_date_time
--   order by custom_id desc;
open p_user_cursor for
select * from 
(select mobile_no,country_code,user_guid,user_id,ROW_NUMBER() OVER(order by user_id) as rno from labgt01_v1.labgt01_v1_web_user order by user_id)a
where a.rno between 300001 and 400000;
  
  end if;
  
  if v_opt_type = 55 then 
  
  
      select p_input_json->'jsondata'->'poll_id' into v_poll_id;
    
  --Contest name : Ticket Giveaway GTvDC
  --user_info->>'contest_name'='ROhSI6FgsGHmikntxl/P3xP96VnsY67PvEL/Lg9zjsREpXdWy6f77R+jaRJSpb0W' 
    delete from labgt01_v1.labgt01_v1_poll_temp;

	
	for i in 
	select poll_option_id,option from labgt01_v1.labgt01_v1_poll_option
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

	insert into labgt01_v1.labgt01_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	
	open p_user_cursor for 
    select pr.user_info->>'email_id' as email_id,
					pr.user_info->>'mobile_no' as mobile_no,
					pr.user_info->>'first_name' as first_name,
					pr.user_info->>'last_name' as last_name,
					pr.user_info->>'city' as city,
					pr.user_info->>'state' as state,
                    pr.user_info->>'address' as address,
                    pr.user_info->>'address_line1' as address1,
                    pr.user_info->>'address_line2' as address2,
                    pr.user_info->>'pincode' as pincode,
					pr.user_info->>'contest_name' as contest_name,
					pr.response_date as response_date,
-- 					(po.option ::jsonb->>'player'):: varchar as user_answer_player_name 
                    answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					as user_answer
                    from labgt01_v1.labgt01_v1_poll_option po  
join labgt01_v1.labgt01_v1_user_poll_response pr on 
(po.poll_option_id = pr.response_option_id) 
left join labgt01_v1.labgt01_v1_poll_temp pt on pr.poll_id = pt.poll_id 
and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
where po.poll_id = v_poll_id order by pr.response_date;
  
  end if;
  ------------------------------------
  if v_opt_type = 56 then 
  open p_user_cursor for
  select 
  		 
		 datajson->'data'->'user_info'->>'first_name' as "first_name" , 
		 datajson->'data'->'user_info'->>'last_name' as "last_name",
		 datajson->'data'->'user_info'->>'email_id' as "email_id",
		 datajson->'data'->'user_info'->>'mobile_no'  as mobile_no,
		 datajson->'data'->'user_info'->>'address' as address,
		 datajson->'data'->'user_info'->>'address_line_1' as address_line_1,
		 datajson->'data'->'user_info'->>'address_line_2' as address_line_2,
		 datajson->'data'->'user_info'->>'city'      as city,
		 datajson->'data'->'user_info'->>'state'	as state,
		 datajson->'data'->'user_info'->>'zip_code'		as zip_code,
		 abc.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date
-- 		 wu.email_id as "email id"
  from labgt01_v1.labgt01_v1_custom_web_json abc
--   left join labgt01_v1.labgt01_v1_web_user wu
--   using(user_guid)
  where module_name = 'gtvspbks_match_tickets_giveaway'; 
 end if;

--------------------
  if v_opt_type = 57 then 
  open p_user_cursor for
  select 
  		 
		 datajson->'data'->'user_info'->>'first_name' as "first_name" , 
		 datajson->'data'->'user_info'->>'last_name' as "last_name",
		 datajson->'data'->'user_info'->>'email_id' as "email_id",
		 datajson->'data'->'user_info'->>'mobile_no'  as mobile_no,
		 datajson->'data'->'user_info'->>'address' as address,
		 datajson->'data'->'user_info'->>'address_line_1' as address_line_1,
		 datajson->'data'->'user_info'->>'address_line_2' as address_line_2,
		 datajson->'data'->'user_info'->>'city'      as city,
		 datajson->'data'->'user_info'->>'state'	as state,
		 datajson->'data'->'user_info'->>'zip_code'		as zip_code,
		 abc.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date
  from labgt01_v1.labgt01_v1_custom_web_json abc

  where module_name = 'ipl_2025_contest_1'; 
 end if;
---------------------
 if v_opt_type = 58 then 
	open p_user_cursor for 
    select
	   datajson->'data'->'user_info'->>'first_name' as first_name,
	   datajson->'data'->'user_info'->>'last_name' as last_name,
	   datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
	   datajson->'data'->'user_info'->>'email_id' as email_id,
	   datajson->'data'->'user_info'->>'dob' as dob,

	   datajson->'data'->'user_info'->>'address' as address,
	   datajson->'data'->'user_info'->>'address_line_1' as address_line_1,
	   datajson->'data'->'user_info'->>'address_line_2' as address_line_2,
	   datajson->'data'->'user_info'->>'city' as city,
	   datajson->'data'->'user_info'->>'state'	as state,
	   datajson->'data'->'user_info'->>'zip_code' as zip_code,
	   ab.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date,
	   datajson->'data'->>'module' as module_name
  from labgt01_v1.labgt01_v1_custom_web_json ab
  where lower(module_name) = 'jos_signed_mini_bat' order by created_date desc; 

  end if;
--------------------

if v_opt_type = 59 then 
	open p_user_cursor for 
    select
	   datajson->'data'->'user_info'->>'first_name' as first_name,
	   datajson->'data'->'user_info'->>'last_name' as last_name,
	   datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
	   datajson->'data'->'user_info'->>'email_id' as email_id,
	   
	   ab.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date,
	   datajson->'data'->>'module' as module_name
  from labgt01_v1.labgt01_v1_custom_web_json ab
  where lower(module_name) = 'gtvdc_hospitality_tickets' order by created_date desc; 

  end if;
  ------------------------------------------------------------------------------
  if v_opt_type = 60 then 
	open p_user_cursor for 
    select
	   datajson->'data'->'user_info'->>'first_name' as first_name,
	   datajson->'data'->'user_info'->>'last_name' as last_name,
	   datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
	   datajson->'data'->'user_info'->>'email_id' as email_id,
	   datajson->'data'->'user_info'->>'city' as city,
	   datajson->'data'->'user_info'->>'state'	as state,
	   
	   ab.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date,
	   datajson->'data'->>'module' as module_name
  from labgt01_v1.labgt01_v1_custom_web_json ab
  where lower(module_name) = 'gtvdc_tickets_giveaway_contest' order by created_date desc; 

  end if;
  ------------------------------------------------------------------------
  if v_opt_type = 61 then 
	open p_user_cursor for 
    select
	   datajson->'data'->'user_info'->>'first_name' as first_name,
	   datajson->'data'->'user_info'->>'last_name' as last_name,
	   datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
	   datajson->'data'->'user_info'->>'email_id' as email_id,
	   datajson->'data'->'user_info'->>'city' as city,
	   datajson->'data'->'user_info'->>'state'	as state,
	   
	   ab.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date,
	   datajson->'data'->>'module' as module_name
  from labgt01_v1.labgt01_v1_custom_web_json ab
  where lower(module_name) = 'gtvsrh_tickets_giveaway_contest' order by created_date desc; 

  end if;
  ------------------------------------------------------------------------
    if v_opt_type = 62 then 
	open p_user_cursor for 
	
	

    select
	   datajson->'data'->'user_info'->>'first_name' as first_name,
	   datajson->'data'->'user_info'->>'last_name' as last_name,
	   datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
	   datajson->'data'->'user_info'->>'email_id' as email_id,
	   datajson->'data'->'user_info'->>'city' as city,
	   datajson->'data'->'user_info'->>'state'	as state,
	   
	   ab.created_date at time zone 'utc' at time zone 'Asia/Calcutta' as created_date,
	   datajson->'data'->>'module' as module_name
  from labgt01_v1.labgt01_v1_custom_web_json ab
  where lower(module_name) = 'gtvsrh_hospitality_tickets' order by created_date desc; 

  end if;
  ------------------------------------------------------------------------
IF v_opt_type = 64 THEN 
    OPEN p_user_cursor FOR
        SELECT 
            s.scenario_id,
            s.scenario_text,
            s.position AS scenario_position,
            b.first_name,
            b.last_name,
            b.email_id,
            b.mobile_no,
            a.created_date + '5.5 hours'::interval AS response_date_ist
        FROM labgt01_v1.labgt01_v1_custom_web_json a
        JOIN labgt01_v1.labgt01_v1_web_user b 
            ON a.user_guid = b.user_guid
        LEFT JOIN labgt01_v1.labgt01_v1_auction_activation_2026 s
            ON a.user_guid = s.user_guid
        WHERE LOWER(a.module_name) = 'auction_activation_2026'
        ORDER BY a.created_date DESC;
END IF;



  -----------------------
  
	 end;
$_$;


--
