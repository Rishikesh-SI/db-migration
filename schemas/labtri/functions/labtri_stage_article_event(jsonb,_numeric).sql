-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_stage_article_event(jsonb, numeric)
-- Type: FUNCTION

-- Name: labtri_stage_article_event(jsonb, numeric); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_stage_article_event(p_json jsonb, p_flag numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id                  bigint;
    v_articleid           numeric;
    v_status              varchar(1000);
    v_content_source_id   numeric;
    v_title               varchar(4000);
    v_title_alias         varchar(4000);
    v_shorttitle          varchar(2000);
    v_article_meta        jsonb;
    v_article_desc        text;
    v_author_id           numeric;
    v_category_id         numeric;
    v_partnerid           numeric;
    v_showinweb           numeric;
    v_showinmobile        numeric;
    v_showinapp           numeric;
    v_published_version_number numeric;
    v_articleurl          varchar(4000);
    v_is_trashed          numeric;
    v_created_date        timestamp;
    v_updated_date        timestamp;
    v_created_by          numeric;
    v_updated_by          numeric;
    v_is_active           numeric;
    v_is_deleted          numeric;
    v_is_published        numeric;
    v_article_guid        varchar(256);
    v_published_date      timestamp;
    v_show_copyright      numeric;
    v_content_source_link varchar(4000);
    v_order_number        numeric;
    v_image_id            numeric;
    v_slug_url            varchar(4000);
    v_checked_out_by      numeric;
    v_checked_out_date    timestamp;
    v_azure_id            numeric;
    v_ref_article_guid    varchar;
    v_ref_article_id      numeric;
    v_seodataid           numeric;
    v_seodataguid         uuid;
    v_asset_list_id       numeric;
    v_json                jsonb := p_json;
    v_operation           varchar(100);

BEGIN
    -- Log the input for debugging
    INSERT INTO siwaf.siwaf_client_logs(api_error_log_id, log_method_name, log_error_message, log_guid, error_json, created_date, client_name, log_type)
    VALUES (nextval('siwaf.seq_siwaf_api_error_log_id'), 'stage_article_process', 'logs', uuid_generate_v4(), p_json, current_timestamp, 'labtri', 'logs');

    -- Extract input from JSON
    IF p_flag = 1 THEN
        SELECT
            (p_json->'data'->>'article_id'),
            (p_json->'data'->>'content_source_id'),
            (p_json->'data'->>'title'),
            (p_json->'data'->>'slug_url'),
            (p_json->'data'->>'short_title'),
            (p_json->'data'->'article_meta'),
            (p_json->'data'->>'article_desc'),
            (p_json->'data'->>'author_id'),
            (p_json->'data'->>'category_id'),
            (p_json->'data'->>'partner_id'),
            (p_json->'data'->>'show_in_web'),
            (p_json->'data'->>'show_in_mobile'),
            (p_json->'data'->>'show_in_app'),
            (p_json->'data'->>'published_version_number'),
            p_json->'data'->>'article_url',
            (p_json->'data'->>'is_trashed'),
            (p_json->'data'->>'created_date'),
            (p_json->'data'->>'updated_date'),
            (p_json->'data'->>'created_by'),
            (p_json->'data'->>'updated_by'),
            (p_json->'data'->>'is_active'),
            (p_json->'data'->>'is_deleted'),
            (p_json->'data'->>'is_published'),
            p_json->'data'->>'article_guid',
            (p_json->'data'->>'published_date'),
            (p_json->'data'->>'show_copyright'),
            p_json->'data'->>'content_source_link',
            (p_json->'data'->>'order_number'),
            (p_json->'data'->>'image_id'),
            p_json->'data'->>'slug_url',
            (p_json->'data'->>'checked_out_by'),
            (p_json->'data'->>'checked_out_date'),
            (p_json->'data'->>'azure_id'),
            p_json->'data'->>'ref_article_guid',
            (p_json->'data'->>'ref_article_id')
        INTO
            v_articleid,
            v_content_source_id,
            v_title,
            v_title_alias,
            v_shorttitle,
            v_article_meta,
            v_article_desc,
            v_author_id,
            v_category_id,
            v_partnerid,
            v_showinweb,
            v_showinmobile,
            v_showinapp,
            v_published_version_number,
            v_articleurl,
            v_is_trashed,
            v_created_date,
            v_updated_date,
            v_created_by,
            v_updated_by,
            v_is_active,
            v_is_deleted,
            v_is_published,
            v_article_guid,
            v_published_date,
            v_show_copyright,
            v_content_source_link,
            v_order_number,
            v_image_id,
            v_slug_url,
            v_checked_out_by,
            v_checked_out_date,
            v_azure_id,
            v_ref_article_guid,
            v_ref_article_id;

        -- If article_id is null, generate new IDs and insert
        IF v_articleid IS NULL THEN
            v_articleid       := nextval('labtri.seq_labtri_article_id');
            v_article_guid     := uuid_generate_v4();
            v_seodataid        := nextval('labtri.seq_labtri_seo_data_id');
            v_seodataguid      := uuid_generate_v4();
            v_asset_list_id    := nextval('labtri.seq_labtri_asset_list_id');
            v_id               := nextval('labtri.seq_labtri_id');
            v_operation        := 'Insertion';
            v_status           := 'pending';

            INSERT INTO labtri.labtri_article_process_log (
                id, article_id, status, content_source_id, title, title_alias, short_title, article_meta, article_desc,
                author_id, category_id, partner_id, show_in_web, show_in_mobile, show_in_app, published_version_number,
                article_url, is_trashed, created_date, updated_date, created_by, updated_by, is_active,
                is_deleted, is_published, article_guid, published_date, show_copyright, content_source_link,
                order_number, image_id, slug_url, checked_out_by, checked_out_date, azure_id,
                ref_article_guid, ref_article_id, payload
            )
            VALUES (
                v_id, v_articleid, v_status, v_content_source_id, v_title, v_title_alias, v_shorttitle, v_article_meta, v_article_desc,
                v_author_id, v_category_id, v_partnerid, v_showinweb, v_showinmobile, v_showinapp, v_published_version_number,
                v_articleurl, v_is_trashed, v_created_date, v_updated_date, v_created_by, v_updated_by, v_is_active,
                v_is_deleted, v_is_published, v_article_guid, v_published_date, v_show_copyright, v_content_source_link,
                v_order_number, v_image_id, v_slug_url, v_checked_out_by, v_checked_out_date, v_azure_id,
                v_ref_article_guid, v_ref_article_id, v_json
            );

            IF v_articleid IS NOT NULL THEN
                v_json := jsonb_set(v_json, '{data,article_id}', to_jsonb(v_articleid), 'true');
            END IF;

            p_result := 1;
            p_data := v_json;
        END IF;

    ELSIF p_flag = 0 THEN
        SELECT
            p_json->>'proc_id'
        INTO
            v_id;

        IF EXISTS (
            SELECT 1 FROM labtri.labtri_article_process_log
            WHERE id = v_id
        ) THEN
            SELECT article_id, title_alias, created_date, updated_date, payload, status, 'Updated'
            INTO v_articleid, v_title_alias, v_created_date, v_updated_date, v_json, v_status, v_operation
            FROM labtri.labtri_article_process_log
            WHERE id = v_id;

            UPDATE labtri.labtri_article_process_log
            SET
                status = 'processed',
                title_alias = v_title_alias,
                published_version_number = v_published_version_number,
                article_url = v_articleurl,
                updated_date = v_updated_date,
                payload = v_json
            WHERE
                id = v_id;

            p_result := 1;
            p_data := '{"status":"Status updated to processed"}';
        END IF;
    END IF;

    -- Audit log
    INSERT INTO labtri.labtri_article_ingestion_audit(
        article_id, title_alias, created_date, updated_date,
        payload, status, operation, processed_at
    )
    VALUES (
        v_articleid, v_title_alias, v_created_date, v_updated_date, v_json,
        v_status, v_operation, current_date
    );

END;
$$;


--
