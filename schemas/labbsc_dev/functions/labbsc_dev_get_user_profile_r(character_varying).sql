-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_user_profile_r(character varying)
-- Type: FUNCTION

-- Name: labbsc_dev_get_user_profile_r(character varying); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_user_profile_r(p_user_guid character varying, OUT p_result numeric, OUT p_profile_json jsonb) RETURNS record
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
	v_profile_json jsonb;
	v_reg_mobile_no text;
	v_code text;
	v_test_id numeric;
	v_date date;
	v_url varchar(500);
	v_sporjo_module varchar(500);
	v_dob text;
	v_sports_vertical varchar(4000);
	v_module_name text;
	v_sport_interest varchar(4000);
	v_ext_info jsonb;
	v_vertical  text;
	v_service text;
begin
	
	p_result := 0;
	--profile_picture_url
	 select user_id, email_id, profile_picture_url, first_name, last_name,mobile_no,university_code,module_name,dob,sports_vertical,ext_info,service
	into strict v_user_id, v_email_id, v_profile_picture_url, v_first_name, v_last_name,v_reg_mobile_no,v_code,v_sporjo_module,v_dob,v_sports_vertical,v_ext_info,v_service
	from labbsc_dev.labbsc_dev_web_user
	where user_guid = p_user_guid;
	
	
	
	select module_name ,client_mod_json->'data'->'me_and_working_in_sports'->>'sport_interest' 
	into v_module_name, v_sport_interest 
	from labbsc_dev.labbsc_dev_client_web_cust_model
    where user_guid = p_user_guid
	order by custom_module_id desc
	limit 1;
	
	-- raise notice '%',v_module_name;
	
	begin
	
	
		if lower(v_module_name) = 'sporjo_coach_user_profile' then
	
			select client_mod_json
			into strict v_profile_json
			from labbsc_dev.labbsc_dev_client_web_cust_model
			where user_guid = p_user_guid
			and module_name = 'sporjo_coach_user_profile';
			
			 p_profile_json := v_profile_json;
			 
			 p_profile_json := jsonb_set(p_profile_json,'{sports_vertical}',('"'||coalesce(v_sports_vertical,'')||'"')::text::jsonb,true);
	
	   else
	
		select
		 billing_details_json->>'city_id',
		billing_details_json->>'city', billing_details_json->>'state_id', billing_details_json->>'state',
					billing_details_json->>'country_id', billing_details_json->>'country',
					billing_details_json->>'zip'
					 
		 	from labbsc_dev.labbsc_dev_purchase_order
			where cart_id = (select cart_id
							 from labbsc_dev.labbsc_dev_cart
							 where user_id = v_user_id
							 and status = 2
							 order by updated_date desc
							 limit 1)
							 into   v_city_id, v_city, v_state_id, v_state, v_country_id, 
							 v_country, v_pin_code
					 ;
		
		select client_mod_json
		 into strict v_profile_json
		from labbsc_dev.labbsc_dev_client_web_cust_model
		where user_guid = p_user_guid
		and module_name = 'user_profile';
		
		
	 	-- raise notice '%',v_profile_json;
		
		
		
		select ut.test_id, ut.valid_till::date
		into v_test_id, v_date
		from labbsc_dev.labbsc_dev_user_tests ut
		join labbsc_dev.labbsc_dev_cart c
		on c.cart_id = ut.cart_id
		and c.user_id = ut.user_id
		where ut.user_id = v_user_id
		and c.status = 2
		and ut.is_attempted = 0
		and ut.valid_till >= v_current_timestamp;

		if v_test_id is not null then
		---	p_result := -3;
			----v_message := 'You already have a test to attempt';
			v_url := 'https://beta1-sporjo.sportz.io/sporscorr';
			--'https://www.sporjo.com/sporscorr';
		end if;
		
		
		if v_profile_json->'data'->'aboutMe'->>'state' = '' then
		--- raise notice '%',v_state;
	    v_profile_json:= replace(v_profile_json::text,'"state": ""','"state": "'||coalesce(v_state,'')||'"') ;
		 end if;
		 
		--  raise notice '%',v_profile_json;
		
		
		 
		 if  -- (v_profile_json not like '%sporjo_module_name%'  or
	      v_profile_json->>'sporjo_module_name' = '' or v_profile_json->>'sporjo_module_name' is null then	
		  
		  
		  
		   
		  if v_service = 'complete-sports-solutions' then
	
			v_sporjo_module := 'Complete Sports Solutions';
	
		  end if;
		  
	    v_profile_json:= replace(v_profile_json::text,'"sporjo_module_name": ""','"sporjo_module_name": "'||coalesce(v_sporjo_module,'')||'"') ;
		
		v_profile_json := jsonb_set(v_profile_json,'{sporjo_module_name}',('"'||coalesce(v_sporjo_module,'')||'"')::text::jsonb,true);
		
		 -- raise notice '%',v_profile_json;
	   
		
		 end if;
		 
		
		 
		if v_profile_json->'data'->'aboutMe'->>'city' = ''  then
	    v_profile_json:= replace(v_profile_json::text,'"city": ""','"city": "'||coalesce(v_city,'')||'"') ;
		 end if;
		 
		
		 
		if v_profile_json->'data'->'aboutMe'->>'city_id' = ''  then
	
	    v_profile_json:= replace(v_profile_json::text,'"city_id": ""','"city_id": "'||coalesce(v_city_id,'')||'"') ;
			
		 end if;
		 
		 
		 if v_profile_json->'data'->'aboutMe'->>'country' = ''  then
		
	    v_profile_json:= replace(v_profile_json::text,'"country": ""','"country": "'||coalesce(v_country,'')||'"') ;
		 end if;
	
		 
		 
		if v_profile_json->'data'->'aboutMe'->>'pin' = ''  then
	    v_profile_json:= replace(v_profile_json::text,'"pin": ""','"pin": "'||coalesce(v_pin_code,'')||'"') ;
		 end if;
		 
		if v_profile_json->'data'->'aboutMe'->>'state_id' = ''  then
			
	    v_profile_json:= replace(v_profile_json::text,'"state_id": ""','"state_id": "'||coalesce(v_state_id,'')||'"') ;
		 end if;
		 
		if v_profile_json->'data'->'aboutMe'->>'country_id' = ''  then
	    v_profile_json:= replace(v_profile_json::text,'"country_id": ""','"country_id": "'||coalesce(v_country_id,'')||'"') ;
		 end if;
		 
		p_profile_json:=v_profile_json::jsonb;
		
		
		
		
		if exists(select 1
				  from labbsc_dev.labbsc_dev_user_tests
				  where user_id  = v_user_id
				  and is_attempted = 1
				  and attempted_on + (test_duration::text||' hours')::interval >= v_current_timestamp) then
			
			v_edit_enable := 0;
			
		end if;
		
		
		
		
		if v_sports_vertical = '' then
		
		v_sports_vertical := null ;
		
		-- raise notice '% v_sports_vertical',v_sports_vertical;
		
		end if;
		
		
		p_profile_json := jsonb_set(p_profile_json,'{enable_edit}',('"'||v_edit_enable||'"')::text::jsonb,true);
			p_profile_json := jsonb_set(p_profile_json,'{sporjo_code}',('"'||coalesce(v_code,'')||'"')::text::jsonb,true);
			p_profile_json := jsonb_set(p_profile_json,'{test_url}',('"'||coalesce(v_url,'')||'"')::text::jsonb,true);
		 p_profile_json := jsonb_set(p_profile_json,'{sports_vertical}',('"'||coalesce(v_sports_vertical,v_sport_interest)||'"')::text::jsonb,true);
		-- p_profile_json := jsonb_set(p_profile_json,'{sporting_event_inspired_you}',('"'||coalesce(v_sport_interest,'')||'"')::text::jsonb,true);
		 
		 
		 end if;
		 
		if v_profile_picture_url is not null then
		
		  p_profile_json := jsonb_set(p_profile_json,'{data,aboutMe,imageUpload}',('"'||v_profile_picture_url||'"')::text::jsonb,true);
		
		end if;
		
		

	exception
		when no_data_found then
			
		 	---- raise notice '%',p_user_guid;
	/*		 
		select user_id, email_id, profile_picture_url
	   into strict v_user_id, v_email_id, v_profile_picture_url
	   from labbsc_dev.labbsc_dev_web_user
	   where user_guid = p_user_guid; */
	   
	
	 	
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
			from labbsc_dev.labbsc_dev_purchase_order
			where cart_id = (select cart_id
							 from labbsc_dev.labbsc_dev_cart
							 where user_id = v_user_id
							 and status = 2
							 order by updated_date desc
							 limit 1);
							 
							 
							 select ut.test_id, ut.valid_till::date
		into v_test_id, v_date
		from labbsc_dev.labbsc_dev_user_tests ut
		join labbsc_dev.labbsc_dev_cart c
		on c.cart_id = ut.cart_id
		and c.user_id = ut.user_id
		where ut.user_id = v_user_id
		and c.status = 2
		and ut.is_attempted = 0
		and ut.valid_till >= v_current_timestamp;

		if v_test_id is not null then
			---p_result := -3;
			----v_message := 'You already have a test to attempt';
			v_url := 'https://beta1-sporjo.sportz.io/sporscorr';
			--'https://www.sporjo.com/sporscorr';
		end if;
							 
		  select v_ext_info->>'vertical' into v_vertical;	
		  ---raise notice '%',v_first_name;
		  
							 
	if (coalesce(v_first_name,'') ='' or  coalesce(v_last_name,'')='') 	 then	 
	
	  select user_id, email_id, profile_picture_url, first_name, last_name,mobile_no,university_code,module_name,dob,sports_vertical,ext_info
	   into strict v_user_id, v_email_id, v_profile_picture_url, v_first_name, v_last_name,v_reg_mobile_no,v_code,v_sporjo_module,v_dob,v_sports_vertical,v_ext_info
	   from labbsc_dev.labbsc_dev_web_user
	   where user_guid = p_user_guid;
	   
	    end if;			 
				 	
					v_reg_mobile_no:=coalesce(v_reg_mobile_no,'');
					---raise notice '%',v_reg_mobile_no;
					
				
					
	if v_service = 'complete-sports-solutions' then
	
		v_sporjo_module := 'Complete Sports Solutions';
	
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
      "mobile": "'||coalesce(v_mobile_number,v_reg_mobile_no)||'",
      "country_id": "'||coalesce(v_country_id,'')||'",
      "country": "'||coalesce(v_country,'')||'",
      "dob_date": "'||coalesce(v_dob,'')||'",
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
      "sport_interest": "'||coalesce(v_sports_vertical,v_vertical,'null')||'",
      "work_in_this_role": ""
    }
  },
  "page_flag": "1",
  "enable_edit": "1",
  "pancard_number": "'||coalesce(v_pan_number,'')||'",
   "sports_vertical": "'||coalesce(v_sports_vertical,v_vertical,'null')||'",
  "gst_number": "'||coalesce(v_gst_number,'')||'",
  "sporjo_code": "'||coalesce(v_code,'')||'",
  "test_url": "'||coalesce(v_url,'')||'",
  "sporjo_module_name": "'||coalesce(v_sporjo_module,'')||'"
}';

  p_profile_json:=jsonb_set(p_profile_json, '{data,ext_info}',coalesce(v_ext_info,'null'), true);

 
  
	 
	
	 
	end;
	

	
	if p_profile_json is not null then
	
		p_result := 1;
		
	--  p_profile_json:=jsonb_set(p_profile_json, '{data,waf_user_guid}',coalesce(p_user_guid,'null'), true);	
     p_profile_json := jsonb_set(p_profile_json,'{data,waf_user_guid}',('"'||coalesce(p_user_guid,' ')||'"')::text::jsonb,true);
	end if;
/*	 
exception
	when others then
		p_result := -1;
	
	when no_data_found then
		p_result := -2;*/
	
end;
$$;


--
