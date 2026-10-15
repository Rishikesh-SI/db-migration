-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_forgot_password(text)
-- Type: FUNCTION

-- Name: labmao_forgot_password(text); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_forgot_password(p_email_mob text, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	   v_email_mob text;

	begin
	
		v_email_mob := p_email_mob;
	
		 if exists(select 1 from labmao.labmao_user_master 
					  where upper(email_id)=upper(v_email_mob) or upper(mobile_no)=upper(v_email_mob)) then
		
				select row_to_json(row) 
				from (select email_id,mobile_no,user_name,usr_password from labmao.labmao_user_master
					  where upper(email_id)=upper(v_email_mob) or upper(mobile_no)=upper(v_email_mob) ) row
				into p_user_json;
		else
		 
		 p_user_json := '{"massage" : "user does not exists"}';
		
		end if; 
		

	 end;
$$;


--
