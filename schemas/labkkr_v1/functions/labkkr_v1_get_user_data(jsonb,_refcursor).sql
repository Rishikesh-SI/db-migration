-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labkkr_v1_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labkkr_v1.labkkr_v1_get_user_data
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
begin

-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'Download_user_data','logs',uuid_generate_v4(),p_input_json,current_timestamp,'labkkr_v1','logs');
 
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    v_start_date_time := v_start_date_time - '5.5 hours'::interval;
    v_end_date_time := v_end_date_time - '5.5 hours'::interval;
    
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labkkr_v1.labkkr_v1_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labkkr_v1.labkkr_v1_web_user wu
          join labkkr_v1.labkkr_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labkkr_v1.labkkr_v1_web_user wu
          join labkkr_v1.labkkr_v1_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labkkr_v1.labkkr_v1_web_user wu
          join labkkr_v1.labkkr_v1_asset_comment_reaction acr
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
      		from labkkr_v1.labkkr_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labkkr_v1.labkkr_v1_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labkkr_v1.labkkr_v1_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labkkr_v1.labkkr_v1_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
    end if;
 
 if v_opt_type = 3 then
		open p_user_cursor for
		 select pr.user_id,wu.first_name,wu.last_name,wu.email_id,po.option::json->>'player_name' player
		 from labkkr_v1.labkkr_v1_user_poll_response pr 
		 join labkkr_v1.labkkr_v1_poll_option po on pr.response_option_id=po.poll_option_id
		 join labkc_v1.labkc_v1_web_user wu using(user_id)
		 where pr.response_date::date between v_start_date_time and v_end_date_time and pr.poll_id=21;
end if;

if v_opt_type = 4 then

open p_user_cursor for
select * from labkc_v1.labkc_v1_otp_details where client_code='labkkr_v1' order by created_date desc limit 10;
end if;

if v_opt_type = 5 then 
open p_user_cursor for
select contact_json->'data'->'user_info'->>'first_name' as first_name,
	   contact_json->'data'->'user_info'->>'last_name'  as last_name,
	   contact_json->'data'->'user_info'->>'email_id'   as email_id,
	   contact_json->'data'->'user_info'->>'mobile_no'  as mobile_no,
	   contact_json->'data'->'user_info'->>'city'		as city,
	   contact_json->'data'->'user_info'->>'state'		as state,
	   contact_json->'data'->'user_info'->>'country_name'	as country,
	   contact_json->'data'->'user_info'->>'country_code' as country_code
from labkkr_v1.labkkr_v1_contact
where page_flag = 10 and (contact_json->'data'->>'campaign_name')='guwahati_ticket_interest_2024' and
         created_date::date between v_start_date_time and v_end_date_time
order by created_date desc;

end if;
 
 
 if v_opt_type = 6 then 
open p_user_cursor for
select contact_json->'data'->'user_info'->>'first_name' as first_name,
	   contact_json->'data'->'user_info'->>'last_name'  as last_name,
	   contact_json->'data'->'user_info'->>'email_id'   as email_id,
	   contact_json->'data'->'user_info'->>'mobile_no'  as mobile_no,
	   contact_json->'data'->'user_info'->>'city'		as city,
	   contact_json->'data'->'user_info'->>'state'		as state,
	   contact_json->'data'->'user_info'->>'country_name'	as country,
	   contact_json->'data'->'user_info'->>'country_code' as country_code
from labkkr_v1.labkkr_v1_contact
where page_flag = 10 and (contact_json->'data'->>'campaign_name')='knights_treasure' and
         created_date::date between v_start_date_time and v_end_date_time
order by created_date desc;

end if;

IF v_opt_type = 11 THEN 
    OPEN p_user_cursor FOR
    SELECT
        contact_json->'data'->'user_info'->>'mobile_no'                AS mobile_no,
        contact_json->'data'->'user_info'->>'dob'                      AS dob,
        contact_json->'data'->'user_info'->>'full_name'                AS full_name,
        contact_json->'data'->'user_info'->>'subling_full_name'        AS subling_full_name,
        contact_json->'data'->'user_info'->>'favourite_number'         AS favourite_number,
        contact_json->'data'->'user_info'->>'sibling_favourite_number' AS sibling_favourite_number,
        contact_json->'data'->'user_info'->>'address'                  AS address,
        contact_json->'data'->'user_info'->>'special_message'          AS special_message,
		created_date as submitted_date
    FROM labkkr_v1.labkkr_v1_contact
    WHERE page_flag = 10
      AND lower(contact_json->'data'->>'campaign_name') = 'raksha_bandhan_campaign'
      AND created_date::date BETWEEN v_start_date_time AND v_end_date_time
    ORDER BY created_date DESC;
END IF;

if  v_opt_type = 7 then	
		--select 1/0;

        open p_user_cursor for
		select a.email_id,a.mobile_no,a.first_name,a.last_name,a.country_code,a.gender,a.city,a.user_id, a.dob,d.name as country_name,a.created_date::date
		from labkc_v1.labkc_v1_web_user a
		join waf_master.waf_countries d
		on a.country_id = d.country_id 
		where created_date between v_start_date_time and v_end_date_time;
 end if;
 
 
 if  v_opt_type = 8 then	

        open p_user_cursor for
		select contact_json->'data'->'user_info'->>'first_name' as first_name,
			   contact_json->'data'->'user_info'->>'last_name'  as last_name,
			   contact_json->'data'->'user_info'->>'email_id'   as email_id,
			   contact_json->'data'->'user_info'->>'mobile_no'  as mobile_no,
			   contact_json->'data'->'user_info'->>'city'		as city,
			   contact_json->'data'->'user_info'->>'state'		as state,
			   contact_json->'data'->'user_info'->>'country_name'	as country_name,
			   contact_json->'data'->'user_info'->>'country_id'	as country_id,
			   contact_json->'data'->'user_info'->>'country_code' as country_code,
			   unique_id 
	   from labkkr_v1.labkkr_v1_contact
	   where (contact_json->'data'->>'campaign_name')='mockauction'  and
         created_date::date between v_start_date_time and v_end_date_time;

end if;

--------------
if  v_opt_type = 9 then	

        open p_user_cursor for
		select contact_json->'data'->'user_info'->>'first_name' as first_name,
			   contact_json->'data'->'user_info'->>'last_name'  as last_name,
			   contact_json->'data'->'user_info'->>'email_id'   as email_id,
			   contact_json->'data'->'user_info'->>'mobile_no'  as mobile_no,
			   contact_json->'data'->'user_info'->>'city'		as city,
			   contact_json->'data'->'user_info'->>'state'		as state,
			   contact_json->'data'->'user_info'->>'country_name'	as country_name,
			   contact_json->'data'->'user_info'->>'country_id'	as country_id,
			   contact_json->'data'->'user_info'->>'country_code' as country_code,
			   contact_json->'data'->'user_info'->>'tourCity' as tour_city,
			   unique_id 
			   
	   from labkkr_v1.labkkr_v1_contact
	   where (contact_json->'data'->>'campaign_name')='trophy_tour'  and
         created_date::date between v_start_date_time and v_end_date_time;

end if;
------------
if v_opt_type = 10 then 
 open p_user_cursor for
 select * from siwaf.siwaf_Client_logs
 where client_name in ('labkkr_v1') order by 1 desc limit 100;
 end if;
 
 
end;

$$;


--
