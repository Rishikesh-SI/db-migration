-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_video_ingestion_report()
-- Type: FUNCTION

-- Name: labuww_get_video_ingestion_report(); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_video_ingestion_report() RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_result jsonb;
BEGIN
    SELECT jsonb_agg(
                jsonb_build_object(
                    'title', COALESCE(title, ''),
                    'slug_url', COALESCE(slug_url, ''),
                    'video_id', COALESCE(video_id::text, ''),
                    'video_url', COALESCE(video_url, ''),
                    'ref_video_id', COALESCE(ref_video_id::text, ''),
                    'status', COALESCE(status, '')
                )
           )
    INTO v_result
    FROM (
        SELECT DISTINCT ON (video_id)
            video_id,
            title,
            slug_url,
            video_url,
            ref_video_id,
            status
        FROM labuww.labuww_video_process_log
        WHERE 
            created_date >= NOW() - INTERVAL '24 hours'
            OR updated_date >= NOW() - INTERVAL '24 hours'
        ORDER BY video_id, updated_date DESC, created_date DESC
    ) t;

    RETURN v_result;
END;
$$;


--
