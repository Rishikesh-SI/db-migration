-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_del_user_paytm_code(character varying, jsonb)
-- Type: FUNCTION

-- Name: labkxp_del_user_paytm_code(character varying, jsonb); Type: FUNCTION; Schema: labkxp; Owner: -
--

CREATE FUNCTION labkxp.labkxp_del_user_paytm_code(p_email_id character varying, p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
	v_json jsonb := p_json;
  	v_paytm_json json;
    	v_paytm_data json;
    	v_code_user_map_id numeric;
    	v_code_id numeric;
	
begin
	
	select v_json->'data'
	into v_paytm_json;
	
	if v_paytm_json is not null then
		
		for v_paytm_data in select * from json_array_elements(v_paytm_json)
		loop
			
			select v_paytm_data->>'code_user_map_id', v_paytm_data->>'code_id'
			into v_code_user_map_id, v_code_id;
			
			delete from labkxp.labkxp_paytm_code_user_map
			where code_user_map_id = v_code_user_map_id
			and email_id = upper(p_email_id);
			
			update labkxp.labkxp_paytm_code_master
			set status = 0
			where code_id = v_code_id;
			
        	end loop;
		
		p_result := 1;
		
	end if;
end;

$$;


--
