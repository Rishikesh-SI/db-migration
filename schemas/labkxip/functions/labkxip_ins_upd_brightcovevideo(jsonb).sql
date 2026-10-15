-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_ins_upd_brightcovevideo(jsonb)
-- Type: FUNCTION

-- Name: labkxip_ins_upd_brightcovevideo(jsonb); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_ins_upd_brightcovevideo(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id                    bigint;
    v_brightcove_video_id   varchar(64);
    v_title                 text;
    v_original_filename     text;
    v_duration              numeric(12,3);
    v_thumbnail_url         text;
    v_poster_url            text;
    v_s3_path               text;
    v_brightcove_created_at timestamptz;
    v_brightcove_updated_at timestamptz;
    v_sync_status           varchar(32);
    v_last_synced_at        timestamptz;
BEGIN

    -- Read JSON values
    SELECT
        p_json->>'brightcove_video_id',
        p_json->>'title',
        p_json->>'original_filename',
        (p_json->>'duration')::numeric,
        p_json->>'thumbnail_url',
        p_json->>'poster_url',
        p_json->>'s3_path',
        COALESCE(p_json->>'sync_status', 'synced')
    INTO
        v_brightcove_video_id,
        v_title,
        v_original_filename,
        v_duration,
        v_thumbnail_url,
        v_poster_url,
        v_s3_path,
        v_sync_status;

    RAISE NOTICE 'brightcove_video_id : %', v_brightcove_video_id;

    -- Parse timestamps
    BEGIN
        v_brightcove_created_at :=
            (p_json->>'brightcove_created_at')::timestamptz;
    EXCEPTION WHEN OTHERS THEN
        v_brightcove_created_at := NULL;
    END;

    BEGIN
        v_brightcove_updated_at :=
            (p_json->>'brightcove_updated_at')::timestamptz;
    EXCEPTION WHEN OTHERS THEN
        v_brightcove_updated_at := NULL;
    END;

    BEGIN
        v_last_synced_at :=
            COALESCE(
                (p_json->>'last_synced_at')::timestamptz,
                current_timestamp AT TIME ZONE 'utc'
            );
    EXCEPTION WHEN OTHERS THEN
        v_last_synced_at := current_timestamp AT TIME ZONE 'utc';
    END;

    -- Validation
    IF COALESCE(v_brightcove_video_id, '') = '' THEN

        p_result := -1;

        p_data := jsonb_build_object(
            'error',
            'brightcove_video_id is required'
        );

        RETURN;

    END IF;

    -- Insert / Update
    INSERT INTO labkxip.labkxip_brightcove_video
    (
        brightcove_video_id,
        title,
        original_filename,
        duration,
        thumbnail_url,
        poster_url,
        s3_path,
        brightcove_created_at,
        brightcove_updated_at,
        sync_status,
        last_synced_at,
        created_at,
        updated_at
    )
    VALUES
    (
        v_brightcove_video_id,
        v_title,
        v_original_filename,
        v_duration,
        v_thumbnail_url,
        v_poster_url,
        v_s3_path,
        v_brightcove_created_at,
        v_brightcove_updated_at,
        v_sync_status,
        v_last_synced_at,
        current_timestamp AT TIME ZONE 'utc',
        current_timestamp AT TIME ZONE 'utc'
    )
    ON CONFLICT (brightcove_video_id)
    DO UPDATE
    SET
        title                 = EXCLUDED.title,
        original_filename     = EXCLUDED.original_filename,
        duration              = EXCLUDED.duration,
        thumbnail_url         = EXCLUDED.thumbnail_url,
        poster_url            = EXCLUDED.poster_url,
        s3_path               = EXCLUDED.s3_path,
        brightcove_updated_at = EXCLUDED.brightcove_updated_at,
        sync_status           = EXCLUDED.sync_status,
        last_synced_at        = EXCLUDED.last_synced_at,
        updated_at            = current_timestamp AT TIME ZONE 'utc'
    RETURNING id
    INTO v_id;

    p_result := 1;

    p_data := jsonb_build_object(
        'id', v_id,
        'brightcove_video_id', v_brightcove_video_id
    );

    RETURN;

EXCEPTION
    WHEN OTHERS THEN

        p_result := -1;

        p_data := jsonb_build_object(
            'error',
            SQLERRM
        );

        RETURN;
END;
$$;


--
