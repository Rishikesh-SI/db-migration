-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_custom_web_model_r(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_get_custom_web_model_r(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_custom_web_model_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	declare
	
		/*
		 {
		  "user_guid": "7d9599b7-ef18-4f68-a805-ac433a09f65f",
		  "module_name": "fanclub",
		  "is_app": "1"
		}
		*/
		
		v_user_guid text;
		v_module_name text;

	begin
	
	 select p_json->>'user_guid',
	 		p_json->>'module_name'
     into v_user_guid,
	      v_module_name;
		  
		if v_module_name <> 'cometchatfanclub'  then
		  
		  
				if exists(select 1 from labkc_v1.labkc_v1_custom_web_json
								 where user_guid = v_user_guid and lower(module_name) = lower(v_module_name)) then

					p_data:= '{
							"data": {
							"status":"1",
							"message":"Already Exists"
							}
							}';			 

				else

					p_data:= '{
							"data": {
							"status":"0",
							"message":"Not Exists"
							}
							}';

				end if;
				
		else
		
			select '{ "data" :'||json_agg(row)||'}' into p_data from(
				select datajson->'data'->>'club_name' as club_name,status,remark 
				from labkc_v1.labkc_v1_custom_web_json
				where user_guid = v_user_guid
				and lower(module_name) = lower(v_module_name))row ;
		
		
		end if ;
		  

	end;

	
$$;


--
