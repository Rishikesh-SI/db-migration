-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_ins_upd_contact(jsonb)
-- Type: FUNCTION

-- Name: labwis_ins_upd_contact(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_ins_upd_contact(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
		v_sysdate 		timestamp;
		v_full_name 	text;
		v_state 		varchar(200);
		v_city 			varchar(200);
		v_subject 		text;
		v_message 		text ;	
		v_api_flag 		numeric;
		v_email_id 		varchar(200);   
		v_cnt 			numeric;
		v_dob 			timestamp;
		v_designation   varchar(200);
		v_oragnisation	varchar(200);
		v_mobile_number varchar(20);
		v_telephone 	varchar(20);
		v_gender 		varchar(10);
		v_address       varchar(2000);
        v_contact_id    numeric;
		v_waf_user_guid character varying;

        v_attachment text;
		--v_module_name jsonb;
		v_module_name text;
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
        "alabwisress" :"Alabwisress",
        "attachments" : "19,20,21"
}
}
*/

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
                p_connect_us_json->'data'->>'attachments',
				p_connect_us_json->'data'->>'module_name'
		into 
		   --v_api_flag,
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
		   v_module_name
		;

	  select p_connect_us_json->>'page_flag' into v_api_flag;

	 -- v_email_id := trim(lower(v_email_id));
	

	  ---
--v_module_array := array( select jsonb_array_elements(v_module_name) );

update labwis.labwis_web_user set subscribed_module_name= v_module_name::text where email_id=v_email_id;

raise notice 'v_email_id:%',v_email_id;
raise notice 'v_module_name:%',v_module_name;
	  
	 if v_api_flag is not null then 

			select count(1) into v_cnt 
			from labwis.labwis_contact 
			where lower(email_address) = v_email_id
		    and page_flag = v_api_flag;

	        if (v_api_flag = 3 and v_cnt >0 )
			then 
	         	p_result:=2 ;
				p_contactjson := '{ "message":"You have already subscribe"}';

			else 		
				 select user_guid from  labwis.labwis_web_user where email_id=v_email_id
				  into v_waf_user_guid;
			
					-- raise notice 'v_email_id:%',v_email_id;
					-- raise notice 'waf_user_guid:%',v_waf_user_guid;
				v_contact_id := nextval('labwis.seq_labwis_contact_id');

	           insert into labwis.labwis_contact
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
					v_api_flag,
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
--raise notice '1here';
                --p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_address}', ('"' || COALESCE(v_email_id, 'null') || '"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"' || COALESCE(v_contact_id, null) || '"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,attachment}', ('"' || COALESCE(v_attachment, 'null') || '"')::text::jsonb, true);
				p_connect_us_json := jsonb_set(p_connect_us_json, '{data,message}', ('"' || 'Thank You' || '"')::text::jsonb, true);
				
				p_result := 1;
	 		 p_contactjson := p_connect_us_json;

				--p_contactjson := null;
			end if ;

	else 

	 select user_guid from  labwis.labwis_web_user where email_id=v_email_id
	  into v_waf_user_guid;

		-- raise notice 'v_email_id:%',v_email_id;
		-- raise notice 'waf_user_guid:%',v_waf_user_guid;

    	v_contact_id := nextval('labwis.seq_labwis_contact_id');

	           insert into labwis.labwis_contact
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
					v_api_flag,
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
raise notice '2here';
       
--p_connect_us_json:= jsonb_set(p_connect_us_json, '{data,waf_user_guid}',(COALESCE('"' || v_waf_user_guid|| '"'::text ::jsonb, null::numeric )), true);
p_connect_us_json := jsonb_set(
  p_connect_us_json,
  '{data,waf_user_guid}',
  COALESCE(('"' || v_waf_user_guid || '"')::text::jsonb, 'null'::jsonb),
  true
);


              --  p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_address}', ('"' || COALESCE(v_email_id, 'null') || '"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"' || COALESCE(v_contact_id, null) || '"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,attachment}', ('"' || COALESCE(v_attachment, 'null') || '"')::text::jsonb, true);
				p_connect_us_json := jsonb_set(p_connect_us_json, '{data,message}', ('"' || 'Thank You' || '"')::text::jsonb, true);
				
				p_result := 1;
	 			 p_contactjson := p_connect_us_json;
				--p_contactjson := null;

	end if ;

END;

$$;


--
