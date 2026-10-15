-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_ins_upd_contact_07april2026(jsonb)
-- Type: FUNCTION

-- Name: labkxip_ins_upd_contact_07april2026(jsonb); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_ins_upd_contact_07april2026(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_sysdate 		timestamp;
	v_full_name 	text;
	v_state 		varchar;
	v_city 			varchar;
	v_subject 		text;
	v_message 		text ;	
	v_api_flag 		numeric;
	v_email_id 		varchar;   
	v_cnt 			numeric;
	v_dob 			timestamp;
	v_designation   varchar;
	v_organisation	varchar;
	v_mobile_number varchar;
	v_telephone 	varchar;
	v_gender 		varchar;
	v_address       varchar;
    v_contact_id    numeric;
	v_first_name character varying;
	v_last_name character varying;
    v_attachment text;
	v_campaign_name TEXT;
	v_user_guid TEXT;
	v_unique_id BIGINT;
	v_formatted_unique_id TEXT;
	v_page_flag numeric;
	v_campaign_status TEXT;
	v_campaign_start_date TEXT;
	v_campaign_end_date TEXT;
	v_campaign_id numeric;
	v_platform varchar;
	v_user_id numeric;
BEGIN

/*page_flag [1: Contact US, 2: Connect US, 3: Subscribe, 4: Career, 5:Contest, 10:Campaign]*/

	select current_timestamp  at time zone 'utc'
	into   v_sysdate;  
/*{
"grcaptcha" : "",
"page_flag" :1,
"data" :{
        "full_name" :"Ravi Sitapara",
        "state" : "Maharshtra",
        "city" : "Mumbai",
        "subject" : "Eng",
        "message" : "message1",
        "email_id": "Ravi@gmail.com",
        "designation" : "IT12",
        "organisation" : "orga123",
        "mobile" :"1234567890",
        "telephone" :"tele",
        "dob" : "2008-04-05",
        "gender" :"M",
        "alabkxipress" :"Alabkxipress",
        "attachments" : "19,20,21"
}
}
*/	
	select   -- p_connect_us_json->>'page_flag', -- ****Note : page_flag master -> waf_master.waf_contact_page_master 
	    p_connect_us_json->'data'->'user_info'->>'full_name',
	    coalesce(p_connect_us_json->'data'->'user_info'->>'state', p_connect_us_json->'data'->>'state'),
	    coalesce(p_connect_us_json->'data'->'user_info'->>'city', p_connect_us_json->'data'->>'city'),
	    p_connect_us_json->'data'->>'subject',
	    p_connect_us_json->'data'->>'message',
        p_connect_us_json->'data'->'user_info'->>'email_id',
	    p_connect_us_json->'data'->>'designation',
	    p_connect_us_json->'data'->>'organisation',
	    coalesce(p_connect_us_json->'data'->'user_info'->>'mobile_no', p_connect_us_json->'data'->'user_info'->>'mobile'),
	    p_connect_us_json->'data'->'user_info'->>'first_name',
	    p_connect_us_json->'data'->'user_info'->>'last_name',
	    p_connect_us_json->'data'->>'telephone',
        nullif(p_connect_us_json->'data'->>'dob', '')::timestamp,	    
        nullif(coalesce(p_connect_us_json->'data'->'user_info'->>'gender', p_connect_us_json->'data'->>'gender'),''),
        p_connect_us_json->'data'->>'address',
        p_connect_us_json->'data'->>'attachments',
		p_connect_us_json->'data'->>'campaign_status',
		p_connect_us_json->'data'->>'campaign_start_date',
		p_connect_us_json->'data'->>'campaign_end_date',
		p_connect_us_json->'data'->>'campaign_id',
		p_connect_us_json->'data'->>'platform',
		p_connect_us_json->'data'->>'user_id',
		p_connect_us_json->'data'->>'user_guid'
	into 
	   v_full_name,
	   v_state,
	   v_city,
	   v_subject,
	   v_message,
	   v_email_id,
	   v_designation,
	   v_organisation,
	   v_mobile_number,
	   v_first_name,
	   v_last_name,
	   v_telephone,
	   v_dob,
	   v_gender,
	   v_address,
       v_attachment,
	   v_campaign_status,
	   v_campaign_start_date,
	   v_campaign_end_date,
	   v_campaign_id,
	   v_platform,
	   v_user_id,
	   v_user_guid;

	v_api_flag := (p_connect_us_json->'data'->>'page_flag')::numeric;
	v_page_flag := v_api_flag;
	v_email_id := trim(lower(coalesce(v_email_id, '')));
	v_cnt := 0;

	-- Handle Subscribe (page_flag = 3) duplicate check
	if v_api_flag = 3 then
		select count(1) into v_cnt 
		from labkxip.labkxip_contact 
		where page_flag = 3 
		and lower(email_address) = v_email_id;
		
		if v_cnt > 0 then
			p_result := 1;
			p_contactjson := jsonb_build_object('data', 
			                                     jsonb_build_object('status', '0', 
												 'message', 'You have already subscribed'));
			return;
		end if;
	end if;

	-- Handle Campaign (page_flag = 10) duplicate check
	if v_api_flag = 10 then
		-- Extract mobile_no for comparison
		v_mobile_number := coalesce(p_connect_us_json->'data'->'user_info'->>'mobile_no', p_connect_us_json->'data'->'user_info'->>'mobile');
		v_campaign_id := (p_connect_us_json->'data'->>'campaign_id')::numeric;
		
		select count(1) into v_cnt 
		from labkxip.labkxip_contact 
		where page_flag = v_api_flag 
		and contact_json->'data'->'user_info'->>'mobile_no' = v_mobile_number
		and (contact_json->'data'->>'campaign_id')::numeric = v_campaign_id;
		
		if v_cnt > 0 then
			p_result := 1;
			p_contactjson := jsonb_build_object('data', jsonb_build_object('status', '0', 
			                                     'message', 'Duplicate campaign submission', 'is_duplicate', true));
			return;
		end if;
		
	end if;

	v_campaign_name := p_connect_us_json->'data'->>'campaign_name';
	v_full_name := coalesce(
		v_full_name, 
		trim(coalesce(v_first_name, '') || ' ' || coalesce(v_last_name, ''))
	);
	
----------------------------------------------------------------------------------------------------------------
	if lower(coalesce(v_campaign_name, '')) = 'test_campaign' then
		raise notice 'Processing test_campaign';
		
		v_contact_id := nextval('labkxip.seq_labkxip_contact_id');
		v_unique_id := nextval('labkxip.seq_labkxip_unique_id_test_campaign');
		
		raise notice 'v_unique_id: %', v_unique_id;
		v_formatted_unique_id := 'PBKS-' || v_unique_id;
		raise notice 'v_formatted_unique_id: %', v_formatted_unique_id;
		
		insert into labkxip.labkxip_contact(
			contact_id,
			name,
			email_address,
			mobile_number,
			address,
			created_date,
			updated_date,
			created_by,
			updated_by,
			is_active,
			is_deleted,
			feedback,
			subject,
			page_flag,
			state,
			city,
			designation,
			oragnisation,
			dob,
			gender,
			telephone_number,
			attachment,
			contact_json,
			user_guid,
			unique_id,
			first_name,
			last_name)
		values(
			v_contact_id,
			v_full_name,
			v_email_id,
			v_mobile_number,
			v_address,
			v_sysdate,
			v_sysdate,
			1,
			1,
			1,
			0,
			v_message,
			v_subject,
			v_page_flag,
			v_state,
			v_city,
			v_designation,
			v_organisation,
			v_dob,
			v_gender,
			v_telephone,
			v_attachment,
			p_connect_us_json,
			v_user_guid,
			v_formatted_unique_id,
			v_first_name,
			v_last_name);
		
		p_connect_us_json := jsonb_set(p_connect_us_json, '{data,unique_id}', to_jsonb(v_formatted_unique_id), true);
		
		p_result := 1;
		p_contactjson := ('{"data": {"status": "1", "message": "Success", "unique_id": "' || v_formatted_unique_id || '"}}')::jsonb;
		
		raise notice 'Insertion Completed. Returning the result.';
		return;
		
----------------------------------------------------------------------------------------------------------------
	elsif lower(coalesce(v_campaign_name, '')) = 'lohri' then
	    raise notice 'Processing %', v_campaign_name;
		
		v_contact_id := nextval('labkxip.seq_labkxip_contact_id');
		v_unique_id := nextval('labkxip.seq_labkxip_unique_id_lohri');
		
		raise notice 'v_unique_id: %', v_unique_id;
		v_formatted_unique_id := 'PBKS-' || v_unique_id;
		raise notice 'v_formatted_unique_id: %', v_formatted_unique_id;
		
		insert into labkxip.labkxip_contact(
		    contact_id,
			name,
			email_address,
			mobile_number,
			address,
			created_date,
			updated_date,
			created_by,
			updated_by,
			is_active,
			is_deleted,
			feedback,
			subject,
			page_flag,
			state,
			city,
			designation,
			oragnisation,
			dob,
			gender,
			telephone_number,
			attachment,
			contact_json,
			user_guid,
			unique_id,
			first_name,
			last_name)
		values(
		    v_contact_id,
			v_full_name,
			v_email_id,
			v_mobile_number,
			v_address,
			v_sysdate,
			v_sysdate,
			1,
			1,
			1,
			0,
			v_message,
			v_subject,
			v_page_flag,
			v_state,
			v_city,
			v_designation,
			v_organisation,
			v_dob,
			v_gender,
			v_telephone,
			v_attachment,
			p_connect_us_json,
			v_user_guid,
			v_formatted_unique_id,
			v_first_name,
			v_last_name);
		
		p_connect_us_json := jsonb_set(p_connect_us_json, '{data,unique_id}', to_jsonb(v_formatted_unique_id), true);
		
		p_result := 1;
		p_contactjson := ('{"data": {"status": "1", "message": "Success", "unique_id": "' || v_formatted_unique_id || '"}}')::jsonb;
		
		raise notice 'Insertion Completed. Returning the result.';
		return;

----------------------------------------------------------------------------------------------------------------
		elsif lower(coalesce(v_campaign_name, '')) = 'arsh_da_birthday' then
	    raise notice 'Processing %', v_campaign_name;
		
		v_contact_id := nextval('labkxip.seq_labkxip_contact_id');
		v_unique_id := nextval('labkxip.seq_labkxip_unique_id_arsh_da_birthday');
		
		raise notice 'v_unique_id: %', v_unique_id;
		v_formatted_unique_id := 'PBKS-' || v_unique_id;
		raise notice 'v_formatted_unique_id: %', v_formatted_unique_id;
		
		insert into labkxip.labkxip_contact(
		    contact_id,
			name,
			email_address,
			mobile_number,
			address,
			created_date,
			updated_date,
			created_by,
			updated_by,
			is_active,
			is_deleted,
			feedback,
			subject,
			page_flag,
			state,
			city,
			designation,
			oragnisation,
			dob,
			gender,
			telephone_number,
			attachment,
			contact_json,
			user_guid,
			unique_id,
			first_name,
			last_name)
		values(
		    v_contact_id,
			v_full_name,
			v_email_id,
			v_mobile_number,
			v_address,
			v_sysdate,
			v_sysdate,
			1,
			1,
			1,
			0,
			v_message,
			v_subject,
			v_page_flag,
			v_state,
			v_city,
			v_designation,
			v_organisation,
			v_dob,
			v_gender,
			v_telephone,
			v_attachment,
			p_connect_us_json,
			v_user_guid,
			v_formatted_unique_id,
			v_first_name,
			v_last_name);
		
		p_connect_us_json := jsonb_set(p_connect_us_json, '{data,unique_id}', to_jsonb(v_formatted_unique_id), true);
		
		p_result := 1;
		p_contactjson := ('{"data": {"status": "1", "message": "Success", "unique_id": "' || v_formatted_unique_id || '"}}')::jsonb;
		
		raise notice 'Insertion Completed. Returning the result.';
		return;
		
----------------------------------------------------------------------------------------------------------------	
        elsif lower(coalesce(v_campaign_name, '')) = 'coffee_and_cricket_with_shashank_campaign' then
	    raise notice 'Processing %', v_campaign_name;
		
		v_contact_id := nextval('labkxip.seq_labkxip_contact_id');
		v_unique_id := nextval('labkxip.seq_labkxip_unique_id_coffee_and_cricket_with_shashank_campaign');
		
		raise notice 'v_unique_id: %', v_unique_id;
		v_formatted_unique_id := 'PBKS-' || v_unique_id;
		raise notice 'v_formatted_unique_id: %', v_formatted_unique_id;
		
		insert into labkxip.labkxip_contact(
		    contact_id,
			name,
			email_address,
			mobile_number,
			address,
			created_date,
			updated_date,
			created_by,
			updated_by,
			is_active,
			is_deleted,
			feedback,
			subject,
			page_flag,
			state,
			city,
			designation,
			oragnisation,
			dob,
			gender,
			telephone_number,
			attachment,
			contact_json,
			user_guid,
			unique_id,
			first_name,
			last_name)
		values(
		    v_contact_id,
			v_full_name,
			v_email_id,
			v_mobile_number,
			v_address,
			v_sysdate,
			v_sysdate,
			1,
			1,
			1,
			0,
			v_message,
			v_subject,
			v_page_flag,
			v_state,
			v_city,
			v_designation,
			v_organisation,
			v_dob,
			v_gender,
			v_telephone,
			v_attachment,
			p_connect_us_json,
			v_user_guid,
			v_formatted_unique_id,
			v_first_name,
			v_last_name);
		
		p_connect_us_json := jsonb_set(p_connect_us_json, '{data,unique_id}', to_jsonb(v_formatted_unique_id), true);
		
		p_result := 1;
		p_contactjson := ('{"data": {"status": "1", "message": "Success", "unique_id": "' || v_formatted_unique_id || '"}}')::jsonb;
		
		raise notice 'Insertion Completed. Returning the result.';
		return;
		
----------------------------------------------------------------------------------------------------------------
	-- Handle other page_flags 
	elsif v_api_flag is not null then 
		v_contact_id := nextval('labkxip.seq_labkxip_contact_id');
		
		insert into labkxip.labkxip_contact(
			contact_id, 
			name, 
			email_address,
			mobile_number,
			address,
			created_date,
			updated_date,
			created_by,
			updated_by,
			is_active,
			is_deleted,
			feedback,
			subject,
			page_flag,
			state,
			city,
			designation,
			oragnisation,
			dob,
			gender,
			telephone_number,
			attachment,
			contact_json,
			first_name,
			last_name)
		values(
			v_contact_id,
			v_full_name,
			v_email_id,
			v_mobile_number,
			v_address,
			v_sysdate,
			v_sysdate,
			1,
			1,
			1,
			0,
			v_message,
			v_subject,
			v_api_flag,
			v_state,
			v_city,
			v_designation,
			v_organisation,
			v_dob,
			v_gender,
			v_telephone,
			v_attachment,
			p_connect_us_json,
			v_first_name,
			v_last_name);
		
		p_result := 1;
		p_contactjson := '{
				  "data": {
					"status": "1",
					"message": "Success"
				  }
				}'::jsonb;
----------------------------------------------------------------------------------------------------------------

	else
		v_contact_id := nextval('labkxip.seq_labkxip_contact_id');
		
		insert into labkxip.labkxip_contact(
			contact_id, 
			name, 
			email_address,
			mobile_number,
			address,
			created_date,
			updated_date,
			created_by,
			updated_by,
			is_active,
			is_deleted,
			feedback,
			subject,
			page_flag,
			state,
			city,
			designation,
			oragnisation,
			dob,
			gender,
			telephone_number,
			attachment,
			contact_json,
			first_name,
			last_name)
		values(
			v_contact_id,
			v_full_name,
			v_email_id,
			v_mobile_number,
			v_address,
			v_sysdate,
			v_sysdate,
			1,
			1,
			1,
			0,
			v_message,
			v_subject,
			v_api_flag,
			v_state,
			v_city,
			v_designation,
			v_organisation,
			v_dob,
			v_gender,
			v_telephone,
			v_attachment,
			p_connect_us_json,
			v_first_name,
			v_last_name);
		
		p_result := 1;
		p_contactjson := '{
				  "data": {
					"status": "1",
					"message": "Success"
				  }
				}'::jsonb;
	end if;
END;
$$;


--
