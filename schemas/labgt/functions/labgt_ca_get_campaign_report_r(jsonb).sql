-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_get_campaign_report_r(jsonb)
-- Type: FUNCTION

-- Name: labgt_ca_get_campaign_report_r(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ca_get_campaign_report_r(p_json jsonb, OUT p_result_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
DECLARE
    v_module_name   TEXT;
    v_date_from     TIMESTAMPTZ;
    v_date_to       TIMESTAMPTZ;
    v_page          INT;
    v_page_size     INT;
    v_offset        INT;
    v_export_all    BOOLEAN;
    v_limit_clause  TEXT;
    v_campaign      labgt.labgt_ca_campaign_metadata%ROWTYPE;
    v_select_list   TEXT := '';
    v_field         RECORD;
    v_cast_suffix   TEXT;
    v_questions     JSONB;
    v_question      RECORD;
    v_question_key  TEXT;
    v_columns       TEXT[] := ARRAY['unique_id', 'created_at'];
    v_sql           TEXT;
    v_rows          JSONB;
    v_total         BIGINT;
BEGIN
    v_module_name := lower(trim(both from (p_json ->> 'module_name')));
    v_date_from   := NULLIF(p_json ->> 'date_from', '')::timestamptz;
    v_date_to     := NULLIF(p_json ->> 'date_to', '')::timestamptz;
    v_page        := COALESCE((p_json ->> 'page')::int, 1);
    v_page_size   := COALESCE((p_json ->> 'page_size')::int, 100);

    -- export_all comes from the API's ?is_download=true flag (see
    -- CampaignReportBLL.GetReport). When true, page/page_size are ignored
    -- end-to-end so a file download always contains the complete dataset.
    v_export_all  := COALESCE((p_json ->> 'export_all')::boolean, FALSE);

    IF v_page IS NULL OR v_page < 1 THEN
        v_page := 1;
    END IF;

    -- Defense in depth: the BLL already clamps page_size, but the procedure
    -- enforces the same cap so it is safe even if called directly. Skipped
    -- entirely for exports, since page_size is meaningless when every row is
    -- being returned.
    IF NOT v_export_all AND (v_page_size IS NULL OR v_page_size < 1 OR v_page_size > 1000) THEN
        v_page_size := 100;
    END IF;

    v_offset := (v_page - 1) * v_page_size;

    -- Full-export requests drop LIMIT/OFFSET from the inner SELECT altogether
    -- rather than substituting some very large limit, so there is no cap at all.
    IF v_export_all THEN
        v_limit_clause := '';
    ELSE
        v_limit_clause := format(' LIMIT %L OFFSET %L', v_page_size, v_offset);
    END IF;

    IF v_module_name IS NULL OR length(v_module_name) = 0 THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'module_name is required.');
        RETURN;
    END IF;

    SELECT *
    INTO v_campaign
    FROM labgt.labgt_ca_campaign_metadata
    WHERE lower(module_name) = v_module_name;

    IF NOT FOUND THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'Campaign is not configured.');
        RETURN;
    END IF;

    IF NOT v_campaign.report_enabled THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'Reporting is not enabled for this campaign.');
        RETURN;
    END IF;

    BEGIN
        -- ---- Build the dynamic column list from metadata. json_path and
        --      column_alias were validated against a strict identifier allow-list
        --      by the BLL at provisioning time (see ProvisionCampaignValidator),
        --      which is what makes assembling them into dynamic SQL here safe.
        --      column_alias is turned into a SQL identifier via format('%I', ...);
        --      json_path is embedded as a quoted literal via format('%L', ...) --
        --      never via naive string concatenation of arbitrary text. ----
        FOR v_field IN
            SELECT json_path, column_alias, data_type
            FROM labgt.labgt_ca_report_field_map
            WHERE campaign_metadata_id = v_campaign.id
            ORDER BY display_order
        LOOP
            v_cast_suffix := CASE v_field.data_type
                WHEN 'numeric'   THEN '::numeric'
                WHEN 'timestamp' THEN '::timestamptz'
                WHEN 'boolean'   THEN '::boolean'
                ELSE ''
            END;

            v_select_list := v_select_list || format(
                ', (s.submission_json -> ''fields'' ->> %L)%s AS %I',
                v_field.json_path,
                v_cast_suffix,
                v_field.column_alias
            );

            v_columns := array_append(v_columns, v_field.column_alias);
        END LOOP;

        -- submission_id is a standard column that always appears, positioned right
        -- after the report_fields columns and before the questionnaire columns (per
        -- the desired report layout: unique_id, created_at, <report fields>,
        -- submission_id, <question answers>).
        v_select_list := v_select_list || ', s.id AS submission_id';
        v_columns := array_append(v_columns, 'submission_id');

        -- ---- Append one column per configured questionnaire question (q1, q2, ...),
        --      pulled from submission_json -> 'questionnaire_answers' -> question_key.
        --      question_key was already validated against the same strict identifier
        --      allow-list as json_path/column_alias at provisioning time (see
        --      ProvisionCampaignValidator), so it is safe to use directly as a SQL
        --      identifier via format('%I', ...) here, same as the report_fields loop
        --      above. Columns appear in question order as configured at provisioning. ----
        IF v_campaign.questionnaire_enabled THEN
            SELECT questions
            INTO v_questions
            FROM labgt.labgt_ca_questionnaire_config
            WHERE campaign_metadata_id = v_campaign.id;

            IF v_questions IS NOT NULL THEN
                FOR v_question IN
                    SELECT value AS q FROM jsonb_array_elements(v_questions) WITH ORDINALITY AS arr(value, ord)
                    ORDER BY ord
                LOOP
                    v_question_key := v_question.q ->> 'question_key';

                    IF v_question_key IS NOT NULL AND length(v_question_key) > 0 THEN
                        v_select_list := v_select_list || format(
                            ', (s.submission_json -> ''questionnaire_answers'' ->> %L) AS %I',
                            v_question_key,
                            v_question_key
                        );

                        v_columns := array_append(v_columns, v_question_key);
                    END IF;
                END LOOP;
            END IF;
        END IF;

        -- ---- unique_id/created_at are the fixed leading columns; submission_id and
        --      every metadata-driven column (report_fields, then questionnaire
        --      answers) are appended above, in that order, inside v_select_list.
        --      Date range and pagination are bound as real parameters ($1/$2),
        --      never string-concatenated. ----
        v_sql := format(
            'SELECT jsonb_agg(row_to_json(t)) AS rows,
                    (SELECT count(*) FROM labgt.labgt_ca_submission
                      WHERE campaign_metadata_id = %L
                        AND ($1 IS NULL OR created_at >= $1)
                        AND ($2 IS NULL OR created_at <= $2)) AS total_count
             FROM (
                 SELECT s.unique_id, s.created_at%s
                 FROM labgt.labgt_ca_submission s
                 WHERE s.campaign_metadata_id = %L
                   AND ($1 IS NULL OR s.created_at >= $1)
                   AND ($2 IS NULL OR s.created_at <= $2)
                 ORDER BY s.created_at DESC%s
             ) t',
            v_campaign.id, v_select_list, v_campaign.id, v_limit_clause
        );

        EXECUTE v_sql INTO v_rows, v_total USING v_date_from, v_date_to;

        -- 'columns' is the AUTHORITATIVE, ordered column list. jsonb never preserves
        -- object key order (it's canonicalized -- shortest key name first, then
        -- alphabetically -- regardless of the SELECT order above), so 'rows' alone
        -- cannot be trusted for column ordering. The CSV exporter (and any other
        -- consumer that cares about column order) must render columns using THIS
        -- array, not by enumerating a row object's own properties.
        p_result_json := jsonb_build_object(
            'status', 1,
            'data', jsonb_build_object(
                'rows', COALESCE(v_rows, '[]'::jsonb),
                'columns', to_jsonb(v_columns),
                'total_count', COALESCE(v_total, 0),
                'page', CASE WHEN v_export_all THEN 1 ELSE v_page END,
                'page_size', CASE WHEN v_export_all THEN COALESCE(v_total, 0) ELSE v_page_size END
            )
        );

    EXCEPTION WHEN OTHERS THEN
        p_result_json := jsonb_build_object('status', 0, 'message', 'Report generation failed: ' || SQLERRM);
    END;
END;
$_$;


--
