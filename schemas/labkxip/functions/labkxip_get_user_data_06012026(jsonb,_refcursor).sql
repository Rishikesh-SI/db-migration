-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_get_user_data_06012026(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labkxip_get_user_data_06012026(jsonb, refcursor); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_get_user_data_06012026(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labkxip.labkxip_get_user_data_06012026
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

	if v_opt_type = 3 then
    
    	 open p_user_cursor for
		 select name as user_full_name,email_address as email_id,first_name,last_name
		 from labkxip.labkxip_contact
		 where created_date between v_start_date_time and v_end_date_time;
		 end if;
         
   if v_opt_type =4 then
  
  	open p_user_cursor for 
  		select * from labkxip.labkxip_otp_details order by created_date desc limit 10;
	
  end if;

if v_opt_type = 5 then
    
    	 open p_user_cursor for
		 select *
		 from labkxip.labkxip_web_user
		 where created_date::date between v_start_date_time and v_end_date_time
         order by created_date desc;
end if;

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
 
 
 
end;
$$;


--
