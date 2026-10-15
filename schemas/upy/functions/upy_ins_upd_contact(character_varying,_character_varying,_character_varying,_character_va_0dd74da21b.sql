-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_ins_upd_contact(character varying, character varying, character varying, character varying, numeric, text, date, character varying)
-- Type: FUNCTION

-- Name: upy_ins_upd_contact(character varying, character varying, character varying, character varying, numeric, text, date, character varying); Type: FUNCTION; Schema: upy; Owner: -
--

CREATE FUNCTION upy.upy_ins_upd_contact(p_name character varying, p_email_address character varying, p_mobile_number character varying, p_address character varying, p_updated_by numeric, p_feedback_text text, p_dob date, p_gender character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

	
declare
	
	v_sysdate timestamp;
	
BEGIN
	
	select current_timestamp at time zone 'utc' into v_sysdate;
	
	insert into upy.upy_contact(contact_id,name,email_address,mobile_number,address,created_date,updated_date,created_by,updated_by,is_active,
								is_deleted,feedback,dob,gender)
	values(nextval('upy.seq_upy_contact_id'),p_name,p_email_address,p_mobile_number,p_address,v_sysdate,v_sysdate,p_updated_by,p_updated_by,1,0,
			p_feedback_text,p_dob,p_gender);
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;

END;

$$;


--
