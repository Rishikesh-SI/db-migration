-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_summary_bkp()
-- Type: FUNCTION

-- Name: labkc_v1_get_summary_bkp(); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_summary_bkp(OUT p_ures_json jsonb) RETURNS jsonb
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
BEGIN

    v_current_timestamp := current_timestamp + interval '5 hours 30 minutes';
    v_updated_date := current_date - interval '1 day';
    v_month_end := (current_timestamp - '1 days'::interval)::date;
    v_month_start := (to_char(v_month_end, 'yyyy-mm') || '-' || '01')::date;

    -- 1. peak hour of the entire month 
    SELECT extract(hour from b.created_date at time zone 'utc') || ':00 (' || count(1) FILTER (WHERE TRUE) || ')'
    INTO v_peak_hour
    FROM (
        SELECT client_code, country_code, created_date 
        FROM labkc_v1.labkc_v1_otp_details 
        UNION ALL
        SELECT client_code, country_code, created_date 
        FROM labkc_v1.labkc_v1_otpless_details  
    ) b
    WHERE date(b.created_date at time zone 'utc') BETWEEN v_month_start AND v_month_end
    GROUP BY extract(hour from b.created_date at time zone 'utc')
    ORDER BY count(1) FILTER (WHERE TRUE) DESC
    LIMIT 1;

    v_peak_hour := coalesce(v_peak_hour, 'no data');

    -- 2. monthly summary with (web/app) counts
    SELECT jsonb_build_object(
        'peakhour', v_peak_hour,
        'totalsms', 
            count(1) FILTER (WHERE TRUE) || ' (' || 
            count(1) FILTER (WHERE b.client_code in ('labkkr_v1','labkkr')) || '/' || 
            count(1) FILTER (WHERE b.client_code in ('labkc_v1','labkc')) || ')',
        'internationalsms', 
            count(1) FILTER (WHERE b.country_code <> '91') || ' (' || 
            count(1) FILTER (WHERE b.country_code <> '91' and b.client_code in ('labkkr_v1','labkkr')) || '/' || 
            count(1) FILTER (WHERE b.country_code <> '91' and b.client_code in ('labkc_v1','labkc')) || ')',
        'domesticsms', 
            count(1) FILTER (WHERE b.country_code = '91') || ' (' || 
            count(1) FILTER (WHERE b.country_code = '91' and b.client_code in ('labkkr_v1','labkkr')) || '/' || 
            count(1) FILTER (WHERE b.country_code = '91' and b.client_code in ('labkc_v1','labkc')) || ')',
        'averageperday', round(count(1) FILTER (WHERE TRUE)::numeric / (v_month_end - v_month_start + 1), 2)
    )
    INTO v_monthlysummary 
    FROM (
        SELECT client_code, country_code, created_date 
        FROM labkc_v1.labkc_v1_otp_details 
        UNION ALL
        SELECT client_code, country_code, created_date 
        FROM labkc_v1.labkc_v1_otpless_details  
    ) b
    WHERE date(b.created_date at time zone 'utc') BETWEEN v_month_start AND v_month_end;

    RAISE NOTICE 'monthly summary: %', v_monthlysummary;

    -- 3. peak hour for each day of last 5 days 
    SELECT jsonb_object_agg(peak_date::text, peakhour)
    INTO v_peak_hours_data
    FROM (
        SELECT
            date(b.created_date at time zone 'utc') as peak_date,
            extract(hour from (b.created_date at time zone 'utc')) || ':00 (' || count(1) FILTER (WHERE TRUE) || ')' as peakhour,
            row_number() over (
            partition by date(b.created_date at time zone 'utc') 
            order by count(1) FILTER (WHERE TRUE) desc
            ) as rn
        FROM (
            SELECT client_code, country_code, created_date 
            FROM labkc_v1.labkc_v1_otp_details 
            UNION ALL
            SELECT client_code, country_code, created_date 
            FROM labkc_v1.labkc_v1_otpless_details  
        ) b
        WHERE date(b.created_date at time zone 'utc')
            BETWEEN current_date - interval '5 days' AND current_date - interval '1 day'
        GROUP BY date(b.created_date at time zone 'utc'), 
                 extract(hour from (b.created_date at time zone 'utc'))
    ) ranked_peak
    WHERE rn = 1;

    v_peak_hours_data := coalesce(v_peak_hours_data, '{}'::jsonb);

    -- 4. last five days trend with (web/app) counts 
    SELECT jsonb_agg(
        jsonb_build_object(
            'date', date,
            'totalsms', totalsms || ' (' || web_total || '/' || app_total || ')',
            'internationalsms', internationalsms || ' (' || web_international || '/' || app_international || ')',
            'domesticsms', domesticsms || ' (' || web_domestic || '/' || app_domestic || ')',
            'peakhour', coalesce(v_peak_hours_data->>date::text, 'no data')
        ) ORDER BY date DESC
    )
    INTO v_lastfivedaystrend
    FROM (
        SELECT
            date(b.created_date at time zone 'utc') as date,
            count(1) FILTER (WHERE TRUE) as totalsms,
            count(1) FILTER (WHERE b.country_code <> '91') as internationalsms,
            count(1) FILTER (WHERE b.country_code = '91') as domesticsms,
            count(1) FILTER (WHERE b.client_code in ('labkkr_v1','labkkr')) as web_total,
            count(1) FILTER (WHERE b.client_code in ('labkc_v1','labkc')) as app_total,
            count(1) FILTER (WHERE b.country_code <> '91' and b.client_code in ('labkkr_v1','labkkr')) as web_international,
            count(1) FILTER (WHERE b.country_code <> '91' and b.client_code in ('labkc_v1','labkc')) as app_international,
            count(1) FILTER (WHERE b.country_code = '91' and b.client_code in ('labkkr_v1','labkkr')) as web_domestic,
            count(1) FILTER (WHERE b.country_code = '91' and b.client_code in ('labkc_v1','labkc')) as app_domestic
        FROM (
            SELECT client_code, country_code, created_date 
            FROM labkc_v1.labkc_v1_otp_details 
            UNION ALL
            SELECT client_code, country_code, created_date 
            FROM labkc_v1.labkc_v1_otpless_details  
        ) b
        WHERE date(b.created_date at time zone 'utc')
            BETWEEN current_date - interval '5 days' AND current_date - interval '1 day'
        GROUP BY date(b.created_date at time zone 'utc')
        ORDER BY date(b.created_date at time zone 'utc') DESC
    ) actual_data;

    RAISE NOTICE 'v_lastfivedaystrend %', v_lastfivedaystrend;

    -- 5. top ten countries by volume 
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
                count(1) FILTER (WHERE TRUE) as total_count,
                count(1) FILTER (WHERE b.client_code in ('labkkr_v1','labkkr')) as web_count,
                count(1) FILTER (WHERE b.client_code in ('labkc_v1','labkc')) as app_count,
                row_number() over (ORDER BY count(1) FILTER (WHERE TRUE) DESC) as row_num
            FROM (
                SELECT client_code, country_code, created_date 
                FROM labkc_v1.labkc_v1_otp_details 
                UNION ALL
                SELECT client_code, country_code, created_date 
                FROM labkc_v1.labkc_v1_otpless_details  
            ) b
            WHERE b.country_code IS NOT NULL  
              AND date(b.created_date at time zone 'utc') = current_date - interval '1 day'
            GROUP BY b.country_code
        ) rd
        LEFT JOIN waf_master.waf_countries wc ON rd.country_code = wc.phone_code
        WHERE rd.row_num <= 10
        ORDER BY rd.row_num
        LIMIT 10
    ) top_ten_countries;

    RAISE NOTICE 'v_toptencountriesbyvolumn %', v_toptencountriesbyvolumn;

    -- final json response
    p_ures_json := jsonb_build_object(
        'status', coalesce(v_status, 0),
        'message', coalesce(v_message, 'no data'),
        'timestamp', to_char(v_current_timestamp, 'yyyy-mm-dd hh24:mi:ss'),
        'monthlysummary', coalesce(v_monthlysummary, jsonb_build_object(
            'peakhour', 'no data',
            'totalsms', '0 (0/0)',
            'internationalsms', '0 (0/0)',
            'domesticsms', '0 (0/0)',
            'averageperday', 0
        )),
        'lastfivedaystrend', coalesce(v_lastfivedaystrend, '[]'::jsonb),
        'toptencountriesbyvolumn', coalesce(v_toptencountriesbyvolumn, '[]'::jsonb)
    );

    RAISE NOTICE 'final output: %', p_ures_json;

END;
$$;


--
