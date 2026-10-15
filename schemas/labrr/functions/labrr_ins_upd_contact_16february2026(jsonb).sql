-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_ins_upd_contact_16february2026(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_contact_16february2026(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_ins_upd_contact_16february2026(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
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
		v_cnt 			numeric=0;
		v_dob 			varchar;
		v_designation   varchar(200);
		v_oragnisation	varchar(200);
		v_mobile_number varchar(50);
		v_telephone 	varchar(20);
		v_gender 		varchar(50);
		v_address       varchar(2000);
        v_contact_id    numeric;
        v_client_id numeric;
        v_attachment text;
        v_user_guid character varying;
BEGIN

/*page_flag [1: Contact US, 2: Connect US, 3: Subscribe, 4: Career,5:Contest]*/

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
        "alabrrress" :"Alabrrress",
        "attachments" : "19,20,21"
}
}
*/

	

	  select p_connect_us_json->'data'->>'page_flag' into v_page_flag;

	  --v_email_id := trim(lower(v_email_id));

            if v_email_id = '' then
                v_email_id:=null;
            end if;
            
            
  if v_page_flag =10 then 
  
  	select 	   -- p_connect_us_json->>'page_flag', -- ****Note : page_flag master -> waf_master.waf_contact_page_master 
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
                p_connect_us_json->'data'->>'attachments',
                p_connect_us_json->'data'->>'client_id',
                p_connect_us_json->'data'->>'user_guid'

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
           v_attachment,
           v_client_id,
           v_user_guid
		;
		
		
		--------------------------------------

		v_mobile_number := trim(
			coalesce(
				p_connect_us_json->'data'->'user_info'->>'mobile_no',
				p_connect_us_json->'data'->'user_info'->>'mobile',
				p_connect_us_json->'data'->>'mobile_no'
			)
		);

		IF p_connect_us_json->'data'->>'campaign_id' IS NULL THEN
			p_result := 0;
			p_contactjson := jsonb_build_object(
				'data', jsonb_build_object(
					'status', '0',
					'message', 'campaign_id is required'
				)
			);
			RETURN;
		END IF;

		
		IF EXISTS (
			SELECT 1
			FROM labrr.labrr_contact
			WHERE page_flag = 10
			  AND trim(
					coalesce(
						contact_json->'data'->'user_info'->>'mobile_no',
						contact_json->'data'->'user_info'->>'mobile',
						contact_json->'data'->>'mobile_no'
					)
				  ) = v_mobile_number
			  AND (contact_json->'data'->>'campaign_id')::numeric =
				  (p_connect_us_json->'data'->>'campaign_id')::numeric
			  AND is_deleted = 0
		) THEN
			p_result := 1;
			p_contactjson := jsonb_build_object(
				'data',
				jsonb_build_object(
					'status', '0',
					'message', 'This mobile number has already been used for this campaign.',
					'is_duplicate', true
				)
			);
			RETURN;
		END IF;
		--------------------------------------
  
  v_contact_id := nextval('labrr.seq_labrr_contact_id');
  
  insert into labrr.labrr_contact
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

                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);       
				p_result := 1;
	 		 p_contactjson := p_connect_us_json;
            
            --raise notice 'v_email_id %',v_email_id;
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
			    p_connect_us_json->'data'->>'mobile_no',
			    p_connect_us_json->'data'->>'telephone',
			    p_connect_us_json->'data'->>'dob',
			    p_connect_us_json->'data'->>'gender',
                p_connect_us_json->'data'->>'address',
                p_connect_us_json->'data'->>'attachments',
                p_connect_us_json->'data'->>'attachments',
                p_connect_us_json->'data'->>'client_id',
                p_connect_us_json->'data'->>'user_guid'

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
           v_attachment,
           v_client_id,
           v_user_guid
		;
	     
        if v_email_id is not null and not exists (select 1 from labrr.labrr_contact where email_address = v_email_id and page_flag = v_page_flag) then
                    
				v_contact_id := nextval('labrr.seq_labrr_contact_id');

	           insert into labrr.labrr_contact
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
                    
                    
                       
                   
                --p_connect_us_json := jsonb_set(p_connect_us_json, '{data,,email_address}', ('"'||v_email_id||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);
                --p_connect_us_json := jsonb_set(p_connect_us_json, '{data,client_id}', ('"'||coalesce(v_client_id,0)||'"')::jsonb, true);
               -- p_connect_us_json := jsonb_set(p_connect_us_json, '{data,attachment}', ('"'||v_attachment||'"')::text::jsonb, true);
				p_result := 1;
	 		 p_contactjson := p_connect_us_json;
                        

	elsif exists (select 1 from labrr.labrr_contact where email_address = v_email_id)  then  
                select contact_id into v_contact_id from labrr.labrr_contact where email_address = v_email_id;
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
                

	end if;
    
    end if;
    
END;

$$;


--
