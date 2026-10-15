-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_ins_panga_hunt_contest(jsonb)
-- Type: FUNCTION

-- Name: labpkl_v1_ins_panga_hunt_contest(jsonb); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_ins_panga_hunt_contest(p_json jsonb, OUT p_result_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
    v_email_id character varying;
	v_full_name character varying;
	v_device_token character varying;
	v_current_timestamp timestamp without time zone;
	v_platform_id numeric;
	v_panga_hunt_user_id numeric[];
	v_result numeric;
	v_user_id numeric;
	v_is_claim numeric;
	
	/*
	  {
  "data": {
    "is_ind": true,
    "is_tnc": true,
    "is_claim": 0,
    "user_info": {
      "full_name": "",
      "email_id": ""
    },
    "device_token": "",
    "captcha": ""
  }
}  
	*/

begin

  select p_json->'data'->'user_info'->>'email_id',
  		 p_json->'data'->'user_info'->>'full_name',
		 p_json->'data'->>'device_token',
		 p_json->'data'->>'platform_id',
		 p_json->'data'->>'is_claim'
  into	 v_email_id,
  		 v_full_name,
		 v_device_token,
		 v_platform_id,
		 v_is_claim;
		 
	  	 v_current_timestamp := current_timestamp at time zone 'utc';
		 
	if v_is_claim = 0 then	 
		 
	
		if not exists(select 1 from labpkl_v1.labpkl_v1_panga_hunt_user
					 where email_id = v_email_id and device_token = v_device_token ) then

			insert into labpkl_v1.labpkl_v1_panga_hunt_user
			(panga_hunt_user_id,email_id,full_name,device_token,platform_id,creadted_date,updated_date,user_json)
			select nextval('labpkl_v1.seq_labpkl_v1_panga_hunt_user_id'),v_email_id,v_full_name,v_device_token,
				   v_platform_id,v_current_timestamp,v_current_timestamp,p_json;

						v_result := 1 ;

					p_result_json := '{
										"status": '||v_result||',
											"msg": "User registered."
										  }';  
										  
            else
					
					v_result := 2 ;

					p_result_json := '{
										"status": '||v_result||',
											"msg": "User already registered."
										  }'; 
			
				

			end if;	
	
	elsif v_is_claim = 1 then
	
	if  exists(select 1 from labpkl_v1.labpkl_v1_panga_hunt_user
					 where email_id = v_email_id) then 
					 
			select array_agg(panga_hunt_user_id) into v_panga_hunt_user_id  
			from labpkl_v1.labpkl_v1_panga_hunt_user
			where email_id = v_email_id ;

					if not exists(select 1 from labpkl_v1.labpkl_v1_panga_hunt_contest
							 where panga_hunt_user_id = ANY(v_panga_hunt_user_id)
							  and (creadted_date + '5.5 hours'::interval)::date = (v_current_timestamp + '5.5 hours'::interval)::date) then

					select panga_hunt_user_id into v_user_id  
					from labpkl_v1.labpkl_v1_panga_hunt_user
					where email_id = v_email_id ;

					insert into labpkl_v1.labpkl_v1_panga_hunt_contest
					(contest_id,panga_hunt_user_id,creadted_date,user_json)
					select nextval('labpkl_v1.seq_labpkl_v1_panga_hunt_contest_id'),
						  v_user_id,v_current_timestamp,p_json ;

					v_result := 1 ;
					p_result_json := '{
										"status": '||v_result||',
										"msg": "Ticket claimed successfully."
									  }';

				else	

					v_result := 2 ;

					p_result_json := '{
										"status": '||v_result||',
										"msg": "Ticket already claimed."
									  }';

				end if;
				
				else 
				p_result_json := '{
										"status": 0,
										"msg": "Email Not Exist"
									  }';
			end if;
	
	end if;

end;
$$;


--
