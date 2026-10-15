-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_get_panga_hunt_contest_r(jsonb)
-- Type: FUNCTION

-- Name: labpkl_v1_get_panga_hunt_contest_r(jsonb); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_get_panga_hunt_contest_r(p_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

  v_device_token character varying;
  v_current_timestamp timestamp without time zone;
  v_json jsonb;
  v_user_id numeric;
  v_email_id character varying; 
  v_panga_hunt_user_id numeric[];
  v_result numeric;


begin
/*
{“device_token“:”5467”}
*/

    select p_json ->>'device_token'
    into v_device_token ;
	
	v_current_timestamp := current_timestamp at time zone 'utc';
	 
	 select user_json->>'data', email_id into v_json , v_email_id 
	 from labpkl_v1.labpkl_v1_panga_hunt_user
	 where device_token = v_device_token ;
	 
	 
	 
	select array_agg(panga_hunt_user_id) into v_panga_hunt_user_id  
	from labpkl_v1.labpkl_v1_panga_hunt_user
	where email_id = v_email_id ;
	
	if v_email_id is null then
	
	v_result := 0;
	
	else
	 
	 if not exists(select 1 from labpkl_v1.labpkl_v1_panga_hunt_contest
				 where panga_hunt_user_id = ANY(v_panga_hunt_user_id)
				  and (creadted_date + '5.5 hours'::interval)::date = (v_current_timestamp + '5.5 hours'::interval)::date) then
			
		v_result := 1 ;	
		
		-- v_json := jsonb_set(v_json,'{status}',v_result::text::jsonb,true);
						
	else
	
	    v_result := 2 ;
		
		-- v_json := jsonb_set(v_json,'{status}',v_result::text::jsonb,true);
			 
    end if;
	
	end if;
	
	v_json := jsonb_set(v_json,'{status}',v_result::text::jsonb,true);
	
	p_ures_json := v_json;

end;
$$;


--
