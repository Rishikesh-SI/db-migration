-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labgt_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labgt_bkp; Owner: -
--

CREATE FUNCTION labgt_bkp.labgt_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
/*
select * from labgt.labgt_get_user_data
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
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
/* if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from(select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labgt.labgt_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labgt.labgt_web_user wu
          join labgt.labgt_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labgt.labgt_web_user wu
          join labgt.labgt_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labgt.labgt_web_user wu
          join labgt.labgt_asset_comment_reaction acr
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
 end if;*/
 
 if v_opt_type = 1 then 
  open p_user_cursor for
  select a.client_id, a.user_full_name, a.email_id, b.platform_version,b.platform_type,b.device_name,a.created_date::date
  from labgt.labgt_web_user a
  left join labgt.labgt_web_user_audit b
  on a.user_id=b.user_id and b.user_id is not null and option_type in (1,2)
  where a.created_date::date between v_start_date_time and v_end_date_time;
  end if;
 
/* 
	if v_opt_type = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labgt.labgt_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labgt.labgt_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labgt.labgt_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labgt.labgt_asset_list al
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
    			 email_id, dob, mobile_no, gender,city,pincode,favourite_player_id,d.name as country,is_verified,created_date at time zone 'utc' at time zone 'Asia/Calcutta',
				 subscribe_for_email
    from (select client_id, first_name, last_name, email_id, dob, mobile_no,gender,city,pincode,favourite_player_id,country_id,is_verified,created_date,subscribe_for_email
          from labgt.labgt_web_user a
           where created_date between v_start_date_time and v_end_date_time)as tab
   			--left join waf_master.waf_players f 
			--on tab.favourite_player_id=f.source_object_id
			left join waf_master.waf_countries d 
			on tab.country_id=d.country_id;		  
end if;

if v_opt_type = 3 then 
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'club_name' as club_name ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'
  from labgt.labgt_custom_web_json a
  join labgt.labgt_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='fanclub';
  
  end if;
  
  if v_opt_type = 4 then 
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'player_name' as player_name ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'
  from labgt.labgt_custom_web_json a
  join labgt.labgt_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='playerofthematch';

end if;

  if v_opt_type = 5 then 
  
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'msg' as msg ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'
  from labgt.labgt_custom_web_json a
  join labgt.labgt_web_user b
  on a.user_guid=b.user_guid
  where (a.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
  and a.module_name='fanticket';

end if;
 --select p_input_json->'jsondata'->'poll_id' into v_poll_id;
 
 
  if v_opt_type = 6 then 
  
  select p_input_json->'jsondata'->'poll_id' into v_poll_id;
   --v_poll_id:=81; 
  open p_user_cursor for
	select a.first_name,a.last_name,a.email_id,a.mobile_no,(c.option)::json->>'pid' as pid,(c.option)::json->>'player' as player_name,
	b.response_date at time zone 'utc' at time zone 'Asia/Calcutta' as vote_time
	from labgt.labgt_web_user a
	join labgt.labgt_user_poll_response b
	on a.user_id=b.user_id
	join labgt.labgt_poll_option c
	on b.poll_id=c.poll_id
	and c.poll_option_id = b.response_option_id
	where --(b.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
	 c.poll_id=v_poll_id
	and b.poll_id=v_poll_id;

end if;

 if v_opt_type = 7 then 
  
  open p_user_cursor for
  select name as user_full_name,email_address as email_id,feedback as message
  from labgt.labgt_contact
  where (created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time;
  	
  
 end if; 
 
 if v_opt_type = 8 then 
 
 
 
 select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labgt.labgt_poll_temp;

	
	for i in 
	select poll_option_id,option from labgt.labgt_poll_option
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
	
	

	insert into labgt.labgt_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	                delete from labgt.labgt_poll_temp_1;
					
				
				
				    insert into labgt.labgt_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||'('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')',pr.response_date::date
					from labgt.labgt_user_poll_response pr
					left join labgt.labgt_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labgt.labgt_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id and question is not null and answer_display_value is not null
					order by 1,2;
	
	perform colpivot('data1', $$ select user_id,question,answer_display_value,response_date from labgt.labgt_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   

    open p_user_cursor for
	select first_name,last_name,email_id,mobile_no,dob,a.*,b.response_date
      from data1 a
	left join labgt.labgt_web_user wu on a.user_id::numeric = wu.user_id
	inner join (select distinct user_id,response_date from labgt.labgt_poll_temp_1) b on a.user_id::numeric=b.user_id::numeric ;

 end if;

  if v_opt_type = 9 then 
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'player_name' as player_name ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'  as created_date 
  from labgt.labgt_custom_web_json a
  join labgt.labgt_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='virtualplayermeet';
  end if;
  
  
  if v_opt_type = 10 then 
  open p_user_cursor for
  select b.first_name, b.last_name,b.email_id,a.datajson->'data'->>'field_1' as department ,a.datajson->'data'->>'field_2' as answer_here ,a.created_date at time zone 'utc' at time zone 'Asia/Calcutta'  as created_date 
  from labgt.labgt_custom_web_json a
  join labgt.labgt_web_user b
  on a.user_guid=b.user_guid
  where a.created_date::date between v_start_date_time and v_end_date_time
  and a.module_name='fantership';
  end if;
  
   if v_opt_type = 11 then 
  open p_user_cursor for
  select a.client_id, a.user_full_name,b.option_type, a.email_id, b.platform_version,b.platform_type,b.device_name,a.created_date::date
  from labgt.labgt_web_user a
  left join labgt.labgt_web_user_audit b
  on a.user_id=b.user_id and b.user_id is not null
  where a.created_date::date between v_start_date_time and v_end_date_time;
  end if;
  
    if v_opt_type = 13 then 
  open p_user_cursor for
  select first_name,last_name,email_id,is_verified
  from labgt.labgt_web_user
  where client_id=5 and is_verified=1;
  end if;
  

end;
$_$;


--
