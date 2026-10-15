-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_last_24hr_audit_data()
-- Type: FUNCTION

-- Name: labuww_get_last_24hr_audit_data(); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_last_24hr_audit_data(OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
BEGIN
    SELECT jsonb_agg(a ORDER BY a->>'created_date' DESC)
    INTO p_result
    FROM (
        SELECT jsonb_build_object(
            'title', title_alias,
            'slug_url', payload -> 'data' ->> 'slug_url',
            'video_id', video_id,
            'video_url', payload -> 'data' ->> 'video_url',
            'ref_video_id', payload -> 'data' ->> 'ref_video_id',
            'status', status,
            'created_date', created_date::text
        ) AS a
        FROM labuww.labuww_video_ingestion_audit
        WHERE created_date >= (NOW() - INTERVAL '24 HOURS')
    ) t;

    IF p_result IS NULL THEN
        p_result := '[]'::jsonb;
    END IF;

    RETURN;
END;
$$;


--
