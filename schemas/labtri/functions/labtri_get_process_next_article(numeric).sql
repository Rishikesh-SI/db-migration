-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_get_process_next_article(numeric)
-- Type: FUNCTION

-- Name: labtri_get_process_next_article(numeric); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_get_process_next_article(p_batch_size numeric, OUT p_jsonb jsonb, OUT p_article_id numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    
-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'get_article_process','logs',uuid_generate_v4(),to_jsonb(p_batch_size),current_timestamp,'labtri','logs');
   
	
    SELECT 
		
		article_id,
        jsonb_set(payload, '{data,proc_id}', to_jsonb(a.id), true)
    INTO 
        
		p_article_id, 
        p_jsonb
    FROM (
        SELECT id, article_id, payload
        FROM labtri.labtri_article_process_log
		where status = 'pending'
        ORDER BY created_date
        LIMIT p_batch_size
    ) a
    LIMIT 1;

    -- If no record found, return empty
--    IF p_article_id IS NULL THEN
--         p_article_id := NULL;
--         p_jsonb := NULL;
--         RETURN;
--     END IF;

   
    RETURN;
END;
$$;


--
