-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_ins_custom_module(jsonb)
-- Type: FUNCTION

-- Name: labpkl_v1_ins_custom_module(jsonb); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_ins_custom_module(p_json jsonb, OUT p_data_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_custom_id numeric;
v_module_name character varying;
v_match_day character varying;
v_max_entry numeric;
v_count numeric;
begin

 select    p_json->'data'->>'module',
           p_json->'data'->>'max_entry',
           p_json->'data'->>'match_day'
into 
	v_module_name,
	v_max_entry,
	v_match_day;


 if exists (select (1) from labpkl_v1.labpkl_v1_custom_web_json
			   where module_name='fanwall') then
			
			   
			select count(1) into v_count
			from labpkl_v1.labpkl_v1_custom_web_json
			where module_name=v_module_name
			and match_day=v_match_day;
			
			if (v_count<=v_max_entry) then
			
				v_custom_id:=nextval('labpkl_v1.seq_labpkl_v1_custom_id');
				
				insert into labpkl_v1.labpkl_v1_custom_web_json
				values(v_custom_id,v_module_name,v_match_day);
				
				p_data_json:='{
				"data": {
				"status":"1"
				}
				}';
			
			end if;
  end if;

			  
end;
$$;


--
