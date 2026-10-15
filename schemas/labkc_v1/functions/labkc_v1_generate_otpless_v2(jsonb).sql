-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_generate_otpless_v2(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_generate_otpless_v2(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_generate_otpless_v2(p_inputjson jsonb, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_mobile_no     varchar(1000);
    v_created_date  timestamp := current_timestamp at time zone 'utc';
    v_attempt       numeric;
    v_client_code   varchar(1000) := 'labkc_v1';
    v_country_code  numeric;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_status        boolean;
BEGIN
    -- Extract input
    SELECT p_inputjson->'data'->>'mobile_no',
           NULLIF(p_inputjson->'data'->>'country_code','')::numeric
    INTO   v_mobile_no, v_country_code;

    IF (v_mobile_no IS NULL OR v_country_code IS NULL) THEN
        v_status := FALSE;
        RETURN;
    END IF;

    -- Step 2: Count today's attempts
    SELECT COUNT(*)
    INTO v_attempt
    FROM labkc_v1.labkc_v1_otpless_details
    WHERE mobile_no    = v_mobile_no
      AND country_code = v_country_code
      AND created_date::date = current_date;

    v_attempt := COALESCE(v_attempt, 0) + 1;

    -- Step 3: Allow or lock
    IF v_attempt <= 10 THEN
        INSERT INTO labkc_v1.labkc_v1_otpless_details
            (mobile_no, created_date, client_code, unique_id, country_code)
        VALUES
            (v_mobile_no, v_created_date, v_client_code, NULL, v_country_code);
        v_status := TRUE;
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
                (v_mobile_no, v_current_timestamp, v_country_code, NULL, 0);
        END IF;
        v_status := FALSE;
    END IF;

    p_result := v_status;
    RETURN;
END;
$$;


--
