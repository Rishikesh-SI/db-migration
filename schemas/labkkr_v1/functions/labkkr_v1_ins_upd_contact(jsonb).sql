-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_ins_upd_contact(jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_ins_upd_contact(jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_ins_upd_contact(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
		v_sysdate 		timestamp;
		v_full_name 	text;
		v_state 		varchar(200);
		v_city 			varchar(200);
		v_subject 		text;
		v_message 		text ;	
		v_page_flag 		numeric;
		v_email_id 		varchar(200);   
		v_cnt 			numeric;
		v_dob 			character varying;
		v_designation   varchar(200);
		v_oragnisation	varchar(200);
		v_mobile_number varchar(200);
		v_telephone 	varchar(200);
		v_gender 		varchar(100);
		v_address       varchar(2000);
		v_client_id 	numeric;
        v_contact_id    numeric;
		v_user_guid 	character varying;
        v_attachment text;
		v_unique_id character varying;
		v_formatted_unique_id character varying;
		v_campaign_name character varying;
		
		v_subling_full_name        text;
		v_favourite_number         varchar(50);
		v_sibling_favourite_number varchar(50);
		v_special_message          text;
BEGIN

/*page_flag [1: Contact US, 2: Connect US, 3: Subscribe, 4: Career,5:Contest]*/

	select current_timestamp  at time zone 'utc'
	into   v_sysdate; 
	
	select p_connect_us_json->'data'->>'page_flag',
		   p_connect_us_json->'data'->>'campaign_name'
	into v_page_flag,
	     v_campaign_name;

-- 	  v_email_id := trim(lower(v_email_id));

	if v_email_id = '' then
                v_email_id:=null;
            end if;
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
        "alabkkr_v1ress" :"Alabkkr_v1ress",
        "attachments" : "19,20,21"
}
}
*/

 if v_campaign_name = 'mockauction' then

    RAISE NOTICE 'tititi2222222';

    SELECT 
        p_connect_us_json->'data'->>'full_name',
        p_connect_us_json->'data'->'user_info'->>'state',
        p_connect_us_json->'data'->'user_info'->>'city',
        p_connect_us_json->'data'->>'subject',
        p_connect_us_json->'data'->>'message',
        p_connect_us_json->'data'->'user_info'->>'email_id',
        p_connect_us_json->'data'->>'designation',
        p_connect_us_json->'data'->>'organisation',
        p_connect_us_json->'data'->'user_info'->>'mobile_no',
        p_connect_us_json->'data'->>'telephone',
        p_connect_us_json->'data'->'user_info'->>'dob',
        p_connect_us_json->'data'->'user_info'->>'gender',
        p_connect_us_json->'data'->>'address',
        p_connect_us_json->'data'->>'attachments',
        p_connect_us_json->'data'->>'user_guid'     
    INTO 
        v_full_name,
        v_state,
        v_city,
        v_subject,
        v_message,
        v_email_id,
        v_designation,
        v_oragnisation,
        v_mobile_number,
        v_telephone,
        v_dob,
        v_gender,
        v_address,
        v_attachment,
        v_user_guid;
        
    v_contact_id := nextval('labkkr_v1.seq_labkkr_v1_contact_id'); 

    v_unique_id := nextval('labkkr_v1.seq_labkkr_v1_unique_id'); 
	raise notice 'v_unique_id %',v_unique_id;
    v_formatted_unique_id := 'KKR-'||v_unique_id;
	--v_formatted_unique_id := 'LAKR-'||v_unique_id;
	raise notice 'v_formatted_unique_id %',v_formatted_unique_id;

    INSERT INTO labkkr_v1.labkkr_v1_contact (
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
        unique_id
    ) VALUES (
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
        v_oragnisation,
        v_dob,
        v_gender,
        v_telephone,
        v_attachment,
        p_connect_us_json,
        v_user_guid,
        v_formatted_unique_id  
    );

    p_connect_us_json := jsonb_set(p_connect_us_json, '{data,unique_id}', ('"' || v_formatted_unique_id || '"')::text::jsonb, true);
    p_result := 1;
    p_contactjson := p_connect_us_json;
	
---------------------
ELSIF lower(v_campaign_name) = 'raksha_bandhan_campaign' and v_page_flag = 10 THEN
    RAISE NOTICE 'Inside raksha_bandhan_campaign logic';
	raise notice 'p_connect_us_json:%',p_connect_us_json;

    -- Extract fields from the input JSON
    SELECT 
        p_connect_us_json->'data'->'user_info'->>'full_name',
        p_connect_us_json->'data'->'user_info'->>'subling_full_name',
        p_connect_us_json->'data'->'user_info'->>'favourite_number',
        p_connect_us_json->'data'->'user_info'->>'sibling_favourite_number',
        p_connect_us_json->'data'->'user_info'->>'address',
        p_connect_us_json->'data'->'user_info'->>'special_message',
        p_connect_us_json->'data'->'user_info'->>'mobile_no',
        p_connect_us_json->'data'->'user_info'->>'dob'
    INTO 
        v_full_name,
        v_subling_full_name,
        v_favourite_number,
        v_sibling_favourite_number,
        v_address,
        v_special_message,
        v_mobile_number,
        v_dob;

    -- Generate new contact_id
    v_contact_id := nextval('labkkr_v1.seq_labkkr_v1_contact_id');

    -- Insert into the contact table (add new columns if needed, or just store in contact_json)
    INSERT INTO labkkr_v1.labkkr_v1_contact
        (contact_id, 
         name, 
         mobile_number,
         address,
         dob,
         created_date,
         updated_date,
         created_by,
         updated_by,
         is_active,
         is_deleted,
         contact_json,
		 page_flag
         -- ,subling_full_name, favourite_number, sibling_favourite_number, special_message -- Uncomment if you add these columns
        )
    VALUES
        (v_contact_id,
         v_full_name,
         v_mobile_number,
         v_address,
         v_dob,
         v_sysdate,
         v_sysdate,
         1,
         1,
         1,
         0,
         p_connect_us_json,
		 v_page_flag
         -- ,v_subling_full_name, v_favourite_number, v_sibling_favourite_number, v_special_message -- Uncomment if you add these columns
        );

    -- Add contact_id to the output JSON
    p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);       
    p_result := 1;
    p_contactjson := p_connect_us_json;
-----------------------------------
elsif v_campaign_name = 'trophy_tour' then

    RAISE NOTICE 'inside trophy_tour';

    SELECT 
        p_connect_us_json->'data'->>'full_name',
        p_connect_us_json->'data'->'user_info'->>'state',
        p_connect_us_json->'data'->'user_info'->>'city',
        p_connect_us_json->'data'->>'subject',
        p_connect_us_json->'data'->>'message',
        p_connect_us_json->'data'->'user_info'->>'email_id',
        p_connect_us_json->'data'->>'designation',
        p_connect_us_json->'data'->>'organisation',
        p_connect_us_json->'data'->'user_info'->>'mobile_no',
        p_connect_us_json->'data'->>'telephone',
        p_connect_us_json->'data'->'user_info'->>'dob',
        p_connect_us_json->'data'->'user_info'->>'gender',
        p_connect_us_json->'data'->>'address',
        p_connect_us_json->'data'->>'attachments',
        p_connect_us_json->'data'->>'user_guid'     
    INTO 
        v_full_name,
        v_state,
        v_city,
        v_subject,
        v_message,
        v_email_id,
        v_designation,
        v_oragnisation,
        v_mobile_number,
        v_telephone,
        v_dob,
        v_gender,
        v_address,
        v_attachment,
        v_user_guid;
        
    v_contact_id := nextval('labkkr_v1.seq_labkkr_v1_contact_id'); 

     SELECT
         upper(translate(substring(gen_random_uuid()::text from 1 for 7), '-', '') )
    INTO v_unique_id;
    RAISE NOTICE 'v_unique_id %', v_unique_id;
	
    v_formatted_unique_id := 'KKR-'||v_unique_id;
	raise notice 'v_formatted_unique_id %',v_formatted_unique_id;

    INSERT INTO labkkr_v1.labkkr_v1_contact (
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
        unique_id
    ) VALUES (
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
        v_oragnisation,
        v_dob,
        v_gender,
        v_telephone,
        v_attachment,
        p_connect_us_json,
        v_user_guid,
        v_formatted_unique_id  
    );

    p_connect_us_json := jsonb_set(p_connect_us_json, '{data,unique_id}', ('"' || v_formatted_unique_id || '"')::text::jsonb, true);
    p_result := 1;
    p_contactjson := p_connect_us_json;
------------------------------------
elsif v_campaign_name = 'lakr_campaign' then

   

    SELECT 
        p_connect_us_json->'data'->>'full_name',
        p_connect_us_json->'data'->'user_info'->>'state',
        p_connect_us_json->'data'->'user_info'->>'city',
        p_connect_us_json->'data'->>'subject',
        p_connect_us_json->'data'->>'message',
        p_connect_us_json->'data'->'user_info'->>'email_id',
        p_connect_us_json->'data'->>'designation',
        p_connect_us_json->'data'->>'organisation',
        p_connect_us_json->'data'->'user_info'->>'mobile_no',
        p_connect_us_json->'data'->>'telephone',
        p_connect_us_json->'data'->'user_info'->>'dob',
        p_connect_us_json->'data'->'user_info'->>'gender',
        p_connect_us_json->'data'->>'address',
        p_connect_us_json->'data'->>'attachments',
        p_connect_us_json->'data'->>'user_guid'     
    INTO 
        v_full_name,
        v_state,
        v_city,
        v_subject,
        v_message,
        v_email_id,
        v_designation,
        v_oragnisation,
        v_mobile_number,
        v_telephone,
        v_dob,
        v_gender,
        v_address,
        v_attachment,
        v_user_guid;
        
    v_contact_id := nextval('labkkr_v1.seq_labkkr_v1_contact_id'); 

     SELECT
         upper(translate(substring(gen_random_uuid()::text from 1 for 7), '-', '') )
    INTO v_unique_id;
    RAISE NOTICE 'v_unique_id %', v_unique_id;
	
    v_formatted_unique_id := 'LAKR-'||v_unique_id;
	raise notice 'v_formatted_unique_id %',v_formatted_unique_id;

    INSERT INTO labkkr_v1.labkkr_v1_contact (
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
        unique_id
    ) VALUES (
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
        v_oragnisation,
        v_dob,
        v_gender,
        v_telephone,
        v_attachment,
        p_connect_us_json,
        v_user_guid,
        v_formatted_unique_id  
    );

    p_connect_us_json := jsonb_set(p_connect_us_json, '{data,unique_id}', ('"' || v_formatted_unique_id || '"')::text::jsonb, true);
    p_result := 1;
    p_contactjson := p_connect_us_json;
	
---------
 elsif v_page_flag =10 then --else if
 	raise notice 'tititi';
  
  	 SELECT 
       p_connect_us_json->'data'->>'full_name',
        COALESCE(p_connect_us_json->'data'->'user_info'->>'state', '') AS state,
        COALESCE(p_connect_us_json->'data'->'user_info'->>'city', '') AS city,
        COALESCE(p_connect_us_json->'data'->>'subject', '') AS subject,
        COALESCE(p_connect_us_json->'data'->>'message', '') AS message,
        COALESCE(p_connect_us_json->'data'->'user_info'->>'email_id', '') AS email_id,
        COALESCE(p_connect_us_json->'data'->>'designation', '') AS designation,
        COALESCE(p_connect_us_json->'data'->>'organisation', '') AS organisation,
        COALESCE(NULLIF(p_connect_us_json->'data'->'user_info'->>'mobile_no', ''), '0') AS mobile_no,
        COALESCE(NULLIF(p_connect_us_json->'data'->>'telephone', ''), '0') AS telephone,
        COALESCE(p_connect_us_json->'data'->'user_info'->>'dob', '') AS dob,
        COALESCE(p_connect_us_json->'data'->'user_info'->>'gender', '') AS gender,
        COALESCE(p_connect_us_json->'data'->>'address', '') AS address,
        COALESCE(p_connect_us_json->'data'->>'attachments', '') AS attachments,
        COALESCE(NULLIF(p_connect_us_json->'data'->>'client_id', ''), '0') AS client_id,
        COALESCE(NULLIF(p_connect_us_json->'data'->>'user_guid', ''), '0') AS user_guid
    INTO 
        v_full_name,
        v_state,
        v_city,
        v_subject,
        v_message,
        v_email_id,
        v_designation,
        v_oragnisation,
        v_mobile_number,
        v_telephone,
        v_dob,
        v_gender,
        v_address,
        v_attachment,
        v_client_id,
        v_user_guid;

    -- Ensure the contact ID is correctly generated
    v_contact_id := nextval('labkkr_v1.seq_labkkr_v1_contact_id');
  
  insert into labkkr_v1.labkkr_v1_contact
					(contact_id, 
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
                    user_guid)
	            values(v_contact_id,
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
					v_oragnisation,
					v_dob,
					v_gender,
					v_telephone,
                    v_attachment,
					p_connect_us_json,
                    v_user_guid
					  
					);
--
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);       
				p_result := 1;
	 		 p_contactjson := p_connect_us_json;		
			 
--------------------------------------------------------
 
----------------------------------------
else

	select 	   -- p_connect_us_json->>'page_flag', -- ****Note : page_flag master -> waf_master.waf_contact_page_master 
			    p_connect_us_json->'data'->>'full_name',
			    p_connect_us_json->'data'->>'state',
			    p_connect_us_json->'data'->>'city',
			    p_connect_us_json->'data'->>'subject',
			    p_connect_us_json->'data'->>'message',
		        p_connect_us_json->'data'->>'email_id',
			    p_connect_us_json->'data'->>'designation',
			    p_connect_us_json->'data'->>'organisation',
			    p_connect_us_json->'data'->>'mobile',
			    p_connect_us_json->'data'->>'telephone',
			    p_connect_us_json->'data'->>'dob',
			    p_connect_us_json->'data'->>'gender',
                p_connect_us_json->'data'->>'address',
                p_connect_us_json->'data'->>'attachments'
		into 
		   --v_page_flag,
		   v_full_name,
		   v_state,
		   v_city,
		   v_subject,
		   v_message,
		   v_email_id,
		   v_designation,
		   v_oragnisation,
		   v_mobile_number,
		   v_telephone,
		   v_dob,
		   v_gender,
		   v_address,
           v_attachment
		;

	  

	 if v_page_flag is not null then 

			select count(1) into v_cnt 
			from labkkr_v1.labkkr_v1_contact 
			where lower(email_address) = v_email_id
		    and page_flag = v_page_flag;

	        if (v_page_flag = 3 and v_cnt >0 )
			then 
	         	p_result:=2 ;
				p_contactjson := '{ "message":"You have already subscribe"}';

			else
			 if v_email_id is not null and not exists (select 1 from labkkr_v1.labkkr_v1_contact where email_address = v_email_id and page_flag = v_page_flag) then
				v_contact_id := nextval('labkkr_v1.seq_labkkr_v1_contact_id');

	           insert into labkkr_v1.labkkr_v1_contact
					(contact_id, 
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
					contact_json)
	            values(v_contact_id,
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
					v_oragnisation,
					v_dob,
					v_gender,
					v_telephone,
                    v_attachment,
					p_connect_us_json
					);

--                 p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_address}', ('"'||v_email_id||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);
--                 p_connect_us_json := jsonb_set(p_connect_us_json, '{data,attachment}', ('"'||v_attachment||'"')::text::jsonb, true);
				p_result := 1;
	 		 p_contactjson := p_connect_us_json;

				--p_contactjson := null;
				
			elsif exists (select 1 from labkkr_v1.labkkr_v1_contact where email_address = v_email_id)  then  
                select contact_id into v_contact_id from labkkr_v1.labkkr_v1_contact where email_address = v_email_id;
                p_result:=1;
				p_contactjson := '{
                                    "data": {
                                    "message": "Email id is in use",
                                    "contact_id": "'|| coalesce(v_contact_id,0)||'"
                                    }
                                  }';
                
    else
                    p_result:=1;
				p_contactjson := '{
                                    "data": {
                                    "message": "Email id is required"
                                    }
                                  }';
                

			end if ;
			end if;

-- 	else 

--     	v_contact_id := nextval('labkkr_v1.seq_labkkr_v1_contact_id');

-- 	           insert into labkkr_v1.labkkr_v1_contact
-- 					(contact_id, 
-- 					 name, 
-- 					 email_address,
-- 					 mobile_number,
-- 					 address,
-- 					 created_date,
-- 					 updated_date,
-- 					 created_by,
-- 					 updated_by,
-- 					 is_active,
-- 					 is_deleted,
-- 					 feedback,
-- 					 subject,
-- 					 page_flag,
-- 					 state,
-- 					 city,
-- 					 designation,
-- 					 oragnisation,
-- 					 dob,
-- 					 gender,
-- 					 telephone_number,
--                      attachment,
-- 					contact_json)
-- 	            values(v_contact_id,
-- 		             v_full_name,
-- 		             v_email_id,
-- 		             v_mobile_number,
-- 		             v_address,
-- 		             v_sysdate,
-- 		             v_sysdate,
-- 		             1,
-- 		             1,
-- 		             1,
-- 					 0,
-- 					v_message,
-- 					v_subject,
-- 					v_page_flag,
-- 					v_state,
-- 					v_city,
-- 					v_designation,
-- 					v_oragnisation,
-- 					v_dob,
-- 					v_gender,
-- 					v_telephone,
--                     v_attachment,
-- 					p_connect_us_json
-- 					);

--                 p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_address}', ('"'||v_email_id||'"')::text::jsonb, true);
--                 p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);
-- --                 p_connect_us_json := jsonb_set(p_connect_us_json, '{data,attachment}', ('"'||v_attachment||'"')::text::jsonb, true);

-- 				p_result := 1;
-- 	 			 p_contactjson := p_connect_us_json;
				--p_contactjson := null;

	end if ;
	
end if;

END;

$$;


--
