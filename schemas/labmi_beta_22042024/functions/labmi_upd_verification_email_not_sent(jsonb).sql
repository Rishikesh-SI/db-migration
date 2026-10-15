-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_upd_verification_email_not_sent(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_verification_email_not_sent(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_upd_verification_email_not_sent(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

    declare
	v_email_id character varying(1000);
	v_client_id numeric;
	v_verification_key character varying(1000);
    
    begin
	select p_inputjson->'data'->>'email_id',
		   p_inputjson->'data'->>'client_id' ,
		   p_inputjson->'data'->>'verification_key'
	into   v_email_id,
		   v_client_id,
		   v_verification_key;
           
       
           
           if exists(select 1 from labmi.labmi_web_user where email_id=v_email_id) then
           
           
			
            
			 update labmi.labmi_web_user
			 set is_mail_sent = 0
			 where email_id=v_email_id and client_id=v_client_id 
             and verification_key=v_verification_key;
			
			p_data	:= '{"status": "1",
		 				"message": "Success"}';
			
	else		
			p_data	:= '{"status": "0",
		 				"message": "Failed"}';	
			
	end if;	
	
end;

$$;


--
