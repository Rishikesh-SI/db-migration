-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_store_uuid(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_store_uuid(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_store_uuid(p_uuid_json jsonb, OUT p_result_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_current_timestamp timestamp without time zone;
    v_uuid character varying;
    v_status numeric;
    v_message character varying;
    v_uuid_id numeric;
    
BEGIN
    v_current_timestamp := current_timestamp at time zone 'utc';
    
    SELECT p_uuid_json->>'uuid'
    INTO v_uuid;
    
    
    IF v_uuid IS NULL OR v_uuid = '' THEN
        v_status := 0;
        v_message := 'UUID is required';
    ELSE
        
        INSERT INTO labkc_v1.labkc_v1_uuid_storage (uuid, created_date, updated_date) 
        VALUES (v_uuid, v_current_timestamp, v_current_timestamp)
        RETURNING uuid_id INTO v_uuid_id;
        
        v_status := 1;
        v_message := 'UUID Stored successfully';
    END IF;
    
    
    p_result_json := ('{
        "data": {
            "status": ' || coalesce(v_status, 0) || ',
            "message": "' || coalesce(v_message, '') || '",
            "uuid": "' || coalesce(v_uuid, '') || '",
            "uuid_id": ' || coalesce(v_uuid_id, 0) || ',
            "timestamp": "' || v_current_timestamp || '"
        }
    }')::jsonb;
    

        
END;
$$;


--
