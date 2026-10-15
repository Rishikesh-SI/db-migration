-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_summary_v2_15092025()
-- Type: FUNCTION

-- Name: labgt_get_summary_v2_15092025(); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_summary_v2_15092025(OUT p_ures_json jsonb) RETURNS jsonb
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
    v_result_fetch text;
	v_user_data text;
	v_user_data_app text;
	v_user_data_web test;
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

  v_result_fetch := '
        SELECT --client_code,
               country_code,
               created_date + interval ''5 hours 30 minutes'' AS created_date,
               is_app
        FROM labgt.labgt_otp_details 
       WHERE (created_date + interval ''5 hours 30 minutes'')::date >= current_date - interval ''10 days''
          AND (created_date + interval ''5 hours 30 minutes'')::date < current_date + interval ''1 day''
    ';
	
	-- Base user registration dataset (within time window)
		v_user_data := '
			SELECT wu.user_guid,
				   (wu.created_date + interval ''5 hours 30 minutes'')::date AS created_date,
				   ua.is_app,
				   wu.first_name,
				   wu.last_name
			FROM labgt.labgt_web_user wu
			JOIN labgt.labgt_web_user_audit ua 
			  ON wu.user_guid = ua.user_guid
			WHERE ua.option_type = 2
			  AND ua.client_code = ''labgt''
			   AND ((wu.created_date + interval ''5 hours 30 minutes'')::date >= current_date - interval ''10 days''
          	    	AND (wu.created_date + interval ''5 hours 30 minutes'')::date < current_date + interval ''1 day'')
		';
/*
v_user_data_app := '
    SELECT wu.user_guid,
           (wu.created_date + interval ''5 hours 30 minutes'')::date AS created_date,
           wu.first_name,
           wu.last_name
    FROM labgt.labgt_web_user wu
    JOIN labgt.labgt_web_user_audit ua 
      ON wu.user_guid = ua.user_guid
    WHERE ua.option_type = 2
      AND ua.client_code = ''labgt''
      AND ua.is_app = 1
      AND ((wu.created_date + interval ''5 hours 30 minutes'')::date >= current_date - interval ''10 days''
           AND (wu.created_date + interval ''5 hours 30 minutes'')::date < current_date + interval ''1 day'')
';

v_user_data_web := '
    SELECT wu.user_guid,
           (wu.created_date + interval ''5 hours 30 minutes'')::date AS created_date,
           wu.first_name,
           wu.last_name
    FROM labgt.labgt_web_user wu
    JOIN labgt.labgt_web_user_audit ua 
      ON wu.user_guid = ua.user_guid
    WHERE ua.option_type = 2
      AND ua.client_code = ''labgt''
      AND (ua.is_app = 0 OR ua.is_app IS NULL)
      AND ((wu.created_date + interval ''5 hours 30 minutes'')::date >= current_date - interval ''10 days''
           AND (wu.created_date + interval ''5 hours 30 minutes'')::date < current_date + interval ''1 day'')
';
*/

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
            ''totalsms'', count(*) || '' ('' ||
                count(*) FILTER (WHERE  COALESCE(b.is_app,0)=0) || ''/'' ||
                count(*) FILTER (WHERE  b.is_app=1) || '')'',
            ''internationalsms'', 
                count(*) FILTER (WHERE b.country_code <> ''91'') || '' ('' ||
                count(*) FILTER (WHERE b.country_code <> ''91'' AND COALESCE(b.is_app,0)=0) || ''/'' ||
                count(*) FILTER (WHERE b.country_code <> ''91'' AND b.is_app=1) || '')'',
            ''domesticsms'', 
                count(*) FILTER (WHERE b.country_code = ''91'') || '' ('' ||
                count(*) FILTER (WHERE b.country_code = ''91'' AND COALESCE(b.is_app,0)=0) || ''/'' ||
                count(*) FILTER (WHERE b.country_code = ''91'' AND  b.is_app=1) || '')'',
            ''averageperday'', round(count(*)::numeric / ($2 - $1 + 1), 2)
        )
        FROM (' || v_result_fetch || ') b
        WHERE b.created_date::date BETWEEN $1 AND $2'
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
                ''date'', dt,
                ''totalsms'', totalsms || '' ('' || web_total || ''/'' || app_total || '')'',
                ''internationalsms'', internationalsms || '' ('' || web_international || ''/'' || app_international || '')'',
                ''domesticsms'', domesticsms || '' ('' || web_domestic || ''/'' || app_domestic || '')'',
                ''peakhour'', COALESCE($1->>dt::text, ''no data'')
            ) ORDER BY dt DESC
        )
        FROM (
            SELECT
                b.created_date::date as dt,
                count(*) as totalsms,
                count(*) FILTER (WHERE b.country_code <> ''91'') as internationalsms,
                count(*) FILTER (WHERE b.country_code = ''91'') as domesticsms,
                count(*) FILTER (WHERE  COALESCE(b.is_app,0)=0) as web_total,
                count(*) FILTER (WHERE  b.is_app=1) as app_total,
                count(*) FILTER (WHERE b.country_code <> ''91'' and COALESCE(b.is_app,0)=0) as web_international,
                count(*) FILTER (WHERE b.country_code <> ''91'' AND b.is_app=1) as app_international,
                count(*) FILTER (WHERE b.country_code = ''91''  AND COALESCE(b.is_app,0)=0) as web_domestic,
                count(*) FILTER (WHERE b.country_code = ''91''  AND b.is_app=1) as app_domestic
            FROM (' || v_result_fetch || ') b
            WHERE b.created_date::date BETWEEN $2 - interval ''5 days'' AND $2 - interval ''1 day''
            GROUP BY b.created_date::date
            ORDER BY b.created_date::date DESC
        ) actual_data'
    INTO v_lastfivedaystrend
    USING v_peak_hours_data, v_current_date;

    -- 5. Top ten countries by volume
    EXECUTE
    'WITH all_days AS (
        SELECT generate_series(1, 7) as day_offset,
               $1 - generate_series(1, 7) as date
    ),
    daily_country_data AS (
        SELECT
            $1 - date(b.created_date) as day_offset,
            b.country_code,
            count(1) as total_count,
            count(1) FILTER (WHERE (b.is_app=0 or b.is_app is null)) as web_count,
            count(1) FILTER (WHERE b.is_app=1) as app_count
        FROM (' || v_result_fetch || ') b
        WHERE b.country_code IS NOT NULL
          AND date(b.created_date) BETWEEN $1 - interval ''7 days'' AND $1 - interval ''1 day''
        GROUP BY $1 - date(b.created_date), b.country_code
    ),
    ranked_countries AS (
        SELECT
            day_offset,
            country_code,
            total_count,
            web_count,
            app_count,
            ROW_NUMBER() OVER (
                PARTITION BY day_offset
                ORDER BY total_count DESC
            ) as rn
        FROM daily_country_data
    ),
    top_countries AS (
        SELECT * FROM ranked_countries WHERE rn <= 10
    ),
    country_names AS (
        SELECT DISTINCT
            phone_code as country_code,
            MIN(name) as representative_name
        FROM waf_master.waf_countries
        WHERE phone_code IS NOT NULL
        GROUP BY phone_code
    )
    SELECT jsonb_agg(
        jsonb_build_object(
            ''day_offset'', ad.day_offset,
            ''date'', ad.date,
            ''country_code'', tc.country_code,
            ''country'', CASE
                WHEN tc.country_code = ''1'' THEN ''USA''
                WHEN tc.country_code IS NOT NULL THEN
                    COALESCE(cn.representative_name, ''Unknown'')
                ELSE NULL
            END,
            ''total_count'', COALESCE(tc.total_count, 0),
            ''web_count'', COALESCE(tc.web_count, 0),
            ''app_count'', COALESCE(tc.app_count, 0),
            ''rank'', tc.rn
        ) ORDER BY ad.day_offset, COALESCE(tc.rn, 999)
    )
    FROM all_days ad
    LEFT JOIN top_countries tc ON ad.day_offset = tc.day_offset
    LEFT JOIN country_names cn ON tc.country_code = cn.country_code
    WHERE tc.country_code IS NOT NULL'
    INTO v_toptencountriesbyvolumn
    USING v_current_date;

    -- Total SMS Out
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
						  COUNT(b.created_date) FILTER (WHERE (b.is_app = 0 OR b.is_app IS NULL))::text || ''/'' ||
						  COUNT(b.created_date) FILTER (WHERE b.is_app=1)::text || '')''
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

 -- Converted_to_Registered 
	EXECUTE
	'SELECT jsonb_object_agg(
		''Day-'' || rn,
		(COALESCE(labgt_app,0) + COALESCE(labgt_web,0))::text 
		|| '' ('' || COALESCE(labgt_app,0)::text || ''/'' || COALESCE(labgt_web,0)::text || '')''
	)
	FROM (
		SELECT
			d,
			(SELECT COUNT(1) 
			 FROM (' || v_user_data || ') u
			 WHERE u.is_app = 1
			   AND u.created_date = d
			) AS labgt_app,
			(SELECT COUNT(1) 
			 FROM (' || v_user_data || ') u
			 WHERE (u.is_app = 0 OR u.is_app IS NULL)
			   AND u.created_date = d
			) AS labgt_web,
			ROW_NUMBER() OVER (ORDER BY d DESC) AS rn
		FROM generate_series(' 
			|| quote_literal(v_current_date - interval '7 days') || '::date, ' 
			|| quote_literal(v_current_date - interval '1 day') || '::date, interval ''1 day''
		) AS gs(d)
	) t'
	INTO v_converted_to_registered;

    -- Percentage_Conversion_to_Registered
	EXECUTE
	'SELECT jsonb_object_agg(
		''Day-'' || rn,
		CASE WHEN total > 0 
			 THEN ROUND(((registered_app + registered_web)::numeric / total) * 100, 2)::text || ''%''
			 ELSE ''0.00%''
		END
	)
	FROM (
		SELECT
			d,
			(SELECT COUNT(1) 
			 FROM (' || v_result_fetch || ') b 
			 WHERE DATE(b.created_date) = d
			) AS total,
			(SELECT COUNT(1) 
			 FROM (' || v_user_data || ') u
			 WHERE u.is_app = 1
			   AND u.created_date = d
			) AS registered_app,
			(SELECT COUNT(1) 
			 FROM (' || v_user_data || ') u
			 WHERE (u.is_app = 0 OR u.is_app IS NULL)
			   AND u.created_date = d
			) AS registered_web,
			ROW_NUMBER() OVER (ORDER BY d DESC) AS rn
		FROM generate_series($2, $3, interval ''1 day'') AS gs(d)
	) t'
	INTO v_percentage_conversation_to_registered
	USING v_current_date, (v_current_date - interval '7 days')::date, (v_current_date - interval '1 day')::date;

    -- Fully_Completed_Profiles
    EXECUTE
	'SELECT jsonb_object_agg(
		''Day-'' || rn,
		(COALESCE(labgt_app,0) + COALESCE(labgt_web,0))::text 
		|| '' ('' || COALESCE(labgt_app,0)::text || ''/'' || COALESCE(labgt_web,0)::text || '')''
	)
	FROM (
		SELECT
			d,
			(SELECT COUNT(1) 
			 FROM (' || v_user_data || ') u
			 WHERE u.is_app = 1
			   AND u.created_date = d
			   AND u.first_name IS NOT NULL AND u.first_name <> ''''
			   AND u.last_name IS NOT NULL  AND u.last_name  <> ''''
			) AS labgt_app,
			(SELECT COUNT(1) 
			 FROM (' || v_user_data || ') u
			 WHERE (u.is_app = 0 OR u.is_app IS NULL)
			   AND u.created_date = d
			   AND u.first_name IS NOT NULL AND u.first_name <> ''''
			   AND u.last_name IS NOT NULL  AND u.last_name  <> ''''
			) AS labgt_web,
			ROW_NUMBER() OVER (ORDER BY d DESC) AS rn
		FROM generate_series($2, $3, interval ''1 day'') AS gs(d)
	) t'
	INTO v_fully_completed_profiles
	USING v_current_date, (v_current_date - interval '7 days')::date, (v_current_date - interval '1 day')::date;

    -- Percentage_Fully_Completed_Profiles
    EXECUTE
	'SELECT jsonb_object_agg(
		''Day-'' || rn,
		CASE WHEN total > 0
			THEN ROUND(((COALESCE(registered_app,0) + COALESCE(registered_web,0))::numeric / total) * 100, 2)::text || ''%''
			ELSE ''0.00%''
		END
	)
	FROM (
		SELECT
			d,
			(SELECT COUNT(1) 
			 FROM (' || v_result_fetch || ') b 
			 WHERE DATE(b.created_date) = d
			) AS total,
			(SELECT COUNT(1) 
			 FROM (' || v_user_data || ') u
			 WHERE u.is_app = 1
			   AND u.created_date = d
			   AND u.first_name IS NOT NULL AND u.first_name <> ''''
			   AND u.last_name IS NOT NULL  AND u.last_name  <> ''''
			) AS registered_app,
			(SELECT COUNT(1) 
			 FROM (' || v_user_data || ') u
			 WHERE (u.is_app = 0 OR u.is_app IS NULL)
			   AND u.created_date = d
			   AND u.first_name IS NOT NULL AND u.first_name <> ''''
			   AND u.last_name IS NOT NULL  AND u.last_name  <> ''''
			) AS registered_web,
			ROW_NUMBER() OVER (ORDER BY d DESC) AS rn
		FROM generate_series($2, $3, interval ''1 day'') AS gs(d)
	) t'
	INTO v_percentage_fully_completed_profiles
	USING v_current_date, (v_current_date - interval '7 days')::date, (v_current_date - interval '1 day')::date;

    -- Output response
    p_json := jsonb_build_object(
        'Total_SMS_Out', COALESCE(v_total_sms_out, '{}'::jsonb),
        'Conveted_to_Registred', COALESCE(v_converted_to_registered, '{}'::jsonb),
        'Percentage_conversation_to_Registred', COALESCE(v_percentage_conversation_to_registered, '{}'::jsonb),
        'Fully_Completed_Profiles', COALESCE(v_fully_completed_profiles, '{}'::jsonb),
        'percentage_Fully_Completed_Profiles', COALESCE(v_percentage_fully_completed_profiles, '{}'::jsonb)
    );

-- Insert into summary table
EXECUTE
'WITH all_sms AS (
    SELECT 
        is_app,
        DATE(created_date + interval ''5 hours 30 minutes'') AS sms_date
    FROM labgt.labgt_otp_details
)
INSERT INTO labgt.labgt_sms_registration_summary (
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
        (current_timestamp + interval ''5 hours 30 minutes'')::date - interval ''7 days'',
        (current_timestamp + interval ''5 hours 30 minutes'')::date - interval ''1 day'',
        interval ''1 day''
    ) AS gs(d)
    WHERE gs.d NOT IN (SELECT date FROM labgt.labgt_sms_registration_summary)
) days
LEFT JOIN (
    -- WEB SMS OUT
    SELECT sms_date, COUNT(*) AS web_sms_out
    FROM all_sms
    WHERE (is_app = 0 OR is_app IS NULL)
    GROUP BY sms_date
) web_sms ON web_sms.sms_date = days.d
LEFT JOIN (
    -- APP SMS OUT
    SELECT sms_date, COUNT(*) AS app_sms_out
    FROM all_sms
    WHERE is_app = 1
    GROUP BY sms_date
) app_sms ON app_sms.sms_date = days.d
LEFT JOIN (
    -- Registrations + Completed profiles from v_user_data
    SELECT 
        u.created_date,
        COUNT(*) FILTER (WHERE (u.is_app = 0 OR u.is_app IS NULL)) AS web_registered_count,
        COUNT(*) FILTER (WHERE u.is_app = 1) AS app_registered_count,
        COUNT(*) FILTER (WHERE (u.is_app = 0 OR u.is_app IS NULL)
                              AND u.first_name IS NOT NULL AND u.first_name <> ''''
                              AND u.last_name IS NOT NULL  AND u.last_name  <> '''') AS web_completed_profile_count,
        COUNT(*) FILTER (WHERE u.is_app = 1
                              AND u.first_name IS NOT NULL AND u.first_name <> ''''
                              AND u.last_name IS NOT NULL  AND u.last_name  <> '''') AS app_completed_profile_count
    FROM (' || v_user_data || ') u
    GROUP BY u.created_date
) user_summary ON user_summary.created_date = days.d';

    -- Final output
    p_ures_json := jsonb_build_object(
        'weekly_data', p_json,
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
