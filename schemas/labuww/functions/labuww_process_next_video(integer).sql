-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_process_next_video(integer)
-- Type: FUNCTION

-- Name: labuww_process_next_video(integer); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_process_next_video(p_batch_size integer DEFAULT 5, OUT p_processed_id bigint, OUT p_video_id text, OUT p_purge_required boolean) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id BIGINT;
    v_video_id TEXT;
    v_event_type TEXT;
    v_payload JSONB;
    v_count INT;
    v_current_timestamp TIMESTAMPTZ := current_timestamp;

    -- Variables for metadata extraction
    v_content_source_id NUMERIC;
    v_title VARCHAR(4000);
    v_title_alias VARCHAR(4000);
    v_short_title VARCHAR(2000);
    v_video_meta JSONB;
    v_video_desc TEXT;
    v_duration VARCHAR(1000);
    v_partner_id NUMERIC;
    v_show_in_web NUMERIC;
    v_show_in_mobile NUMERIC;
    v_show_in_app NUMERIC;
    v_published_version_number NUMERIC;
    v_video_url VARCHAR(4000);
    v_is_trashed NUMERIC;
    v_created_date TIMESTAMPTZ;
    v_updated_date TIMESTAMPTZ;
    v_created_by NUMERIC;
    v_updated_by NUMERIC;
    v_is_active NUMERIC;
    v_is_deleted NUMERIC;
    v_is_published NUMERIC;
    v_video_guid VARCHAR(256);
    v_published_date TIMESTAMPTZ;
    v_show_copyright NUMERIC;
    v_content_source_link VARCHAR(4000);
    v_order_number NUMERIC;
    v_image_id NUMERIC;
    v_slug_url VARCHAR(4000);
    v_hls_url VARCHAR(4000);
    v_azure_id NUMERIC;
    v_ref_video_guid VARCHAR(256);
    v_ref_video_id NUMERIC;
BEGIN
    
    SELECT
        id,
        video_id::text,
        payload->'data'->>'event_type',
        payload,
        -- Extract metadata from payload
        (payload->'data'->>'content_source_id')::NUMERIC,
        payload->'data'->>'title',
        payload->'data'->>'title_alias',
        payload->'data'->>'short_title',
        payload->'data'->'video_meta',
        payload->'data'->>'video_desc',
        payload->'data'->>'duration',
        (payload->'data'->>'partner_id')::NUMERIC,
        (payload->'data'->>'show_in_web')::NUMERIC,
        (payload->'data'->>'show_in_mobile')::NUMERIC,
        (payload->'data'->>'show_in_app')::NUMERIC,
        (payload->'data'->>'published_version_number')::NUMERIC,
        payload->'data'->>'video_url',
        (payload->'data'->>'is_trashed')::NUMERIC,
        (payload->'data'->>'created_date')::TIMESTAMPTZ,
        (payload->'data'->>'updated_date')::TIMESTAMPTZ,
        (payload->'data'->>'created_by')::NUMERIC,
        (payload->'data'->>'updated_by')::NUMERIC,
        (payload->'data'->>'is_active')::NUMERIC,
        (payload->'data'->>'is_deleted')::NUMERIC,
        (payload->'data'->>'is_published')::NUMERIC,
        payload->'data'->>'video_guid',
        (payload->'data'->>'published_date')::TIMESTAMPTZ,
        (payload->'data'->>'show_copyright')::NUMERIC,
        payload->'data'->>'content_source_link',
        (payload->'data'->>'order_number')::NUMERIC,
        (payload->'data'->>'image_id')::NUMERIC,
        payload->'data'->>'slug_url',
        payload->'data'->>'hls_url',
        (payload->'data'->>'azure_id')::NUMERIC,
        payload->'data'->>'ref_video_guid',
        (payload->'data'->>'ref_video_id')::NUMERIC
    INTO
        v_id, v_video_id, v_event_type, v_payload,
        v_content_source_id, v_title, v_title_alias, v_short_title, v_video_meta, v_video_desc, v_duration,
        v_partner_id, v_show_in_web, v_show_in_mobile, v_show_in_app, v_published_version_number,
        v_video_url, v_is_trashed, v_created_date, v_updated_date, v_created_by, v_updated_by,
        v_is_active, v_is_deleted, v_is_published, v_video_guid, v_published_date, v_show_copyright,
        v_content_source_link, v_order_number, v_image_id, v_slug_url, v_hls_url, v_azure_id,
        v_ref_video_guid, v_ref_video_id
    FROM labuww.labuww_video_process_log
    WHERE status = 'pending'
    ORDER BY created_at
    FOR UPDATE SKIP LOCKED
    LIMIT 1;

    -- If no record found, return empty
    IF v_id IS NULL THEN
        p_processed_id := NULL;
        p_video_id := NULL;
        p_purge_required := FALSE;
        RETURN;
    END IF;

    -- 2. Call ingestion SP
    PERFORM labuww.labuww_ins_upd_video_by_guid(v_payload);

    -- 3. Insert into audit table (with extracted metadata)
    INSERT INTO labuww.video_ingestion_audit(
        video_id, event_type, payload,
        content_source_id, title, title_alias, short_title, video_meta, video_desc, duration,
        partner_id, show_in_web, show_in_mobile, show_in_app, published_version_number,
        video_url, is_trashed, created_date, updated_date, created_by, updated_by,
        is_active, is_deleted, is_published, video_guid, published_date, show_copyright,
        content_source_link, order_number, image_id, slug_url, hls_url, azure_id,
        ref_video_guid, ref_video_id, processed_at
    )
    VALUES (
        v_video_id,
        COALESCE(v_event_type, 'unknown'),
        v_payload,
        v_content_source_id, v_title, v_title_alias, v_short_title, v_video_meta, v_video_desc, v_duration,
        v_partner_id, v_show_in_web, v_show_in_mobile, v_show_in_app, v_published_version_number,
        v_video_url, v_is_trashed, v_created_date, v_updated_date, v_created_by, v_updated_by,
        v_is_active, v_is_deleted, v_is_published, v_video_guid, v_published_date, v_show_copyright,
        v_content_source_link, v_order_number, v_image_id, v_slug_url, v_hls_url, v_azure_id,
        v_ref_video_guid, v_ref_video_id, v_current_timestamp
    );

    -- 4. Delete from staging
    DELETE FROM labuww.labuww_video_process_log WHERE id = v_id;

    -- 5. Count videos processed in last 5 minutes
    SELECT count(*) INTO v_count
    FROM labuww.video_ingestion_audit
    WHERE processed_at > now() - interval '5 minutes';

    -- 6. Set output
    p_processed_id := v_id;
    p_video_id := v_video_id;
    p_purge_required := (v_count % p_batch_size = 0);

    RETURN;
END;
$$;


--
