-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_get_summary(jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_get_summary(jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_get_summary(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
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

select 1/0;
    -- Initialize variables
    v_current_timestamp := CURRENT_TIMESTAMP + INTERVAL '5 hours 30 minutes';
    v_status := 1;
    v_message := 'Success';
    v_updated_date := CURRENT_DATE - INTERVAL '1 day';
    
    -- Error handling block
    BEGIN
        v_month_start := CURRENT_DATE - INTERVAL '30 days';
        v_month_end := CURRENT_DATE - INTERVAL '1 day';

        RAISE NOTICE 'Using last 30 days: % to %', v_month_start, v_month_end;
        
        -- 1. Peak hour of the entire month
        SELECT EXTRACT(HOUR FROM created_date AT TIME ZONE 'UTC') || ':00 (' || COUNT(*) || ')'
        INTO v_peak_hour
        FROM labkc_v1.labkc_v1_otp_details
        WHERE DATE(created_date AT TIME ZONE 'UTC') BETWEEN v_month_start AND v_month_end
        GROUP BY EXTRACT(HOUR FROM created_date AT TIME ZONE 'UTC')
        ORDER BY COUNT(*) DESC
        LIMIT 1;

        v_peak_hour := COALESCE(v_peak_hour, 'No Data');

        -- 2. Monthly summary JSON
        SELECT jsonb_build_object(
            'totalsms', COUNT(*),
            'internationalsms', COUNT(*) FILTER (WHERE country_code <> '91'),
            'domesticsms', COUNT(*) FILTER (WHERE country_code = '91'),
            'peakhour', v_peak_hour,
            'averageperday', ROUND(COUNT(*)::NUMERIC / (v_month_end - v_month_start + 1), 2)
        )
        INTO v_monthlysummary
        FROM labkc_v1.labkc_v1_otp_details
        WHERE DATE(created_date AT TIME ZONE 'UTC') BETWEEN v_month_start AND v_month_end;

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
            FROM labkc_v1.labkc_v1_otp_details
            WHERE DATE(created_date AT TIME ZONE 'UTC')
                BETWEEN CURRENT_DATE - INTERVAL '5 days' AND CURRENT_DATE - INTERVAL '1 day'
            GROUP BY DATE(created_date AT TIME ZONE 'UTC'), 
                     EXTRACT(HOUR FROM (created_date AT TIME ZONE 'UTC'))
        ) ranked_peak
        WHERE rn = 1;

        v_peak_hours_data := COALESCE(v_peak_hours_data, '{}'::jsonb);

        -- 4. Last five days trend
        SELECT jsonb_agg(
            jsonb_build_object(
                'date', date,
                'totalsms', totalsms,
                'internationalsms', internationalsms,
                'domesticsms', domesticsms,
                'peakhour', COALESCE(v_peak_hours_data->>date::text, 'No Data')
            ) ORDER BY date DESC
        )
        INTO v_lastfivedaystrend
        FROM (
            SELECT
                DATE(created_date AT TIME ZONE 'UTC') AS date,
                COUNT(*) AS totalsms,
                COUNT(CASE WHEN country_code <> '91' THEN 1 END) AS internationalsms,
                COUNT(CASE WHEN country_code = '91' THEN 1 END) AS domesticsms
            FROM labkc_v1.labkc_v1_otp_details
            WHERE DATE(created_date AT TIME ZONE 'UTC')
                BETWEEN CURRENT_DATE - INTERVAL '5 days' AND CURRENT_DATE - INTERVAL '1 day'
            GROUP BY DATE(created_date AT TIME ZONE 'UTC')
            ORDER BY DATE(created_date AT TIME ZONE 'UTC') DESC
        ) AS actual_data;

        RAISE NOTICE 'v_lastfivedaystrend %', v_lastfivedaystrend;

        -- 5. Top ten countries by volume (FIXED: use last 7 days and proper COALESCE)
        SELECT jsonb_agg(
            jsonb_build_object(
                'country', country_name,
                'country_code', country_code,
                'smssent', total_count
            )
        )
        INTO v_toptencountriesbyvolumn
        FROM (
            SELECT
                rd.country_code,
                rd.total_count,
                COALESCE(wc.name, 'Unknown') AS country_name,
                rd.row_num
            FROM (
                SELECT
                    country_code,
                    COUNT(*) AS total_count,
                    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_num
                FROM labkc_v1.labkc_v1_otp_details
                WHERE country_code IS NOT NULL  
                AND DATE(created_date AT TIME ZONE 'UTC') 
                    BETWEEN CURRENT_DATE - INTERVAL '7 days' AND CURRENT_DATE - INTERVAL '1 day'
                GROUP BY country_code
            ) rd
            LEFT JOIN waf_master.waf_countries wc ON rd.country_code = wc.phone_code
            WHERE rd.row_num <= 10
            ORDER BY rd.row_num
            LIMIT 10
        ) AS top_ten_countries;

        RAISE NOTICE 'v_toptencountriesbyvolumn %', v_toptencountriesbyvolumn;

    
    END;
-- RAISE NOTICE '2Monthly Summary: %', v_monthlysummary;
--     -- Final JSON response with proper error handling
--     p_ures_json := jsonb_build_object(
--         'status', COALESCE(v_status, 0),
--         'message', COALESCE(v_message, 'No Data'),
--         'timestamp', to_char(v_current_timestamp, 'YYYY-MM-DD HH24:MI:SS'),
--         'lastfivedaystrend', COALESCE(v_lastfivedaystrend, '[]'::jsonb),
--         'toptencountriesbyvolumn', COALESCE(v_toptencountriesbyvolumn, '[]'::jsonb)
--     );
--    p_ures_json := jsonb_set(p_ures_json, '{data,monthlysummary}', COALESCE(v_monthlysummary, '{}'), true);

--     RAISE NOTICE 'Final output: %', p_ures_json;

END;
$$;


--
