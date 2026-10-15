-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_get_user_data_07april2026(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labkxip_get_user_data_07april2026(jsonb, refcursor); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_get_user_data_07april2026(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labkxip.labkxip_get_user_data_07April2026
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
	v_json_data jsonb;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;

-----------------------------------------------------------------------------------------------
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, 0 as reaction_count,
          		0 as comment_count
          from labkxip.labkxip_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender,
          		count(1) as reaction_count, 0 as comment_count
          from labkxip.labkxip_web_user wu
          join labkxip.labkxip_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, 0 as reaction_count,
          		count(1) as comment_count
          from labkxip.labkxip_web_user wu
          join labkxip.labkxip_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender,
          		count(1) as reaction_count, 0 as comment_count
          from labkxip.labkxip_web_user wu
          join labkxip.labkxip_asset_comment_reaction acr
          on acr.user_id = wu.user_id
          where acr.reaction_date between v_start_date_time and v_end_date_time
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender
         ) as tab
	;
 end if;
 
----------------------------------------------------------------------------------------------- 
	if v_opt_type = 2 then
    
    	 open p_user_cursor for
         	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labkxip.labkxip_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labkxip.labkxip_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labkxip.labkxip_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labkxip.labkxip_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;

-----------------------------------------------------------------------------------------------
	if v_opt_type = 3 then
    
    	 open p_user_cursor for
		 select name as user_full_name,email_address as email_id,first_name,last_name
		 from labkxip.labkxip_contact
		 where created_date between v_start_date_time and v_end_date_time;
		 end if;

-----------------------------------------------------------------------------------------------         
   if v_opt_type =4 then
  
  	open p_user_cursor for 
  		select * from labkxip.labkxip_otp_details order by created_date desc limit 10;
	
  end if;

-----------------------------------------------------------------------------------------------
if v_opt_type = 5 then
    
    	 open p_user_cursor for
		 select *
		 from labkxip.labkxip_web_user
		 where created_date::date between v_start_date_time and v_end_date_time
         order by created_date desc;
end if;

-----------------------------------------------------------------------------------------------
if 	v_opt_type = 6 then
    select p_input_json->'jsondata'->'id' into v_json_data;

        open p_user_cursor for
		select client_id, social_user_name, user_full_name, 
		email_id, created_date,dob,gender,mobile_no,user_guid,first_name,last_name,updated_date
		from labkxip.labkxip_web_user a,
		jsonb_array_elements_text(v_json_data) as b
		where  a.user_id::text=b.value
		order by created_date desc
		;
		
		end if;
		
-----------------------------------------------------------------------------------------------		
if v_opt_type = 7 then
    open p_user_cursor for
	with questionnaire_data as (
       select 
           c.contact_id,
		   q->>'question_id' as q_id,
		   q->>'question_type' as q_type,
		   q->>'response' as q_response,
		   q->'options' as q_options
		from labkxip.labkxip_contact c
        cross join jsonb_array_elements(
            coalesce(c.contact_json->'data'->'questionnaire', '[]'::jsonb)) q
		where lower(c.contact_json->'data'->>'campaign_name') = 'test_campaign' 
        and c.created_date::date between v_start_date_time::date and v_end_date_time::date
        and c.contact_json->'data'->'questionnaire' is not null  
	),
	formatted_responses as (
       select 
           contact_id, q_id,
		  case
		     when q_type = 'single_choice' then
			   coalesce((select opt->>'label' from jsonb_array_elements(coalesce(q_options, '[]'::jsonb)) opt 
                    where (opt->>'option_id')::int = (q_response)::int limit 1), 'Option ' || coalesce(q_response, ''))
			 when q_type = 'multiple_choice' then
			   coalesce((select string_agg(opt->>'label', ', ' order by (opt->>'option_id')::int) from jsonb_array_elements(
                        coalesce(q_options, '[]'::jsonb)) opt where (opt->>'option_id')::int = any(select jsonb_array_elements_text(
                            coalesce(q_response::jsonb, '[]'::jsonb))::int)),'Options: ' || coalesce(q_response::text, ''))
			 when q_type = 'yes_no' then
			   case
			     when q_response = 'true' then 'Yes'
				 when q_response = 'false' then 'No'
				 else coalesce(q_response, '')
			   end
		     else
		       coalesce(q_response, '')
		  end as formatted_response
		from questionnaire_data
	)
	select
	    c.contact_json->'data'->>'campaign_id' as campaign_id,
		c.contact_json->'data'->>'campaign_name' as campaign_name,
		c.contact_json->'data'->>'form_name' as form_name,
	    coalesce(c.contact_json->'data'->'user_info'->>'first_name', '') as first_name,
		coalesce(c.contact_json->'data'->'user_info'->>'last_name', '') as last_name,
		coalesce(c.contact_json->'data'->'user_info'->>'email_id', '') as email_id,
		coalesce(c.contact_json->'data'->'user_info'->>'mobile_no', '') as mobile_number,
        coalesce(c.contact_json->'data'->'user_info'->>'gender', c.contact_json->'data'->>'gender', c.gender, '') as gender,
        coalesce(c.contact_json->'data'->'user_info'->>'city', c.contact_json->'data'->>'city', c.city, '') as city,
		coalesce(c.contact_json->'data'->'user_info'->>'state', c.contact_json->'data'->>'state', c.state, '') as state,
		coalesce(c.contact_json->'data'->'user_info'->>'country_name', c.contact_json->'data'->>'country_name', '') as country_name,
		coalesce(c.contact_json->'data'->>'jersey_number', '') as jersey_number,
		coalesce(c.contact_json->'data'->>'favourite_player', '') as favourite_player,
		max(case when fr.q_id = '1' then fr.formatted_response end) as question_1_response,
		max(case when fr.q_id = '2' then fr.formatted_response end) as question_2_response,
		max(case when fr.q_id = '3' then fr.formatted_response end) as question_3_response,
		max(case when fr.q_id = '4' then fr.formatted_response end) as question_4_response,
		to_char(c.created_date + interval '5 hours 30 minutes', 'DD-MM-YYYY HH24:MI:SS') as submission_date
    from labkxip.labkxip_contact c
	left join formatted_responses fr on c.contact_id = fr.contact_id
    where lower(c.contact_json->'data'->>'campaign_name') = 'test_campaign'
    and c.created_date::date between v_start_date_time::date and v_end_date_time::date
    group by 
	    c.contact_id,
		c.contact_json,
		c.name,
		c.email_address,
		c.mobile_number,
		c.gender,
		c.city,
		c.state,
		c.created_date
	order by c.created_date;
	return next p_user_cursor; 
end if;

-----------------------------------------------------------------------------------------------
if v_opt_type = 8 then
    open p_user_cursor for

	with questionnaire_data as (select c.contact_id, q->>'question_id' as q_id, q->>'question_type' as q_type, q->>'response' as q_response, q->'options' as q_options 
		from labkxip.labkxip_contact c 
		cross join jsonb_array_elements(coalesce(c.contact_json->'data'->'questionnaire', '[]'::jsonb)) q where lower(c.contact_json->'data'->>'campaign_name') = 'lohri' and c.created_date::date between v_start_date_time::date and v_end_date_time::date and c.contact_json->'data'->'questionnaire' is not null),
	formatted_responses as (
		select contact_id, q_id,
			case
				when q_type = 'single_choice' then coalesce((select opt->>'label' from jsonb_array_elements(coalesce(q_options, '[]'::jsonb)) opt where (opt->>'option_id')::int = (q_response)::int limit 1), 'Option ' || coalesce(q_response, ''))
				else coalesce(q_response, '')
			end as formatted_response
		from questionnaire_data)
	select
	    c.contact_json->'data'->>'campaign_id' as campaign_id,
		c.contact_json->'data'->>'campaign_name' as campaign_name,
		c.contact_json->'data'->>'form_name' as form_name,
	    coalesce(c.contact_json->'data'->'user_info'->>'first_name', '') as first_name,
	    coalesce(c.contact_json->'data'->'user_info'->>'last_name', '') as Last_name,
		coalesce(c.contact_json->'data'->'user_info'->>'mobile_no', '') as mobile_number,
		coalesce(c.contact_json->'data'->'user_info'->>'email_id', '') as email_id,
		coalesce(c.contact_json->'data'->>'dob', '') as birthday,
        coalesce(c.contact_json->'data'->'user_info'->>'gender', c.contact_json->'data'->>'gender', c.gender, '') as gender,
		max(case when fr.q_id = '1' then fr.formatted_response end) as question_1_response,
		max(case when fr.q_id = '2' then fr.formatted_response end) as question_2_response,
		to_char(c.created_date + interval '5 hours 30 minutes', 'DD-MM-YYYY HH24:MI:SS') as submission_date
    from labkxip.labkxip_contact c
	left join formatted_responses fr on c.contact_id = fr.contact_id
    where lower(c.contact_json->'data'->>'campaign_name') = 'lohri'
    and c.created_date::date between v_start_date_time::date and v_end_date_time::date
    group by 
	    c.contact_id,
		c.contact_json,
		c.first_name,
		c.last_name,
		c.gender,
		c.created_date
	order by c.created_date;
	return next p_user_cursor; 
end if;

-----------------------------------------------------------------------------------------------
if v_opt_type = 9 then
    open p_user_cursor for

	with questionnaire_data as (select c.contact_id, q->>'question_id' as q_id, q->>'question_type' as q_type, q->>'response' as q_response, q->'options' as q_options 
		from labkxip.labkxip_contact c 
		cross join jsonb_array_elements(coalesce(c.contact_json->'data'->'questionnaire', '[]'::jsonb)) q where lower(c.contact_json->'data'->>'campaign_name') = 'arsh_da_birthday' and c.created_date::date between v_start_date_time::date and v_end_date_time::date and c.contact_json->'data'->'questionnaire' is not null),
	formatted_responses as (
		select contact_id, q_id,
			case
				when q_type = 'single_choice' then coalesce((select opt->>'label' from jsonb_array_elements(coalesce(q_options, '[]'::jsonb)) opt where (opt->>'option_id')::int = (q_response)::int limit 1), 'Option ' || coalesce(q_response, ''))
				else coalesce(q_response, '')
			end as formatted_response
		from questionnaire_data)
	select
	    c.contact_json->'data'->>'campaign_id' as campaign_id,
		c.contact_json->'data'->>'campaign_name' as campaign_name,
		c.contact_json->'data'->>'form_name' as form_name,
	    coalesce(c.contact_json->'data'->'user_info'->>'first_name', '') as first_name,
	    coalesce(c.contact_json->'data'->'user_info'->>'last_name', '') as Last_name,
		coalesce(c.contact_json->'data'->'user_info'->>'mobile_no', '') as mobile_number,
		coalesce(c.contact_json->'data'->'user_info'->>'email_id', '') as email_id,
		coalesce(c.contact_json->'data'->>'dob', '') as birthday,
        coalesce(c.contact_json->'data'->'user_info'->>'gender', c.contact_json->'data'->>'gender', c.gender, '') as gender,
		max(case when fr.q_id = '1' then fr.formatted_response end) as question_1_response,
		max(case when fr.q_id = '2' then fr.formatted_response end) as question_2_response,
		to_char(c.created_date + interval '5 hours 30 minutes', 'DD-MM-YYYY HH24:MI:SS') as submission_date
    from labkxip.labkxip_contact c
	left join formatted_responses fr on c.contact_id = fr.contact_id
    where lower(c.contact_json->'data'->>'campaign_name') = 'arsh_da_birthday'
    and c.created_date::date between v_start_date_time::date and v_end_date_time::date
    group by 
	    c.contact_id,
		c.contact_json,
		c.first_name,
		c.last_name,
		c.gender,
		c.created_date
	order by c.created_date;
	return next p_user_cursor; 
end if;

-----------------------------------------------------------------------------------------------
if v_opt_type = 10 then
    open p_user_cursor for

	with questionnaire_data as (select c.contact_id, q->>'question_id' as q_id, q->>'question_type' as q_type, q->>'response' as q_response, q->'options' as q_options 
		from labkxip.labkxip_contact c 
		cross join jsonb_array_elements(coalesce(c.contact_json->'data'->'questionnaire', '[]'::jsonb)) q where lower(c.contact_json->'data'->>'campaign_name') = 'coffee_and_cricket_with_shashank_campaign' and c.created_date::date between v_start_date_time::date and v_end_date_time::date and c.contact_json->'data'->'questionnaire' is not null),
	formatted_responses as (
		select contact_id, q_id,
			case
				when q_type = 'single_choice' then coalesce((select opt->>'label' from jsonb_array_elements(coalesce(q_options, '[]'::jsonb)) opt where (opt->>'option_id')::int = (q_response)::int limit 1), 'Option ' || coalesce(q_response, ''))
				else coalesce(q_response, '')
			end as formatted_response
		from questionnaire_data)
	select
	    c.contact_json->'data'->>'campaign_id' as campaign_id,
		c.contact_json->'data'->>'campaign_name' as campaign_name,
		c.contact_json->'data'->>'form_name' as form_name,
	    coalesce(c.contact_json->'data'->'user_info'->>'first_name', '') as full_name,
		coalesce(c.contact_json->'data'->'user_info'->>'mobile_no', '') as mobile_number,
		coalesce(c.contact_json->'data'->'user_info'->>'email_id', '') as email_id,
		coalesce(c.contact_json->'data'->>'dob', '') as birthday,
        coalesce(c.contact_json->'data'->'user_info'->>'gender', c.contact_json->'data'->>'gender', c.gender, '') as gender,
		max(case when fr.q_id = '1' then fr.formatted_response end) as question_1_response,
		max(case when fr.q_id = '2' then fr.formatted_response end) as question_2_response,
		to_char(c.created_date + interval '5 hours 30 minutes', 'DD-MM-YYYY HH24:MI:SS') as submission_date
    from labkxip.labkxip_contact c
	left join formatted_responses fr on c.contact_id = fr.contact_id
    where lower(c.contact_json->'data'->>'campaign_name') = 'coffee_and_cricket_with_shashank_campaign'
    and c.created_date::date between v_start_date_time::date and v_end_date_time::date
    group by 
	    c.contact_id,
		c.contact_json,
		c.first_name,
		c.last_name,
		c.gender,
		c.created_date
	order by c.created_date;
	return next p_user_cursor; 
end if;

-----------------------------------------------------------------------------------------------

end;
$$;


--
