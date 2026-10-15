-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labmcfc_v1_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labmcfc_v1; Owner: -
--

CREATE FUNCTION labmcfc_v1.labmcfc_v1_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
/*
select * from labmcfc_v1.labmcfc_v1_get_user_data
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
	v_json json;
	v_opt_type_1 numeric;
    v_map_id numeric;
begin
	
    select p_input_json->>'start_date_time', 
	p_input_json->>'end_date_time',
	p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
	
	
    select opt_type,map_id into v_opt_type_1,v_map_id from labmcfc_v1.labmcfc_v1_user_data_filter
    where id = v_opt_type;
    
 if v_opt_type_1 = 1 then
    open p_user_cursor for
   select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' 
	when 5 then 'Custom' end as source, 
    			 email_id, dob, mobile_no, gender, c.name as city, 
				s.name as statename, 
				--co.name as country,
				created_date,is_verified,first_name,last_name,address,pincode
    from (select client_id, social_user_name, 
		  user_full_name, email_id, dob, mobile_no, 
		  gender, city_id, state_id, country_id,created_date,is_verified,first_name,last_name,address,pincode
          from labmcfc_v1.labmcfc_v1_web_user wu
          where (created_date between v_start_date_time and v_end_date_time)
             ) as tab
	left join waf_master.waf_cities c
     on c.city_id = tab.city_id
     left join waf_master.waf_states s
     on s.state_id = tab.state_id
     left join waf_master.waf_countries co
     on co.country_id = tab.country_id; 
     
     elsif v_opt_type_1 =20  then
    open p_user_cursor for
   select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' 
	when 5 then 'Custom' end as source, 
    			 email_id, dob, mobile_no, gender, c.name as city, 
				s.name as statename, 
				--co.name as country,
				updated_date,is_verified,first_name,last_name,address,pincode
    from (select client_id, social_user_name, 
		  user_full_name, email_id, dob, mobile_no, 
		  gender, city_id, state_id, country_id,updated_date,is_verified,first_name,last_name,address,pincode
          from labmcfc_v1.labmcfc_v1_web_user wu
          where (updated_date between v_start_date_time and v_end_date_time)
             ) as tab
	left join waf_master.waf_cities c
     on c.city_id = tab.city_id
     left join waf_master.waf_states s
     on s.state_id = tab.state_id
     left join waf_master.waf_countries co
     on co.country_id = tab.country_id; 
	 
		-- where a.poll_id = 381  ; 
	 
	 
	 /*
	 
		 
	  open p_user_cursor for
		 select a.poll_id,user_full_name, email_id, dob, mobile_no, gender,
			is_verified,first_name,last_name,option::jsonb->>'pid' as id ,option::jsonb->>'player' as name
		from labmcfc_v1.labmcfc_v1_user_poll_response a
		join labmcfc_v1.labmcfc_v1_poll_option b on a.response_option_id=b.poll_option_id
		join labmcfc_v1.labmcfc_v1_web_user c on a.user_id=c.user_id ;
 
	 
	 
	 
	 select user_full_name, email_id, dob, mobile_no, gender,
	is_verified,first_name,last_name,option::jsonb->>'pid' as id ,option::jsonb->>'player' as name
from labmcfc_v1.labmcfc_v1_user_poll_response a
join labmcfc_v1.labmcfc_v1_poll_option b on a.response_option_id=b.poll_option_id
join labmcfc_v1.labmcfc_v1_web_user c on a.user_id=c.user_id
where a.poll_id=361  ; -- and option::jsonb->>'pid'='55658' order by 1 desc;*/

 end if;
 
	if v_opt_type_1 = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
	
	sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labmcfc_v1.labmcfc_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labmcfc_v1.labmcfc_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labmcfc_v1.labmcfc_v1_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labmcfc_v1.labmcfc_v1_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
 
 if v_opt_type_1 = 3 then
    
    	 /*open p_user_cursor for
		 select user_full_name, email_id, dob, mobile_no, gender,
			is_verified,first_name,last_name,option::jsonb->>'pid' as id ,option::jsonb->>'player' as name
		from labmcfc_v1.labmcfc_v1_user_poll_response a
		join labmcfc_v1.labmcfc_v1_poll_option b on a.response_option_id=b.poll_option_id
		join labmcfc_v1.labmcfc_v1_web_user c on a.user_id=c.user_id
		where a.poll_id = 381  ; -- and option::jsonb->>'pid'='55658' order by 1 desc;*/
		
		select p_input_json->'jsondata'->'poll_id' into v_poll_id;
		
    	 open p_user_cursor for
		 select user_full_name, email_id, dob, mobile_no, gender,
			is_verified,first_name,last_name,option::jsonb->>'pid' as id ,option::jsonb->>'player' as name
		from labmcfc_v1.labmcfc_v1_user_poll_response a
		join labmcfc_v1.labmcfc_v1_poll_option b on a.response_option_id=b.poll_option_id
		join labmcfc_v1.labmcfc_v1_web_user c on a.user_id=c.user_id
		where a.poll_id = v_poll_id  ; -- and option::jsonb->>'pid'='55658' order by 1 desc;
	
         	
    end if;
 
 if v_opt_type_1 = 8 then
    
 open p_user_cursor for
 select email_id,mobile_no,dob,gender,state_id,pincode,created_date from labmcfc_v1.labmcfc_v1_web_user
where is_active=1 and is_deleted=0 and
 created_date::date between v_start_date_time and v_end_date_time;
 
 end if;
 
 if v_opt_type_1 = 9 then
    
 open p_user_cursor for
 select email_id,mobile_no,dob,gender,state_id,pincode,updated_date from labmcfc_v1.labmcfc_v1_web_user
where is_active=1 and is_deleted=0 and email_id is not null and first_name is not null and last_name is not null
and subscribe_for_email is not null and mobile_no is not null and 
updated_date::date between v_start_date_time and v_end_date_time;
 
 end if;
 
 
 if v_opt_type_1 = 10 then
    
--	v_poll_id := v_map_id ;
			select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labmcfc_v1.labmcfc_v1_poll_temp;

	
	for i in 
	select poll_option_id,option from labmcfc_v1.labmcfc_v1_poll_option
	where poll_id = v_poll_id
	loop
	
	-- raise notice '%',i.option;

	/*select options into v_options from (
	select b->'options' as options from (
	select b
	from json_array_elements((i.option)::json->'options') b)as a )c
	where options is not null ;*/
	
	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;
	
	-- raise notice '%',v_options;

   	/* select question_text into v_question from (
	select b->>'question_text' as question_text from (
	select b
	from json_array_elements((i.option)::json->'question_text') b)as a )c
	where question_text is not null ;*/
    raise notice 'v_options%',v_options;
	raise notice 'v_question%',v_question;
    
	insert into labmcfc_v1.labmcfc_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;

    /*open p_user_cursor for
	select first_name,last_name,email_id,category_1 as question_1,category_2 as question_2,
	case when created_date > '2022-01-24 08:30:00' then 1 else 0 end as New_user,mobile_no,
	 dob,gender,s.name,co.name,pincode
	 from(
	 SELECT * FROM crosstab4('select  user_id::text,question,answer_display_value from labmcfc_v1.labmcfc_v1_user_poll_response pr
	left join labmcfc_v1.labmcfc_v1_poll_temp pt on pr.poll_id = pt.poll_id 
	and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
	left join labmcfc_v1.labmcfc_v1_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
	where pr.poll_id = '||v_poll_id||' and (po.option::json->>''correct_ans_id'')::numeric = pr.ans
	order by 1,2' ))a
	left join labmcfc_v1.labmcfc_v1_web_user wu on a.row_name::numeric = wu.user_id
	left join waf_master.waf_states s
     on s.state_id = wu.state_id
     left join waf_master.waf_countries co
     on co.country_id = wu.country_id
	where category_1 is not null and category_2 is not null;*/
	
	delete from labmcfc_v1.labmcfc_v1_poll_temp_1;
				
				    insert into labmcfc_v1.labmcfc_v1_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||'('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from labmcfc_v1.labmcfc_v1_user_poll_response pr
					left join labmcfc_v1.labmcfc_v1_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labmcfc_v1.labmcfc_v1_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
	
	perform colpivot('data1', $$ select user_id,question,answer_display_value from labmcfc_v1.labmcfc_v1_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
   --  raise notice '2';

    open p_user_cursor for
	select first_name,last_name,email_id,mobile_no,dob,ct.name as country_name,city,pincode,address,a.*
      from data1 a
	left join labmcfc_v1.labmcfc_v1_web_user wu on a.user_id::numeric = wu.user_id
	left join waf_master.waf_countries ct on wu.country_id=ct.country_id;
 
 	
 
 
 
 end if;
/*
if v_opt_type = 17 then
    
	select p_input_json->'jsondata'->'poll_id' into v_poll_id;

--	v_poll_id := 1001 ;

	
	Delete from labmcfc_v1.labmcfc_v1_poll_temp;

	for i in 
	select poll_option_id,option from labmcfc_v1.labmcfc_v1_poll_option
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

	insert into labmcfc_v1.labmcfc_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;

    open p_user_cursor for
	select first_name,last_name,email_id,category_1 as question_1,category_2 as question_2,
	case when created_date > '2022-01-21 13:18:40.471875' then 1 else 0 end as New_user,mobile_no,dob,gender,
	s.name as state, co.name as country,pincode
	 from(
	 SELECT * FROM crosstab4('select  user_id::text,question,answer_display_value from labmcfc_v1.labmcfc_v1_user_poll_response pr
	join labmcfc_v1.labmcfc_v1_poll_temp pt on pr.poll_id = pt.poll_id 
	and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
	join labmcfc_v1.labmcfc_v1_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
	where pr.poll_id = '||v_poll_id||' and (po.option::json->>''correct_ans_id'')::numeric = pr.ans
	order by 1,2' ))a
	left join labmcfc_v1.labmcfc_v1_web_user wu on a.row_name::numeric = wu.user_id
	left join waf_master.waf_states s
     on s.state_id = wu.state_id
     left join waf_master.waf_countries co
     on co.country_id = wu.country_id
	where category_1 is not null and category_2 is not null;

 end if;
*/
  if v_opt_type = 17 then 
  
  select p_input_json->'jsondata'->'poll_id' into v_poll_id;
   --v_poll_id:=81; 
  open p_user_cursor for
	select a.first_name,a.last_name,a.email_id,a.mobile_no,a.address,a.city,ct.name as country_name,b.response_date,(c.option)::json->>'pid' as pid,(c.option)::json->>'player' as player_name,
	b.response_date at time zone 'utc' at time zone 'Asia/Calcutta' as vote_time
	from labmcfc_v1.labmcfc_v1_web_user a
	join labmcfc_v1.labmcfc_v1_user_poll_response b
	on a.user_id=b.user_id
	join labmcfc_v1.labmcfc_v1_poll_option c
	on b.poll_id=c.poll_id
	and c.poll_option_id = b.response_option_id
	left join waf_master.waf_countries ct
	on a.country_id = ct.country_id
	where --(b.created_date + '5.5 hours'::interval)::date between v_start_date_time and v_end_date_time
	 c.poll_id=v_poll_id
	and b.poll_id=v_poll_id;

end if;
 if v_opt_type_1 = 18 then
      select p_input_json->'jsondata'->'poll_id' into v_poll_id;

    	 open p_user_cursor for
		 select user_full_name, email_id, dob, mobile_no, gender,c.address,c.city,ct.name as country_name ,c.pincode as pincode,a.response_date::date as vote_date
			,first_name,last_name,option::jsonb->>'pid' as id ,option::jsonb->>'player' as name
		from labmcfc_v1.labmcfc_v1_user_poll_response a
		join labmcfc_v1.labmcfc_v1_poll_option b on a.response_option_id=b.poll_option_id
		join labmcfc_v1.labmcfc_v1_web_user c on a.user_id=c.user_id
		left join waf_master.waf_countries ct
		on c.country_id = ct.country_id
		where a.poll_id = v_poll_id  ; -- and option::jsonb->>'pid'='55658' order by 1 desc;
         	
    end if; 

	if 	v_opt_type = 19 then

        open p_user_cursor for
		select client_id,email_id,first_name,last_name,is_verified		
		from labmcfc_v1.labmcfc_v1_web_user
		where client_id=5
		;
		
		end if;
        
        
   if v_opt_type_1 = 21 then
    
    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labmcfc_v1.labmcfc_v1_poll_temp;

	
	for i in 
	select poll_option_id,option from labmcfc_v1.labmcfc_v1_poll_option
	where poll_id = v_poll_id 
	loop
	
	-- raise notice '%',i.option;

	select (i.option)::json->'options' into v_options;
	select (i.option)::json->>'question_text' into v_question;
	
	insert into labmcfc_v1.labmcfc_v1_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;

	
	delete from labmcfc_v1.labmcfc_v1_poll_temp_1;
				
				    insert into labmcfc_v1.labmcfc_v1_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||'('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from labmcfc_v1.labmcfc_v1_user_poll_response pr
					left join labmcfc_v1.labmcfc_v1_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labmcfc_v1.labmcfc_v1_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
	
	perform colpivot('poll_data', $$ select user_id,question,answer_display_value from labmcfc_v1.labmcfc_v1_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   

    open p_user_cursor for
	select first_name,last_name,email_id,mobile_no,city,pincode,address,b.response_date,a.*
      from poll_data a
	left join labmcfc_v1.labmcfc_v1_web_user wu on a.user_id::numeric = wu.user_id
    left join (select user_id ,min(response_date) as response_date from labmcfc_v1.labmcfc_v1_user_poll_response
              where poll_id = v_poll_id group by 1 ) b on a.user_id::numeric = b.user_id;
    
        
    end if;  
    
    if v_opt_type = 22 then 

  open p_user_cursor for
    SELECT datajson->'data'->'user_info'->>'first_name' as first_name,
       datajson->'data'->'user_info'->>'last_name' as last_name,
       datajson->'data'->'user_info'->>'email_id' as email_id,
       datajson->'data'->'user_info'->>'state' as state,
       datajson->'data'->'user_info'->>'mobile_no' as mobile_no,
       datajson->'data'->'user_info'->>'country_name' as country_name
        FROM labmcfc_v1.labmcfc_v1_custom_web_json
        WHERE module_name = 'contestpage' and
        created_date::date between v_start_date_time and v_end_date_time;

end if; 
        

end;
$_$;


--
