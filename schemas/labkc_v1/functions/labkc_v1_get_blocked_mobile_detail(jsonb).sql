-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_blocked_mobile_detail(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_get_blocked_mobile_detail(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_blocked_mobile_detail(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_mobile_no       varchar(1000);
    v_country_code    numeric;
    v_current_attempt numeric := 0;
    v_is_blocked      boolean := false;
    v_lock_time       timestamp;
    v_unlock_time     timestamp;
    v_unlock_type     int;
    v_block_reason    text := '';
BEGIN
    -- Extract input
    SELECT p_inputjson->'data'->>'mobile_no',
           (p_inputjson->'data'->>'country_code')::numeric
    INTO   v_mobile_no, v_country_code;

    IF (v_mobile_no IS NULL or  v_country_code is null ) THEN
        p_data := jsonb_build_object(
            'status', '0',
            'message', 'Mobile_no with country_code is needed under json {data} node'
        );
        RETURN;
    END IF;

 IF EXISTS (
        SELECT 1
        FROM labkc_v1.labkc_v1_otpless_lockout_log
        WHERE mobile_no = v_mobile_no
          AND country_code = v_country_code
         -- AND created_date::date = current_date
    ) THEN
	
    -- Count today's OTP-less requests
    SELECT count(*)
    INTO v_current_attempt
    FROM labkc_v1.labkc_v1_otpless_details
    WHERE mobile_no = v_mobile_no
      AND country_code = v_country_code
      AND created_date::date = current_date;

    -- Determine if blocked based on attempts > 10
    IF v_current_attempt > 10 THEN
        v_is_blocked := true;
        v_block_reason := 'Exceeded daily limit';
    END IF;

    -- Fetch lockout info if exists
    SELECT lock_time, unlock_time, unlock_type
    INTO v_lock_time, v_unlock_time, v_unlock_type
    FROM labkc_v1.labkc_v1_otpless_lockout_log
    WHERE mobile_no = v_mobile_no
      AND country_code = v_country_code
    LIMIT 1;

    -- Calculate dynamic unlock time as lock_time + 24 hours if lock_time exists
    IF v_lock_time IS NOT NULL THEN
        v_unlock_time := v_lock_time + interval '24 hours';
        IF current_timestamp < v_unlock_time THEN
            v_is_blocked := true;
            v_block_reason := 'Currently locked';
        END IF;
    END IF;
	
	-- Set block reason if not blocked
	IF v_is_blocked = false THEN
		v_block_reason := 'Currently unlocked';
	END IF;

	-- Build output JSON
	p_data := jsonb_build_object(
		'status', '1',
		'data', jsonb_build_object(
			'mobile_no', v_mobile_no,
			'country_code', v_country_code,
			'IsBlocked', v_is_blocked,
			'NumberOfRequests', v_current_attempt::text || '/10',
			'lock_time', coalesce(v_lock_time::text, ''),
			'unlock_time', coalesce(v_unlock_time::text, ''),
			'unlock_type', coalesce(v_unlock_type, 0),
			'message', v_block_reason
		)
	);

    ELSE
        -- Mobile number not found in OTP-less details for today
        p_data := jsonb_build_object(
            'status', '0',
            'data', jsonb_build_object(
                'mobile_no', v_mobile_no,
                'country_code', v_country_code,
                'message', 'Incorrect mobile number or no OTP requests today'
            )
        );
    END IF;
END;
$$;


--
