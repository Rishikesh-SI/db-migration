-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_user_data_08042019(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labmi_v1_get_user_data_08042019(jsonb, refcursor); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_user_data_08042019(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labmi_v1.labmi_v1_get_user_data
(
    '{
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
    
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time'
    into v_start_date_time, v_end_date_time;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count,
                (select ((count(1)*100)/8)
                from (select unnest(array['user_full_name','dob','email_id','mobile_no','state_id','city_id','gender','profile_picture_url']) as "columns",
                      			unnest(array[user_full_name,dob,email_id,mobile_no,state_id::text,city_id::text,gender,profile_picture_url]) as "values"
                      from labmi_v1.labmi_v1_web_user wu1
                      where wu1.user_id = wu.user_id
                     ) as a
                 where values is not null) as profile_completion_percentage, (wu.created_date + '5.5 hours'::interval) as registration_date
    from (select user_id, sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
          from (
        select user_id, 0 as reaction_count, 0 as comment_count
          from labmi_v1.labmi_v1_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select user_id, count(1) as reaction_count, 0 as comment_count
          from labmi_v1.labmi_v1_user_asset_reaction uar
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by user_id
          union
          select user_id, 0 as reaction_count, count(1) as comment_count
          from labmi_v1.labmi_v1_user_asset_reaction uar
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by user_id
          union
          select user_id, count(1) as reaction_count, 0 as comment_count
          from labmi_v1.labmi_v1_asset_comment_reaction acr
          where acr.reaction_date between v_start_date_time and v_end_date_time
          group by user_id
              ) as tab1
          group by user_id
         ) as tab
	join labmi_v1.labmi_v1_web_user wu
    on wu.user_id = tab.user_id
	left join waf_master.waf_cities c
     on c.city_id = wu.city_id
     left join waf_master.waf_states s
     on s.state_id = wu.state_id
     left join waf_master.waf_countries co
     on co.country_id = wu.country_id;
    
end;

$$;


--
