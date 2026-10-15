-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_user_asset_reaction_r_neww(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_user_asset_reaction_r_neww(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_user_asset_reaction_r_neww(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_asset_reaction_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
DECLARE
    v_user_guid            varchar(100);
    v_asset_id             numeric[];
    v_asset_type_id        numeric[];
    v_is_detail            numeric;
    v_page_number          numeric;
    v_item_number          numeric;
    v_limit                numeric;
    v_offset               numeric;
    v_user_id              numeric;
    v_client_user_id       numeric;
BEGIN
    /* ===========================
       INPUT PARSING
    ============================ */
    SELECT
        p_json->>'user_guid',
        string_to_array(p_json->>'asset_id', ',')::numeric[],
        string_to_array(p_json->>'asset_type_id', ',')::numeric[],
        (p_json->>'is_detail')::numeric,
        (p_json->>'page_number')::numeric,
        (p_json->>'item_number')::numeric
    INTO
        v_user_guid,
        v_asset_id,
        v_asset_type_id,
        v_is_detail,
        v_page_number,
        v_item_number;

    v_offset := (v_page_number - 1) * v_item_number;
    v_limit  := v_item_number;

    /* ===========================
       USER CONTEXT
    ============================ */
    IF v_user_guid IS NOT NULL THEN
        EXECUTE format(
            'SELECT user_id FROM %I.%I_web_user WHERE user_guid = $1',
            p_schema_prefix, p_schema_prefix
        )
        INTO v_user_id
        USING v_user_guid;
    END IF;

    SELECT source_value
    INTO v_client_user_id
    FROM siwaf.siwaf_client_comment_source_map
    WHERE client_code = p_schema_prefix
      AND source_id = 1;

    /* ============================================================
       NON DETAIL MODE (is_detail = 0)
    ============================================================ */
    IF v_is_detail = 0 THEN

        EXECUTE format($SQL$
        WITH asset_list AS (
            SELECT
                unnest($1::numeric[]) AS asset_id,
                unnest($2::numeric[]) AS asset_type_id
        ),

        asset_counts AS (
            SELECT
                uar.asset_id,
                uar.asset_type_id,
                COUNT(*) FILTER (WHERE reaction_id <> 4) AS reactions_count,
                COUNT(*) FILTER (WHERE reaction_id = 4 AND parent_comment_id IS NULL) AS comments_count
            FROM %I.%I_user_asset_reaction uar
            JOIN asset_list al
              ON al.asset_id = uar.asset_id
             AND al.asset_type_id = uar.asset_type_id
            GROUP BY uar.asset_id, uar.asset_type_id
        ),

        user_asset_reaction AS (
            SELECT
                asset_id,
                asset_type_id,
                reaction_id
            FROM %I.%I_user_asset_reaction
            WHERE reaction_id <> 4
              AND user_id = COALESCE($3,0)
        ),

        comments AS (
            SELECT DISTINCT ON (uar.asset_id, uar.asset_type_id)
                uar.user_asset_reaction_id AS comment_id,
                uar.asset_id,
                uar.asset_type_id,
                uar.user_id,
                uar.comment_text,
                uar.reaction_date
            FROM %I.%I_user_asset_reaction uar
            JOIN asset_list al
              ON al.asset_id = uar.asset_id
             AND al.asset_type_id = uar.asset_type_id
            WHERE uar.reaction_id = 4
              AND uar.parent_comment_id IS NULL
            ORDER BY uar.asset_id, uar.asset_type_id, uar.reaction_date DESC
        ),

        comment_reaction_counts AS (
            SELECT
                comment_id,
                COUNT(*) AS reactions_count
            FROM %I.%I_asset_comment_reaction
            GROUP BY comment_id
        ),

        comment_user_reaction AS (
            SELECT
                comment_id,
                reaction_id
            FROM %I.%I_asset_comment_reaction
            WHERE user_id = COALESCE($3,0)
        ),

        reply_counts AS (
            SELECT
                parent_comment_id AS comment_id,
                COUNT(*) AS total_replies
            FROM %I.%I_user_asset_reaction
            GROUP BY parent_comment_id
        ),

        latest_reply AS (
            SELECT DISTINCT ON (parent_comment_id)
                parent_comment_id,
                user_asset_reaction_id,
                user_id,
                comment_text,
                reaction_date
            FROM %I.%I_user_asset_reaction
            WHERE parent_comment_id IS NOT NULL
            ORDER BY parent_comment_id, reaction_date DESC
        ),

        spam AS (
            SELECT DISTINCT comment_id, reported_by, 1 AS is_spam
            FROM %I.%I_comment_spam
        )

        SELECT jsonb_build_object(
            'data',
            jsonb_agg(
                jsonb_build_object(
                    'asset_id', al.asset_id,
                    'asset_type_id', al.asset_type_id,
                    'reactions_count', COALESCE(ac.reactions_count,0),
                    'comments_count', COALESCE(ac.comments_count,0),
                    'user_reaction', COALESCE(uar.reaction_id,0),
                    'comments',
                        CASE WHEN c.comment_id IS NULL THEN NULL ELSE
                        jsonb_build_array(
                            jsonb_build_object(
                                'comment_id', c.comment_id,
                                'comment_text', c.comment_text,
                                'reaction_date', c.reaction_date,
                                'reactions_count', COALESCE(crc.reactions_count,0),
                                'user_reaction', COALESCE(cur.reaction_id,0),
                                'total_replies', COALESCE(rc.total_replies,0),
                                'latest_reply',
                                    CASE WHEN lr.user_asset_reaction_id IS NULL THEN NULL ELSE
                                    jsonb_build_array(
                                        jsonb_build_object(
                                            'comment_id', lr.user_asset_reaction_id,
                                            'comment_text', lr.comment_text,
                                            'reaction_date', lr.reaction_date
                                        )
                                    ) END,
                                'is_spam', COALESCE(s.is_spam,0)
                            )
                        ) END
                )
            )
        )
        FROM asset_list al
        LEFT JOIN asset_counts ac
               ON ac.asset_id = al.asset_id
              AND ac.asset_type_id = al.asset_type_id
        LEFT JOIN user_asset_reaction uar
               ON uar.asset_id = al.asset_id
              AND uar.asset_type_id = al.asset_type_id
        LEFT JOIN comments c
               ON c.asset_id = al.asset_id
              AND c.asset_type_id = al.asset_type_id
        LEFT JOIN comment_reaction_counts crc ON crc.comment_id = c.comment_id
        LEFT JOIN comment_user_reaction cur ON cur.comment_id = c.comment_id
        LEFT JOIN reply_counts rc ON rc.comment_id = c.comment_id
        LEFT JOIN latest_reply lr ON lr.parent_comment_id = c.comment_id
        LEFT JOIN spam s ON s.comment_id = c.comment_id AND s.reported_by = COALESCE($3,0)
        $SQL$,
        p_schema_prefix, p_schema_prefix,
        p_schema_prefix, p_schema_prefix,
        p_schema_prefix, p_schema_prefix,
        p_schema_prefix, p_schema_prefix,
        p_schema_prefix, p_schema_prefix,
        p_schema_prefix, p_schema_prefix,
        p_schema_prefix, p_schema_prefix,
        p_schema_prefix, p_schema_prefix
        )
        INTO p_asset_reaction_json
        USING v_asset_id, v_asset_type_id, v_user_id;

    END IF;

    /* ===========================
       FINAL OUTPUT
    ============================ */
    IF p_asset_reaction_json IS NOT NULL THEN
        p_result := 1;
    ELSE
        p_result := 0;
        p_asset_reaction_json := '{"data":[]}'::jsonb;
    END IF;

END;
$_$;


--
