-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: labkkr_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labkkr_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labkkr_beta; Owner: -
--

CREATE FUNCTION labkkr_beta.labkkr_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
/*
select * from labkkr.labkkr_get_user_data
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
	v_opt_type_1 numeric;
	v_json_data jsonb;
    v_map_id numeric;
	i record;
	v_options json;
	v_question text;
    
    user_poll_response_id_arr jsonb;
    j jsonb;
    v_user_response_id numeric;
    v_display_name character varying ='';
    v_answer character varying ='';
    v_is_ans numeric;
    v_name character varying ='';
    v_email_id character varying ='';
    v_mobile_no character varying;
    v_created_date timestamp;
    v_json character varying ='';
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
	
	select opt_type,map_id into v_opt_type_1,v_map_id from labkkr.labkkr_user_data_filter
    where id = v_opt_type;
    
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, 
	--social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender,
				/*c.name as city, 
				s.name as state, co.name as country,
				*/
				created_date,is_verified,membership_code as social_user_name,whatsapp_consent as contestinfo,
				first_name,last_name
    from (select client_id, social_user_name, 
		  user_full_name, email_id, dob, mobile_no, 
		  gender,created_date,is_verified,membership_code,whatsapp_consent,
		  first_name,last_name
          from labkkr.labkkr_web_user wu
          where created_date between v_start_date_time and v_end_date_time
             ) as tab
			 ;
	--left join waf_master.waf_cities c
     --on c.city_id = tab.city_id
     --left join waf_master.waf_states s
     --on s.state_id = tab.state_id
     --left join waf_master.waf_countries co
     --on co.country_id = tab.country_id;
 end if;
 
	if v_opt_type = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labkkr.labkkr_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labkkr.labkkr_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labkkr.labkkr_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labkkr.labkkr_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
 
 	if v_opt_type_1 = 3 then

	
	select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labkkr.labkkr_poll_temp;

	
	for i in 
	select poll_option_id,option from labkkr.labkkr_poll_option
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

	insert into labkkr.labkkr_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	                delete from labkkr.labkkr_poll_temp_1;
				
				    insert into labkkr.labkkr_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from labkkr.labkkr_user_poll_response pr
					left join labkkr.labkkr_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labkkr.labkkr_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
	
	perform colpivot('data1', $$ select user_id,question,answer_display_value from labkkr.labkkr_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';

    open p_user_cursor for
	select first_name,last_name,email_id,dob,a.*,tab.score
      from data1 a
	left join labkc_v1.labkc_v1_web_user wu on a.user_id::numeric = wu.user_id
	left join (select user_id,sum(score) as score from
					(select distinct user_id,question,
					answer_display_value,case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 1 else 0 end as score
					from labkkr.labkkr_user_poll_response pr
					left join labkkr.labkkr_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labkkr.labkkr_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id 
					order by 1 desc) a
					group by 1
					order by 2 desc) tab on a.user_id::numeric = tab.user_id 
	order by tab.score desc	;

	end if;
	
	if 	v_opt_type = 8 then
    select p_input_json->'jsondata'->'guids' into v_json_data;

        open p_user_cursor for
		select client_id, social_user_name, user_full_name, 
		email_id, created_date,dob,gender,mobile_no,user_guid,first_name,last_name,updated_date

		
		from labkkr.labkkr_web_user a,
		jsonb_array_elements_text(v_json_data) as b
		where  a.user_guid=b.value
		order by created_date desc
		;
		
		end if;

	if 	v_opt_type = 9 then

        open p_user_cursor for
		select client_id,email_id,first_name,last_name,is_verified		
		from labkkr.labkkr_web_user
		where client_id=5
		;
		
		end if;
if v_opt_type = 10 then
    select p_input_json->'jsondata'->'poll_id' into v_poll_id;
	
   delete from labkkr.labkkr_poll_temp;

	
	for i in 
	select poll_option_id,option from labkkr.labkkr_poll_option
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

	insert into labkkr.labkkr_poll_temp
	select *,i.poll_option_id,v_poll_id,v_question from  json_to_recordset(v_options)
	as x("answer_id" numeric, "answer_display_value" text);

	end loop;
	                delete from labkkr.labkkr_poll_temp_1;
				
				    insert into labkkr.labkkr_poll_temp_1
	                select   user_id::text,question,
					answer_display_value ||' ('||case when po.option::jsonb->>'correct_ans_id' = pt.answer_id::text then 'Correct' else 'Wrong' end ||')'
					from labkkr.labkkr_user_poll_response pr
					left join labkkr.labkkr_poll_temp pt on pr.poll_id = pt.poll_id 
					and pr.response_option_id = pt.poll_option_id and pr.ans=answer_id
					left join labkkr.labkkr_poll_option po on pr.poll_id = po.poll_id and pr.response_option_id=po.poll_option_id
					where pr.poll_id = v_poll_id
					order by 1,2;
	
	perform colpivot('data1', $$ select user_id,question,answer_display_value from labkkr.labkkr_poll_temp_1 $$, array['user_id'], array['question'], '#.answer_display_value','question');
   
     -- raise notice '2';

    open p_user_cursor for
	select first_name,last_name,email_id,dob,a.*
      from data1 a
	left join labkc_v1.labkc_v1_web_user wu on a.user_id::numeric = wu.user_id	;

 end if; 
 

end;
$_$;


--
