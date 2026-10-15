-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_peppo_ins_upd_failed_request(jsonb)
-- Type: FUNCTION

-- Name: labgt_peppo_ins_upd_failed_request(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_peppo_ins_upd_failed_request(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_waf_user_guid       VARCHAR;
    v_event_type          VARCHAR;
    v_api_type            VARCHAR;
    v_request_url         VARCHAR;
    v_request_payload     TEXT;
  
    v_response_status     INT;
    v_response_body       TEXT;
  
    v_attempt_no          INT;
    v_max_attempts        INT;
    v_is_final_failure    BOOLEAN;
    v_processing_status   VARCHAR;
BEGIN
    SELECT
       p_json->>'user_guid',
    p_json->>'event_type',
    p_json->>'api_type',
    p_json->>'request_url',
    p_json->>'request_payload',
    
    (p_json->>'response_status_code')::INT,
    p_json->>'response_body',
    
    (p_json->>'attempt_no')::INT,
    (p_json->>'max_attempts')::INT,
    (p_json->>'is_final_failure')::BOOLEAN,
    COALESCE(p_json->>'processing_status', 'pending')
    INTO
        v_waf_user_guid,
        v_event_type,
        v_api_type,
        v_request_url,
        v_request_payload,
        
        v_response_status,
        v_response_body,
        
        v_attempt_no,
        v_max_attempts,
        v_is_final_failure,
        v_processing_status;

    IF EXISTS (
        SELECT 1
        FROM labgt.labgt_peppo_failed_requests
        WHERE waf_user_guid = v_waf_user_guid
    )
    THEN
        UPDATE labgt.labgt_peppo_failed_requests
        SET
           
            response_status_code  = v_response_status,
            response_body         = v_response_body,
           
            attempt_no            = v_attempt_no,
            is_final_failure      = v_is_final_failure,
            processing_status     = v_processing_status,
            updated_date          = CURRENT_TIMESTAMP
        WHERE waf_user_guid = v_waf_user_guid;
    ELSE
        INSERT INTO labgt.labgt_peppo_failed_requests
        (
            waf_user_guid,
            event_type,
            api_type,
            request_url,
            request_payload,
            
            response_status_code,
            response_body,
            
            attempt_no,
            max_attempts,
            is_final_failure,
            processing_status,
            created_date,
            updated_date
        )
        VALUES
        (
            v_waf_user_guid,
            v_event_type,
            v_api_type,
            v_request_url,
            v_request_payload,
           
            v_response_status,
            v_response_body,
          
            v_attempt_no,
            v_max_attempts,
            v_is_final_failure,
            v_processing_status,
            CURRENT_TIMESTAMP,
            CURRENT_TIMESTAMP
        );
    END IF;

    p_data := jsonb_build_object(
        'data', jsonb_build_object(
            'status', '1',
            'message', 'Success'
        )
    );


END;
$$;


--
