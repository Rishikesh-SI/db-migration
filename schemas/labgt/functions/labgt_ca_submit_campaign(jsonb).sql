-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_submit_campaign(jsonb)
-- Type: FUNCTION

-- Name: labgt_ca_submit_campaign(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ca_submit_campaign(p_json jsonb, OUT p_result_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_module_name    TEXT;
    v_fields         JSONB;
    v_questionnaire  JSONB;
    v_attachment     JSONB;
    v_ip_address     TEXT;
    v_source_domain  TEXT;
    v_user_guid      TEXT;
    v_campaign       labgt.labgt_ca_campaign_metadata%ROWTYPE;
    v_dup_fields     JSONB;
    v_dedupe_key     TEXT;
    v_key            TEXT;
    v_unique_id      TEXT;
    v_next_val       BIGINT;
    v_padding        INT;
    v_full_json      JSONB;
    v_submission_id  BIGINT;
BEGIN
    v_module_name   := lower(trim(both from (p_json ->> 'module_name')));
    v_fields        := p_json -> 'fields';
    v_questionnaire := COALESCE(p_json -> 'questionnaire_answers', '{}'::jsonb);
    v_attachment    := p_json -> 'attachment';
    v_ip_address    := p_json ->> 'ip_address';
    v_source_domain := p_json ->> 'source_domain';
    v_user_guid     := p_json ->> 'user_guid';

    IF v_module_name IS NULL OR length(v_module_name) = 0 OR v_fields IS NULL THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'module_name and fields are required.');
        RETURN;
    END IF;

    -- ---- Look up campaign configuration. Not found / inactive short-circuits here,
    --      before any row is ever written. ----
    SELECT *
    INTO v_campaign
    FROM labgt.labgt_ca_campaign_metadata
    WHERE lower(module_name) = v_module_name
      AND status = 1;

    IF NOT FOUND THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'Campaign is not configured or is inactive.');
        RETURN;
    END IF;

    BEGIN
        -- ---- Duplicate validation: reduce the campaign's configured field list to a
        --      single deterministic, indexable dedupe_key. The actual enforcement
        --      happens at the database layer via the partial unique index created in
        --      001_create_metadata_tables.sql + the ON CONFLICT clause below -- not
        --      via a race-prone SELECT-then-INSERT check. ----
        IF NOT v_campaign.allow_duplicate THEN
            SELECT duplicate_fields
            INTO v_dup_fields
            FROM labgt.labgt_ca_duplicate_rule
            WHERE campaign_metadata_id = v_campaign.id
              AND is_active = TRUE;

            IF v_dup_fields IS NOT NULL THEN
                v_dedupe_key := '';
                FOR v_key IN SELECT jsonb_array_elements_text(v_dup_fields)
                LOOP
                    v_dedupe_key := v_dedupe_key || v_key || '=' || COALESCE(v_fields ->> v_key, '') || '|';
                END LOOP;
            END IF;
        END IF;

        -- ---- Unique ID generation via native sequence (atomic, lock-free). ----
        IF v_campaign.generate_unique_id AND v_campaign.sequence_name IS NOT NULL THEN
            v_next_val := nextval(v_campaign.sequence_name);

            SELECT padding_length INTO v_padding
            FROM labgt.labgt_ca_sequence_registry
            WHERE campaign_metadata_id = v_campaign.id;

            v_unique_id := COALESCE(v_campaign.unique_prefix, 'ID') || '-' ||
                            lpad(v_next_val::text, COALESCE(v_padding, 6), '0');
        END IF;

        v_full_json := jsonb_build_object('fields', v_fields, 'questionnaire_answers', v_questionnaire);

        -- ---- Insert. ON CONFLICT targets the same partial unique index used for
        --      duplicate enforcement; when dedupe_key is NULL (duplicate validation
        --      disabled for this campaign) no conflict is ever possible. ----
        INSERT INTO labgt.labgt_ca_submission
            (campaign_metadata_id, unique_id, dedupe_key, submission_json,
             user_guid, ip_address, source_domain, status, created_at)
        VALUES
            (v_campaign.id, v_unique_id, v_dedupe_key, v_full_json,
             v_user_guid, v_ip_address, v_source_domain, 1, now())
        ON CONFLICT (campaign_metadata_id, dedupe_key) WHERE dedupe_key IS NOT NULL
            DO NOTHING
        RETURNING id INTO v_submission_id;

        IF v_submission_id IS NULL AND v_dedupe_key IS NOT NULL THEN
            p_result_json := jsonb_build_object('status', 0, 'message', 'Duplicate submission for the configured fields.');
            RETURN;
        END IF;

        -- ---- Attachment (metadata only; binary already sits in object storage). ----
        IF v_campaign.attachment_enabled AND v_attachment IS NOT NULL AND v_attachment ? 'file_url' THEN
            INSERT INTO labgt.labgt_ca_attachment
                (submission_id, file_name, file_type, file_url, file_size_kb, created_at)
            VALUES
                (v_submission_id,
                 v_attachment ->> 'file_name',
                 v_attachment ->> 'file_type',
                 v_attachment ->> 'file_url',
                 NULLIF(v_attachment ->> 'file_size_kb', '')::int,
                 now());
        END IF;

        p_result_json := jsonb_build_object(
            'status', 1,
            'data', jsonb_build_object('submission_id', v_submission_id, 'unique_id', v_unique_id)
        );

    EXCEPTION
        WHEN unique_violation THEN
            -- Defensive fallback in case a raw constraint violation reaches here via a
            -- path other than the ON CONFLICT clause above.
            p_result_json := jsonb_build_object('status', 0, 'message', 'Duplicate submission for the configured fields.');
        WHEN OTHERS THEN
            p_result_json := jsonb_build_object('status', 0, 'message', 'Submission failed: ' || SQLERRM);
    END;
END;
$$;


--
