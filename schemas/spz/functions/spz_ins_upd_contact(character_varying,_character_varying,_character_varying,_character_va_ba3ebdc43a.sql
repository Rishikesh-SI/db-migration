-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_ins_upd_contact(character varying, character varying, character varying, character varying, numeric, text, text, jsonb)
-- Type: FUNCTION

-- Name: spz_ins_upd_contact(character varying, character varying, character varying, character varying, numeric, text, text, jsonb); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_ins_upd_contact(p_name character varying, p_email_address character varying, p_mobile_number character varying, p_address character varying, p_updated_by numeric, p_feedback_text text, p_subject text, p_connect_us_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_sysdate 							 timestamp;
v_full_name text;
	v_state varchar(200);
	v_city varchar(200);
	v_subject text;
	v_message text ;
	
	v_api_flag numeric;

   v_email_id varchar(200);
BEGIN

	select current_timestamp  at time zone 'utc'
	into   v_sysdate;    
    
	select p_connect_us_json->'data'->>'full_name',
	       p_connect_us_json->'data'->>'state',
		   p_connect_us_json->'data'->>'city',
		   p_connect_us_json->'data'->>'subject',
		   p_connect_us_json->'data'->>'message',
		    p_connect_us_json->'data'->>'email_id'
		into 
		   v_full_name,
		   v_state,
		   v_city,
		   v_subject,
		   v_message,
		   v_email_id
		;
	
	
	select p_connect_us_json->'page_flag'
	 into v_api_flag 
	 ;
	
	
   if p_connect_us_json is null then 
			
	insert into spz.spz_contact(contact_id,name,
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
								subject,page_flag)
	values(nextval('spz.seq_spz_contact_id'),
		p_name,
		p_email_address,
		p_mobile_number,
		p_address,
		v_sysdate,
		v_sysdate,
		p_updated_by,
		p_updated_by,
		1,
		0,
		p_feedback_text,
		p_subject,1);
	else 
	 
	 if v_api_flag is not null then 
	 insert into spz.spz_contact(contact_id,
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
								feedback,subject,page_flag,state,city)
	values(nextval('spz.seq_spz_contact_id'),
		v_full_name,
		v_email_id,
		p_mobile_number,
		p_address,
		v_sysdate,
		v_sysdate,
		1,
		1,
		1,
		0,
		v_message,
		v_subject,
		v_api_flag,
		v_state,v_city);
	
	 
		end if;
	
	
	end if ;
	
	
	
	
	
	
     	p_result := 1;

   -- exception 
  --  when others then p_result := -1;

END;

$$;


--
