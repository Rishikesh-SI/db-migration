-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_ins_upd_page_by_directus(jsonb)
-- Type: FUNCTION

-- Name: labbg_ins_upd_page_by_directus(jsonb); Type: FUNCTION; Schema: labbg; Owner: -
--

CREATE FUNCTION labbg.labbg_ins_upd_page_by_directus(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare  
    v_page_id                       labbg.labbg_page.page_id%TYPE;
    v_alias                         labbg.labbg_page.alias%TYPE;
    v_title                         labbg.labbg_page.title%TYPE;
    v_status                        labbg.labbg_page.is_published%TYPE;
    v_page_guid                     labbg.labbg_page.page_guid%TYPE; 
    v_scheduled_publish             labbg.labbg_page.scheduled_publish%TYPE;
    v_scheduled_unpublish           labbg.labbg_page.scheduled_unpublish%TYPE;
    v_created_date                  labbg.labbg_page.created_date%TYPE;
    v_updated_date                  labbg.labbg_page.updated_date%TYPE;
    v_created_by                    labbg.labbg_page.created_by%TYPE;
    v_updated_by                    labbg.labbg_page.updated_by%TYPE;
    v_is_active                     labbg.labbg_page.is_active%TYPE;
    v_is_deleted                    labbg.labbg_page.is_deleted%TYPE;
    v_title_app                     labbg.labbg_page.title_app%TYPE;
    v_title_mobile                  labbg.labbg_page.title_mobile%TYPE;
	v_parent_page_alias                text;

    v_ref_page_id                   numeric;
    v_published_version_number      numeric;
    v_asset_id                      numeric;
    v_seo_data_id                   numeric;
    v_seo_data_guid                 uuid;

    v_entity_data                   jsonb;
    v_seojson                       jsonb;
    v_meta_info                     jsonb;
    v_sysdate                       timestamp;
    v_show_in_sitemap               numeric;
    v_entityjson                    jsonb;
    v_required_entities             numeric[];

    v_entity_role_map_id            numeric;
    v_asset_type_id                 numeric;
    v_asset_entity_map_id           numeric;
    v_aemap_guid                    uuid;
	v_page_parent_id				numeric;
	
    
    -- template
    v_unique_id                     text;       
    v_template_unique_id           text;       
    v_template_id                   numeric;    
    v_template_name                 text := 'Mapper Template'; 

begin
    select current_timestamp at time zone 'utc' into v_sysdate;

	select 
        p_json->'data'->>'ref_page_id',
        p_json->'data'->>'alias',
        p_json->'data'->>'page_name',
        (case when p_json->'data'->>'is_published' = 'published' then 1 else 0 end),
        coalesce((p_json->'data'->>'scheduled_publish')::timestamp, v_sysdate),
        coalesce((p_json->'data'->>'scheduled_unpublish')::timestamp, v_sysdate),
        p_json->'data'->>'guid',
        p_json->'data'->'seo',
        p_json->'data'->'meta_info'
    into 
        v_ref_page_id,
        v_alias,
        v_title,
        v_status,
        v_scheduled_publish,
        v_scheduled_unpublish,
        v_page_guid,
        v_seojson,
        v_meta_info;

		
      raise notice '1. v_meta_info:%',v_meta_info;
		
    
    -- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
    -- log_error_message,log_guid,error_json,created_date,client_name,log_type)
    -- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-labbg_ins_upd_page_by_directus','logs',uuid_generate_v4(),p_json,current_timestamp,'labbg','logs');

    v_asset_type_id := 11;
   
    v_is_active := case when p_json->'data'->>'is_active' = 'true' then 1 else 0 end;
    v_is_deleted := case when p_json->'data'->>'is_deleted' = 'true' then 1 else 0 end;

    v_title_app := v_title;
    v_title_mobile := v_title;

    v_show_in_sitemap := case 
                            when p_json->'data'->>'show_in_sitemap' = 'true' then 1
                            when p_json->'data'->>'show_in_sitemap' = 'false' then 0
                            else null   end;

    select p_json->'data'->>'entitydata' into v_entityjson;

    select obj.value->>'entity_role_map_id' into v_entity_role_map_id
    from jsonb_array_elements(v_entityjson::jsonb) obj(value)
    where obj.value->>'is_lang' = '1';
    
    -- template logic
	
		v_template_id := 23723;  
		  
		
		select template_name into v_unique_id
		from labbg.labbg_template
		where template_id = 23723 ;

		v_template_unique_id := v_title || '-' || v_unique_id;
		
		
		select p_json->'data'->>'parent_page_id' into v_parent_page_alias;
		
		select page_id INTO v_page_parent_id
		from labbg.labbg_page
		where alias =v_parent_page_alias ;
		

	
	raise notice 'v_template_unique_id %',v_template_unique_id;
	raise notice 'v_status %',v_status;
--insertion started

    if not exists (select 1 from labbg.labbg_page 
                   where ref_page_id = v_ref_page_id and alias = v_alias) then
				   
        -- Insert logic when page does not exist
        v_aemap_guid := uuid_generate_v4();
        v_asset_entity_map_id := nextval('labbg.seq_labbg_asset_entity_map_id');
        v_seo_data_id := nextval('labbg.seq_labbg_seo_data_id');
        v_seo_data_guid := uuid_generate_v4();
        v_page_id := nextval('labbg.seq_labbg_page_id');
        v_asset_id := v_page_id;
        v_page_guid := uuid_generate_v4();
        v_published_version_number := 1;
		v_template_id := nextval('labbg.seq_labbg_template_id');
		
		insert into labbg.labbg_asset_entity_map(
            asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, 
            is_linkable, is_visible, priority, created_date, updated_date, 
            created_by, updated_by, is_active, is_deleted, is_published, 
            aemap_guid, is_required, order_number) 
        values (
            v_asset_entity_map_id, v_asset_id, v_asset_type_id, v_entity_role_map_id, 
            0, 0, 1, v_sysdate, v_sysdate, 1, 1, 1, 0, 1, v_aemap_guid, 1, null);

        -- Insert into labbg.labbg_seo_data
		
        insert into labbg.labbg_seo_data(
            seo_data_id, asset_id, asset_type_id, meta_info, 
            published_version_number, created_date, updated_date, 
            created_by, updated_by, is_active, is_deleted, is_published, 
            seo_data_guid) 
        values (
            v_seo_data_id, v_asset_id, v_asset_type_id, v_meta_info, 
            v_published_version_number, v_sysdate, v_sysdate, 1, 1, 1, 0, 1, v_seo_data_guid);
			
raise notice '2. v_meta_info:%',v_meta_info;
        -- Insert into labbg.labbg_page
		
       insert into labbg.labbg_page (
        page_id, alias, title, is_published, page_guid, meta_info, 
        show_in_sitemap, is_active, is_deleted, created_date, updated_date,
        ref_page_id, scheduled_publish, scheduled_unpublish, ordering, 
        created_by, updated_by, page_level, upfront, upfront_app, upfront_mobile,
        is_wrapper, parent_id, visible, visible_app, visible_mobile, is_redirect, is_custom_menu,
        published_version_number, title_app, title_mobile, required_entities,asset_type_id
    ) 
    values (
        v_page_id, v_alias, v_title, v_status, v_page_guid, v_seojson, 
        v_show_in_sitemap, v_is_active, v_is_deleted, v_sysdate, v_sysdate,
        v_ref_page_id, v_scheduled_publish, v_scheduled_unpublish, 0, 
        1, 1, 0, 0, 0, 0, 0, v_page_parent_id, 0, 0, 0, 0, 0, v_published_version_number, 
        v_title_app, v_title_mobile, array[v_entity_role_map_id],38
    );
        
        -- Insert into labbg.labbg_template
        insert into labbg.labbg_template (
            template_id, page_id, template_name, template_desc, layout_id, 
            is_inherited, parent_id, published_version_number, created_date, 
            updated_date, created_by, updated_by, is_active, is_deleted, 
            is_published, template_guid, is_master, template_html, 
            is_responsive, mobile_html, use_default_bg_color, use_default_bg_image, 
            bg_color, bg_image_id
        )
        values (
            v_template_id, v_page_id,  v_template_unique_id, 'Template Description', null,  
            1, 23723, 1, v_sysdate, v_sysdate, 1, 1, v_is_active, v_is_deleted, 
            case when v_is_active = 0 then 0 else 1 end, uuid_generate_v4(),  
            0, null, null, null, null, null, null,null
        );
		
		
        
    else
        -- Update logic if page exists
        select page_id into v_asset_id from labbg.labbg_page 
        where ref_page_id = v_ref_page_id and alias = v_alias; 

        -- Update labbg.labbg_asset_entity_map
        update labbg.labbg_asset_entity_map
        set entity_role_map_id = v_entity_role_map_id		
        where asset_id = v_asset_id and asset_type_id = v_asset_type_id;

        -- Update SEO data
        update labbg.labbg_seo_data
        set 
        meta_info = v_seojson,
        published_version_number = coalesce(v_published_version_number, 0) + 1
        where asset_id = v_asset_id and asset_type_id = v_asset_type_id;

        select published_version_number into v_published_version_number 
        from labbg.labbg_page 
        where ref_page_id = v_ref_page_id and alias = v_alias;

        -- Update template
        update labbg.labbg_template
        set 
            is_active = v_is_active,
            is_deleted = v_is_deleted,
            updated_date = v_sysdate,
            is_published = case when v_is_active = 0 then 0 else is_published end  
        where template_id = v_template_id;

		raise notice '3. v_ref_page_id -:%',v_ref_page_id;
		raise notice '3. v_alias -:%',v_alias;
		
        -- Update labbg.labbg_page
        update labbg.labbg_page
        set 
            alias = v_alias,
            title = v_title,
            is_published = v_status,
            meta_info = v_meta_info,
            show_in_sitemap = v_show_in_sitemap,
            is_active = v_is_active,
            is_deleted = v_is_deleted,
            updated_date = v_sysdate,
            scheduled_publish = v_scheduled_publish,
            scheduled_unpublish = v_scheduled_unpublish,
            title_app = v_title_app,
            title_mobile = v_title_mobile,
			parent_id=v_page_parent_id,
			asset_type_id=38,
            required_entities = array[v_entity_role_map_id],
            published_version_number = coalesce(v_published_version_number, 0) + 1
        where ref_page_id = v_ref_page_id and alias = v_alias;
		
		
		
    end if;

         raise notice '4. v_meta_info:%',v_meta_info;

    p_result := 1;
    p_data := jsonb_build_object(
        'id', v_page_id,
        'slug', v_alias,
        'title', v_title,
        'status', case when v_status = 1 then 'published' else 'unpublished' end,
        'show_in_sitemap', case when v_show_in_sitemap = 1 then true else false end
    );
	      --raise notice '5. v_meta_info:%',v_meta_info;

    return;
end;
$$;


--
