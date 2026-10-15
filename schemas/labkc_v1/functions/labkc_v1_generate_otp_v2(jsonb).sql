-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_generate_otp_v2(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_generate_otp_v2(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_generate_otp_v2(p_inputjson jsonb, OUT p_result boolean) RETURNS boolean
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
    v_otp_request_count numeric;
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
        v_request_ip,
        v_country_code;

    -- Special case for specific mobile numbers
    IF v_mobile_no IN (
        '6e3cUE74rv9lesR+j3afEkeD1gonLnF9BO2pbWGfgLQ=',
        '6e3cUE74rv9lesR+j3afEkMk8yHA4Pt0E76jDYOhb9o=',
        '6e3cUE74rv9lesR+j3afEhoUakGr8wcbu2EAaFKfx5s=',
        '6e3cUE74rv9lesR+j3afEqcVlWpKG2Lol+la6l7wEKo=',
        'JfHL0A1+vKHQxw75mi6S+WaIW6OPHzPFSOppcq86zPc=',
        'JfHL0A1+vKHQxw75mi6S+aQ/UIX4xGlOyck7JOqdwBo=',
        'JfHL0A1+vKHQxw75mi6S+YvGWaQsoCj5lDVESrIcIJU=',
        '9FlMOj0jP5mIOJFEHHPx3lvdBbQF5rJjajvjUjUMHFs=',
        '9FlMOj0jP5mIOJFEHHPx3u0TIasMiVZO5xXZgpewBlc=',
        '9FlMOj0jP5mIOJFEHHPx3kPFLO1W0Vqk7K4b/WNL3IY=',
        '6e3cUE74rv9lesR+j3afEsYqaheaDleQzeFD44Q8LKU=',
        '6e3cUE74rv9lesR+j3afEtSOPHs7KduG4LyepwCT+ck=',
        '6e3cUE74rv9lesR+j3afEmPOBi+3Wud2Y6Be1csta3o=',
        '6e3cUE74rv9lesR+j3afEl7Xne1rNz9DK4DYEgvUX/k=',
        '6e3cUE74rv9lesR+j3afEsdH4MkmNvYBSYLy+LzTpH4=',
        '6e3cUE74rv9lesR+j3afEvoS9KPil3qRwy67fvYMppM=',
        '6e3cUE74rv9lesR+j3afEhB5tkmDxKU9tp5Akq408mU=',
        '6e3cUE74rv9lesR+j3afEmsLY4De68eb7EcXwwsLhwk=',
        '6e3cUE74rv9lesR+j3afEhpfVjZMdKRaqIWVBcOHXPo=',
        '6e3cUE74rv9lesR+j3afEoOh75Y9jfygCX3lSHmuLTc='
    ) THEN
        v_otp := 123456;
        INSERT INTO labkc_v1.labkc_v1_otp_details(
            mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, request_ip, country_code, client_code
        )
        VALUES (
            COALESCE(v_mobile_no, v_email_id), v_otp, CURRENT_TIMESTAMP AT TIME ZONE 'utc',
            CURRENT_TIMESTAMP AT TIME ZONE 'utc' + '1 day'::interval, 0, v_type, v_user_guid, v_is_app, v_opt, v_request_ip, v_country_code, 'labrr'
        );
        v_status := TRUE;
        RETURN;

    -- Normal OTP generation logic
    ELSIF v_opt IN (1, 2) THEN
        SELECT COUNT(*)
        INTO v_otp_request_count
        FROM labkc_v1.labkc_v1_otp_details
        WHERE mobile_no = COALESCE(v_mobile_no, v_email_id)
          AND (created_date)::date = (CURRENT_TIMESTAMP AT TIME ZONE 'utc')::date;

        IF v_otp_request_count < 5 THEN
            INSERT INTO labkc_v1.labkc_v1_otp_details(
                mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, request_ip, country_code, client_code
            )
            VALUES (
                COALESCE(v_mobile_no, v_email_id), v_otp, CURRENT_TIMESTAMP AT TIME ZONE 'utc',
                CURRENT_TIMESTAMP AT TIME ZONE 'utc' + '120 seconds'::interval, 0, v_type, v_user_guid, v_is_app, v_opt, v_request_ip, v_country_code, 'labkc'
            );
            v_status := TRUE;

        -- Special case for specific mobile numbers with higher limit
        ELSIF v_mobile_no IN (
            'zPHKvSO83fSj+QKK6D96zlNYo7QHBmXx32QOpxzf3NM=',
            'JfHL0A1+vKHQxw75mi6S+b5HohEZS46j2rjcOXU6WM4=',
            'JfHL0A1+vKHQxw75mi6S+RIkWnudtI1h8FXSkzoTPj4=',
            'JfHL0A1+vKHQxw75mi6S+VTEP+ywBzyqJHb7wwDy+RI=',
            'JfHL0A1+vKHQxw75mi6S+T9qYiRwOeVlnT0pHG8qbsE=',
            'JfHL0A1+vKHQxw75mi6S+S4lMhm3577/3FYC+OhkrP8=',
            'JfHL0A1+vKHQxw75mi6S+eOlxVMoaCF3Wbjz5zknHX4=',
            'JfHL0A1+vKHQxw75mi6S+Q3LiNNV/8OQObAkGARRP/w=',
            'JfHL0A1+vKHQxw75mi6S+bwDvOATY21w2F1Cscsviec=',
            'JfHL0A1+vKHQxw75mi6S+YGAt3ny5pU8BEw1Y91geHM=',
            'JfHL0A1+vKHQxw75mi6S+eOq1X4eZo/1lh42ipqXh4Y=',
            'HEEVJcVU+jXONOPcFI1fpkYSQEs1oC52XdYqVpIS0qU=',
            'HEEVJcVU+jXONOPcFI1fpni0jgiZyjfqhyDcoXiQcyA=',
            'HEEVJcVU+jXONOPcFI1fpgVSaC+elywhOjrSFoiAne8=',
            'HEEVJcVU+jXONOPcFI1fpmQTDUt6YZ8QzsQpaoT3rcM=',
            'HEEVJcVU+jXONOPcFI1fpk9BG4aOF7QuEa6HXhaXC3M=',
            'HEEVJcVU+jXONOPcFI1fpiuLR1XajN++JJaeY9kaKXs=',
            'HEEVJcVU+jXONOPcFI1fpqBPJo0vapIUtONlHHoMamQ=',
            'HEEVJcVU+jXONOPcFI1fphBhrS1UK2mtR42UI3N1VFg=',
            'HEEVJcVU+jXONOPcFI1fpsSCNpGaPFwtxFOy2riWubY=',
            'HEEVJcVU+jXONOPcFI1fpmqjZFjEbMptXhxKm2ZeUmk=',
            '9FlMOj0jP5mIOJFEHHPx3u0TIasMiVZO5xXZgpewBlc=',
            '9FlMOj0jP5mIOJFEHHPx3kPFLO1W0Vqk7K4b/WNL3IY=',
            '6e3cUE74rv9lesR+j3afEsYqaheaDleQzeFD44Q8LKU=',
            '6e3cUE74rv9lesR+j3afEtSOPHs7KduG4LyepwCT+ck=',
            '6e3cUE74rv9lesR+j3afEmPOBi+3Wud2Y6Be1csta3o=',
            '6e3cUE74rv9lesR+j3afEl7Xne1rNz9DK4DYEgvUX/k=',
            '6e3cUE74rv9lesR+j3afEsdH4MkmNvYBSYLy+LzTpH4=',
            '6e3cUE74rv9lesR+j3afEvoS9KPil3qRwy67fvYMppM=',
            '6e3cUE74rv9lesR+j3afEhB5tkmDxKU9tp5Akq408mU=',
            '6e3cUE74rv9lesR+j3afEmsLY4De68eb7EcXwwsLhwk=',
            '6e3cUE74rv9lesR+j3afEhpfVjZMdKRaqIWVBcOHXPo=',
            '6e3cUE74rv9lesR+j3afEoOh75Y9jfygCX3lSHmuLTc=',
            'z3Ddw/cd33IyXP3rnxec9m0zPR7w4Uyq2JoulUe3AlI=',
            'MMKg1C+TdAfAzfOoNCyUY5J4lPtKKXnDxRu2diANgU4='
        ) THEN
            IF v_otp_request_count < 20 THEN
                INSERT INTO labkc_v1.labkc_v1_otp_details(
                    mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, request_ip, country_code, client_code
                )
                VALUES (
                    COALESCE(v_mobile_no, v_email_id), v_otp, CURRENT_TIMESTAMP AT TIME ZONE 'utc',
                    CURRENT_TIMESTAMP AT TIME ZONE 'utc' + '120 seconds'::interval, 0, v_type, v_user_guid, v_is_app, v_opt, v_request_ip, v_country_code, 'labkc'
                );
                v_status := TRUE;
            ELSE
                v_status := FALSE;
            END IF;

        ELSE
            v_status := FALSE;
        END IF;

    -- Logic for opt = 3
    ELSIF v_opt = 3 THEN
        SELECT COUNT(1), MAX(created_date)
        INTO v_count, v_created_date
        FROM labkc_v1.labkc_v1_otp_details
        WHERE user_guid = v_user_guid AND mobile_no = COALESCE(v_mobile_no, v_email_id) AND type = v_type;

        IF (v_count <= 2 OR v_count IS NULL) AND (
            CURRENT_TIMESTAMP AT TIME ZONE 'utc' < v_created_date + '1 day'::interval OR v_created_date IS NULL
        ) THEN
            INSERT INTO labkc_v1.labkc_v1_otp_details(
                mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, request_ip, country_code, client_code
            )
            VALUES (
                COALESCE(v_mobile_no, v_email_id), v_otp, CURRENT_TIMESTAMP AT TIME ZONE 'utc',
                CURRENT_TIMESTAMP AT TIME ZONE 'utc' + '120 seconds'::interval, 0, v_type, v_user_guid, v_is_app, v_opt, v_request_ip, v_country_code, 'labkc'
            );
            v_status := TRUE;

        ELSIF CURRENT_TIMESTAMP AT TIME ZONE 'utc' > v_created_date + '1 day'::interval THEN
            INSERT INTO labkc_v1.labkc_v1_otp_details(
                mobile_no, otp, created_date, expiry_date, is_verified, type, user_guid, is_app, opt, request_ip, country_code, client_code
            )
            VALUES (
                COALESCE(v_mobile_no, v_email_id), v_otp, CURRENT_TIMESTAMP AT TIME ZONE 'utc',
                CURRENT_TIMESTAMP AT TIME ZONE 'utc' + '120 seconds'::interval, 0, v_type, v_user_guid, v_is_app, v_opt, v_request_ip, v_country_code, 'labkc'
            );
            v_status := TRUE;

        ELSE
            v_status := FALSE;
        END IF;
    END IF;

    -- Optionally, build a JSON response for logging or internal use
    v_result_json := jsonb_build_object(
        'status', CASE WHEN v_status THEN '1' ELSE '0' END,
        'message', CASE
            WHEN v_status THEN 'Success'
            ELSE 'OTP request count exceeded, account is locked. Please try again after 1 day.'
        END,
        'otp_duration', '120',
        'user_full_name', COALESCE((SELECT user_full_name FROM labkc_v1.labkc_v1_web_user WHERE user_guid = v_user_guid), '')
    );

    p_result := v_status;
    RETURN;
END;
$$;


--
