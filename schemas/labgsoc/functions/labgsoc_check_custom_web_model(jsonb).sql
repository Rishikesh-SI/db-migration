-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_check_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_check_custom_web_model(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_check_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

v_module_name character varying;
v_user_guid character varying;
v_datajson jsonb;
begin
/*
{
    "module": "luckydraw",
    "user_guid":""
}
*/

 select    p_json->>'module',
		   p_json->>'user_guid'
into 
	v_module_name,
	v_user_guid;

  
			
if not exists (select 1 from labgsoc.labgsoc_custom_web_json where user_guid = v_user_guid and lower(module_name) = v_module_name)
	then
 
		 p_data:='{
					"data": {
					"status":"1",
					"message":"Form not submitted"
					}
					}';
	else  
		  p_data:='{
						"data": {
						"status":"0",
						"message":"Form Already Submitted"
						}
						}';				
					
	
	end if;

-- if not exists (select 1 from labgsoc.labgsoc_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'isl-100th-signed-pennat')
-- 	then
 
-- 		 p_data:='{
-- 					"data": {
-- 					"status":"1",
-- 					"message":"Form not submitted"
-- 					}
-- 					}';
-- 	else  
-- 		  p_data:='{
-- 						"data": {
-- 						"status":"0",
-- 						"message":"Form Already Submitted"
-- 						}
-- 						}';				
					
	
-- 	end if;
	
end;
$$;


--
