-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_ins_upd_contact(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_ins_upd_contact(jsonb); Type: FUNCTION; Schema: labdd_v1_30april24; Owner: -
--

CREATE FUNCTION labdd_v1_30april24.labdd_v1_ins_upd_contact(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
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
		v_mobile_number varchar;
		v_telephone 	varchar;
		v_gender 		varchar;
		v_address       varchar(2000);
        v_contact_id    numeric;

        v_attachment text;
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
        "alabdd_v1ress" :"Alabdd_v1ress",
        "attachments" : "19,20,21"
}
}
*/

	select 	   -- p_connect_us_json->>'page_flag', -- ****Note : page_flag master -> waf_master.waf_contact_page_master 
			    p_connect_us_json->'data'->'user_info'->>'full_name',
			    p_connect_us_json->'data'->>'state',
			    p_connect_us_json->'data'->>'city',
			    p_connect_us_json->'data'->>'subject',
			    p_connect_us_json->'data'->>'message',
		        p_connect_us_json->'data'->'user_info'->>'email_id',
			    p_connect_us_json->'data'->>'designation',
			    p_connect_us_json->'data'->>'organisation',
			    p_connect_us_json->'data'->'user_info'->>'mobile_no',
			    p_connect_us_json->'data'->>'telephone',
			    p_connect_us_json->'data'->>'dob',
			    p_connect_us_json->'data'->>'gender',
                p_connect_us_json->'data'->>'address',
                p_connect_us_json->'data'->>'attachments'
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
           v_attachment
		;

	  select p_connect_us_json->>'page_flag' into v_api_flag;

	  v_email_id := trim(lower(v_email_id));

	 if v_api_flag is not null then 

			select count(1) into v_cnt 
			from labdd_v1.labdd_v1_contact 
			where lower(email_address) = v_email_id
		    and page_flag = v_api_flag;

	        if (v_api_flag = 3 and v_cnt >0 )
			then 
	         	p_result:=2 ;
				p_contactjson := '{ "message":"You have already subscribe"}';

			else 				
				v_contact_id := nextval('labdd_v1.seq_labdd_v1_contact_id');

	           insert into labdd_v1.labdd_v1_contact
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

	else 
	
	if not exists(select 1 from labdd_v1.labdd_v1_contact where email_address = v_email_id and (updated_date + interval '1' day) > current_timestamp) then

    	v_contact_id := nextval('labdd_v1.seq_labdd_v1_contact_id');

	           insert into labdd_v1.labdd_v1_contact
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

--                 p_connect_us_json := jsonb_set(p_connect_us_json, '{data,email_address}', ('"'||v_email_id||'"')::text::jsonb, true);
                p_connect_us_json := jsonb_set(p_connect_us_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);
--              p_connect_us_json := jsonb_set(p_connect_us_json, '{data,attachment}', ('"'||v_attachment||'"')::text::jsonb, true);

				p_result := 1;
	 			 p_contactjson := p_connect_us_json;
				--p_contactjson := null;
		else 
			p_result := 1 ;
			v_message := 'Kindly wait 24 hours before submitting again. Thanks!';
			p_connect_us_json := jsonb_set(p_connect_us_json, '{data,message}', ('"'||v_message||'"')::text::jsonb, true);
			p_contactjson := p_connect_us_json;
	end if;
			

	end if ;

END;

$$;


--
