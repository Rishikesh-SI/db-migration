-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_generate_otpless_v2(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_generate_otpless_v2(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_generate_otpless_v2(p_inputjson jsonb, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_mobile_no character varying(1000);
    v_created_date timestamp := current_timestamp at time zone 'utc';
    v_attempt numeric;
    v_country_code character varying;
    v_status boolean;
BEGIN
    -- Extract input (unchanged)
    SELECT
        p_inputjson->'data'->>'mobile_no',
        p_inputjson->'data'->>'country_code'
    INTO
        v_mobile_no,
        v_country_code;
		

    -- Count today's attempts (unchanged)
    SELECT COUNT(mobile_no)
    INTO v_attempt
    FROM labdd_v1.labdd_v1_otpless_details
    WHERE mobile_no = v_mobile_no
      AND created_date::date = current_date
    GROUP BY mobile_no;

    v_attempt := COALESCE(v_attempt, 0) + 1;

    -- Logic for success/failure (unchanged)
    IF v_attempt <= 4 THEN
        INSERT INTO labdd_v1.labdd_v1_otpless_details
        VALUES (v_mobile_no, v_created_date, v_country_code);
        v_status := TRUE;
    ELSE
        v_status := FALSE;
    END IF;

    p_result := v_status;
    RETURN;
END;
$$;


--
