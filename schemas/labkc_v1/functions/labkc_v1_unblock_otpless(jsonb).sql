-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_unblock_otpless(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_unblock_otpless(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_unblock_otpless(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    /*
    {
      "data": {
        "mobile_no": "string",   -- optional
        "country_code": "91",    -- required if mobile_no is given
        "ip_address": "string"   -- optional (for future use)
      }
    }
    */
    v_mobile_no    varchar(1000);
    v_country_code numeric;
    v_ip_address   varchar(100);
    v_deleted_det  numeric := 0;
    v_updated_log  numeric := 0;
BEGIN

    SELECT p_inputjson->'data'->>'mobile_no',
           (p_inputjson->'data'->>'country_code')::numeric
    INTO   v_mobile_no, v_country_code; 

    IF (v_mobile_no IS NULL or  v_country_code is null ) THEN
        p_data := jsonb_build_object(
            'status','0',
            'message','Mobile_no with country_code is needed under json {data} node'
        );
        RETURN;
    END IF;

    IF v_mobile_no IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM labkc_v1.labkc_v1_otpless_details WHERE mobile_no = v_mobile_no AND country_code = v_country_code AND created_date::date = current_date
        ) THEN
            p_data := jsonb_build_object(
                'status','0',
                'message','Mobile number '||v_mobile_no||' does not exist for today'
            );
            RETURN;
			   ELSE
			DELETE FROM labkc_v1.labkc_v1_otpless_details
			WHERE ctid IN (
				SELECT ctid
				FROM labkc_v1.labkc_v1_otpless_details
				WHERE mobile_no = v_mobile_no
				  AND country_code = v_country_code
				  AND created_date::date = current_date
			);
			GET DIAGNOSTICS v_deleted_det = ROW_COUNT;
		END IF;

        IF NOT EXISTS (
            SELECT 1 FROM labkc_v1.labkc_v1_otpless_lockout_log WHERE mobile_no = v_mobile_no AND country_code = v_country_code
        				) THEN
            p_data := jsonb_build_object(
                'status','0',
                'message','Mobile number '||v_mobile_no||' does not exist in lockout log table'
            );
            RETURN;
        ELSE
            UPDATE labkc_v1.labkc_v1_otpless_lockout_log
            SET lock_time  = (current_timestamp  - interval '2 days'), -- push back so not considered locked
                unlock_time = current_timestamp,
                unlock_type = 1                           --1 FORCED , 0 naturally 
            WHERE mobile_no = v_mobile_no
              AND country_code = v_country_code;
            GET DIAGNOSTICS v_updated_log = ROW_COUNT;
        END IF;
    END IF;

    IF v_deleted_det > 0 OR v_updated_log > 0 THEN
        p_data := jsonb_build_object(
            'status','1',
            'message','Unblock successful',
            'rows_deleted_details', v_deleted_det,
            'rows_updated_log', v_updated_log
        );
    ELSE
        p_data := jsonb_build_object(
            'status','0',
            'message','No matching blocked entry found. mobile number does not exist in the table'
        );
    END IF;
END;
$$;


--
