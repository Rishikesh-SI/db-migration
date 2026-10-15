-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_update_mail_status(jsonb)
-- Type: FUNCTION

-- Name: labwis_update_mail_status(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_update_mail_status(p_input jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_user_guid character varying;
    v_subscribe_for_email boolean;
    v_input jsonb;
    v_result numeric;
	v_subscribed_module_name text;
	v_nsubscribed_module_name text;
	v_is_subscribe text ;
	v_email character varying;
	v_module_name text;
BEGIN

    /*
    {
"data":{
"waf_user_guid":"ee91aa53-f993-4982-b6f4-1ec685192d63",
"is_subscribed":true
}
}
    */

-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'update_mail_status','logs',uuid_generate_v4(),p_input,current_timestamp,'labwis','logs');

    v_input := p_input;

    SELECT v_input->>'waf_user_guid',
           v_input->>'is_subscribed',
		   v_input->>'email',
		   v_input->>'module_name'
    INTO v_user_guid, v_is_subscribe,v_email,v_module_name;
    
    IF EXISTS (SELECT 1 FROM labwis.labwis_web_user where user_guid = v_user_guid or email_id = v_email) THEN
		SELECT COALESCE(subscribed_module_name, '') INTO v_subscribed_module_name
        FROM labwis.labwis_web_user 
        where user_guid = v_user_guid or email_id = v_email;

		raise notice 'v_is_subscribe %',v_is_subscribe;
		
if	v_is_subscribe::boolean=false then 
			raise notice 'v_is_subscribe %',v_is_subscribe;
	-- raise notice 'v_module_name %',v_module_name;
	-- raise notice 'v_subscribed_module_name %',v_subscribed_module_name;
	-- raise notice 'v_nsubscribed_module_name %',v_nsubscribed_module_name;
	 if position(lower(v_module_name) in lower(v_subscribed_module_name)) > 0 then
				v_nsubscribed_module_name:= REPLACE(v_subscribed_module_name, ', '|| v_module_name, '');
				v_nsubscribed_module_name:= REPLACE(v_nsubscribed_module_name, ','|| v_module_name, '');
				v_nsubscribed_module_name:= REPLACE(v_nsubscribed_module_name, '''', '');
					raise notice '2v_nsubscribed_module_name %',v_nsubscribed_module_name;

				update labwis.labwis_web_user
				set subscribed_module_name = v_nsubscribed_module_name
				where user_guid = v_user_guid or email_id = v_email;
			v_result := 1; --removed a module
		else 
		v_result := 2; -- false but module is alredy absent
			end if;


elsif v_is_subscribe::boolean=true then 
	
		 if position(lower(v_module_name) in lower(v_subscribed_module_name)) = 0 then
				v_nsubscribed_module_name:= v_subscribed_module_name|| ', '|| v_module_name;
				v_nsubscribed_module_name:= REPLACE(v_nsubscribed_module_name, '''', '');
				update labwis.labwis_web_user
				set subscribed_module_name = v_nsubscribed_module_name
				where user_guid = v_user_guid or email_id = v_email;
			v_result := 3; -- added a new module
		else 
		v_result := 4; -- true but module is alredy present
			end if;
		 
 end if;
    ELSE
        v_result := 0;  

    END IF;

    p_result := v_result;  
    RETURN;

END;
$$;


--
