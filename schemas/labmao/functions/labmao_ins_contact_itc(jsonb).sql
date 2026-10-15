-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_ins_contact_itc(jsonb)
-- Type: FUNCTION

-- Name: labmao_ins_contact_itc(jsonb); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_ins_contact_itc(p_connect_us_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
		v_sysdate 		timestamp;
		v_first_name 	text;
		v_last_name 	text;
		v_email_id 		varchar(500);   
		v_mobile_number varchar(50);
		v_cnt numeric ;
		v_dob date;
		v_gender text;
		v_codeno text;

BEGIN

	select current_timestamp  at time zone 'utc'
	into   v_sysdate;    
 /*{
"data" :{
        "first_name" :"Dip",
		"last_name" :"Panchal",
        "email_id": "dip@gmail.com",
        "mobile" :"1234567890"
        }
}
*/

	   select  p_connect_us_json->'data'->>'first_name',
	           p_connect_us_json->'data'->>'last_name',
			   p_connect_us_json->'data'->>'email_id',
			   p_connect_us_json->'data'->>'mobile',
			   p_connect_us_json->'data'->>'dob',
			   p_connect_us_json->'data'->>'gender',
			   p_connect_us_json->'data'->>'codeno'
	   into    v_first_name,
			   v_last_name,
			   v_email_id,
			   v_mobile_number,
			   v_dob,
			   v_gender,
			   v_codeno;
			   
		select count(1)  into v_cnt
		from labmao.labmao_itc_contact;
		
		if v_cnt >= 1000 then 
		
			p_result := 3 ;
			   
		else
		
			if not exists(select 1 from labmao.labmao_itc_contact
						 where lower(trim(email_address)) = lower(trim(v_email_id)) 
						  or trim(mobile_number) = trim(v_mobile_number) ) then
						  
				insert into labmao.labmao_itc_contact (contact_id,first_name,last_name,email_address,
													   mobile_number,created_date,contact_json,dob,gender,codeno)
				values(nextval('labmao.seq_labmao_itc_contact_id'),v_first_name,v_last_name,v_email_id,
					   v_mobile_number,v_sysdate,p_connect_us_json,v_dob,v_gender,v_codeno);
						 
				p_result := 1 ;
			else
				
				p_result := 2 ;
			
			end if;
			
	   end if;

END;
$$;


--
