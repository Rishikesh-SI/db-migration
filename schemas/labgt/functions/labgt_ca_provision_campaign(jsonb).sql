-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_provision_campaign(jsonb)
-- Type: FUNCTION

-- Name: labgt_ca_provision_campaign(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ca_provision_campaign(p_json jsonb, OUT p_result_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_module_name           TEXT;
    v_module_type           TEXT;
    v_allow_duplicate       BOOLEAN;
    v_generate_unique_id    BOOLEAN;
    v_unique_prefix         TEXT;
    v_report_enabled        BOOLEAN;
    v_attachment_enabled    BOOLEAN;
    v_questionnaire_enabled BOOLEAN;
    v_duplicate_fields      JSONB;
    v_questions             JSONB;
    v_report_fields         JSONB;
    v_campaign_id           BIGINT;
    v_seq_name              TEXT;
    v_seq_schema            TEXT;
    v_seq_bare_name         TEXT;
    v_existing_id           BIGINT;
    v_field                 JSONB;
BEGIN
    v_module_name           := lower(trim(both from (p_json ->> 'module_name')));
    v_module_type           := p_json ->> 'module_type';
    v_allow_duplicate       := COALESCE((p_json ->> 'allow_duplicate')::boolean, TRUE);
    v_generate_unique_id    := COALESCE((p_json ->> 'generate_unique_id')::boolean, FALSE);
    v_unique_prefix         := p_json ->> 'unique_prefix';
    v_report_enabled        := COALESCE((p_json ->> 'report_enabled')::boolean, FALSE);
    v_attachment_enabled    := COALESCE((p_json ->> 'attachment_enabled')::boolean, FALSE);
    v_questionnaire_enabled := COALESCE((p_json ->> 'questionnaire_enabled')::boolean, FALSE);
    v_duplicate_fields      := p_json -> 'duplicate_fields';
    v_questions             := p_json -> 'questions';
    v_report_fields         := p_json -> 'report_fields';

    -- ---- Guard: required fields (defense in depth -- the API layer validates too) ----
    IF v_module_name IS NULL OR length(v_module_name) = 0 THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'module_name is required.');
        RETURN;
    END IF;

    IF v_module_type IS NULL OR v_module_type NOT IN ('contact', 'custom_web') THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'module_type must be one of: contact, custom_web.');
        RETURN;
    END IF;

    -- ---- Guard: campaign must not already exist for this tenant ----
    SELECT id
    INTO v_existing_id
    FROM labgt.labgt_ca_campaign_metadata
    WHERE lower(module_name) = v_module_name;

    IF FOUND THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'Campaign already exists for this client.');
        RETURN;
    END IF;

    BEGIN
        -- 1. Root metadata row.
        INSERT INTO labgt.labgt_ca_campaign_metadata
            (module_name, module_type, allow_duplicate, generate_unique_id, unique_prefix,
             report_enabled, attachment_enabled, questionnaire_enabled, status, created_at)
        VALUES
            (v_module_name, v_module_type, v_allow_duplicate, v_generate_unique_id, v_unique_prefix,
             v_report_enabled, v_attachment_enabled, v_questionnaire_enabled, 1, now())
        RETURNING id INTO v_campaign_id;

        -- 2. Native sequence, only when the campaign opts into unique-ID generation.
        --    nextval() is atomic and lock-free, unlike a counter-table UPDATE, which
        --    matters under submission spikes.
        IF v_generate_unique_id THEN
            v_seq_name := 'labgt.labgt_ca_seq_' || regexp_replace(v_module_name, '[^a-z0-9_]', '_', 'g');

            -- On tenants whose ProcedurePrefix is itself schema-qualified (e.g.
            -- "labgt.labgt", same pattern as the existing potptemp.potptemp_* objects),
            -- v_seq_name comes out as "schema.object_name". format('%I', v_seq_name)
            -- would quote the WHOLE string as a single identifier (dot included),
            -- creating a sequence that nextval()'s regclass cast (which DOES split on
            -- the dot as schema.object) would then fail to find. So: split schema from
            -- object name explicitly and quote each part separately when a dot is
            -- present, and fall back to the simple unqualified case otherwise.
            IF position('.' in v_seq_name) > 0 THEN
                v_seq_schema    := split_part(v_seq_name, '.', 1);
                v_seq_bare_name := split_part(v_seq_name, '.', 2);
                EXECUTE format('CREATE SEQUENCE IF NOT EXISTS %I.%I START WITH 100001 INCREMENT BY 1', v_seq_schema, v_seq_bare_name);
            ELSE
                EXECUTE format('CREATE SEQUENCE IF NOT EXISTS %I START WITH 100001 INCREMENT BY 1', v_seq_name);
            END IF;

            INSERT INTO labgt.labgt_ca_sequence_registry
                (campaign_metadata_id, sequence_name, unique_prefix, padding_length, created_at)
            VALUES
                (v_campaign_id, v_seq_name, v_unique_prefix, 6, now());

            UPDATE labgt.labgt_ca_campaign_metadata
            SET sequence_name = v_seq_name
            WHERE id = v_campaign_id;
        END IF;

        -- 3. Duplicate validation rule -- configuration, not code.
        IF NOT v_allow_duplicate AND v_duplicate_fields IS NOT NULL AND jsonb_array_length(v_duplicate_fields) > 0 THEN
            INSERT INTO labgt.labgt_ca_duplicate_rule
                (campaign_metadata_id, duplicate_fields, is_active, created_at)
            VALUES
                (v_campaign_id, v_duplicate_fields, TRUE, now());
        END IF;

        -- 4. Questionnaire configuration (optional; empty shell if not supplied).
        IF v_questionnaire_enabled THEN
            INSERT INTO labgt.labgt_ca_questionnaire_config
                (campaign_metadata_id, questions, created_at)
            VALUES
                (v_campaign_id, COALESCE(v_questions, '[]'::jsonb), now());
        END IF;

        -- 5. Report field map (optional). The generic report procedure ALWAYS returns
        --    id, unique_id and created_at as standard columns regardless of this map,
        --    so it is fine for this to be empty at provisioning time and extended later
        --    with a plain INSERT -- no procedure change required.
        IF v_report_enabled AND v_report_fields IS NOT NULL AND jsonb_array_length(v_report_fields) > 0 THEN
            FOR v_field IN SELECT * FROM jsonb_array_elements(v_report_fields)
            LOOP
                INSERT INTO labgt.labgt_ca_report_field_map
                    (campaign_metadata_id, json_path, column_alias, data_type, display_order, created_at)
                VALUES
                    (v_campaign_id,
                     v_field ->> 'json_path',
                     COALESCE(v_field ->> 'column_alias', v_field ->> 'json_path'),
                     COALESCE(v_field ->> 'data_type', 'text'),
                     COALESCE((v_field ->> 'display_order')::int, 0),
                     now());
            END LOOP;
        END IF;

        p_result_json := jsonb_build_object(
            'status', 1,
            'message', 'Campaign provisioned successfully',
            'data', jsonb_build_object(
                'campaign_metadata_id', v_campaign_id,
                'module_name', v_module_name,
                'sequence_name', v_seq_name,
                'duplicate_validation_enabled', NOT v_allow_duplicate,
                'questionnaire_enabled', v_questionnaire_enabled,
                'report_enabled', v_report_enabled
            )
        );

    EXCEPTION WHEN OTHERS THEN
        -- Never let an exception propagate to the client as a raw ADO.NET error --
        -- communicate failure through the same jsonb OUT parameter as success.
        p_result_json := jsonb_build_object('status', 0, 'message', 'Provisioning failed: ' || SQLERRM);
    END;
END;
$$;


--
