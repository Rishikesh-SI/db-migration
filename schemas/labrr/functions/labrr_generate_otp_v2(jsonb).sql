-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_generate_otp_v2(jsonb)
-- Type: FUNCTION

-- Name: labrr_generate_otp_v2(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_generate_otp_v2(p_inputjson jsonb, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_mobile_no varchar;
    v_email_id varchar;
    v_otp numeric;
    v_opt numeric;
    v_type numeric;
    v_user_guid varchar;
    v_is_app numeric;
    v_failed_attempt numeric;
    v_created_date timestamp;
    v_user_lock numeric;
    v_otp_request_count numeric;
    v_mobile_with_countrycode varchar;
    v_request_ip varchar;
    v_country_code varchar;  
    v_status boolean;
BEGIN

    -- Extract input
    SELECT
        p_inputjson->'data'->>'mobile_no',
        (p_inputjson->'data'->>'otp')::numeric,
        p_inputjson->'data'->>'email_id',
        (p_inputjson->'data'->>'type')::numeric,
        (p_inputjson->'data'->>'opt')::numeric,
        p_inputjson->'data'->>'user_guid',
        (p_inputjson->'data'->>'is_app')::numeric,
        p_inputjson->'data'->>'mobile_with_countrycode',
        p_inputjson->'data'->>'ip',
        p_inputjson->'data'->>'country_code'   
    INTO
        v_mobile_no,
        v_otp,
        v_email_id,
        v_type,
        v_opt,
        v_user_guid,
        v_is_app,
        v_mobile_with_countrycode,
        v_request_ip,
        v_country_code;

    -- ---------- STATIC OTP ----------
    IF EXISTS (
        SELECT 1
        FROM siwaf.siwaf_records_static_otp
        WHERE mobile_no = v_mobile_no
          AND client_name = 'labgt'
          AND is_active = 1
    ) THEN

        INSERT INTO labrr.labrr_otp_details(
            mobile_no, otp, created_date, expiry_date,
            is_verified, type, user_guid, is_app, opt,
            mobile_no_cc, request_ip, country_code
        )
        VALUES (
            COALESCE(v_mobile_no, v_email_id),
            123456,
            now(),
            now() + interval '5 hours',
            0,
            v_type,
            v_user_guid,
            v_is_app,
            v_opt,
            v_mobile_with_countrycode,
            v_request_ip,
            v_country_code
        );

        p_result := TRUE;
        RETURN;
    END IF;

    -- ---------- LOCK CHECK ----------
    IF NOT EXISTS (
        SELECT 1
        FROM labrr.labrr_otp_lockout_log
        WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
          AND country_code::text = v_country_code   -- 🔥 FIX
          AND lock_time > now() - interval '1 day'
    ) THEN

        SELECT COUNT(*)
        INTO v_otp_request_count
        FROM labrr.labrr_otp_details
        WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
          AND type = v_type
          AND country_code = v_country_code
          AND created_date > now() - interval '1 day';

        IF v_otp_request_count >= 5 THEN
            INSERT INTO labrr.labrr_otp_lockout_log(
                mobile_no, lock_time, country_code
            )
            VALUES (
                COALESCE(v_mobile_no, v_email_id),
                now(),
                v_country_code::numeric   
            );

            v_user_lock := 1;
        ELSE
            v_user_lock := 0;
        END IF;

    ELSE
        v_user_lock := 1;
    END IF;

    -- ---------- OTP GENERATION ----------
IF v_user_lock = 0 THEN

    SELECT COALESCE(failed_attempt, 0), created_date
    INTO v_failed_attempt, v_created_date
    FROM labrr.labrr_otp_details
    WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
      AND type = v_type
      AND country_code = v_country_code
    ORDER BY created_date DESC
    LIMIT 1;

    IF v_failed_attempt <= 10
       OR (v_failed_attempt > 10 AND v_created_date + interval '5 minutes' < now())
       OR v_created_date IS NULL THEN

        INSERT INTO labrr.labrr_otp_details(
            mobile_no, otp, created_date, expiry_date,
            is_verified, type, user_guid, is_app, opt,
            mobile_no_cc, request_ip, country_code
        )
        VALUES (
            COALESCE(v_mobile_no, v_email_id),
            v_otp,
            now(),
            now() + interval '30 minutes',
            0,
            v_type,
            v_user_guid,
            v_is_app,
            v_opt,
            v_mobile_with_countrycode,
            v_request_ip,
            v_country_code
        );

        v_status := TRUE;
    ELSE
        v_status := FALSE;
    END IF;

ELSE
    v_status := FALSE;
END IF;

    p_result := v_status;
    RETURN;

END;
$$;


--
