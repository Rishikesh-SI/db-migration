-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_delete_email()
-- Type: FUNCTION

-- Name: labgt_delete_email(); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_delete_email(OUT p_r numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare

   
begin


	--v_otp := 123456;
	update labgt.labgt_web_user
	set email_id=null,email_verified=0,
	upper_email_id=null,user_guid='8e0e746b-3ccd-402f-9f25-6e82106d9f03'
	where user_id=387050;
	
	
	p_r:=1;
	
	

end;
$$;


--
