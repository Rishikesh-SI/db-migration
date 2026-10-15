-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_ins_upd_page(jsonb)
-- Type: FUNCTION

-- Name: ttmum_ins_upd_page(jsonb); Type: FUNCTION; Schema: ttmum; Owner: -
--

CREATE FUNCTION ttmum.ttmum_ins_upd_page(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare 

V_page_id        				ttmum.ttmum_page.page_id%TYPE;
V_alias        					ttmum.ttmum_page.alias%TYPE;
V_title        					ttmum.ttmum_page.title%TYPE;
V_page_level        			ttmum.ttmum_page.page_level%TYPE;
V_upfront        				ttmum.ttmum_page.upfront%TYPE;
V_upfront_app        			ttmum.ttmum_page.upfront_app%TYPE;
V_upfront_mobile        		ttmum.ttmum_page.upfront_mobile%TYPE;
V_is_wrapper        			ttmum.ttmum_page.is_wrapper%TYPE;
V_page_parent_id        	    ttmum.ttmum_page.parent_id%TYPE;
V_visible        				ttmum.ttmum_page.visible%TYPE;
V_visible_app       	 		ttmum.ttmum_page.visible_app%TYPE;
V_visible_mobile        		ttmum.ttmum_page.visible_mobile%TYPE;
V_scheduled_publish        		ttmum.ttmum_page.scheduled_publish%TYPE;
V_scheduled_unpublish        	ttmum.ttmum_page.scheduled_unpublish%TYPE;
V_ordering        				ttmum.ttmum_page.ordering%TYPE;
V_title_mobile        			ttmum.ttmum_page.title_mobile%TYPE;
V_title_app        				ttmum.ttmum_page.title_app%TYPE;
V_is_redirect        			ttmum.ttmum_page.is_redirect%TYPE;
V_published_version_number      ttmum.ttmum_page.published_version_number%TYPE;
V_created_date        			ttmum.ttmum_page.created_date%TYPE;
V_updated_date        			ttmum.ttmum_page.updated_date%TYPE;
V_created_by        			ttmum.ttmum_page.created_by%TYPE;
V_updated_by        			ttmum.ttmum_page.updated_by%TYPE;
V_is_active        				ttmum.ttmum_page.is_active%TYPE;
V_is_deleted        			ttmum.ttmum_page.is_deleted%TYPE;
V_status        			ttmum.ttmum_page.is_published%TYPE;
V_page_guid        				ttmum.ttmum_page.page_guid%TYPE;

V_template_id        			ttmum.ttmum_template.template_id%TYPE;
V_template_name        			ttmum.ttmum_template.template_name%TYPE;
V_template_desc        			ttmum.ttmum_template.template_desc%TYPE;
V_layout_id        				ttmum.ttmum_template.layout_id%TYPE;
V_is_inherited        			ttmum.ttmum_template.is_inherited%TYPE;
V_template_parent_id            ttmum.ttmum_template.parent_id%TYPE;
V_template_guid        			ttmum.ttmum_template.template_guid%TYPE;
v_json							jsonb;
v_sysdate						timestamp;
v_is_responsive ttmum.ttmum_template.is_responsive%type;
v_mobile_html  ttmum.ttmum_template.mobile_html%type;

--  ENTITY VARIABLES
v_entityjson json;
v_entity json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type numeric:=11;

-- template variables
v_templatejson jsonb;
v_img_ret numeric;
v_img_ret_data jsonb;
v_t_layout_id numeric;
v_t_template_name varchar(2000);
v_t_parent_id numeric;

v_page_template_json jsonb;

begin

      select current_timestamp at time zone 'utc'
      into   v_sysdate;
      -------------------------------------------------------
      
      v_json := p_json;
      -------------------------------------------------------
      select    v_json->'data'->>'page_id',
                v_json->'data'->>'alias',
                v_json->'data'->>'title',
                v_json->'data'->>'page_level',
                v_json->'data'->>'upfront',
                v_json->'data'->>'upfront_app',
                v_json->'data'->>'upfront_mobile',
                v_json->'data'->>'is_wrapper',
                v_json->'data'->>'parent_id',
                v_json->'data'->>'visible',
                v_json->'data'->>'visible_app',
                v_json->'data'->>'visible_mobile',
                COALESCE((v_json->'data'->>'scheduled_publish')::TIMESTAMP,v_sysdate)::TIMESTAMP,
                COALESCE((v_json->'data'->>'scheduled_unpublish')::TIMESTAMP,v_sysdate)::TIMESTAMP, 
                v_json->'data'->>'ordering',
                v_json->'data'->>'title_mobile',
                v_json->'data'->>'title_app',
                v_json->'data'->>'is_redirect',
                v_json->'data'->>'version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'status',
                v_json->'data'->>'guid'                

     into       V_page_id,
                V_alias,
                V_title,
                V_page_level,
                V_upfront,
                V_upfront_app,
                V_upfront_mobile,
                V_is_wrapper,
                V_page_parent_id,
                V_visible,
                V_visible_app,
                V_visible_mobile,
                V_scheduled_publish,
                V_scheduled_unpublish,
                V_ordering,
                V_title_mobile,
                V_title_app,
                V_is_redirect,
                V_published_version_number,
                V_updated_by,
                V_status,
                V_page_guid;
                
    
    --------------------------------------------------------------------------------------------------------
    IF (V_page_id  is null )
    THEN
		
        /***
        Insert page information
        ***/
        
        V_page_guid    	 := uuid_generate_v4();	
        V_page_id        := nextval('ttmum.seq_ttmum_page_id');
        v_json 	         := jsonb_set(v_json, '{data,page_id}', v_page_id::text::jsonb, true);
        v_json 	         := jsonb_set(v_json, '{data,page_guid}', ('"'||v_page_guid||'"')::text::jsonb, true);
          
          INSERT INTO ttmum.ttmum_PAGE
          (
          page_id,ALIAS, title, page_level, upfront, upfront_app, upfront_mobile, is_wrapper, parent_id,
          visible, visible_app, visible_mobile, scheduled_publish, scheduled_unpublish, ordering, 
          title_mobile, title_app, is_redirect, published_version_number, created_date, updated_date, 
          created_by, updated_by, is_active, is_deleted, is_published, page_guid
          )    
          VALUES
          (
          V_page_id, V_alias, V_title, V_page_level, V_upfront, V_upfront_app, V_upfront_mobile, 
          V_is_wrapper, V_page_parent_id, V_visible, V_visible_app, V_visible_mobile, V_scheduled_publish,
          V_scheduled_unpublish, V_ordering, V_title_mobile, V_title_app, V_is_redirect, V_published_version_number,
          v_sysdate, v_sysdate, V_updated_by, V_updated_by, 1, 0, V_status, V_page_guid
        );    
         
        select v_json->'data'->'templatedata'
        into   v_templatejson;   
        select v_json->'data'->'templatedata'->'data'->>'layout_id',
               v_json->'data'->'templatedata'->'data'->>'template_name',
               v_json->'data'->'templatedata'->'data'->>'parent_id',
               v_json->'data'->'templatedata'->'data'->>'is_responsive',
               v_json->'data'->'templatedata'->'data'->>'mobile_html'
        into   v_t_layout_id,v_t_template_name,v_t_parent_id, v_is_responsive, v_mobile_html ;
        
        if v_templatejson is not null and v_t_layout_id is not null then
             SELECT S.p_result INTO v_img_ret  
             FROM ttmum.ttmum_ins_upd_template  
                    (0, v_templatejson) S;
        end if;
          raise notice '%',1111;
        v_page_template_json:='{
                                "data": {
                                  "template_id": null,
                                  "template_name": "'||V_title||'-' || v_t_template_name||'" ,
                                  "template_desc": "Template Desc",
                                  "version_number": "1",
                                  "updated_by": "'||V_updated_by||'",
                                  "status": "'||V_status||'",
                                  "guid": null,
                                  "is_master": "0",
                                  "layout_id": null,
                                  "is_inherited": "1",
                                  "parent_id": "'||COALESCE(v_t_parent_id,v_img_ret)||'",
                                  "template_html": "some html",
                                  "componentdata": null,
                                  "is_responsive":"'||v_is_responsive||'", 
                                  "mobile_html":"'||v_mobile_html||'"
                                }
                              }';
                            
          raise notice '%',2222;
          raise notice '%',v_page_template_json;
          
        SELECT S.p_result INTO v_img_ret  
             FROM ttmum.ttmum_ins_upd_template  
                    (V_page_id, v_page_template_json) S;
    END IF;
    
    --  ENTITY DATA---     
                     DELETE FROM ttmum.ttmum_asset_entity_map 
                     WHERE ASSET_TYPE_ID=v_asset_type
                     AND ASSET_ID=V_page_id;
                     
                     select v_json->'data'->>'entitydata'
                         into   v_entityjson;

                        if v_entityjson is not null then

                         for v_entity in select * from json_array_elements(v_entityjson)
                           loop
  
                           select v_entity->>'entity_role_map_id',
                                  v_entity->>'priority',
                                  v_entity->>'is_linkable',
                                  v_entity->>'is_visible'
                           into   v_entityrolemapid,
                                  v_priority,
                                  v_islinkable,
                                  v_isvisible;

                      if (v_entityrolemapid is not null and v_priority is not null) then

                           v_assetentitymapid   := nextval('ttmum.seq_ttmum_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();

                           insert into ttmum.ttmum_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid)
                          values(v_assetentitymapid, V_page_id, v_asset_type, 
                          v_entityrolemapid, COALESCE(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                          1, v_assetentitymapguid);
                       END IF;
                      END LOOP;
                    END IF;
              -- ENTITY DATA -- 
      p_result:=v_img_ret;        
      p_data := v_json;

END;

$$;


--
