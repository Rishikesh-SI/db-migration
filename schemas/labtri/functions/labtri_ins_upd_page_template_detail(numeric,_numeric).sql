-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_ins_upd_page_template_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labtri_ins_upd_page_template_detail(numeric, numeric); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_ins_upd_page_template_detail(p_template_id numeric, p_page_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare

v_page_id         labtri.labtri_page.page_id%type;
v_alias           labtri.labtri_page.alias%type;
v_title           labtri.labtri_page.title%type;
v_page_level      labtri.labtri_page.page_level%type;
v_upfront         labtri.labtri_page.upfront%type;
v_upfront_app     labtri.labtri_page.upfront_app%type;
v_upfront_mobile  labtri.labtri_page.upfront_mobile%type;
v_is_wrapper      labtri.labtri_page.is_wrapper%type;
v_page_parent_id  labtri.labtri_page.parent_id%type;
v_visible         labtri.labtri_page.visible%type;
v_visible_app     labtri.labtri_page.visible_app%type;
v_visible_mobile  labtri.labtri_page.visible_mobile%type;
v_scheduled_publish labtri.labtri_page.scheduled_publish%type;
v_scheduled_unpublish labtri.labtri_page.scheduled_unpublish%type;
v_ordering        labtri.labtri_page.ordering%type;
v_title_mobile    labtri.labtri_page.title_mobile%type;
v_title_app       labtri.labtri_page.title_app%type;
v_is_redirect     labtri.labtri_page.is_redirect%type;
v_published_version_number labtri.labtri_page.published_version_number%type;
v_created_date    labtri.labtri_page.created_date%type;
v_updated_date    labtri.labtri_page.updated_date%type;
v_created_by      labtri.labtri_page.created_by%type;
v_updated_by      labtri.labtri_page.updated_by%type;
v_is_active       labtri.labtri_page.is_active%type;
v_is_deleted      labtri.labtri_page.is_deleted%type;
v_status          labtri.labtri_page.is_published%type;
v_page_guid       labtri.labtri_page.page_guid%type;

v_template_id     labtri.labtri_template.template_id%type;
v_template_name   labtri.labtri_template.template_name%type;
v_template_desc   labtri.labtri_template.template_desc%type;
v_layout_id       labtri.labtri_template.layout_id%type;
v_is_inherited    labtri.labtri_template.is_inherited%type;
v_template_parent_id labtri.labtri_template.parent_id%type;
v_template_guid   labtri.labtri_template.template_guid%type;
v_json            jsonb;
v_sysdate         timestamp;
v_is_responsive   labtri.labtri_template.is_responsive%type;
v_mobile_html     labtri.labtri_template.mobile_html%type;

-- entity variables
v_entityjson      json;
v_entity          json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type numeric := 11;

-- template variables
v_templatejson jsonb;
v_img_ret numeric;
v_img_ret_data jsonb;
v_t_layout_id numeric;
v_t_template_name varchar(2000);
v_t_parent_id numeric;

v_page_template_json jsonb;
v_seojson          jsonb;
v_seodataid        numeric;
v_seodataguid      varchar(200);

v_asset_type_id numeric;
v_is_custom numeric;
v_is_required numeric;
v_custom_alias character varying ;
v_ent_role_map_id numeric;
v_is_amp numeric;

v_meta_info jsonb;
v_is_update numeric;
v_page_alias     labtri.labtri_page.alias%TYPE;
v_page_data_json jsonb;
v_mob_flag numeric;
v_mob_page_data_json jsonb;
V_page_template_name varchar(4000);
V_template_html text;
v_parent_template_id numeric;
i numeric;

begin

-- Debugging: Check if p_page_id is passed
RAISE NOTICE 'Starting function with p_page_id: %', p_page_id;

if p_page_id is not null then
    v_page_id := p_page_id;

    -- Debugging: Check if v_page_id is set
    RAISE NOTICE 'Fetched v_page_id: %', v_page_id;

    -- Fetch template data
    select parent_id, template_name, template_html, mobile_html, is_responsive
    from labtri.labtri_template
    where page_id = p_page_id
    into v_template_id, V_page_template_name, V_template_html, V_mobile_html, v_is_responsive;

    -- Debugging: Check template data fetched
    RAISE NOTICE 'v_template_id: %, V_page_template_name: %, V_template_html: %, V_mobile_html: %', v_template_id, V_page_template_name, V_template_html, V_mobile_html;

    -- Check if template_id is valid before proceeding
    if v_template_id is null then
        RAISE NOTICE 'No template found for page_id: %, skipping further processing.', v_page_id;
        p_result := 0;  -- Set result as 0 if template is not found
        return;
    end if;

    -- Fetch page-specific data
    select is_amp, alias, is_deleted, is_published
    from labtri.labtri_page
    where page_id = v_page_id
    into v_is_amp, v_page_alias, v_is_deleted, v_status;

    -- Debugging: Check page data
    RAISE NOTICE 'v_is_amp: %, v_page_alias: %, v_is_deleted: %, v_status: %', v_is_amp, v_page_alias, v_is_deleted, v_status;

    -- Check if responsive template
    if v_is_responsive is not null and v_is_responsive = 0 then
        execute 'select * from labtri.labtri_get_page_data_by_service_r
                  (''{
                      "inputs": {
                          "p_url": "",
                          "v_service_page_id": ' || v_page_id || ',
                          "is_mobile": 1,
                          "is_amp": "' || v_is_amp || '",
                          "listing_page_no": "1",
                          "search_key": {
                              "search_text": null,
                              "entity_id": null,
                              "page_number": null
                          }
                      }
                  }'')'
        into v_mob_page_data_json;

        RAISE NOTICE 'Fetched mobile page data for v_page_id: %', v_page_id;
    end if;

    execute 'select * from labtri.labtri_get_page_data_by_service_r
              (''{
                  "inputs": {
                      "p_url": "",
                      "v_service_page_id": ' || v_page_id || ',
                      "is_mobile": 0,
                      "is_amp": "' || v_is_amp || '",
                      "listing_page_no": "1",
                      "search_key": {
                          "search_text": null,
                          "entity_id": null,
                          "page_number": null
                      }
                  }
              }'')'
    into v_page_data_json;

    RAISE NOTICE 'Fetched page data for v_page_id: %', v_page_id;

    -- Clear existing template detail for this page
    delete from labtri.labtri_page_template_detail
    where page_id = v_page_id;

    -- Insert new template details
    insert into labtri.labtri_page_template_detail
    select nextval('labtri.seq_labtri_page_template_detail_id'),
           v_page_id, v_page_alias, v_template_id, V_page_template_name, 
           V_template_html, v_page_data_json, 1, current_timestamp, current_timestamp,
           v_mobile_html, v_mob_page_data_json, v_is_responsive, 0, v_is_amp, 
           coalesce(v_is_deleted, 0), v_status;

    RAISE NOTICE 'Inserted template details for v_page_id: %', v_page_id;

end if;

-- If template_id is passed, process for pages under the template
if p_template_id is not null then
    v_template_id := p_template_id;

    -- Debugging: Check if template_id is passed
    RAISE NOTICE 'Processing pages for template_id: %', v_template_id;

    for i in (select page_id from labtri.labtri_template
              where parent_id = v_template_id
                and is_published = 1) loop
        v_page_id := i;

        -- Debugging: Check the page_id in the loop
        RAISE NOTICE 'Processing template for page_id: %', v_page_id;

        select parent_id, template_name, template_html, mobile_html, is_responsive
        from labtri.labtri_template
        where page_id = v_page_id
        into v_template_id, V_page_template_name, V_template_html,
             V_mobile_html, v_is_responsive;

        RAISE NOTICE 'v_template_id: %, V_page_template_name: %', v_template_id, V_page_template_name;

        select is_responsive
        from labtri.labtri_template
        where template_id = v_template_id
        into v_is_responsive;

        select is_amp, alias, is_deleted, is_published
        from labtri.labtri_page
        where page_id = v_page_id
        into v_is_amp, v_page_alias, v_is_deleted, v_status;

        -- Debugging: Check page and template data
        RAISE NOTICE 'v_is_amp: %, v_page_alias: %, v_is_deleted: %, v_status: %', v_is_amp, v_page_alias, v_is_deleted, v_status;
raise notice 'v_is_amp%', v_is_amp;

        if v_is_responsive is not null and v_is_responsive = 0 then
            execute 'select * from labtri.labtri_get_page_data_by_service_r
                      (''{
                          "inputs": {
                              "p_url": "",
                              "v_service_page_id": ' || v_page_id || ',
                              "is_mobile": 1,
                              "is_amp": "' || COALESCE(v_is_amp,0 )|| '",
                              "listing_page_no": "1",
                              "search_key": {
                                  "search_text": null,
                                  "entity_id": null,
                                  "page_number": null
                              }
                          }
                      }'')'
            into v_mob_page_data_json;

            RAISE NOTICE 'Fetched mobile page data for v_page_id: %', v_page_id;
        end if;

        execute 'select * from labtri.labtri_get_page_data_by_service_r
                  (''{
                      "inputs": {
                          "p_url": "",
                          "v_service_page_id": ' || v_page_id || ',
                          "is_mobile": 0,
                          "is_amp": "' || v_is_amp || '",
                          "listing_page_no": "1",
                          "search_key": {
                              "search_text": null,
                              "entity_id": null,
                              "page_number": null
                          }
                      }
                  }'')'
        into v_page_data_json;

        RAISE NOTICE 'Fetched page data for v_page_id: %', v_page_id;

       
        delete from labtri.labtri_page_template_detail
        where page_id = v_page_id;

        -- Insert new template details
        insert into labtri.labtri_page_template_detail
        select nextval('labtri.seq_labtri_page_template_detail_id'),
               v_page_id, v_page_alias, p_template_id, V_page_template_name, 
               V_template_html, v_page_data_json, 1, current_timestamp, current_timestamp,
               v_mobile_html, v_mob_page_data_json, v_is_responsive, 0, v_is_amp, 
               coalesce(v_is_deleted, 0), v_status;

        RAISE NOTICE 'Inserted template details for v_page_id: %', v_page_id;
    end loop;
end if;

-- Return result
p_result := 1;

END;
$$;


--
