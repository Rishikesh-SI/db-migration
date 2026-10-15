-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_generate_otpless(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_generate_otpless(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_generate_otpless(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    /*
    {
      "data": {
        "mobile_no": "string",
        "country_code": "91"
      }
    }
    */
    v_mobile_no     varchar(1000);
    v_created_date  timestamp := current_timestamp at time zone 'utc';
    v_attempt       numeric;
    v_client_code   varchar(1000) := 'labkc_v1';
    v_country_code  numeric;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
BEGIN
    -- Extract input
    SELECT p_inputjson->'data'->>'mobile_no',
           NULLIF(p_inputjson->'data'->>'country_code','')::numeric
    INTO   v_mobile_no, v_country_code;

	IF (v_mobile_no IS NULL or v_country_code is null) THEN 
		p_data := jsonb_build_object( 
										'status','0', 
								 		'message','Mobile_no with country_code is needed under json {data} node' 
			); 
      RETURN; 
	END IF;
	
--     -- Step 1: Check lockout
--     IF EXISTS (
--         SELECT 1
--         FROM labkc_v1.labkc_v1_otpless_lockout_log 
--         WHERE mobile_no   = v_mobile_no
--           AND country_code = v_country_code
--           AND lock_time > v_current_timestamp - interval '1 day'
--     ) THEN
--         p_data := '{
--             "status":"0",
--             "message":"Your OTP request limit has been exceeded. Please try again after 24 hours."
--         }';
--         RETURN;
--     END IF;

    -- Step 2: Count today's attempts
    SELECT count(*) 
    INTO v_attempt
    FROM labkc_v1.labkc_v1_otpless_details
    WHERE mobile_no    = v_mobile_no
      AND country_code = v_country_code
      AND created_date::date = current_date;

    v_attempt := coalesce(v_attempt,0) + 1;

    -- Step 3: Allow or lock
    IF v_attempt <= 10 THEN
        INSERT INTO labkc_v1.labkc_v1_otpless_details
            (mobile_no, created_date, client_code, unique_id, country_code)
        VALUES
            (v_mobile_no, v_created_date, v_client_code, null, v_country_code);

        p_data := jsonb_build_object(
            'status','1',
            'message','Success',
            'attempt', v_attempt::text || '/10',
            'current_attempt', v_attempt::text,
            'max_attempt','10'
        );
    ELSE
        -- Either update existing lock or insert a new one
        IF EXISTS (
            SELECT 1 FROM labkc_v1.labkc_v1_otpless_lockout_log
            WHERE mobile_no = v_mobile_no
              AND country_code = v_country_code
        ) THEN
            UPDATE labkc_v1.labkc_v1_otpless_lockout_log
            SET lock_time = v_current_timestamp
            WHERE mobile_no = v_mobile_no
              AND country_code = v_country_code;
        ELSE
            INSERT INTO labkc_v1.labkc_v1_otpless_lockout_log
                (mobile_no, lock_time, country_code, unlock_time, unlock_type)
            VALUES
                (v_mobile_no, v_current_timestamp, v_country_code, null, 0);
        END IF;

        p_data := '{
            "status":"0",
            "message":"You have exhausted the daily limit of OTP request, Please try again after 24 hours"
        }';
    END IF;
END;
$$;


--
