-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_ins_upd_module_count(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_ins_upd_module_count(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_ins_upd_module_count(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
           v_json->'data'->>'module_name',
           v_json->'data'->>'current_count',
           v_json->'data'->>'total_count'
    into   v_module_id,
           v_module_guid,
           v_module_name,
           v_current_count,
           v_total_count;
		
	if not exists 
		(select 1 from labgt01_v1.labgt01_v1_module where module_name = v_module_name or module_id = v_module_id or module_guid = v_module_guid) then
	    v_module_id   := nextval('labgt01_v1.seq_labgt01_v1_module_id');
		
		insert into labgt01_v1.labgt01_v1_module (
            module_id, module_name, version_number,module_guid,created_date,updated_date, 
            total_count, current_count, is_active,is_deleted,is_published,is_trashed ) 
			values (
            v_module_id,v_module_name,1,uuid_generate_v4(),v_currenttimestamp, v_currenttimestamp,
            v_total_count, v_current_count,
            1,  -- active
            0,  -- deleted
            1,  -- published
            0   -- trashed
        );
        
        p_result := 1;  
        p_data := jsonb_build_object(
			'status', p_result,
            'module_id', v_module_id,
            'module_name', v_module_name,
			'current_count', v_current_count,
			'total_count', v_total_count,
			'message', 'inserted'     
        );
	else 
	
	if v_current_count is not null and v_total_count is not null then 
		select version_number into v_version_number
		from labgt01_v1.labgt01_v1_module
		where module_name = v_module_name or module_id = v_module_id or module_guid = v_module_guid
		limit 1;
		
		v_version_number := v_version_number + 1;
		
		update labgt01_v1.labgt01_v1_module
        set 
            updated_date = v_currenttimestamp,
            total_count = v_total_count,
            current_count = v_current_count,
			version_number = v_version_number
        where module_name = v_module_name or module_id = v_module_id or module_guid = v_module_guid;
        
        p_result := 2; 
        p_data := jsonb_build_object(
			'status', p_result,
            'module_id', v_module_id,
            'module_name', v_module_name,
			'current_count', v_current_count,
			'total_count', v_total_count,
			'message', 'updated'     
        );
		
		else 
			p_result := 2; 
            p_data := jsonb_build_object(
			'status', p_result,
			'message', 'Current count and Total count cannot be null'     
           );
		   end if;
	end if;
end;
$$;


--
