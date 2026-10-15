-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_ins_upd_contact(character varying, character varying, character varying, character varying, numeric, text)
-- Type: FUNCTION

-- Name: upp_ins_upd_contact(character varying, character varying, character varying, character varying, numeric, text); Type: FUNCTION; Schema: upp; Owner: -
--

CREATE FUNCTION upp.upp_ins_upd_contact(p_name character varying, p_email_address character varying, p_mobile_number character varying, p_address character varying, p_updated_by numeric, p_feedback_text text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_sysdate 							 timestamp;

BEGIN

	select current_timestamp  at time zone 'utc'
	into   v_sysdate;    
    
     insert into upp.upp_contact
	(
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
	feedback
	)
    values
    ( nextval('upp.seq_upp_contact_id'),
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
	 p_feedback_text
     ) ;
     	p_result := 1;

    exception 
    when others then p_result := -1;

END;

$$;


--
