-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_process_next_video(numeric)
-- Type: FUNCTION

-- Name: labuww_get_process_next_video(numeric); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_process_next_video(p_batch_size numeric, OUT p_jsonb jsonb, OUT p_video_id numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    
insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'get_video_process','logs',uuid_generate_v4(),to_jsonb(p_batch_size),current_timestamp,'labuww','logs');
   
	
    SELECT 
		
		video_id,
        jsonb_set(payload, '{data,proc_id}', to_jsonb(a.id), true)
    INTO 
        
		p_video_id, 
        p_jsonb
    FROM (
        SELECT id, video_id, payload
        FROM labuww.labuww_video_process_log
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
