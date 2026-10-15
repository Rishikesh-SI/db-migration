-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_verify_user(jsonb)
-- Type: FUNCTION

-- Name: labwis_verify_user(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_verify_user(p_input jsonb, OUT p_result numeric, OUT p_output jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_user_name character varying;
    v_user_pwd character varying;
    v_input jsonb;
    v_output jsonb;
BEGIN

    /*
    {
"data":{
"username":"Admin",
"password":"667A6E595171457441532F6766652B4D6B35335774773D3D"
}
}
    */

-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'verify_cms-user','logs',uuid_generate_v4(),p_input,current_timestamp,'labwis','logs');

    v_input := p_input;

    SELECT v_input->'data'->>'username',
           v_input->'data'->>'password'
    INTO v_user_name, v_user_pwd;
    
    IF EXISTS (SELECT 1 FROM labwis.labwis_user WHERE user_name = v_user_name AND user_pwd = v_user_pwd) THEN
        p_result := 1;  
        v_output := '{
                        "status": "successful",
                        "message": "User is present"
                    }'::jsonb;
    ELSE
        p_result := -1;  
        v_output := '{
                        "status": "unsuccessful",
                        "message": "User Not found"
                    }'::jsonb;
    END IF;

    p_output := v_output;  
    RETURN;

END;
$$;


--
