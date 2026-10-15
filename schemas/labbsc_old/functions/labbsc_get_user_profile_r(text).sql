-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_get_user_profile_r(text)
-- Type: FUNCTION

-- Name: labbsc_get_user_profile_r(text); Type: FUNCTION; Schema: labbsc_old; Owner: -
--

CREATE FUNCTION labbsc_old.labbsc_get_user_profile_r(p_user_guid text, OUT p_data jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

	
    
begin
	
    	
		select client_mod_json into p_data  from labbsc.labbsc_client_web_cust_model where module_name='job_application'
																						and user_guid=p_user_guid;
																						
		p_result:=1;
               
end;	      

$$;


--
