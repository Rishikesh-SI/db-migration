-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_module_count(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_get_module_count(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_module_count(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
    v_module_id numeric;
	v_module_guid character varying;
	v_module_name character varying;
	v_total_count numeric; 
	v_current_count numeric;
	v_currenttimestamp timestamp without time zone;
	v_json jsonb;
	v_version_number numeric;
begin
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
	
	v_json := p_json;
	
	select v_json->'data'->>'module_id',
           v_json->'data'->>'module_guid',
           v_json->'data'->>'module_name'
    into   v_module_id,
           v_module_guid,
           v_module_name;
		
	if exists 
		(select 1 from labgt01_v1.labgt01_v1_module where module_name = v_module_name or module_id = v_module_id or module_guid = v_module_guid) then
        
		select module_id,current_count,total_count into v_module_id,v_current_count,v_total_count
		from labgt01_v1.labgt01_v1_module
		where module_name = v_module_name or module_id = v_module_id or module_guid = v_module_guid limit 1;
		
	    p_result := 1;  
        p_data := jsonb_build_object(
			'status', p_result,
			'message', 'Sucess',   
            'module_id', v_module_id,
            'module_name', v_module_name,
			'current_count', v_current_count,
			'total_count', v_total_count
        );
	else 
        p_result := 0; 
        p_data := jsonb_build_object(
			'status', p_result,
			'message', 'module does not exist',
            'module_id', v_module_id,
            'module_name', v_module_name,
			'current_count', v_current_count,
			'total_count', v_total_count			    
        );
	end if;
end;
$$;


--
