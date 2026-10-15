-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_stage_video_event(jsonb)
-- Type: FUNCTION

-- Name: labuww_stage_video_event(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_stage_video_event(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_videoid         varchar(4000);
    v_status          varchar(2000);
    v_content_source_id numeric;
    v_title           varchar(4000);
    v_title_alias     varchar(4000);
    v_shorttitle      varchar(2000);
    v_video_meta      jsonb;
    v_video_desc      text;
    v_duration        varchar(1000);
    v_partnerid       numeric;
    v_showinweb       numeric;
    v_showinmobile    numeric;
    v_showinapp       numeric;
    v_published_version_number numeric;
    v_videourl        varchar(4000);
    v_is_trashed      numeric;
    v_created_date    timestamp;
    v_updated_date    timestamp;
    v_created_by      numeric;
    v_updated_by      numeric;
    v_is_active       numeric;
    v_is_deleted      numeric;
    v_is_published    numeric;
    v_video_guid      varchar(256);
    v_published_date  timestamp;
    v_show_copyright  numeric;
    v_content_source_link varchar(4000);
    v_order_number    numeric;
    v_image_id        numeric;
    v_slug_url        varchar(4000);
    v_checked_out_by  numeric;
    v_checked_out_date timestamp;
    v_hls_url         varchar(4000);
    v_azure_id        numeric;
    v_ref_video_guid  varchar;
    v_ref_video_id    numeric;
    

   
    v_videoguid       uuid;
    v_seodataid       numeric;
    v_seodataguid     uuid;
    v_asset_list_id   numeric;
    v_json            jsonb := p_json;
BEGIN
    -- Extract input from JSON
    SELECT 
        (p_json->'data'->>'video_id'),
        (p_json->'data'->>'status'),
        (p_json->'data'->>'content_source_id'),
        p_json->'data'->>'title',
        p_json->'data'->>'title_alias',
        p_json->'data'->>'short_title',
        p_json->'data'->'video_meta',
        p_json->'data'->>'video_desc',
        p_json->'data'->>'duration',
        (p_json->'data'->>'partner_id'),
        (p_json->'data'->>'show_in_web'),
        (p_json->'data'->>'show_in_mobile'),
        (p_json->'data'->>'show_in_app'),
        (p_json->'data'->>'published_version_number'),
        p_json->'data'->>'video_url',
        (p_json->'data'->>'is_trashed'),
        (p_json->'data'->>'created_date'),
        (p_json->'data'->>'updated_date'),
        (p_json->'data'->>'created_by'),
        (p_json->'data'->>'updated_by'),
        (p_json->'data'->>'is_active'),
        (p_json->'data'->>'is_deleted'),
        (p_json->'data'->>'is_published'),
        p_json->'data'->>'video_guid',
        (p_json->'data'->>'published_date'),
        (p_json->'data'->>'show_copyright'),
        p_json->'data'->>'content_source_link',
        (p_json->'data'->>'order_number'),
        (p_json->'data'->>'image_id'),
        p_json->'data'->>'slug_url',
        (p_json->'data'->>'checked_out_by'),
        (p_json->'data'->>'checked_out_date'),
        p_json->'data'->>'hls_url',
        (p_json->'data'->>'azure_id'),
        p_json->'data'->>'ref_video_guid',
        (p_json->'data'->>'ref_video_id')
    INTO
        v_videoid, 
        v_status,
        v_content_source_id, 
        v_title,
        v_title_alias, 
        v_shorttitle,
        v_video_meta,
        v_video_desc, 
        v_duration, 
        v_partnerid,
        v_showinweb,
        v_showinmobile, 
        v_showinapp,
        v_published_version_number,
        v_videourl,
        v_is_trashed, 
        v_created_date, 
        v_updated_date,
        v_created_by,
        v_updated_by,
        v_is_active, 
        v_is_deleted,
        v_is_published,
        v_video_guid,
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
        v_ref_video_guid,
        v_ref_video_id;

    
    IF NOT EXISTS (
    SELECT 1 FROM labuww.labuww_video_process_log
    WHERE video_guid = v_video_guid OR title_alias = v_title_alias
	) THEN
        v_videoid       := nextval('labuww.seq_labuww_video_id');
        v_videoguid     := uuid_generate_v4();
        v_seodataid     := nextval('labuww.seq_labuww_seo_data_id');
        v_seodataguid   := uuid_generate_v4();
        v_asset_list_id := nextval('labuww.seq_labuww_asset_list_id');

        -- Update JSON with generated guid
        v_json := jsonb_set(v_json, '{data,guid}', to_jsonb(v_videoguid::text), true);
    END IF;
	
    -- Insert
    INSERT INTO labuww.labuww_video_process_log (
        video_id, status, content_source_id, title, title_alias, short_title, video_meta, video_desc,
        duration, partner_id, show_in_web, show_in_mobile, show_in_app, published_version_number,
        video_url, is_trashed, created_date, updated_date, created_by, updated_by, is_active,
        is_deleted, is_published, video_guid, published_date, show_copyright, content_source_link,
        order_number, image_id, slug_url, checked_out_by, checked_out_date, hls_url, azure_id,
        ref_video_guid, ref_video_id, payload
    )
    VALUES (
        v_videoid, 'pending', v_content_source_id, v_title, v_title_alias, v_shorttitle, v_video_meta, v_video_desc,
        v_duration, v_partnerid, v_showinweb, v_showinmobile, v_showinapp, v_published_version_number,
        v_videourl, v_is_trashed, v_created_date, v_updated_date, v_created_by, v_updated_by, v_is_active,
        v_is_deleted, v_is_published, v_videoguid, v_published_date, v_show_copyright, v_content_source_link,
        v_order_number, v_image_id, v_slug_url, v_checked_out_by, v_checked_out_date, v_hls_url, v_azure_id,
        v_ref_video_guid, v_ref_video_id, v_json
    );

-- Update status
		UPDATE labuww.labuww_video_process_log
		SET status = v_status
		WHERE title_alias = v_title_alias
		  AND created_date = v_created_date;


    -- Output
    p_result := 1;
    p_data := jsonb_set(v_json, '{status}', to_jsonb(v_status), true);

EXCEPTION
    WHEN OTHERS THEN
        p_result := -1;
        p_data := jsonb_build_object(
            
            'payload', v_json
        );
END;
$$;


--
