-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_process_next_video(integer)
-- Type: FUNCTION

-- Name: labgt01_v1_get_process_next_video(integer); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_process_next_video(p_batch_size integer DEFAULT 5, OUT p_jsonb jsonb, OUT p_video_id text) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    
	
    SELECT 
        video_id,
        jsonb_set(payload, '{data,proc_id}', to_jsonb(a.id), true)
    INTO 
        p_video_id, 
        p_jsonb
    FROM (
        SELECT id, video_id, payload
        FROM labgt01_v1.labgt01_v1_video_process_log
        WHERE status = 'pending'
        ORDER BY created_date
        LIMIT p_batch_size
    ) a
    LIMIT 1;

    -- If no record found, return empty
   IF p_video_id IS NULL THEN
        p_video_id := NULL;
        p_jsonb := NULL;
        RETURN;
    END IF;

   
    RETURN;
END;
$$;


--
