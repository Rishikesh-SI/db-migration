-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_ins_upd_contact(jsonb)
-- Type: FUNCTION

-- Name: labdsg_ins_upd_contact(jsonb); Type: FUNCTION; Schema: labdsg; Owner: -
--

CREATE FUNCTION labdsg.labdsg_ins_upd_contact(p_connect_us_json jsonb, OUT p_result numeric, OUT p_contactjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
		v_sysdate 		timestamp;
		v_page_flag 	NUMERIC;
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
		v_telephone 	varchar(20);
		v_captcha 		varchar;
		v_address       varchar(2000);
        v_contact_id    numeric;
		   v_first_name varchar;
		   v_last_name varchar;
		   v_country_code varchar;
        v_attachment text;
BEGIN

/*
1. Fans

2. Media

3. Sponsors*/

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
        "alabdsgress" :"Alabdsgress",
        "attachments" : "19,20,21"
}
}
*/

	select 	   -- p_connect_us_json->>'page_flag', -- ****Note : page_flag master -> waf_master.waf_contact_page_master 
			    p_connect_us_json->'data'->>'page_flag',
			    p_connect_us_json->'data'->>'subject',
			    p_connect_us_json->'data'->>'message',
		        p_connect_us_json->'data'->'user_info'->>'first_name',
		        p_connect_us_json->'data'->'user_info'->>'last_name',
		        p_connect_us_json->'data'->'user_info'->>'email_id',
		        p_connect_us_json->'data'->'user_info'->>'mobile_no',
			    p_connect_us_json->'data'->>'country_code',
			    p_connect_us_json->'data'->>'captcha'
		into 
		   --v_api_flag,
		   v_page_flag,
		   v_subject,
		   v_message,
		   v_first_name,
		   v_last_name,
		   v_email_id,
		   v_mobile_number,
		   v_country_code,
           v_captcha
		;



	 if v_page_flag is not null then 
	
				v_contact_id := nextval('labdsg.seq_labdsg_contact_id');

	           insert into labdsg.labdsg_contact
					(contact_id, 
					 page_flag, 
					 email_address,
					 mobile_number,
					 created_date,
					 updated_date,
					 created_by,
					 updated_by,
					 is_active,
					 is_deleted,
					 feedback,
					 subject,
					 first_name,
					 last_name,
					 country_code,
					 captcha,
					contact_json)
	            values(v_contact_id,
		             v_page_flag,
		             v_email_id,
		             v_mobile_number,
		             v_sysdate,
		             v_sysdate,
		             1,
		             1,
		             1,
					 0,
					v_message,
					v_subject,
					v_first_name,
					v_last_name,
					v_country_code,
                    v_captcha,
					p_connect_us_json
					);

				p_result := 1;
	 		 p_contactjson := p_connect_us_json;

				--p_contactjson := null;
				
				else 
				p_contactjson:= p_connect_us_json;
			end if ;


END;

$$;


--
