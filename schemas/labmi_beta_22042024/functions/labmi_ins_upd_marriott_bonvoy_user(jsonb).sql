-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_ins_upd_marriott_bonvoy_user(jsonb)
-- Type: FUNCTION

-- Name: labmi_ins_upd_marriott_bonvoy_user(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_ins_upd_marriott_bonvoy_user(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$     

	
	declare
		
	/*{"user_name" : "dipnil24",
		"user_guid" : "728a3020-126d-4693-830a-c65082b347bd",
		"opt_type" : 1,
		"poll_id" : 741
	
	}*/

	-- v_json  jsonb;
	
	v_user_name character varying ;
	v_user_guid character varying ;
	v_opt_type numeric ;
	v_user_id numeric ;
	v_poll_id numeric ;

	begin
	
		select p_json->>'user_name',
			   p_json->>'user_guid',
			   p_json->>'opt_type',
			   p_json->>'poll_id'
		into v_user_name,
			 v_user_guid,
			 v_opt_type,
			 v_poll_id;
			 
		select user_id into v_user_id  from labmi.labmi_web_user		
		where user_guid = v_user_guid;	 
			 
		if v_opt_type = 1 then
		
			if exists(select 1 from labmi.labmi_user_poll_response
					 where poll_id = v_poll_id and user_id = v_user_id and marriott_bonvoy_user is not null) then
				
				p_result := 2 ;
					 
			else
				
				p_result := 1 ;
			
			end if;
					 					 				
		elseif v_opt_type = 2 then
		
			if exists(select 1 from labmi.labmi_user_poll_response
					 where poll_id = v_poll_id and user_id = v_user_id and marriott_bonvoy_user is not null ) then
					 
					p_result := 2 ;	 
			
			else
		
					update labmi.labmi_user_poll_response
					set marriott_bonvoy_user = v_user_name
					where user_id = v_user_id and poll_id = v_poll_id;
					
					p_result := 1 ;
			end if;
		
		
		
		end if;
		
	

	end;

	$$;


--
