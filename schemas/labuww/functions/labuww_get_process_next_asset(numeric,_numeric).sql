-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_process_next_asset(numeric, numeric)
-- Type: FUNCTION

-- Name: labuww_get_process_next_asset(numeric, numeric); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_process_next_asset(p_batch_size numeric, p_asset_type numeric, OUT p_jsonb jsonb, OUT p_asset_id numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log the input for debugging
    INSERT INTO siwaf.siwaf_client_logs(api_error_log_id, log_method_name, log_error_message, log_guid, error_json, created_date, client_name, log_type)
    VALUES (nextval('siwaf.seq_siwaf_api_error_log_id'), 'labuww_get_process_next_asset', ('p_batch_size: ' || p_batch_size || ', p_asset_type: ' || p_asset_type)::text, uuid_generate_v4(), '{}', current_timestamp, 'labuww', 'logs');

    -- Fetch pending records based on asset_type
    SELECT
        json_agg(
            jsonb_set(a.payload, '{data,proc_id}', to_jsonb(a.id), true)
        ),
        NULL
    INTO
        p_jsonb,
        p_asset_id
    FROM (
        SELECT id, asset_id, payload
        FROM labuww.labuww_asset_process_log
        WHERE status = 'pending' AND asset_type = p_asset_type
        ORDER BY created_date
        LIMIT p_batch_size
    ) a;

    RETURN;
END;
$$;


--
