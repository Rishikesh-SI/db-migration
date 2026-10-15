-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_check_uuid_exists(jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_check_uuid_exists(jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_check_uuid_exists(p_uuid_json jsonb, OUT p_result_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_current_timestamp timestamp without time zone;
    v_uuid character varying;
    v_status numeric;
    v_message character varying;
    v_exists_count numeric;
    
BEGIN
    v_current_timestamp := current_timestamp at time zone 'utc';
    
    -- Extract uuid from input JSON following the same pattern as user_guid extraction
    SELECT p_uuid_json->>'uuid'
    INTO v_uuid;
    
    
    IF v_uuid IS NULL OR v_uuid = '' THEN
        v_status := 0;
        v_message := 'UUID is required';
    ELSE
        
        SELECT COUNT(1) 
        FROM labkkr_v1.labkkr_v1_uuid_storage 
        WHERE uuid = v_uuid
        INTO v_exists_count;
        
        IF v_exists_count > 0 THEN
            v_status := 1;
            v_message := 'UUID exists';
        ELSE
            v_status := 0;
            v_message := 'UUID does not exist';
        END IF;
    END IF;
    
    -- Prepare result JSON following the exact same pattern as reference function
    p_result_json := ('{
        "data": {
            "status": ' || coalesce(v_status, 0) || ',
            "message": "' || coalesce(v_message, '') || '",
            "uuid": "' || coalesce(v_uuid, '') || '",
            "exists": ' || coalesce(v_status, 0) || ',
            "timestamp": "' || v_current_timestamp || '"
        }
    }')::jsonb;
        
END;
$$;


--
