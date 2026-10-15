-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_stage_video_event(jsonb, numeric)
-- Type: FUNCTION

-- Name: labuww_stage_video_event(jsonb, numeric); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_stage_video_event(p_json jsonb, p_flag numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_id			  bigint;
    v_videoid         numeric;
    v_status          varchar(1000);
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

    v_seodataid       numeric;
    v_seodataguid     uuid;
    v_asset_list_id   numeric;
    v_json            jsonb := p_json;
	v_operation		varchar(100);
	v_processing_status varchar(100);
	 
	
BEGIN

-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'stage_video_SP','logs',uuid_generate_v4(),p_json,current_timestamp,'labuww','logs');
   
   -- Extract input from JSON
	if p_flag=1 then
    SELECT
        (p_json->'data'->>'video_id'),
       -- (p_json->'data'->>'status'),
        (p_json->'data'->>'content_source_id'),
        (p_json->'data'->>'title'),
        (p_json->'data'->>'slug_url'),
        (p_json->'data'->>'short_title'),
        (p_json->'data'->'video_meta'),
        (p_json->'data'->>'video_desc'),
        (p_json->'data'->>'duration'),
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
        --v_status,
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
        v_ref_video_id
		;
	
	
	raise notice '1st step';
    if v_videoid is null THEN
        
        v_videoid       := nextval('labuww.seq_labuww_video_id');
        v_video_guid     := uuid_generate_v4();
        v_seodataid     := nextval('labuww.seq_labuww_seo_data_id');
        v_seodataguid   := uuid_generate_v4();
        v_asset_list_id := nextval('labuww.seq_labuww_asset_list_id');
      	v_id			:= nextval('labuww.seq_labuww_id');
--         v_json := jsonb_set(v_json, '{data,guid}', to_jsonb(v_video_guid::text), true);
		v_operation		:= 'Insertion';
		v_status 		:='pending';
		v_updated_date := current_timestamp;
		
		raise notice 'v_videoid %',v_videoid;
		
        INSERT INTO labuww.labuww_video_process_log (
           	id, video_id,status, content_source_id, title, title_alias, short_title, video_meta, video_desc,
            duration, partner_id, show_in_web, show_in_mobile, show_in_app, published_version_number,
            video_url, is_trashed, created_date, updated_date, created_by, updated_by, is_active,
            is_deleted, is_published, video_guid, published_date, show_copyright, content_source_link,
            order_number, image_id, slug_url, checked_out_by, checked_out_date, hls_url, azure_id,
            ref_video_guid, ref_video_id, payload
        )
        VALUES (
            v_id,v_videoid,v_status, v_content_source_id, v_title, v_title_alias, v_shorttitle, v_video_meta, v_video_desc,
            v_duration, v_partnerid, v_showinweb, v_showinmobile, v_showinapp, v_published_version_number,
            v_videourl, v_is_trashed, v_created_date, v_updated_date, v_created_by, v_updated_by, v_is_active,
            v_is_deleted, v_is_published, v_video_guid, v_published_date, v_show_copyright, v_content_source_link,
            v_order_number, v_image_id, v_slug_url, v_checked_out_by, v_checked_out_date, v_hls_url, v_azure_id,
            v_ref_video_guid, v_ref_video_id, v_json
        );
			
-- 		select video_id into v_videoid from labuww.labuww_video where ref_video_id = v_ref_video_id limit 1; 

		if v_videoid is not null then 
 		v_json := jsonb_set(v_json,'{data,video_id}',to_jsonb(v_videoid),'true');
		end if;
		p_result := 1;
  	 	p_data := v_json;
	end if;
	
	raise notice '11.v_videoid %',v_videoid;
	
    ELSIF p_flag = 0 THEN
   
    SELECT
        p_json->>'proc_id',
        p_json->>'processing_status'
    INTO
        v_id,
        v_processing_status;

    RAISE NOTICE 'Processing ID: %, Status: %', v_id, v_processing_status;

   
    IF EXISTS (
        SELECT 1 FROM labuww.labuww_video_process_log
        WHERE id = v_id
    ) THEN
        
        SELECT
            video_id,
            title_alias,
			video_url,
            created_date,
            updated_date,
            payload,
            status
        INTO
            v_videoid,
            v_title_alias,
			v_videourl,
            v_created_date,
            v_updated_date,
            v_json,
            v_status
        FROM labuww.labuww_video_process_log
        WHERE id = v_id;

      
        IF v_processing_status = 'Success' THEN
            v_status := 'processed';
            p_data := '{"status":"Status updated to processed"}';
        ELSIF v_processing_status = 'Failed' THEN
            v_status := 'Failed';
            p_data := '{"status":"Status updated to Failed"}';
        END IF;

        -- Update the record
        UPDATE labuww.labuww_video_process_log
        SET
            status = v_status,
            title_alias = v_title_alias,
            published_version_number = v_published_version_number,
            --video_url = v_videourl,
            updated_date = v_updated_date,
            payload = v_json
        WHERE id = v_id;

        p_result := 1;
    END IF;
END IF;

raise notice '2.v_videoid %',v_videoid;

  INSERT INTO labuww.labuww_video_ingestion_audit(
           video_id, title_alias,  created_date, updated_date,
           payload, status,operation, processed_at
      )
      VALUES (
         v_videoid,  v_title_alias, v_created_date, v_updated_date, v_json,
           v_status,v_operation, current_date
      );

		
END;
$$;


--
