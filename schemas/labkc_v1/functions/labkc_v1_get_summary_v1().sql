-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_summary_v1()
-- Type: FUNCTION

-- Name: labkc_v1_get_summary_v1(); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_summary_v1(OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_current_timestamp timestamp without time zone;
    v_status numeric := 1;
    v_updated_date date;
    v_message character varying(10) := 'success';
    v_monthlysummary jsonb;
    v_lastfivedaystrend jsonb;
    v_toptencountriesbyvolumn jsonb;
    v_month_start date;
    v_month_end date;
    v_peak_hour text;
    v_peak_hours_data jsonb;
    v_result_fetch text ;
	v_current_date date;
	
	v_total_sms_out jsonb;
	v_converted_to_registered jsonb;
	v_percentage_conversation_to_registered jsonb;
	v_fully_completed_profiles jsonb;
	v_percentage_fully_completed_profiles jsonb;
    
BEGIN
	
	 
    
    v_current_timestamp := current_timestamp + interval ' 5 hours 30 minutes';
    v_current_date := (current_timestamp + interval ' 5 hours 30 minutes')::date;
	--v_current_date := '2025-07-24';
    v_updated_date := current_date - interval '1 day';
    v_month_end := (current_timestamp - '1 days'::interval)::date;
    v_month_start := (to_char(v_month_end, 'yyyy-mm') || '-' || '01')::date;
	 
	v_result_fetch := 'SELECT client_code, country_code, date(created_date + interval '' 5 hours 30 minutes'') as created_date
						 FROM labkc_v1.labkc_v1_otp_details
						 UNION ALL
						 SELECT client_code, country_code, date(created_date + interval '' 5 hours 30 minutes'') as created_date
						 FROM labkc_v1.labkc_v1_otpless_details';

---Total_SMS_Out 
EXECUTE
    'SELECT jsonb_object_agg(
        ''Day-'' || rn,
        COALESCE(total_sms, ''0 (0/0)'')
    )
    FROM (
        SELECT
            d,
            CASE WHEN COUNT(b.created_date) IS NULL OR COUNT(b.created_date) = 0 THEN NULL
                 ELSE COUNT(b.created_date)::text || '' ('' ||
                      COUNT(b.created_date) FILTER (WHERE b.client_code in (''labkkr_v1'',''labkkr''))::text || ''/'' ||
                      COUNT(b.created_date) FILTER (WHERE b.client_code in (''labkc_v1'',''labkc''))::text || '')''
            END AS total_sms,
            row_number() OVER (ORDER BY d DESC) AS rn
        FROM generate_series(' || quote_literal(v_current_date - interval '7 days') || '::date, ' 
            || quote_literal(v_current_date - interval '1 day') || '::date, interval ''1 day'') AS gs(d)
        LEFT JOIN (' || v_result_fetch || ') b
            ON b.created_date = d::date
        GROUP BY d
        ORDER BY d DESC
    ) t'
INTO v_total_sms_out;

-- Conveted_to_Registred 
EXECUTE
    'SELECT jsonb_object_agg(
        ''Day-'' || rn,
        (COALESCE(labkkr,0) + COALESCE(labkc,0))::text || '' ('' || COALESCE(labkkr,0)::text || ''/'' || COALESCE(labkc,0)::text || '')''
    )
    FROM (
        SELECT
            d,
            (SELECT count(1) FROM labkkr_v1.labkkr_v1_web_user WHERE date(created_date + interval ''5 hours 30 minutes'') = d) AS labkkr, -- kkr web
            (SELECT count(1) FROM labkc_v1.labkc_v1_web_user WHERE date(created_date + interval ''5 hours 30 minutes'') = d) AS labkc, -- kc app
            row_number() OVER (ORDER BY d DESC) AS rn
         FROM generate_series(' || quote_literal(v_current_date - interval '7 days') || '::date, ' 
            || quote_literal(v_current_date - interval '1 day') || '::date, interval ''1 day'') AS gs(d)
    ) t'
INTO v_converted_to_registered;

-- Percentage_conversation_to_Registred 
EXECUTE
    'SELECT jsonb_object_agg(
        ''Day-'' || rn,
        CASE WHEN total > 0 THEN round(((registeredKkr + registeredKc)::numeric / total) * 100, 2)::text || ''%'' ELSE ''0%'' END
    )
    FROM (
        SELECT
            d,
            (SELECT count(1) FROM (' || v_result_fetch || ') b WHERE b.created_date  = d) AS total,
            (SELECT count(1) FROM labkkr_v1.labkkr_v1_web_user WHERE date(created_date + interval ''5 hours 30 minutes'') = d) AS registeredKkr, -- kkr web
            (SELECT count(1) FROM labkc_v1.labkc_v1_web_user WHERE date(created_date + interval ''5 hours 30 minutes'') = d) AS registeredKc,  -- kc app
            row_number() OVER (ORDER BY d DESC) AS rn
        FROM generate_series(' || quote_literal(v_current_date - interval '7 days') || '::date, ' 
            || quote_literal(v_current_date - interval '1 day') || '::date, interval ''1 day'') AS gs(d)
    ) t'
INTO v_percentage_conversation_to_registered;

--Fully_Completed_Profiles--
EXECUTE
    'SELECT jsonb_object_agg(
        ''Day-'' || rn,
        (COALESCE(labkkr,0) + COALESCE(labkc,0))::text || '' ('' || COALESCE(labkkr,0)::text || ''/'' || COALESCE(labkc,0)::text || '')''
    ) FROM (
        SELECT
            d,
            (SELECT count(1) FROM labkkr_v1.labkkr_v1_web_user 
                WHERE date(created_date + interval ''5 hours 30 minutes'') = d AND first_name IS NOT NULL AND first_name <> '''' AND last_name IS NOT NULL AND last_name <> ''''
            ) AS labkkr,
            (SELECT count(1) FROM labkc_v1.labkc_v1_web_user 
                WHERE date(created_date + interval ''5 hours 30 minutes'') = d AND first_name IS NOT NULL AND first_name <> '''' AND last_name IS NOT NULL AND last_name <> ''''
            ) AS labkc,
            row_number() OVER (ORDER BY d DESC) AS rn
        FROM generate_series(' || quote_literal(v_current_date - interval '7 days') || '::date, ' 
            || quote_literal(v_current_date - interval '1 day') || '::date, interval ''1 day'') AS gs(d)
    ) t'
INTO v_fully_completed_profiles;

--percentage_Fully_Completed_Profiles 
EXECUTE
    'SELECT jsonb_object_agg(
        ''Day-'' || rn,
        CASE WHEN total > 0 
            THEN round(((COALESCE(registeredKkr,0) + COALESCE(registeredKc,0))::numeric / total) * 100, 2)::text || ''%'' 
            ELSE ''0%'' 
        END
    ) FROM (
        SELECT
            d,
            (SELECT count(1) FROM (' || v_result_fetch || ') b WHERE b.created_date = d) AS total,
            (SELECT count(1) FROM labkkr_v1.labkkr_v1_web_user WHERE date(created_date + interval ''5 hours 30 minutes'') = d AND first_name IS NOT NULL AND first_name <> '''' AND last_name IS NOT NULL AND last_name <> ''''
            ) AS registeredKkr,
            (SELECT count(1) FROM labkc_v1.labkc_v1_web_user WHERE date(created_date + interval ''5 hours 30 minutes'') = d AND first_name IS NOT NULL AND first_name <> '''' AND last_name IS NOT NULL AND last_name <> ''''
            ) AS registeredKc,
            row_number() OVER (ORDER BY d DESC) AS rn
        FROM generate_series(' || quote_literal(v_current_date - interval '7 days') || '::date, ' 
            || quote_literal(v_current_date - interval '1 day') || '::date, interval ''1 day'') AS gs(d)
    ) t'
INTO v_percentage_fully_completed_profiles;

--------------------------
WITH all_sms AS (
    SELECT client_code, date(created_date + interval '5 hours 30 minutes') AS sms_date
    FROM labkc_v1.labkc_v1_otp_details
    UNION ALL
    SELECT client_code, date(created_date + interval '5 hours 30 minutes') AS sms_date
    FROM labkc_v1.labkc_v1_otpless_details
)
INSERT INTO labkc_v1.labkc_v1_sms_registration_summary (
    date,
    web_sms_out,
    app_sms_out,
    total_sms_out,
    web_registered_count,
    app_registered_count,
    total_registered_count,
    web_completed_profile_count,
    app_completed_profile_count,
    total_completed_profile_count
)
SELECT
    d::date AS date,
    COALESCE(web_sms_out, 0) AS web_sms_out,
    COALESCE(app_sms_out, 0) AS app_sms_out,
    COALESCE(web_sms_out, 0) + COALESCE(app_sms_out, 0) AS total_sms_out,
    COALESCE(web_registered_count, 0) AS web_registered_count,
    COALESCE(app_registered_count, 0) AS app_registered_count,
    COALESCE(web_registered_count, 0) + COALESCE(app_registered_count, 0) AS total_registered_count,
    COALESCE(web_completed_profile_count, 0) AS web_completed_profile_count,
    COALESCE(app_completed_profile_count, 0) AS app_completed_profile_count,
    COALESCE(web_completed_profile_count, 0) + COALESCE(app_completed_profile_count, 0) AS total_completed_profile_count
FROM (
    SELECT gs.d
    FROM generate_series(
        (current_timestamp + interval '5 hours 30 minutes')::date - interval '7 days',
        (current_timestamp + interval '5 hours 30 minutes')::date - interval '1 day',
		 -- ('2025-07-25')::date - interval '7 days',
   --      ('2025-07-25')::date - interval '1 day',
        interval '1 day'
    ) AS gs(d)
    WHERE gs.d NOT IN (SELECT date FROM labkc_v1.labkc_v1_sms_registration_summary)
) days
left JOIN (
    -- WEB_SMS_OUT (labkkr) from both tables
    SELECT sms_date, COUNT(*) AS web_sms_out
    FROM all_sms
    WHERE client_code IN ('labkkr_v1', 'labkkr')
    GROUP BY sms_date
) web_sms ON web_sms.sms_date = days.d
left JOIN (
    -- APP_SMS_OUT (labkc) from both tables
    SELECT sms_date, COUNT(*) AS app_sms_out
    FROM all_sms
    WHERE client_code IN ('labkc_v1', 'labkc')
    GROUP BY sms_date
) app_sms ON app_sms.sms_date = days.d
left JOIN (
    -- WEB Registered Count
    SELECT date(created_date + interval '5 hours 30 minutes') AS reg_date, COUNT(*) AS web_registered_count
    FROM labkkr_v1.labkkr_v1_web_user
    GROUP BY reg_date
) web_reg ON web_reg.reg_date = days.d
left JOIN (
    -- APP Registered Count
    SELECT date(created_date + interval '5 hours 30 minutes') AS reg_date, COUNT(*) AS app_registered_count
    FROM labkc_v1.labkc_v1_web_user
    GROUP BY reg_date
) app_reg ON app_reg.reg_date = days.d
left JOIN (
    -- WEB Completed Profile Count
    SELECT date(created_date + interval '5 hours 30 minutes') AS comp_date, COUNT(*) AS web_completed_profile_count
    FROM labkkr_v1.labkkr_v1_web_user
    WHERE first_name IS NOT NULL AND first_name <> '' AND last_name IS NOT NULL AND last_name <> ''
    GROUP BY comp_date
) web_comp ON web_comp.comp_date = days.d
left JOIN (
    -- APP Completed Profile Count
    SELECT date(created_date + interval '5 hours 30 minutes') AS comp_date, COUNT(*) AS app_completed_profile_count
    FROM labkc_v1.labkc_v1_web_user
    WHERE first_name IS NOT NULL AND first_name <> '' AND last_name IS NOT NULL AND last_name <> ''
    GROUP BY comp_date
) app_comp ON app_comp.comp_date = days.d;

---------------------------
    --output response
    p_ures_json := jsonb_build_object(
	    'Total_SMS_Out', COALESCE(v_total_sms_out, '{}'::jsonb),
         'Conveted_to_Registred', COALESCE(v_converted_to_registered, '{}'::jsonb),
         'Percentage_conversation_to_Registred ', COALESCE(v_percentage_conversation_to_registered, '{}'::jsonb),
         'Fully_Completed_Profiles', COALESCE(v_fully_completed_profiles, '{}'::jsonb),
         'percentage_Fully_Completed_Profiles', COALESCE(v_percentage_fully_completed_profiles, '{}'::jsonb)
    );

    

END;
$$;


--
