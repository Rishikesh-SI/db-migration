-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_get_user_data_backup_22september2026(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labdd_v1_get_user_data_backup_22september2026(jsonb, refcursor); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_get_user_data_backup_22september2026(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labdd_v1.labdd_v1_get_user_data_Backup_22September2026
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
	v_string_array text;
    v_array numeric[];
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
 
----------------------------------------------------------------------------------- 
 
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labdd_v1.labdd_v1_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labdd_v1.labdd_v1_web_user wu
          join labdd_v1.labdd_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labdd_v1.labdd_v1_web_user wu
          join labdd_v1.labdd_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labdd_v1.labdd_v1_web_user wu
          join labdd_v1.labdd_v1_asset_comment_reaction acr
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

-----------------------------------------------------------------------------------

-- 	if v_opt_type = 2 then
    
--     	 open p_user_cursor for
--          	select case al.asset_type_id when 1 then 'Article' when 2 then 'Album' when 4 then 'Video' end as asset_type, al.asset_title, al.title_alias,
-- 			sum(reaction_count) as reaction_count, sum(comment_count) as comment_count
-- 			from (select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labdd_v1.labdd_v1_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		and reaction_id <> 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
--       		from labdd_v1.labdd_v1_user_asset_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--      		 and reaction_id = 4
--       		group by asset_id, asset_type_id
--       		union
--       		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
--       		from labdd_v1.labdd_v1_asset_comment_reaction
--       		where reaction_date::date between v_start_date_time and v_end_date_time
--       		group by asset_id, asset_type_id) as tab
-- 			join labdd_v1.labdd_v1_asset_list al
-- 			on al.asset_id = tab.asset_id
-- 			and al.asset_type_id = tab.asset_type_id
-- 			group by al.asset_type_id, al.asset_title, al.title_alias
-- 			order by al.asset_type_id, al.asset_title;
--     end if;

-----------------------------------------------------------------------------------

 if v_opt_type = 2 then
  raise notice 'v_array';
    select p_input_json->'jsondata'->>'user_id' into v_string_array;
   
   select string_to_array(v_string_array,',')::numeric[] into v_array;
    
    open p_user_cursor for
    select wu.user_id,wu.first_name as first_name,
	wu.last_name as last_name,
	wu.email_id as email_id,
	wu.mobile_no as mobile_no,
    ws.name as state_name
    from labdd_v1.labdd_v1_web_user wu
    left join waf_master.waf_states ws on ws.state_id=wu.state_id   
    where wu.user_id= any(v_array);
    
    end if;
	
	 if v_opt_type =3 then
  
  	open p_user_cursor for 
   		select * from labdd_v1.labdd_v1_otp_details order by created_date desc limit 10;

	
  end if;
  
-----------------------------------------------------------------------------------
  
if v_opt_type= 4 then 
    OPEN p_user_cursor FOR
SELECT 
    contact_json->'data'->'user_info'->>'first_name' AS first_name,
    contact_json->'data'->'user_info'->>'last_name'  AS last_name,
    contact_json->'data'->'user_info'->>'email_id'   AS email_id,
    contact_json->'data'->'user_info'->>'mobile_no'  AS mobile_no,
    contact_json->'data'->'user_info'->>'city'       AS city,
    contact_json->'data'->'user_info'->>'age'        AS age,
    contact_json->'data'->'user_info'->>'country_name' AS country_name,
    contact_json->'data'->'user_info'->>'country_id'   AS country_id,
    contact_json->'data'->'user_info'->>'country_code' AS country_code,
    contact_json->'data'->'user_info'->>'custom_fields' AS message,
    --contact_json->'data'->>'client_id' AS client_id,
    --contact_json->'data'->>'form_name' AS form_name,
    --contact_json->'data'->>'page_flag' AS page_flag,
    contact_json->'data'->>'user_guid' AS user_guid,
    contact_json->'data'->>'accept_tnc' AS accept_tnc,
    --contact_json->'data'->>'is_used_data' AS is_used_data,
    contact_json->'data'->>'campaign_name' AS campaign_name,
    created_date + interval '5 hours 30 minutes' AS submit_date,
    --contact_json->'data'->>'is_shared_data' AS is_shared_data,
    unique_id,
    (contact_json::json->'data'->'quiz_module'->>'response_1')::text AS "year DC got in first IPL final",
    (contact_json::json->'data'->'quiz_module'->>'response_2')::text AS "current captain of Delhi Capitals"
FROM labdd_v1.labdd_v1_contact
WHERE lower(contact_json::json->'data'->>'campaign_name') = 'dc_fanform_2025'
  AND created_date::date BETWEEN v_start_date_time AND v_end_date_time
  order by created_date;

END IF;

-----------------------------------------------------------------------------------
  
if v_opt_type= 5 then 
    OPEN p_user_cursor FOR
SELECT 
    contact_json->'data'->'user_info'->>'first_name' AS first_name,
    contact_json->'data'->'user_info'->>'last_name'  AS last_name,
    contact_json->'data'->'user_info'->>'email_id'   AS email_id,
    contact_json->'data'->'user_info'->>'mobile_no'  AS mobile_no,
    contact_json->'data'->'user_info'->>'city'       AS city,
    contact_json->'data'->'user_info'->>'age'        AS age,
	contact_json->'data'->'user_info'->>'gender'        AS gender,
    contact_json->'data'->'user_info'->>'country_name' AS country_name,
    contact_json->'data'->'user_info'->>'country_id'   AS country_id,
    contact_json->'data'->'user_info'->>'country_code' AS country_code,
    --contact_json->'data'->'user_info'->>'custom_fields' AS message,
    --contact_json->'data'->>'client_id' AS client_id,
    --contact_json->'data'->>'form_name' AS form_name,
    --contact_json->'data'->>'page_flag' AS page_flag,
    contact_json->'data'->>'user_guid' AS user_guid,
    contact_json->'data'->>'accept_tnc' AS accept_tnc,
    --contact_json->'data'->>'is_used_data' AS is_used_data,
    contact_json->'data'->>'campaign_name' AS campaign_name,
    created_date + interval '5 hours 30 minutes' AS submit_date,
    --contact_json->'data'->>'is_shared_data' AS is_shared_data, 
	unique_id,
    (contact_json::json->'data'->'quiz_module'->>'response_1')::text AS "Where did DC finish in IPL 2025"
FROM labdd_v1.labdd_v1_contact
WHERE lower(contact_json::json->'data'->>'campaign_name') = 'diwali grand lucky draw'
  AND created_date::date BETWEEN v_start_date_time AND v_end_date_time
  order by created_date;

END IF;

-----------------------------------------------------------------------------------

if v_opt_type= 6 then 
    OPEN p_user_cursor FOR
SELECT 
    contact_json->'data'->'user_info'->>'first_name' AS first_name,
    contact_json->'data'->'user_info'->>'last_name'  AS last_name,
    contact_json->'data'->'user_info'->>'email_id'   AS email_id,
    contact_json->'data'->'user_info'->>'mobile_no'  AS mobile_no,
    contact_json->'data'->'user_info'->>'city'       AS city,
    contact_json->'data'->'user_info'->>'age'        AS age,
	contact_json->'data'->'user_info'->>'gender'        AS gender,
    contact_json->'data'->'user_info'->>'country_name' AS country_name,
    contact_json->'data'->'user_info'->>'country_id'   AS country_id,
    contact_json->'data'->'user_info'->>'country_code' AS country_code,
    --contact_json->'data'->'user_info'->>'custom_fields' AS message,
    --contact_json->'data'->>'client_id' AS client_id,
    --contact_json->'data'->>'form_name' AS form_name,
    --contact_json->'data'->>'page_flag' AS page_flag,
    contact_json->'data'->>'user_guid' AS user_guid,
    contact_json->'data'->>'accept_tnc' AS accept_tnc,
    --contact_json->'data'->>'is_used_data' AS is_used_data,
    contact_json->'data'->>'campaign_name' AS campaign_name,
    created_date + interval '5 hours 30 minutes' AS submit_date,
    --contact_json->'data'->>'is_shared_data' AS is_shared_data, 
	unique_id,
    (contact_json::json->'data'->'quiz_module'->>'response_1')::text AS "Runs Ashutosh Sharma score against LSG?"
FROM labdd_v1.labdd_v1_contact
WHERE lower(contact_json::json->'data'->>'campaign_name') = 'ipl auction campaign'
  AND created_date::date BETWEEN v_start_date_time AND v_end_date_time
  order by created_date;
  
END IF;  

-----------------------------------------------------------------------------------
  
if v_opt_type= 7 then 
    OPEN p_user_cursor FOR
SELECT 
    contact_json->'data'->'user_info'->>'first_name' AS first_name,
    contact_json->'data'->'user_info'->>'last_name'  AS last_name,
    contact_json->'data'->'user_info'->>'email_id'   AS email_id,
    contact_json->'data'->'user_info'->>'mobile_no'  AS mobile_no,
    contact_json->'data'->'user_info'->>'city'       AS city,
    contact_json->'data'->'user_info'->>'age'        AS age,
	contact_json->'data'->'user_info'->>'gender'        AS gender,
    contact_json->'data'->'user_info'->>'country_name' AS country_name,
    contact_json->'data'->'user_info'->>'country_id'   AS country_id,
    contact_json->'data'->'user_info'->>'country_code' AS country_code,
    contact_json->'data'->>'user_guid' AS user_guid,
    contact_json->'data'->>'accept_tnc' AS accept_tnc,
    contact_json->'data'->>'campaign_name' AS campaign_name,
    created_date + interval '5 hours 30 minutes' AS submit_date,
	unique_id
FROM labdd_v1.labdd_v1_contact
WHERE lower(contact_json::json->'data'->>'campaign_name') = 'ipl_ticketing_campaign'
  AND created_date::date BETWEEN v_start_date_time AND v_end_date_time
  order by created_date;

END IF;

-----------------------------------------------------------------------------------

end;

$$;


--
