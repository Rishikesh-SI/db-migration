-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_generate_otpless_v2(jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_generate_otpless_v2(jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_generate_otpless_v2(p_inputjson jsonb, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_mobile_no character varying(1000);
    v_created_date timestamp := current_timestamp at time zone 'utc';
    v_attempt numeric;
    v_client_code character varying(1000) := 'labkkr_v1';
    v_country_code numeric;
    v_status boolean;
BEGIN
    -- Extract input
    SELECT
        p_inputjson->'data'->>'mobile_no',
        NULLIF(p_inputjson->'data'->>'country_code', '')::numeric
    INTO
        v_mobile_no,
        v_country_code;

    -- Count today's attempts
    SELECT COUNT(mobile_no)
    INTO v_attempt
    FROM labkc_v1.labkc_v1_otpless_details
    WHERE mobile_no = v_mobile_no
      AND country_code = v_country_code
      AND created_date::date = current_date
    GROUP BY mobile_no;

    v_attempt := COALESCE(v_attempt, 0) + 1;

    -- Allow or deny based on attempt count
    IF v_attempt <= 10 THEN
        INSERT INTO labkc_v1.labkc_v1_otpless_details
        VALUES (v_mobile_no, v_created_date, v_client_code, NULL, v_country_code);
        v_status := TRUE;
    ELSE
        v_status := FALSE;
    END IF;

    p_result := v_status;
    RETURN;
END;
$$;


--
