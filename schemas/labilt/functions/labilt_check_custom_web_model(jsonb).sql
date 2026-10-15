-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_check_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labilt_check_custom_web_model(jsonb); Type: FUNCTION; Schema: labilt; Owner: -
--

CREATE FUNCTION labilt.labilt_check_custom_web_model(p_json jsonb) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare

v_module_name character varying;
v_student_id text;
v_datajson jsonb;
v_school_name text;
p_data boolean := false;
begin
raise notice 'p_data %',p_data;
 select    p_json->'data'->>'module',
		   p_json->'data'->>'student_id',
		   p_json->'data'->>'school_name'
into 
	v_module_name,
	v_student_id,
	v_school_name;  
			
if exists (select 1 
				from labilt.labilt_custom_web_json 
				where  module_name = v_module_name 
					and student_id = v_student_id
					and school_name = v_school_name			
			)
then

	 p_data:= true;

 end if;

	return p_data;

end;
$$;


--
