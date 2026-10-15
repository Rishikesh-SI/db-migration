-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_ins_upd_page(jsonb)
-- Type: FUNCTION

-- Name: jafc_ins_upd_page(jsonb); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_ins_upd_page(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare 

v_page_id        				jafc.jafc_page.page_id%type;
v_alias        					jafc.jafc_page.alias%type;
v_title        					jafc.jafc_page.title%type;
v_page_level        			jafc.jafc_page.page_level%type;
v_upfront        				jafc.jafc_page.upfront%type;
v_upfront_app        			jafc.jafc_page.upfront_app%type;
v_upfront_mobile        		jafc.jafc_page.upfront_mobile%type;
v_is_wrapper        			jafc.jafc_page.is_wrapper%type;
v_page_parent_id        	    jafc.jafc_page.parent_id%type;
v_visible        				jafc.jafc_page.visible%type;
v_visible_app       	 		jafc.jafc_page.visible_app%type;
v_visible_mobile        		jafc.jafc_page.visible_mobile%type;
v_scheduled_publish        		jafc.jafc_page.scheduled_publish%type;
v_scheduled_unpublish        	jafc.jafc_page.scheduled_unpublish%type;
v_ordering        				jafc.jafc_page.ordering%type;
v_title_mobile        			jafc.jafc_page.title_mobile%type;
v_title_app        				jafc.jafc_page.title_app%type;
v_is_redirect        			jafc.jafc_page.is_redirect%type;
v_published_version_number      jafc.jafc_page.published_version_number%type;
v_created_date        			jafc.jafc_page.created_date%type;
v_updated_date        			jafc.jafc_page.updated_date%type;
v_created_by        			jafc.jafc_page.created_by%type;
v_updated_by        			jafc.jafc_page.updated_by%type;
v_is_active        				jafc.jafc_page.is_active%type;
v_is_deleted        			jafc.jafc_page.is_deleted%type;
v_status        			jafc.jafc_page.is_published%type;
v_page_guid        				jafc.jafc_page.page_guid%type;

v_template_id        			jafc.jafc_template.template_id%type;
v_template_name        			jafc.jafc_template.template_name%type;
v_template_desc        			jafc.jafc_template.template_desc%type;
v_layout_id        				jafc.jafc_template.layout_id%type;
v_is_inherited        			jafc.jafc_template.is_inherited%type;
v_template_parent_id            jafc.jafc_template.parent_id%type;
v_template_guid        			jafc.jafc_template.template_guid%type;
v_json							jsonb;
v_sysdate						timestamp;
v_is_responsive jafc.jafc_template.is_responsive%type;
v_mobile_html  jafc.jafc_template.mobile_html%type;

--  entity variables
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
                coalesce((v_json->'data'->>'scheduled_publish')::timestamp,v_sysdate)::timestamp,
                coalesce((v_json->'data'->>'scheduled_unpublish')::timestamp,v_sysdate)::timestamp, 
                v_json->'data'->>'ordering',
                v_json->'data'->>'title_mobile',
                v_json->'data'->>'title_app',
                v_json->'data'->>'is_redirect',
                v_json->'data'->>'version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'status',
                v_json->'data'->>'guid'                

     into       v_page_id,
                v_alias,
                v_title,
                v_page_level,
                v_upfront,
                v_upfront_app,
                v_upfront_mobile,
                v_is_wrapper,
                v_page_parent_id,
                v_visible,
                v_visible_app,
                v_visible_mobile,
                v_scheduled_publish,
                v_scheduled_unpublish,
                v_ordering,
                v_title_mobile,
                v_title_app,
                v_is_redirect,
                v_published_version_number,
                v_updated_by,
                v_status,
                v_page_guid;
                
    
    --------------------------------------------------------------------------------------------------------
    if (v_page_id  is null )
    then
		
        /***
        insert page information
        ***/
        
        v_page_guid    	 := uuid_generate_v4();	
        v_page_id        := nextval('jafc.seq_jafc_page_id');
        v_json 	         := jsonb_set(v_json, '{data,page_id}', v_page_id::text::jsonb, true);
        v_json 	         := jsonb_set(v_json, '{data,page_guid}', ('"'||v_page_guid||'"')::text::jsonb, true);
          
          insert into jafc.jafc_page
          (
          page_id,alias, title, page_level, upfront, upfront_app, upfront_mobile, is_wrapper, parent_id,
          visible, visible_app, visible_mobile, scheduled_publish, scheduled_unpublish, ordering, 
          title_mobile, title_app, is_redirect, published_version_number, created_date, updated_date, 
          created_by, updated_by, is_active, is_deleted, is_published, page_guid
          )    
          values
          (
          v_page_id, v_alias, v_title, v_page_level, v_upfront, v_upfront_app, v_upfront_mobile, 
          v_is_wrapper, v_page_parent_id, v_visible, v_visible_app, v_visible_mobile, v_scheduled_publish,
          v_scheduled_unpublish, v_ordering, v_title_mobile, v_title_app, v_is_redirect, v_published_version_number,
          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, v_status, v_page_guid
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
             select s.p_result into v_img_ret  
             from jafc.jafc_ins_upd_template  
                    (0, v_templatejson) s;
        end if;
          raise notice '%',1111;
        v_page_template_json:='{
                                "data": {
                                  "template_id": null,
                                  "template_name": "'||v_title||'-' || v_t_template_name||'" ,
                                  "template_desc": "template desc",
                                  "version_number": "1",
                                  "updated_by": "'||v_updated_by||'",
                                  "status": "'||v_status||'",
                                  "guid": null,
                                  "is_master": "0",
                                  "layout_id": null,
                                  "is_inherited": "1",
                                  "parent_id": "'||coalesce(v_t_parent_id,v_img_ret)||'",
                                  "template_html": "some html",
                                  "componentdata": null,
                                  "is_responsive":"'||v_is_responsive||'", 
                                  "mobile_html":"'||v_mobile_html||'"
                                }
                              }';
                            
          raise notice '%',2222;
          raise notice '%',v_page_template_json;
          
        select s.p_result into v_img_ret  
             from jafc.jafc_ins_upd_template  
                    (v_page_id, v_page_template_json) s;
    end if;
    
    --  entity data---     
                     delete from jafc.jafc_asset_entity_map 
                     where asset_type_id=v_asset_type
                     and asset_id=v_page_id;
                     
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

                           v_assetentitymapid   := nextval('jafc.seq_jafc_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();

                           insert into jafc.jafc_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid)
                          values(v_assetentitymapid, v_page_id, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                          1, v_assetentitymapguid);
                       end if;
                      end loop;
                    end if;
              -- entity data -- 
      p_result:=v_img_ret;        
      p_data := v_json;

end;

$$;


--
