-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_user_profile_r(character varying)
-- Type: FUNCTION

-- Name: labbsc_get_user_profile_r(character varying); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_user_profile_r(p_user_guid character varying, OUT p_result numeric, OUT p_profile_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_id numeric;
	v_email_id text;
	v_profile_picture_url text;
	v_first_name text;
	v_last_name text;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_edit_enable numeric := 1;
	v_address1 text;
	v_address2 text;
	v_city_id text;
	v_city text;
	v_state_id text;
	v_state text;
	v_country_id text;
	v_country text;
	v_pin_code text;
	v_mobile_number text;
	v_pan_number text;
	v_gst_number text;
begin
	
	p_result := 0;
	
	/*select user_id, email_id, profile_picture_url, first_name, last_name
	into strict v_user_id, v_email_id, v_profile_picture_url, v_first_name, v_last_name
	from labbsc.labbsc_web_user
	where user_guid = p_user_guid;*/
	
	begin
		
		select client_mod_json
		into strict p_profile_json
		from labbsc.labbsc_client_web_cust_model
		where user_guid = p_user_guid
		and module_name = 'user_profile';
		
		if exists(select 1
				  from labbsc.labbsc_user_tests
				  where user_id  = v_user_id
				  and is_attempted = 1
				  and attempted_on + (test_duration::text||' hours')::interval >= v_current_timestamp) then
			
			v_edit_enable := 0;
			
		end if;
		
		p_profile_json := jsonb_set(p_profile_json,'{enable_edit}',('"'||v_edit_enable||'"')::text::jsonb,true);
		
	exception
		when no_data_found then
			
		--	raise notice '%',v_user_id;
			 
		select user_id, email_id, profile_picture_url
	   into strict v_user_id, v_email_id, v_profile_picture_url
	   from labbsc.labbsc_web_user
	   where user_guid = p_user_guid;
	 	
			select   billing_details_json->>'firstname'  ,
					   billing_details_json->>'lastname' ,
					billing_details_json->>'address1', billing_details_json->>'address2', billing_details_json->>'city_id',
					billing_details_json->>'city', billing_details_json->>'state_id', billing_details_json->>'state',
					billing_details_json->>'country_id', billing_details_json->>'country', billing_details_json->>'zip',
					billing_details_json->>'mobile',
					billing_details_json->>'pancard_number',
					billing_details_json->>'gst_number'
			into v_first_name, v_last_name, v_address1, v_address2, v_city_id, v_city, v_state_id, v_state, v_country_id, v_country, v_pin_code,
					v_mobile_number,v_pan_number,v_gst_number
			from labbsc.labbsc_purchase_order
			where cart_id = (select cart_id
							 from labbsc.labbsc_cart
							 where user_id = v_user_id
							 and status = 2
							 order by updated_date desc
							 limit 1);
	if (coalesce(v_first_name,'') ='' or  coalesce(v_last_name,'')='')	 then	 
	  select user_id, email_id, profile_picture_url, first_name, last_name
	   into strict v_user_id, v_email_id, v_profile_picture_url, v_first_name, v_last_name
	   from labbsc.labbsc_web_user
	   where user_guid = p_user_guid;			 
				end if;			 
							 
		
			p_profile_json := '{
  "data": {
    "aboutMe": {
      "pin": "'||coalesce(v_pin_code,'')||'",
      "city_id": "'||coalesce(v_city_id,'')||'",
      "city": "'||coalesce(v_city,'')||'",
      "email": "'||coalesce(v_email_id,'')||'",
      "m_nam": "",
      "state_id": "'||coalesce(v_state_id,'')||'",
      "state": "'||coalesce(v_state,'')||'",
      "f_name": "'||coalesce(v_first_name,'')||'",
      "l_name": "'||coalesce(v_last_name,'')||'",
      "mobile": "'||coalesce(v_mobile_number,'')||'",
      "country_id": "'||coalesce(v_country_id,'')||'",
      "country": "'||coalesce(v_country,'')||'",
      "dob_date": "",
      "dob_year": "",
      "work_exp": [
        {
          "year": "",
          "month": "",
          "position": "",
          "start_date": "",
          "organisation": ""
        }
      ],
      "dob_month": "",
      "education": "",
      "imageUpload": "'||coalesce(v_profile_picture_url,'')||'",
      "college_name": "",
      "address_line1": "'||coalesce(v_address1,'')||'",
      "address_line2": "'||coalesce(v_address2,'')||'",
      "work_exp_year": "",
      "specialisation": "",
      "work_exp_month": "",
      "alternate_email": "",
      "education_other": "",
      "alternate_mobile": ""
    },
    "user_guid": "'||p_user_guid||'",
    "module_name": "user_profile",
    "world_of_sport": {
      "consumed_on_tv": [
        {
          "channel": "NA",
          "consumeTime": {
            "consumed_on_hh": "0",
            "consumed_on_mm": "0"
          }
        }
      ],
      "consumed_on_app": [
        {
          "app_name": "NA",
          "consumeTime": {
            "consumed_on_hh": "0",
            "consumed_on_mm": "0"
          }
        }
      ],
      "consumed_on_web": [
        {
          "website": "NA",
          "consumeTime": {
            "consumed_on_hh": "0",
            "consumed_on_mm": "0"
          }
        }
      ],
      "sporting_moment": "",
      "sports_to_watch": "",
      "consumed_on_news": [
        {
          "consumeTime": {
            "consumed_on_hh": "0",
            "consumed_on_mm": "0"
          },
          "publication": "NA"
        }
      ],
      "consumed_on_social": [
        {
          "consumeTime": {
            "consumed_on_hh": "0",
            "consumed_on_mm": "0"
          },
          "social_medium": "NA"
        }
      ],
      "what_favourite_sport": "",
      "consumed_on_streaming": [
        {
          "consumeTime": {
            "consumed_on_hh": "0",
            "consumed_on_mm": "0"
          },
          "streaming_medium": "NA"
        }
      ],
      "consumed_on_tv_add_hr": 0,
      "favourite_sports_team": "",
      "consumed_on_app_add_hr": 0,
      "consumed_on_web_add_hr": 0,
      "favourite_sportsperson": "",
      "consumed_on_news_add_hr": 0,
      "consumed_on_social_add_hr": 0,
      "favourite_sporting_moment": "",
      "why_favourite_sports_team": "",
      "why_favourite_sportsperson": "",
      "consumed_on_streaming_add_hr": 0,
      "total_consumption_time_hh_tv": 0,
      "total_consumption_time_mm_tv": 0,
      "total_consumption_time_hh_app": 0,
      "total_consumption_time_hh_web": 0,
      "total_consumption_time_mm_app": 0,
      "total_consumption_time_mm_web": 0,
      "total_consumption_time_hh_news": 0,
      "total_consumption_time_mm_news": 0,
      "total_consumption_time_hh_social": 0,
      "total_consumption_time_mm_social": 0,
      "total_consumption_time_hh_streaming": 0,
      "total_consumption_time_mm_streaming": 0
    },
    "change_in_sports": {
      "rules_not_suited": "",
      "rules_like_to_improve": "",
      "transformation_in_sport": ""
    },
    "me_and_my_sports": {
      "why": "",
      "love_sports": "",
      "following_sports": [],
      "favourite_Sports_to_play": ""
    },
    "me_and_working_in_sports": {
      "why": "",
      "work_in_sport": "",
      "sport_interest": "",
      "work_in_this_role": ""
    }
  },
  "page_flag": "1",
  "enable_edit": "1",
  "pancard_number": "'||coalesce(v_pan_number,'')||'",
  "gst_number": "'||coalesce(v_gst_number,'')||'"
}';
	
	end;
	
	if p_profile_json is not null then
		p_result := 1;
	end if;
	
exception
	when others then
		p_result := -1;
	
	when no_data_found then
		p_result := -2;
	
end;
$$;


--
