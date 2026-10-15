-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_ins_upd_contact(jsonb)
-- Type: FUNCTION

-- Name: labsaw_ins_upd_contact(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_ins_upd_contact(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
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

        v_attachment text;
		
		v_is_subscribe numeric;
		v_user_type numeric;
		v_is_subscribe_val numeric;
		v_guid text;
		v_first_name text;
		v_last_name text;
		v_name text;
BEGIN

/*page_flag [1: Contact US, 2: Connect US, 3: Subscribe [is_subscribe=1 then subscribe 0 the unsubscribe], 4: Career,5:Contest ,6 : Unsubscribe ]*/

	select current_timestamp  at time zone 'utc'
	into   v_sysdate;    
 /*{
"grcaptcha" : "",
"page_flag" :1,
"is_subscribe":0,
"user_type":0,
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
        "address" :"Alabsawress",
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
				p_connect_us_json->'data'->>'guid'
		into 
		   -- v_api_flag,
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
		   v_guid
		;

	  select p_connect_us_json->>'page_flag' ,
	         p_connect_us_json->>'is_subscribe',
			 p_connect_us_json->>'user_type'
	  into v_api_flag,v_is_subscribe,v_user_type;

	  --v_email_id := trim(lower(v_email_id));

	  if v_api_flag is not null then 
            
			if (v_api_flag=3 and v_is_subscribe=1) then 
			select count(1) into v_cnt 
			from labsaw.labsaw_contact 
			where lower(email_address) = lower(v_email_id)
		    and page_flag = v_api_flag
			;
			else 
			select count(1) into v_cnt 
			from labsaw.labsaw_contact 
			where lower(contact_guid) = v_guid
		    and page_flag = v_api_flag
			;
			end if ;
            
			
			
	        if (v_api_flag = 3 and v_cnt >0 and v_is_subscribe=1)
			  then 
	         	 
				 select is_subscribe into v_is_subscribe_val 
			     from labsaw.labsaw_contact 
			     where lower(email_address) = lower(v_email_id)
		         and page_flag = v_api_flag;
				
				if v_is_subscribe_val=1 then 
				 
				   p_result:=2 ;
				   p_contactjson := '{ "message":"You have already subscribe"}';
                else 
				
			      update  labsaw.labsaw_contact
				  set     is_subscribe=v_is_subscribe
			      where   lower(email_address) = lower(v_email_id)
		          and     page_flag = v_api_flag;
				
				   p_result:=1 ;
				   p_contactjson := '{ "message":"You have subscribe now"}';
				
				end if;
			 
			 
			  ELSIF (v_api_flag = 3 and v_cnt >0 and v_is_subscribe=0) then 
			 
			 	select email_address ,contact_json->'data'->>'first_name',contact_json->'data'->>'last_name',
				name
				into v_email_id,v_first_name,v_last_name,v_name
				from labsaw.labsaw_contact 
				where lower(contact_guid) = v_guid
		        and page_flag = v_api_flag ;
				  
			    p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_id}', ('"'||v_email_id||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,first_name}', ('"'||v_first_name||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,last_name}', ('"'||v_last_name||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,full_name}', ('"'||v_name||'"')::text::jsonb, true);
					
			 
			      update  labsaw.labsaw_contact
				  set is_subscribe=v_is_subscribe,contact_json=p_connect_us_json,
				  updated_date=v_sysdate
			      where lower(contact_guid) = v_guid
		          and page_flag = v_api_flag;
				
				   p_result:=3 ;
				   p_contactjson := '{ "message":"You have Unsubscribe now"}';
					 
					 
			  else 				
				v_contact_id := nextval('labsaw.seq_labsaw_contact_id');

	            insert into labsaw.labsaw_contact
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
					user_type,
					is_subscribe,
					contact_guid)
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
					p_connect_us_json,
					v_user_type,
					v_is_subscribe	,
					v_guid);

                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_address}', ('"'||v_email_id||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,attachment}', ('"'||v_attachment||'"')::text::jsonb, true);
				p_result := 1;
	 		 p_contactjson := p_connect_us_json;

				--p_contactjson := null;
			end if ;

	else 

    	v_contact_id := nextval('labsaw.seq_labsaw_contact_id');

	           insert into labsaw.labsaw_contact
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

                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_address}', ('"'||v_email_id||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,attachment}', ('"'||v_attachment||'"')::text::jsonb, true);

				p_result := 1;
	 			 p_contactjson := p_connect_us_json;
				--p_contactjson := null;

	end if ;

END;

$$;


--
