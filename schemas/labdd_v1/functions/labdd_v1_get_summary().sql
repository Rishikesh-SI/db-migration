-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_get_summary()
-- Type: FUNCTION

-- Name: labdd_v1_get_summary(); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_get_summary(OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_current_timestamp TIMESTAMP WITHOUT TIME ZONE;
    v_status NUMERIC;
    v_updated_date DATE;
    v_message TEXT;
    v_monthlysummary JSONB;
    v_lastfivedaystrend JSONB;
    v_toptencountriesbyvolumn JSONB;
    v_month_start DATE;
    v_month_end DATE;
    v_peak_hour TEXT;
    v_peak_hours_data JSONB;
	
BEGIN

    -- Initialize variables
    v_current_timestamp := CURRENT_TIMESTAMP + INTERVAL '5 hours 30 minutes';
    v_status := 1;
    v_message := 'Success';
    v_updated_date := CURRENT_DATE - INTERVAL '1 day';
    
    
	
	v_month_end:=(CURRENT_TIMESTAMP -'1 Days'::interval)::date;
	v_month_start:=(to_char(v_month_end,'YYYY-MM')||'-'||'01')::date;

    -- 1. Peak hour of the entire month 
    SELECT EXTRACT(HOUR FROM b.created_date AT TIME ZONE 'UTC') || ':00 (' || COUNT(*) || ')'
    INTO v_peak_hour
    FROM (
        SELECT country_code, created_date 
        FROM labdd_v1.labdd_v1_otp_details 
        UNION ALL
        SELECT country_code, created_date 
        FROM labdd_v1.labdd_v1_otpless_details 
    ) b
    WHERE DATE(b.created_date AT TIME ZONE 'UTC') BETWEEN v_month_start AND v_month_end
    GROUP BY EXTRACT(HOUR FROM b.created_date AT TIME ZONE 'UTC')
    ORDER BY COUNT(*) DESC
    LIMIT 1;

    v_peak_hour := COALESCE(v_peak_hour, 'No Data');

    -- 2. Monthly summary with  (web/app) counts
   SELECT jsonb_build_object(
    'peakhour', v_peak_hour,
    'totalsms', 
        COUNT(*) || ' (' || 
        COUNT(*) FILTER (WHERE b.is_app = 0) || '/' || 
        COUNT(*) FILTER (WHERE b.is_app = 1) || ')',
    'internationalsms', 
        COUNT(*) FILTER (WHERE b.country_code <> '91') || ' (' || 
        COUNT(*) FILTER (WHERE b.country_code <> '91' AND b.is_app = 0) || '/' || 
        COUNT(*) FILTER (WHERE b.country_code <> '91' AND b.is_app = 1) || ')',
    'domesticsms', 
        COUNT(*) FILTER (WHERE b.country_code = '91') || ' (' || 
        COUNT(*) FILTER (WHERE b.country_code = '91' AND b.is_app = 0) || '/' || 
        COUNT(*) FILTER (WHERE b.country_code = '91' AND b.is_app = 1) || ')',
    'averageperday', ROUND(COUNT(*)::NUMERIC / (v_month_end - v_month_start + 1), 2)
)
INTO v_monthlysummary 
FROM( 
    SELECT country_code, created_date, is_app
    FROM labdd_v1.labdd_v1_otp_details 
    UNION ALL
    SELECT country_code, created_date, NULL as is_app
    FROM labdd_v1.labdd_v1_otpless_details 
) b
WHERE DATE(b.created_date AT TIME ZONE 'UTC') BETWEEN v_month_start AND v_month_end;

    RAISE NOTICE 'Monthly Summary: %', v_monthlysummary;

    -- 3. Peak hour for each day of last 5 days 
    SELECT jsonb_object_agg(peak_date::text, peakhour)
    INTO v_peak_hours_data
    FROM (
        SELECT
            DATE(created_date AT TIME ZONE 'UTC') AS peak_date,
            EXTRACT(HOUR FROM (created_date AT TIME ZONE 'UTC')) || ':00 (' || COUNT(*) || ')' AS peakhour,
            ROW_NUMBER() OVER (
                PARTITION BY DATE(created_date AT TIME ZONE 'UTC') 
                ORDER BY COUNT(*) DESC
            ) AS rn
        FROM (
            SELECT country_code, created_date
            FROM labdd_v1.labdd_v1_otp_details 
            UNION ALL
            SELECT country_code, created_date
            FROM labdd_v1.labdd_v1_otpless_details  
        ) subq
        WHERE DATE(created_date AT TIME ZONE 'UTC')
            BETWEEN CURRENT_DATE - INTERVAL '5 days' AND CURRENT_DATE - INTERVAL '1 day'
        GROUP BY DATE(created_date AT TIME ZONE 'UTC'), 
                 EXTRACT(HOUR FROM (created_date AT TIME ZONE 'UTC'))
    ) ranked_peak
    WHERE rn = 1;

    v_peak_hours_data := COALESCE(v_peak_hours_data, '{}'::jsonb);

    -- 4. Last five days trend with  (web/app) counts 
    SELECT jsonb_agg(
        jsonb_build_object(
            'date', date,
            'totalsms', 
                totalsms || ' (' || web_total || '/' || app_total || ')',
            'internationalsms', 
                internationalsms || ' (' || web_international || '/' || app_international || ')',
            'domesticsms', 
                domesticsms || ' (' || web_domestic || '/' || app_domestic || ')',
            'peakhour', COALESCE(v_peak_hours_data->>date::text, 'No Data')
        ) ORDER BY date DESC
    )
    INTO v_lastfivedaystrend
    FROM (
       SELECT
            DATE(created_date AT TIME ZONE 'UTC') AS date,
            COUNT(*) AS totalsms,
            COUNT(CASE WHEN country_code <> '91' THEN 1 END) AS internationalsms,
            COUNT(CASE WHEN country_code = '91' THEN 1 END) AS domesticsms,
            
            COUNT(CASE WHEN is_app = 0 THEN 1 END) AS web_total,
            COUNT(CASE WHEN is_app = 1 THEN 1 END) AS app_total,
            COUNT(CASE WHEN country_code <> '91' AND is_app = 0 THEN 1 END) AS web_international,
            COUNT(CASE WHEN country_code <> '91' AND is_app = 1 THEN 1 END) AS app_international,
            COUNT(CASE WHEN country_code = '91' AND is_app = 0 THEN 1 END) AS web_domestic,
            COUNT(CASE WHEN country_code = '91' AND is_app = 1 THEN 1 END) AS app_domestic
        FROM (
            SELECT country_code, created_date, is_app
            FROM labdd_v1.labdd_v1_otp_details 
            UNION ALL
            SELECT country_code, created_date, NULL as is_app
            FROM labdd_v1.labdd_v1_otpless_details 
        ) subq
        WHERE DATE(created_date AT TIME ZONE 'UTC')
            BETWEEN CURRENT_DATE - INTERVAL '5 days' AND CURRENT_DATE - INTERVAL '1 day'
        GROUP BY DATE(created_date AT TIME ZONE 'UTC')
        ORDER BY DATE(created_date AT TIME ZONE 'UTC') DESC
    ) AS actual_data;

    RAISE NOTICE 'v_lastfivedaystrend %', v_lastfivedaystrend;

    -- 5. Top ten countries by volume 
    SELECT jsonb_agg(
        jsonb_build_object(
            'country', name,
            'country_code', country_code,
            'smssent', total_count || ' (' || web_count || '/' || app_count || ')'
        )
    )
    INTO v_toptencountriesbyvolumn
    FROM (
        SELECT
            rd.country_code,
            rd.total_count,
            rd.web_count,
            rd.app_count,
			wc.name,
            rd.row_num
        FROM (
            SELECT
                b.country_code,
                COUNT(*) AS total_count,
                COUNT(CASE WHEN b.is_app = 0 THEN 1 END) AS web_count,
                COUNT(CASE WHEN b.is_app = 1 THEN 1 END) AS app_count,
                ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_num
            FROM (
                SELECT country_code, created_date, is_app
                FROM labdd_v1.labdd_v1_otp_details 
                UNION ALL
                SELECT country_code, created_date, NULL as is_app
                FROM labdd_v1.labdd_v1_otpless_details 
              ) b
            WHERE b.country_code IS NOT NULL  
            AND DATE(b.created_date AT TIME ZONE 'UTC') = CURRENT_DATE - INTERVAL '1 day'
            GROUP BY b.country_code
        ) rd
        LEFT JOIN waf_master.waf_countries wc ON rd.country_code = wc.phone_code::text
        WHERE rd.row_num <= 10
        ORDER BY rd.row_num
        LIMIT 10
    ) AS top_ten_countries;

    RAISE NOTICE 'v_toptencountriesbyvolumn %', v_toptencountriesbyvolumn;

    -- Final JSON response
    p_ures_json := jsonb_build_object(
        'status', COALESCE(v_status, 0),
        'message', COALESCE(v_message, 'No Data'),
        'timestamp', to_char(v_current_timestamp, 'YYYY-MM-DD HH24:MI:SS'),
        'monthlysummary', COALESCE(v_monthlysummary, jsonb_build_object(
            'peakhour', 'No Data',
            'totalsms', '0 (0/0)',
            'internationalsms', '0 (0/0)',
            'domesticsms', '0 (0/0)',
            'averageperday', 0
        )),
        'lastfivedaystrend', COALESCE(v_lastfivedaystrend, '[]'::jsonb),
        'toptencountriesbyvolumn', COALESCE(v_toptencountriesbyvolumn, '[]'::jsonb)
    );
   
    RAISE NOTICE 'Final output: %', p_ures_json;

END;
$$;


--
