-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labbsc_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
select * from labbsc.labbsc_get_user_data
(
    '{
    "opt_type": 3,
  "start_date_time": "2019-04-08 20:00:00",
  "end_date_time": "2019-04-08 23:59:59"
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
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
  
 if v_opt_type = 1 then
    open p_user_cursor for
    select case client_id when 2 then 'Facebook' when 3 then 'Twitter' when 4 then 'Google+' when 5 then 'Custom' end as source, social_user_name,
    			user_full_name, email_id, dob, mobile_no, gender, c.name as city, s.name as state, co.name as country, reaction_count, comment_count
    from (select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		0 as comment_count
          from labbsc.labbsc_web_user wu
          where created_date between v_start_date_time and v_end_date_time
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labbsc.labbsc_web_user wu
          join labbsc.labbsc_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id <> 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id, 0 as reaction_count,
          		count(1) as comment_count
          from labbsc.labbsc_web_user wu
          join labbsc.labbsc_user_asset_reaction uar
          on uar.user_id = wu.user_id
          where uar.reaction_date between v_start_date_time and v_end_date_time
          and uar.reaction_id = 4
          group by client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id
          union
          select client_id, social_user_name, user_full_name, email_id, dob, mobile_no, gender, city_id, state_id, country_id,
          		count(1) as reaction_count, 0 as comment_count
          from labbsc.labbsc_web_user wu
          join labbsc.labbsc_asset_comment_reaction acr
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
      		from labbsc.labbsc_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		and reaction_id <> 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, 0 as reaction_count, count(1) as comment_count
      		from labbsc.labbsc_user_asset_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
     		 and reaction_id = 4
      		group by asset_id, asset_type_id
      		union
      		select asset_id, asset_type_id, count(1) as reaction_count, 0 as comment_count
      		from labbsc.labbsc_asset_comment_reaction
      		where reaction_date::date between v_start_date_time and v_end_date_time
      		group by asset_id, asset_type_id) as tab
			join labbsc.labbsc_asset_list al
			on al.asset_id = tab.asset_id
			and al.asset_type_id = tab.asset_type_id
			group by al.asset_type_id, al.asset_title, al.title_alias
			order by al.asset_type_id, al.asset_title;
			
			 end if;
    
   if v_opt_type = 3 then 
open p_user_cursor for
 select  cw.client_mod_json->'data'->'aboutMe'->>'f_name' as  first_name,
 cw.client_mod_json->'data'->'aboutMe'->>'l_name' as  last_name,
 cw.client_mod_json->'data'->'aboutMe'->>'mobile' as mobile_no
 from labbsc.labbsc_web_user wu
  join labbsc.labbsc_client_web_cust_model cw
  on cw.user_guid=wu.user_guid
 ;
 end if;
 
 if v_opt_type = 4 then ---- profile data
 
 open p_user_cursor for
  select  cw.client_mod_json->'data'->'aboutMe'->>'f_name' as  first_name,
 cw.client_mod_json->'data'->'aboutMe'->>'l_name' as  last_name,
 cw.client_mod_json->'data'->'aboutMe'->>'mobile' as mobile_no,
 cw.client_mod_json->'data'->'aboutMe'->>'city' as city,
 cw.client_mod_json->'data'->'aboutMe'->>'pin' as pincode,
  cw.client_mod_json->'data'->'aboutMe'->>'email' as email_id, 
  cw.client_mod_json->'data'->'aboutMe'->>'state' as state,
  cw.client_mod_json->'data'->'aboutMe'->>'country' as country,
  cw.client_mod_json->'data'->'aboutMe'->>'dob_date' as dob,
  cw.client_mod_json->'data'->'aboutMe'->>'dob_year' as dob_year,
   cw.client_mod_json->'data'->'aboutMe'->>'imageUpload' as profile_picture_url,
   cw.client_mod_json->'data'->'aboutMe'->>'college_name' as college,
   cw.client_mod_json->'data'->'aboutMe'->>'address_line1' as address_line1,
   cw.client_mod_json->'data'->'aboutMe'->>'address_line2' as address_line2,
      cw.client_mod_json->'data'->'aboutMe'->>'work_exp_year' as work_exp_year,
   cw.client_mod_json->'data'->'aboutMe'->>'specialisation' as specialisation,
   cw.client_mod_json->'data'->'aboutMe'->>'work_exp_month' as work_exp_month,
   cw.client_mod_json->'data'->'aboutMe'->>'alternate_email' as alternate_email_id,
   cw.client_mod_json->'data'->'aboutMe'->>'education_other' as education,
   cw.client_mod_json->'data'->'aboutMe'->>'is_custom_image' as is_custom_image,
   cw.client_mod_json->'data'->'aboutMe'->>'alternate_mobile' as alternate_mobile_no,
   cw.client_mod_json->'data'->'aboutMe'->>'work_exp' as work_exp,
   cw.client_mod_json->'data'->>'form_submitted' as form_submitted,
   cw.client_mod_json->'data'->>'world_of_sport' as world_of_sport,
   cw.client_mod_json->'data'->>'change_in_sports' as change_in_sports,
   cw.client_mod_json->'data'->>'me_and_my_sports' as me_and_my_sports,
   cw.client_mod_json->'data'->>'profile_percentage' as profile_percentage,
   cw.client_mod_json->'data'->>'me_and_working_in_sports' as me_and_working_in_sports,
   cw.client_mod_json->'data'->>'page_flag' as page_flag 
   
 from labbsc.labbsc_web_user wu
  join labbsc.labbsc_client_web_cust_model cw
  on cw.user_guid=wu.user_guid 
  where cw.module_name='user_profile';
 
 end if;
 
 if v_opt_type = 5 then ---- invoice data
 
 open p_user_cursor for
 select first_name ,state_name as state ,
 pan_number,gst_number,bill_date,bill_no,
 transaction_id,transaction_status,invoice_id,invoice_status,
		total_amount,taxable_amount,tax_rate,
		case when coalesce(is_state,0)=1 then igst else null end as igst,
		case when coalesce(is_state,0)=0 then cgst else null end as cgst,
		case when coalesce(is_state,0)=0 then sgst else null end as sgst,
		service_type,sac_code,created_date,coalesce(merchant_name,'SPORSCORR') as service_code
	from labbsc.labbsc_invoice_detail	
	where created_date>=v_start_date_time
	and created_date<=v_end_date_time
	order by created_date asc;
 
 end if;
 
 if v_opt_type = 6 then ---- Ambassador data
 
 open p_user_cursor for
 select distinct user_name,email_id,contact,college_name
 from (
 select   client_mod_json->'data'->'user_data'->>'Name' as user_name,
 client_mod_json->'data'->'user_data'->>'Email' as email_id,
 client_mod_json->'data'->'user_data'->>'Contact' as contact,
	 client_mod_json->'data'->'user_data'->>'CollegeName' as college_name,
 created_date
 from labbsc.labbsc_client_web_cust_model
 where module_name='sporjo - campusprogram'
 and client_mod_json is not null
 and created_date>=v_start_date_time
	and created_date<=v_end_date_time
	order by created_date asc) row;
 end if;
 
end;
$$;


--
