-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_get_custom_web_model_r_24042023(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_get_custom_web_model_r_24042023(jsonb); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_get_custom_web_model_r_24042023(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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
		  

	end;
$$;


--
