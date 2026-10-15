-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_generate_otp_v2_02apr2026(jsonb)
-- Type: FUNCTION

-- Name: labkxip_generate_otp_v2_02apr2026(jsonb); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_generate_otp_v2_02apr2026(p_inputjson jsonb, OUT p_result boolean) RETURNS boolean
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
    v_country_code numeric;
BEGIN
    SELECT
        p_inputjson->'data'->>'mobile_no',
        p_inputjson->'data'->>'otp',
        p_inputjson->'data'->>'email_id',
        p_inputjson->'data'->>'type',
        p_inputjson->'data'->>'opt',
        p_inputjson->'data'->>'user_guid',
        p_inputjson->'data'->>'is_app',
        p_inputjson->'data'->>'country_code'
    INTO
        v_mobile_no,
        v_otp,
        v_email_id,
        v_type,
        v_opt,
        v_user_guid,
        v_is_app,
        v_country_code;

----------------------------
insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'labkxip_generate_otp_v2','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labkxip','logs');

------------------------------------------

    IF v_mobile_no = 'zPHKvSO83fSj+QKK6D96zlNYo7QHBmXx32QOpxzf3NM=' THEN
        INSERT INTO labkxip.labkxip_otp_details(
            mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, updated_date, country_code
        )
        VALUES (
            COALESCE(v_mobile_no, v_email_id),
            123456,
            current_timestamp AT TIME ZONE 'utc',
            current_timestamp AT TIME ZONE 'utc' + '1800 seconds'::interval,
            0,
            v_type,
            v_user_guid,
            v_is_app,
            v_opt,
            current_timestamp AT TIME ZONE 'utc',
            v_country_code
        );
        p_result := TRUE;
        RETURN;
    ELSE
        IF v_opt IN (1, 2) THEN
            IF NOT EXISTS (
                SELECT 1
                FROM labkxip.labkxip_otp_lockout_log
                WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
                  AND lock_time > now() - interval '1 day'
            ) THEN
                SELECT COUNT(*)
                INTO v_otp_request_count
                FROM labkxip.labkxip_otp_details
                WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
                  AND type = v_type
                  AND created_date > now() - interval '1 day';
                IF v_otp_request_count >= 50 THEN
                    INSERT INTO labkxip.labkxip_otp_lockout_log (mobile_no, lock_time)
                    VALUES (COALESCE(v_mobile_no, v_email_id), now());
                END IF;
                v_user_lock := 0;
            ELSE
                v_user_lock := 1;
            END IF;

            IF v_user_lock = 0 THEN
                SELECT COALESCE(failed_attempt, 0), updated_date
                INTO v_failed_attempt, v_updated_date
                FROM labkxip.labkxip_otp_details
                WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
                  AND type = v_type
                ORDER BY created_date DESC
                LIMIT 1;
                IF v_failed_attempt <= 4
                   OR (v_failed_attempt > 4 AND v_updated_date + '5 minutes'::interval < current_timestamp AT TIME ZONE 'utc')
                   OR v_updated_date IS NULL THEN
                    INSERT INTO labkxip.labkxip_otp_details(
                        mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, updated_date, country_code
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
                        v_country_code
                    );
                    p_result := TRUE;
                ELSE
                    p_result := FALSE;
                END IF;
            ELSE
                p_result := FALSE;
            END IF;
        ELSIF v_opt = 3 THEN
            IF NOT EXISTS (
                SELECT 1
                FROM labkxip.labkxip_otp_lockout_log
                WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
                  AND lock_time > now() - interval '5 minutes'
            ) THEN
                SELECT COUNT(*)
                INTO v_otp_request_count
                FROM labkxip.labkxip_otp_details
                WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
                  AND type = v_type
                  AND created_date > now() - interval '1 day';
                IF v_otp_request_count >= 50 THEN
                    INSERT INTO labkxip.labkxip_otp_lockout_log (mobile_no, lock_time)
                    VALUES (COALESCE(v_mobile_no, v_email_id), now());
                END IF;
                v_user_lock := 0;
            ELSE
                v_user_lock := 1;
            END IF;

            IF v_user_lock = 0 THEN
                SELECT COUNT(1), MAX(created_date)
                INTO v_count, v_created_date
                FROM labkxip.labkxip_otp_details
                WHERE user_guid = v_user_guid
                  AND mobile_no = COALESCE(v_mobile_no, v_email_id)
                  AND type = v_type;
                IF (v_count <= 50 OR v_count IS NULL)
                   AND (current_timestamp AT TIME ZONE 'utc' < v_created_date + '1 day'::interval OR v_created_date IS NULL) THEN
                    INSERT INTO labkxip.labkxip_otp_details(
                        mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, updated_date, country_code
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
                        v_country_code
                    );
                    p_result := TRUE;
                ELSIF current_timestamp AT TIME ZONE 'utc' > v_created_date + '1 day'::interval THEN
                    INSERT INTO labkxip.labkxip_otp_details(
                        mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, updated_date, country_code
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
                        v_country_code
                    );
                    p_result := TRUE;
                ELSE
                    p_result := FALSE;
                END IF;
            ELSE
                p_result := FALSE;
            END IF;
        END IF;
    END IF;
    RETURN;
END;
$$;


--
