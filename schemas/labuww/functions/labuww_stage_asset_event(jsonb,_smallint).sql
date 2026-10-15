-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_stage_asset_event(jsonb, smallint)
-- Type: FUNCTION

-- Name: labuww_stage_asset_event(jsonb, smallint); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_stage_asset_event(p_json jsonb, p_flag smallint, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id bigint;
    v_asset_id numeric;
    v_status varchar(1000);
    v_content_source_id numeric;
    v_title varchar(4000);
    v_title_alias varchar(4000);
    v_short_title varchar(2000);
    v_meta_data jsonb;
    v_description text;
    v_author_id numeric;
    v_category_id numeric;
    v_partner_id numeric;
    v_show_in_web numeric;
    v_show_in_mobile numeric;
    v_show_in_app numeric;
    v_published_version_number numeric;
    v_asset_url varchar(4000);
    v_is_trashed numeric;
    v_created_date timestamp;
    v_updated_date timestamp;
    v_created_by numeric;
    v_updated_by numeric;
    v_is_active numeric;
    v_is_deleted numeric;
    v_is_published numeric;
    v_asset_guid varchar(256);
    v_published_date timestamp;
    v_show_copyright numeric;
    v_content_source_link varchar(4000);
    v_order_number numeric;
    v_image_id numeric;
    v_slug_url varchar(4000);
    v_checked_out_by numeric;
    v_checked_out_date timestamp;
    v_hls_url varchar(4000);
    v_azure_id numeric;
    v_ref_asset_guid varchar;
    v_ref_asset_id numeric;
    v_asset_type numeric;
    v_operation varchar(100);
    v_json jsonb := p_json;
	v_processing_status varchar(100);
BEGIN
    
--     INSERT INTO siwaf.siwaf_client_logs(api_error_log_id, log_method_name, log_error_message, log_guid, error_json, created_date, client_name, log_type)
--     VALUES (nextval('siwaf.seq_siwaf_api_error_log_id'), 'stage_asset_process', 'logs', uuid_generate_v4(), p_json, current_timestamp, 'labuww', 'logs');

    -- Extract asset_type from JSON
    v_asset_type := (p_json->'data'->>'asset_type');

    
    IF p_flag = 1 THEN
        SELECT
            (p_json->'data'->>'asset_id'),
            (p_json->'data'->>'status'),
            (p_json->'data'->>'content_source_id'),
            (p_json->'data'->>'title'),
            (p_json->'data'->>'title_alias'),
            (p_json->'data'->>'short_title'),
            (p_json->'data'->'meta_data'),
            (p_json->'data'->>'description'),
            (p_json->'data'->>'author_id'),
            (p_json->'data'->>'category_id'),
            (p_json->'data'->>'partner_id'),
            (p_json->'data'->>'show_in_web'),
            (p_json->'data'->>'show_in_mobile'),
            (p_json->'data'->>'show_in_app'),
            (p_json->'data'->>'published_version_number'),
            (p_json->'data'->>'asset_url'),
            (p_json->'data'->>'is_trashed'),
            (p_json->'data'->>'created_date'),
            (p_json->'data'->>'updated_date'),
            (p_json->'data'->>'created_by'),
            (p_json->'data'->>'updated_by'),
            (p_json->'data'->>'is_active'),
            (p_json->'data'->>'is_deleted'),
            (p_json->'data'->>'is_published'),
            (p_json->'data'->>'asset_guid'),
            (p_json->'data'->>'published_date'),
            (p_json->'data'->>'show_copyright'),
            (p_json->'data'->>'content_source_link'),
            (p_json->'data'->>'order_number'),
            (p_json->'data'->>'image_id'),
            (p_json->'data'->>'slug_url'),
            (p_json->'data'->>'checked_out_by'),
            (p_json->'data'->>'checked_out_date'),
            (p_json->'data'->>'hls_url'),
            (p_json->'data'->>'azure_id'),
            (p_json->'data'->>'ref_asset_guid'),
            (p_json->'data'->>'ref_asset_id')
        INTO
            v_asset_id,
            v_status,
            v_content_source_id,
            v_title,
            v_title_alias,
            v_short_title,
            v_meta_data,
            v_description,
            v_author_id,
            v_category_id,
            v_partner_id,
            v_show_in_web,
            v_show_in_mobile,
            v_show_in_app,
            v_published_version_number,
            v_asset_url,
            v_is_trashed,
            v_created_date,
            v_updated_date,
            v_created_by,
            v_updated_by,
            v_is_active,
            v_is_deleted,
            v_is_published,
            v_asset_guid,
            v_published_date,
            v_show_copyright,
            v_content_source_link,
            v_order_number,
            v_image_id,
            v_slug_url,
            v_checked_out_by,
            v_checked_out_date,
            v_hls_url,
            v_azure_id,
            v_ref_asset_guid,
            v_ref_asset_id;

        -- If asset_id is null, generate new IDs and insert
        IF v_asset_id IS NULL THEN
            v_asset_id   := nextval('labuww.seq_labuww_asset_id');
            v_asset_guid := uuid_generate_v4();
            v_id         := nextval('labuww.seq_labuww_id');
            v_operation  := 'Insertion';
            v_status     := 'pending';
			v_updated_date := current_timestamp;
            
        
            IF v_created_date IS NULL THEN v_created_date := current_timestamp; END IF;
            v_updated_date := current_timestamp;

            INSERT INTO labuww.labuww_asset_process_log (
                id, asset_id, asset_type, status, title, title_alias, short_title, meta_data, description,
                author_id, category_id, partner_id, show_in_web, show_in_mobile, show_in_app, published_version_number,
                asset_url, is_trashed, created_date, updated_date, created_by, updated_by, is_active,
                is_deleted, is_published, asset_guid, published_date, show_copyright, content_source_link,
                order_number, image_id, slug_url, checked_out_by, checked_out_date, hls_url, azure_id,
                ref_asset_guid, ref_asset_id, payload, content_source_id
            )
            VALUES (
                v_id, v_asset_id, v_asset_type, v_status, v_title, v_title_alias, v_short_title, v_meta_data, v_description,
                v_author_id, v_category_id, v_partner_id, v_show_in_web, v_show_in_mobile, v_show_in_app, v_published_version_number,
                v_asset_url, v_is_trashed, v_created_date, v_updated_date, v_created_by, v_updated_by, v_is_active,
                v_is_deleted, v_is_published, v_asset_guid, v_published_date, v_show_copyright, v_content_source_link,
                v_order_number, v_image_id, v_slug_url, v_checked_out_by, v_checked_out_date, v_hls_url, v_azure_id,
                v_ref_asset_guid, v_ref_asset_id, v_json, v_content_source_id
            );

            v_json := jsonb_set(v_json, '{data,asset_id}', to_jsonb(v_asset_id), true);

            p_result := 1;
            p_data   := v_json;
        END IF; 

    -- FLAG 0: Process Status Update
    ELSIF p_flag = 0 THEN
       SELECT
        p_json->>'proc_id',
        p_json->>'processing_status'
    INTO
        v_id,
        v_processing_status;

        IF EXISTS (
            SELECT 1
            FROM labuww.labuww_asset_process_log
            WHERE id = v_id
        ) THEN
            SELECT asset_id, title_alias, created_date, updated_date, payload, status, 'Updated'
            INTO v_asset_id, v_title_alias, v_created_date, v_updated_date, v_json, v_status, v_operation
            FROM labuww.labuww_asset_process_log
            WHERE id = v_id;
            
			IF v_processing_status = 'Success' THEN
            v_status := 'processed';
            p_data := '{"status":"Status updated to processed"}';
        ELSIF v_processing_status = 'Failed' THEN
            v_status := 'Failed';
            p_data := '{"status":"Status updated to Failed"}';
        END IF;
          
            
            UPDATE labuww.labuww_asset_process_log
            SET
                status = v_status,
                title_alias = v_title_alias,
                published_version_number = v_published_version_number,
                
                updated_date = v_updated_date,
                payload = v_json
            WHERE id = v_id;

            p_result := 1;
        END IF;

    END IF; 

   
    IF v_asset_id IS NOT NULL THEN
        INSERT INTO labuww.labuww_asset_ingestion_audit(
            asset_id, asset_type, title_alias, created_date, updated_date,
            payload, status, operation, processed_at
        )
        VALUES (
            v_asset_id, v_asset_type, v_title_alias, v_created_date, v_updated_date, v_json,
            v_status, v_operation, current_date
        );
    END IF;

    RETURN;
END;
$$;


--
