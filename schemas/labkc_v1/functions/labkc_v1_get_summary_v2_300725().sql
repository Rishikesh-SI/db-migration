-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_summary_v2_300725()
-- Type: FUNCTION

-- Name: labkc_v1_get_summary_v2_300725(); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_summary_v2_300725(OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
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
	p_json jsonb;

	v_total_sms_out jsonb;
	v_converted_to_registered jsonb;
	v_percentage_conversation_to_registered jsonb;
	v_fully_completed_profiles jsonb;
	v_percentage_fully_completed_profiles jsonb;
BEGIN
	
	 
    
    v_current_timestamp := current_timestamp + interval '5 hours 30 minutes';
	v_current_date := (v_current_timestamp)::date;
    v_updated_date := v_current_date - interval '1 day';
    v_month_end := (v_current_timestamp - '1 days'::interval)::date;
    v_month_start := (to_char(v_month_end, 'yyyy-mm') || '-' || '01')::date;
	v_result_fetch  := 'SELECT client_code, country_code, created_date + interval ''5 hours 30 minutes'' as created_date
                         FROM labkc_v1.labkc_v1_otp_details 
                         UNION ALL
                         SELECT client_code, country_code, created_date + interval ''5 hours 30 minutes'' as created_date
                         FROM labkc_v1.labkc_v1_otpless_details';
	

    -- 1. Peak hour of the entire month
    EXECUTE
        'SELECT extract(hour from b.created_date) || '':00 ('' || count(1) || '')''
        FROM (' || v_result_fetch || ') b
        WHERE date(b.created_date) BETWEEN $1 AND $2
        GROUP BY extract(hour from b.created_date)
        ORDER BY count(1) DESC
        LIMIT 1'
    INTO v_peak_hour
    USING v_month_start, v_month_end;

    v_peak_hour := COALESCE(v_peak_hour, 'no data');

    -- 2. Monthly summary with (web/app) counts
    EXECUTE
        'SELECT jsonb_build_object(
            ''peakhour'', $3,
            ''totalsms'', 
                count(1) || '' ('' || 
                count(1) FILTER (WHERE b.client_code in (''labkkr_v1'',''labkkr'')) || ''/'' || 
                count(1) FILTER (WHERE b.client_code in (''labkc_v1'',''labkc'')) || '')'',
            ''internationalsms'', 
                count(1) FILTER (WHERE b.country_code <> ''91'') || '' ('' || 
                count(1) FILTER (WHERE b.country_code <> ''91'' and b.client_code in (''labkkr_v1'',''labkkr'')) || ''/'' || 
                count(1) FILTER (WHERE b.country_code <> ''91'' and b.client_code in (''labkc_v1'',''labkc'')) || '')'',
            ''domesticsms'', 
                count(1) FILTER (WHERE b.country_code = ''91'') || '' ('' || 
                count(1) FILTER (WHERE b.country_code = ''91'' and b.client_code in (''labkkr_v1'',''labkkr'')) || ''/'' || 
                count(1) FILTER (WHERE b.country_code = ''91'' and b.client_code in (''labkc_v1'',''labkc'')) || '')'',
            ''averageperday'', round(count(1)::numeric / ($2 - $1 + 1), 2)
        )
        FROM (' || v_result_fetch || ') b
        WHERE date(b.created_date) BETWEEN $1 AND $2'
    INTO v_monthlysummary
    USING v_month_start, v_month_end, v_peak_hour;

    

    -- 3. Peak hour for each day of last 5 days
    EXECUTE
        'SELECT jsonb_object_agg(peak_date::text, peakhour)
        FROM (
            SELECT
                date(b.created_date) as peak_date,
                extract(hour from (b.created_date)) || '':00 ('' || count(1) || '')'' as peakhour,
                row_number() over (
                    partition by date(b.created_date) 
                    order by count(1) desc
                ) as rn
            FROM (' || v_result_fetch || ') b
            WHERE date(b.created_date)
                BETWEEN $1 - interval ''5 days'' AND $1 - interval ''1 day''
            GROUP BY date(b.created_date), 
                     extract(hour from (b.created_date))
        ) ranked_peak
        WHERE rn = 1'
    INTO v_peak_hours_data
	USING v_current_date;

    v_peak_hours_data := COALESCE(v_peak_hours_data, '{}'::jsonb);

    -- 4. Last five days trend with (web/app) counts 
    EXECUTE
        'SELECT jsonb_agg(
            jsonb_build_object(
                ''date'', date,
                ''totalsms'', totalsms || '' ('' || web_total || ''/'' || app_total || '')'',
                ''internationalsms'', internationalsms || '' ('' || web_international || ''/'' || app_international || '')'',
                ''domesticsms'', domesticsms || '' ('' || web_domestic || ''/'' || app_domestic || '')'',
                ''peakhour'', COALESCE($1->>date::text, ''no data'')
            ) ORDER BY date DESC
        )
        FROM (
            SELECT
                date(b.created_date) as date,
                count(1) as totalsms,
                count(1) FILTER (WHERE b.country_code <> ''91'') as internationalsms,
                count(1) FILTER (WHERE b.country_code = ''91'') as domesticsms,
                count(1) FILTER (WHERE b.client_code in (''labkkr_v1'',''labkkr'')) as web_total,
                count(1) FILTER (WHERE b.client_code in (''labkc_v1'',''labkc'')) as app_total,
                count(1) FILTER (WHERE b.country_code <> ''91'' and b.client_code in (''labkkr_v1'',''labkkr'')) as web_international,
                count(1) FILTER (WHERE b.country_code <> ''91'' and b.client_code in (''labkc_v1'',''labkc'')) as app_international,
                count(1) FILTER (WHERE b.country_code = ''91'' and b.client_code in (''labkkr_v1'',''labkkr'')) as web_domestic,
                count(1) FILTER (WHERE b.country_code = ''91'' and b.client_code in (''labkc_v1'',''labkc'')) as app_domestic
            FROM (' || v_result_fetch || ') b
            WHERE date(b.created_date)
                BETWEEN $2 - interval ''5 days'' AND $2 - interval ''1 day''
            GROUP BY date(b.created_date)
            ORDER BY date(b.created_date) DESC
        ) actual_data'
    INTO v_lastfivedaystrend
    USING v_peak_hours_data,v_current_date;

    

-- 5. Top ten countries by volume 
EXECUTE
'WITH daily_country_data AS (
    SELECT 
        $1 - date(b.created_date) as day_offset,
        b.country_code,
        count(1) as total_count,
        count(1) FILTER (WHERE b.client_code in (''labkkr_v1'',''labkkr'')) as web_count,
        count(1) FILTER (WHERE b.client_code in (''labkc_v1'',''labkc'')) as app_count
    FROM (' || v_result_fetch || ') b
    WHERE b.country_code IS NOT NULL  
      AND date(b.created_date) BETWEEN $1 - interval ''7 days'' AND $1 - interval ''1 day''
    GROUP BY $1 - date(b.created_date), b.country_code
),
country_code_aggregated AS (
    SELECT 
        day_offset,
        country_code,
        sum(total_count) as total_count,
        sum(web_count) as web_count,
        sum(app_count) as app_count
    FROM daily_country_data
    GROUP BY day_offset, country_code
),
country_names AS (
    SELECT DISTINCT 
        phone_code as country_code,
        MIN(name) as representative_name
    FROM waf_master.waf_countries 
    WHERE phone_code IS NOT NULL
    GROUP BY phone_code
),
ranked_countries AS (
    SELECT 
        day_offset,
		$1 - day_offset as date,
        country_code,
        total_count,
        web_count,
        app_count,
        ROW_NUMBER() OVER (
            PARTITION BY day_offset 
            ORDER BY total_count DESC
        ) as rn
    FROM country_code_aggregated
)
-- Debug: Show all countries with their ranks
SELECT jsonb_agg(
    jsonb_build_object(
        ''day_offset'', rc.day_offset,
		''date'', date,
        ''country_code'', rc.country_code,
        ''country'', CASE 
            WHEN rc.country_code = ''1'' THEN ''USA''
            ELSE COALESCE(cn.representative_name, ''Unknown'')
        END,
        ''total_count'', rc.total_count,
        ''rank'', rc.rn
    ) ORDER BY rc.day_offset, rc.rn
)
FROM ranked_countries rc
LEFT JOIN country_names cn ON rc.country_code = cn.country_code'
INTO v_toptencountriesbyvolumn
USING v_current_date;

-------------------------------------

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
            ON date(b.created_date) = d::date
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
            (SELECT count(1) FROM labkkr_v1.labkkr_v1_web_user WHERE date(created_date) = d) AS labkkr,
            (SELECT count(1) FROM labkc_v1.labkc_v1_web_user WHERE date(created_date) = d) AS labkc,
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
            (SELECT count(1) FROM (' || v_result_fetch || ') b WHERE date(b.created_date) = d) AS total,
            (SELECT count(1) FROM labkkr_v1.labkkr_v1_web_user WHERE date(created_date) = d) AS registeredKkr,
			(SELECT count(1) FROM labkc_v1.labkc_v1_web_user WHERE date(created_date) = d) AS registeredKc,
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
                WHERE date(created_date) = d AND first_name IS NOT NULL AND first_name <> '''' AND last_name IS NOT NULL AND last_name <> ''''
            ) AS labkkr,
            (SELECT count(1) FROM labkc_v1.labkc_v1_web_user 
                WHERE date(created_date) = d AND first_name IS NOT NULL AND first_name <> '''' AND last_name IS NOT NULL AND last_name <> ''''
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
            (SELECT count(1) FROM (' || v_result_fetch || ') b WHERE date(b.created_date ) = d) AS total,
            (SELECT count(1) FROM labkkr_v1.labkkr_v1_web_user WHERE date(created_date) = d AND first_name IS NOT NULL AND first_name <> '''' AND last_name IS NOT NULL AND last_name <> ''''
            ) AS registeredKkr,
            (SELECT count(1) FROM labkc_v1.labkc_v1_web_user WHERE date(created_date) = d AND first_name IS NOT NULL AND first_name <> '''' AND last_name IS NOT NULL AND last_name <> ''''
            ) AS registeredKc,
			row_number() OVER (ORDER BY d DESC) AS rn
        FROM generate_series(' || quote_literal(v_current_date - interval '7 days') || '::date, ' 
            || quote_literal(v_current_date - interval '1 day') || '::date, interval ''1 day'') AS gs(d)
	) t'
INTO v_percentage_fully_completed_profiles;

    --output response
    p_json := jsonb_build_object(	
	    'Total_SMS_Out', COALESCE(v_total_sms_out, '{}'::jsonb),
         'Conveted_to_Registred', COALESCE(v_converted_to_registered, '{}'::jsonb),
         'Percentage_conversation_to_Registred ', COALESCE(v_percentage_conversation_to_registered, '{}'::jsonb),
         'Fully_Completed_Profiles', COALESCE(v_fully_completed_profiles, '{}'::jsonb),
         'percentage_Fully_Completed_Profiles', COALESCE(v_percentage_fully_completed_profiles, '{}'::jsonb)
    );

 --------------------------------------------------------------------------------------   

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

	
------------------------------------------------------------------------------------------
    --output response
    p_ures_json := jsonb_build_object(
		'weekly_data',p_json,
        'status', COALESCE(v_status, 0),
        'message', COALESCE(v_message, 'no data'),
        'timestamp', to_char(v_current_timestamp, 'yyyy-mm-dd hh24:mi:ss'),
        'monthlysummary', COALESCE(v_monthlysummary, jsonb_build_object(
            'peakhour', 'no data',
            'totalsms', '0 (0/0)',
            'internationalsms', '0 (0/0)',
            'domesticsms', '0 (0/0)',
            'averageperday', 0
        )),
        'lastfivedaystrend', COALESCE(v_lastfivedaystrend, '[]'::jsonb),
        'toptencountriesbyvolumn', COALESCE(v_toptencountriesbyvolumn, '[]'::jsonb)
 );

    

END;
$_$;


--
