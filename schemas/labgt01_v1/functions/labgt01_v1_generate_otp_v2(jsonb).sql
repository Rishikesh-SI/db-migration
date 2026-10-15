-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_generate_otp_v2(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_generate_otp_v2(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_generate_otp_v2(p_inputjson jsonb, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_mobile_no character varying(1000);
    v_email_id character varying(1000);
    v_otp numeric;
    v_opt numeric;
    v_type numeric;
    v_user_guid character varying(1000);
    v_is_app numeric;
    v_count numeric;
    v_created_date timestamp;
    v_user_full_name character varying(1000);
    v_failed_attempt numeric;
    v_updated_date timestamp;
    v_user_lock numeric;
    v_otp_request_count numeric;
    v_mobile_with_countrycode character varying(1000);
    v_request_ip character varying(1000);
    v_country_code numeric;
    v_status boolean;
    v_result_json jsonb;
BEGIN
    SELECT
        p_inputjson->'data'->>'mobile_no',
        p_inputjson->'data'->>'otp',
        p_inputjson->'data'->>'email_id',
        p_inputjson->'data'->>'type',
        p_inputjson->'data'->>'opt',
        p_inputjson->'data'->>'user_guid',
        p_inputjson->'data'->>'is_app',
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
		
		raise notice '111mobile_no:%',v_mobile_no;
		
    -- Check for static OTP
    IF EXISTS (
        SELECT 1
        FROM siwaf.siwaf_records_static_otp
        WHERE mobile_no = v_mobile_no
          AND client_name = 'labgt01_v1'
          AND is_active = 1
    ) THEN
	raise notice '222.mobile_no:%',v_mobile_no;
        INSERT INTO labgt01_v1.labgt01_v1_otp_details(
            mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, updated_date, mobile_no_cc, request_ip, country_code
        )
        VALUES (
            COALESCE(v_mobile_no, v_email_id),
            123456,
            current_timestamp AT TIME ZONE 'utc',
            current_timestamp AT TIME ZONE 'utc' + '18000 seconds'::interval,
            0,
            v_type,
            v_user_guid,
            v_is_app,
            v_opt,
            current_timestamp AT TIME ZONE 'utc',
            v_mobile_with_countrycode,
            v_request_ip,
            v_country_code
        );
		
        p_result := TRUE;
		
        RETURN;
		
		
    END IF;
	 
	 raise notice '2.mobile_no:%',v_mobile_no;
	 
    -- Handle OTP generation for opt 1 or 2
    IF v_opt IN (1, 2) THEN
        -- Check if user is locked out
        IF NOT EXISTS (
            SELECT 1
            FROM labgt01_v1.labgt01_v1_otp_lockout_log
            WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
              AND country_code = v_country_code
              AND lock_time > now() - interval '1 day'
        ) THEN
		raise notice 'lockkmobile_no:%',v_mobile_no;
            -- Check OTP request count
            SELECT COUNT(*)
            INTO v_otp_request_count
            FROM labgt01_v1.labgt01_v1_otp_details
            WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
              AND type = v_type
              AND country_code = v_country_code
              AND created_date > now() - interval '1 day';

            IF v_otp_request_count >= 200 THEN
                INSERT INTO labgt01_v1.labgt01_v1_otp_lockout_log (mobile_no, lock_time, country_code)
                VALUES (COALESCE(v_mobile_no, v_email_id), now(), v_country_code);
                v_user_lock := 1;
            ELSE
                v_user_lock := 0;
            END IF;
        ELSE
            v_user_lock := 1;
        END IF;

        -- If not locked, proceed with OTP generation
        IF v_user_lock = 0 THEN
            SELECT COALESCE(failed_attempt, 0), updated_date
            INTO v_failed_attempt, v_updated_date
            FROM labgt01_v1.labgt01_v1_otp_details
            WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
              AND type = v_type
              AND country_code = v_country_code
            ORDER BY created_date DESC
            LIMIT 1;
		raise notice 'mobile_no:%',v_mobile_no;
            IF v_failed_attempt <= 10
               OR (v_failed_attempt > 10 AND v_updated_date + '5 minutes'::interval < current_timestamp AT TIME ZONE 'utc')
               OR v_updated_date IS NULL THEN
                INSERT INTO labgt01_v1.labgt01_v1_otp_details(
                    mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, updated_date, mobile_no_cc, request_ip, country_code
                )
                VALUES (
                    COALESCE(v_mobile_no, v_email_id),
                    v_otp,
                    current_timestamp AT TIME ZONE 'utc',
                    current_timestamp AT TIME ZONE 'utc' + '1800 seconds'::interval,
                    0,
                    v_type,
                    v_user_guid,
                    v_is_app,
                    v_opt,
                    current_timestamp AT TIME ZONE 'utc',
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
    -- Handle OTP generation for opt 3
    ELSIF v_opt = 3 THEN
        -- Check if user is locked out
        IF NOT EXISTS (
            SELECT 1
            FROM labgt01_v1.labgt01_v1_otp_lockout_log
            WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
              AND country_code = v_country_code
              AND lock_time > now() - interval '5 minutes'
        ) THEN
            -- Check OTP request count
            SELECT COUNT(*)
            INTO v_otp_request_count
            FROM labgt01_v1.labgt01_v1_otp_details
            WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
              AND type = v_type
              AND country_code = v_country_code
              AND created_date > now() - interval '1 day';

            IF v_otp_request_count >= 200 THEN
                INSERT INTO labgt01_v1.labgt01_v1_otp_lockout_log (mobile_no, lock_time, country_code)
                VALUES (COALESCE(v_mobile_no, v_email_id), now(), v_country_code);
                v_user_lock := 1;
            ELSE
                v_user_lock := 0;
            END IF;
        ELSE
            v_user_lock := 1;
        END IF;

        -- If not locked, proceed with OTP generation
        IF v_user_lock = 0 THEN
            SELECT COUNT(1), MAX(created_date)
            INTO v_count, v_created_date
            FROM labgt01_v1.labgt01_v1_otp_details
            WHERE user_guid = v_user_guid
              AND mobile_no = COALESCE(v_mobile_no, v_email_id)
              AND type = v_type
              AND country_code = v_country_code;

            IF (v_count <= 4 OR v_count IS NULL)
               AND (current_timestamp AT TIME ZONE 'utc' < v_created_date + '1 day'::interval OR v_created_date IS NULL) THEN
                INSERT INTO labgt01_v1.labgt01_v1_otp_details(
                    mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, updated_date, mobile_no_cc, request_ip, country_code
                )
                VALUES (
                    COALESCE(v_mobile_no, v_email_id),
                    v_otp,
                    current_timestamp AT TIME ZONE 'utc',
                    current_timestamp AT TIME ZONE 'utc' + '1800 seconds'::interval,
                    0,
                    v_type,
                    v_user_guid,
                    v_is_app,
                    v_opt,
                    current_timestamp AT TIME ZONE 'utc',
                    v_mobile_with_countrycode,
                    v_request_ip,
                    v_country_code
                );
                v_status := TRUE;
            ELSIF current_timestamp AT TIME ZONE 'utc' > v_created_date + '1 day'::interval THEN
                INSERT INTO labgt01_v1.labgt01_v1_otp_details(
                    mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, updated_date, mobile_no_cc, request_ip, country_code
                )
                VALUES (
                    COALESCE(v_mobile_no, v_email_id),
                    v_otp,
                    current_timestamp AT TIME ZONE 'utc',
                    current_timestamp AT TIME ZONE 'utc' + '1800 seconds'::interval,
                    0,
                    v_type,
                    v_user_guid,
                    v_is_app,
                    v_opt,
                    current_timestamp AT TIME ZONE 'utc',
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
    END IF;

    p_result := v_status;
    RETURN;
END;
$$;


--
