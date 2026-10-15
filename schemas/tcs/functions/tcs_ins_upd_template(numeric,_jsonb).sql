-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_ins_upd_template(numeric, jsonb)
-- Type: FUNCTION

-- Name: tcs_ins_upd_template(numeric, jsonb); Type: FUNCTION; Schema: tcs; Owner: -
--

CREATE FUNCTION tcs.tcs_ins_upd_template(p_page_id numeric, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$    

declare

v_json 								jsonb;
V_template_id        			    tcs.tcs_template.template_id%TYPE;

V_template_name        				tcs.tcs_template.template_name%TYPE;
V_template_desc        				tcs.tcs_template.template_desc%TYPE;
v_page_id							tcs.tcs_template.page_id%type;
v_layout_id							tcs.tcs_template.layout_id%type;
v_parent_id							tcs.tcs_template.parent_id%type;
v_is_inherited							tcs.tcs_template.is_inherited%type;
V_published_version_number        	tcs.tcs_template.published_version_number%TYPE:=1;
V_created_date        				tcs.tcs_template.created_date%TYPE;
V_updated_date        				tcs.tcs_template.updated_date%TYPE;
V_created_by        				tcs.tcs_template.created_by%TYPE;
V_updated_by        				tcs.tcs_template.updated_by%TYPE;
V_is_active        					tcs.tcs_template.is_active%TYPE;
V_is_deleted        				tcs.tcs_template.is_deleted%TYPE;
V_is_published        				tcs.tcs_template.is_published%TYPE;
V_template_guid        				tcs.tcs_template.template_guid%TYPE;
v_master_id						tcs.tcs_template.is_master%type;

v_sysdate 							 timestamp;
V_is_master                             numeric;
V_master_template_id                    numeric;
V_template_html        				tcs.tcs_layout.layout_html%TYPE;

V_version_number numeric;
v_status numeric;
v_guid varchar(256);

v_componentjson json;
v_componentdata json;
v_is_responsive tcs.tcs_template.is_responsive%type;
v_mobile_html  tcs.tcs_template.mobile_html%type;

-- template component variables
v_co_template_component_map_id numeric;
v_co_component_id numeric;
v_co_title VARCHAR(500);
v_co_display_title VARCHAR(500);
v_co_title_mobile VARCHAR(500);
v_co_title_app VARCHAR(500);
v_co_show_in_web NUMERIC;
v_co_show_in_mobile NUMERIC;
v_co_show_in_app NUMERIC;
v_co_fetch_from NUMERIC;
v_co_parent_container_id VARCHAR(256); 
v_co_meta json;

-- child component variables
v_childcomponentjson json;
v_childcomponentdata json;

v_coc_template_component_map_id numeric;
v_coc_component_id numeric;
v_coc_title VARCHAR(500);
v_coc_display_title VARCHAR(500);
v_coc_title_mobile VARCHAR(500);
v_coc_title_app VARCHAR(500);
v_coc_show_in_web NUMERIC;
v_coc_show_in_mobile NUMERIC;
v_coc_show_in_app NUMERIC;
v_coc_fetch_from NUMERIC;
v_coc_parent_container_id VARCHAR(256); 
v_c_template_component_map_id NUMERIC;
v_c_asset_guid1 VARCHAR(256);
v_coc_meta json;

V_template_component_map_id NUMERIC;
v_asset_guid1 VARCHAR(256);

--  ENTITY VARIABLES
v_entityjson json;
v_entity json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type NUMERIC:=13;

BEGIN

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/***
		Get data from JSON
		***/
		-------------------------------------------------------------
      --  raise notice '%', v_json;
         
		SELECT 	v_json->'data'->>'template_id',
                v_json->'data'->>'template_name',
                v_json->'data'->>'template_desc',
                v_json->'data'->>'version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'status',
                v_json->'data'->>'guid',
                v_json->'data'->>'is_master',
                v_json->'data'->>'layout_id',
                v_json->'data'->>'is_inherited',
                v_json->'data'->>'parent_id',
                v_json->'data'->>'template_html',
                v_json->'data'->>'is_responsive',
                v_json->'data'->>'mobile_html'

		INTO            
				V_template_id,
                V_template_name,
                V_template_desc,
                V_version_number,
                V_updated_by,
                v_status,
                v_guid,
                V_is_master,
                V_layout_id,
                v_is_inherited,
                v_parent_id,
                v_template_html,
                v_is_responsive,
				v_mobile_html;
		---------------------------------------------------------------        
--raise notice '%',v_is_inherited;

		if (V_template_id is null)
		then
        
          V_template_guid    := uuid_generate_v4();	
          V_template_id      := nextval('tcs.seq_tcs_template_id');
                v_json 	         := jsonb_set(v_json, '{data,template_id}', V_template_id::text::jsonb, true);
                v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||V_template_guid||'"')::text::jsonb, true);
    
          insert into tcs.tcs_template
          (
          template_id, 
              page_id, 
              template_name,
              template_desc, 
              layout_id, 
              is_inherited,
              parent_id,
          published_version_number,
              created_date, 
              updated_date,
              created_by, 
              updated_by, 
              is_active,
          is_deleted, 
              is_published, 
              template_guid,
              is_master, 
              template_html, 
              is_responsive, 
              mobile_html
          )    
          values
          (
          V_template_id,
              p_page_id, 
              v_template_name,
              V_template_desc, 
              v_layout_id, 
              v_is_inherited, 
              v_parent_id,
          V_version_number, 
              v_sysdate, 
              v_sysdate, 
              1, 
              1, 
              1, 
              0, 
              v_status, 
              V_template_guid,
              V_is_master, 
              V_template_html, 
              v_is_responsive, 
              v_mobile_html
          );    
		else
        
			update tcs.tcs_template
            set 	page_id = v_page_id,
                    template_name = V_template_name,
                    template_desc = V_template_desc,
                    layout_id = v_layout_id,
                    is_inherited = 1,
                    parent_id = v_parent_id,
                    published_version_number = V_published_version_number,
                    updated_date = v_sysdate,
                    updated_by = V_updated_by,
                    is_active = 1,
                    is_deleted = 0,
                    is_published = V_status,
                    is_master = V_is_master,
                    template_html = V_template_html,
                    is_responsive = v_is_responsive,
                    mobile_html = v_mobile_html
		   where    template_id = V_template_id;

		end if;
    
    UPDATE tcs.tcs_TEMPLATE_COMPONENT_MAP
    SET IS_DELETED=1,IS_ACTIVE=0
    WHERE template_id = V_template_id;
    
    -- ==============
          select v_json->'data'->>'componentdata'
               into   v_componentjson; 
        --  raise notice '%' ,6;
          
          if v_componentjson is not null then 

            for v_componentdata in select * from json_array_elements(v_componentjson)
              loop
             -- raise notice '%' ,7;
    
                 select 
                       v_componentdata->>'template_component_map_id',
                       v_componentdata->>'component_id',
                       v_componentdata->>'title',
                       v_componentdata->>'display_title',
                       v_componentdata->>'title_mobile',
                       v_componentdata->>'title_app',
                       v_componentdata->>'show_in_web',
                       v_componentdata->>'show_in_mobile',
                       v_componentdata->>'show_in_app',
                       v_componentdata->>'fetch_from',
                       v_componentdata->>'parent_container_id' ,
                       v_componentdata->>'meta_info' 
                     into  
                        v_co_template_component_map_id ,
                        v_co_component_id ,
                        v_co_title ,
                        v_co_display_title ,
                        v_co_title_mobile ,
                        v_co_title_app ,
                        v_co_show_in_web ,
                        v_co_show_in_mobile ,
                        v_co_show_in_app ,
                        v_co_fetch_from ,
                        v_co_parent_container_id ,
                        v_co_meta
                        ;
        
                IF  v_co_template_component_map_id IS NULL THEN
                        
                        V_template_component_map_id :=nextval('tcs.seq_tcs_template_component_map_id');
                        v_asset_guid1       := uuid_generate_v4();
               -- raise notice '%' ,8;
                         INSERT INTO tcs.tcs_template_component_map(
                        template_component_map_id, template_id, component_id, title, display_title,
                        title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
                        created_date, updated_date, created_by, updated_by, 
                          is_active, is_deleted, is_published, tcmap_guid, parent_container_id, parent_tcmap_id,meta_info)
                        VALUES (V_template_component_map_id, V_template_id,v_co_component_id,v_co_title,
                        v_co_display_title, v_co_title_mobile, v_co_title_app,  v_co_show_in_web ,
                        v_co_show_in_mobile ,v_co_show_in_app ,v_co_fetch_from , 
                        v_sysdate, v_sysdate, V_updated_by, V_updated_by, 1, 0, V_status,
                        v_asset_guid1, v_co_parent_container_id,null,v_coc_meta);
                 ELSE
                        UPDATE tcs.tcs_template_component_map
                        SET   component_id=v_co_component_id, title=v_co_title, 
                        display_title=v_co_display_title, title_mobile=v_co_title_mobile,
                        title_app=v_co_title_app , show_in_web=v_co_show_in_web, show_in_mobile=v_co_show_in_mobile, 
                        show_in_app=v_co_show_in_app, fetch_from=v_co_fetch_from, updated_date=v_sysdate,  
                        updated_by=V_updated_by, is_active=1, is_deleted=0, is_published=V_status, 
                        parent_container_id=v_co_parent_container_id,meta_info=v_coc_meta
                        WHERE template_component_map_id=v_co_template_component_map_id;
                        
                 END IF;
                 
              -- raise notice '%' ,10; 
                     --  ENTITY DATA---     
                     DELETE FROM tcs.tcs_asset_entity_map 
                     WHERE ASSET_TYPE_ID=v_asset_type
                     AND ASSET_ID=COALESCE(v_co_template_component_map_id,v_template_component_map_id);
                     
                     select v_componentdata->'entitydata'
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

                           v_assetentitymapid   := nextval('tcs.seq_tcs_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();

                           insert into tcs.tcs_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid)
                          values(v_assetentitymapid, v_template_component_map_id, v_asset_type, 
                          v_entityrolemapid, COALESCE(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                          1, v_assetentitymapguid);
                       END IF;
                      END LOOP;
                    END IF;
              -- ENTITY DATA --
                   
                   --  CHILD COMPONENTS START
                          select v_componentdata->>'child_components'
                               into   v_childcomponentjson; 
                 --         raise notice '%' ,6;
                          
                          if v_childcomponentjson is not null then 
                
                            for v_childcomponentdata in select * from json_array_elements(v_childcomponentjson)
                              loop
                             -- raise notice '%' ,7;
                    
                                 select 
                                       v_childcomponentdata->>'template_component_map_id',
                                       v_childcomponentdata->>'component_id',
                                       v_childcomponentdata->>'title',
                                       v_childcomponentdata->>'display_title',
                                       v_childcomponentdata->>'title_mobile',
                                       v_childcomponentdata->>'title_app',
                                       v_childcomponentdata->>'show_in_web',
                                       v_childcomponentdata->>'show_in_mobile',
                                       v_childcomponentdata->>'show_in_app',
                                       v_childcomponentdata->>'fetch_from',
                                       v_childcomponentdata->>'parent_container_id',
                       				   v_componentdata->>'meta_info' 
                                     into  
                                        v_coc_template_component_map_id ,
                                        v_coc_component_id ,
                                        v_coc_title ,
                                        v_coc_display_title ,
                                        v_coc_title_mobile ,
                                        v_coc_title_app ,
                                        v_coc_show_in_web ,
                                        v_coc_show_in_mobile ,
                                        v_coc_show_in_app ,
                                        v_coc_fetch_from ,
                                        v_coc_parent_container_id ,
                                        v_coc_meta
                                        ;
                        
                                IF  v_coc_template_component_map_id IS NULL THEN
                                        
                                        v_c_template_component_map_id :=nextval('tcs.seq_tcs_template_component_map_id');
                                        v_c_asset_guid1       := uuid_generate_v4();
                               -- raise notice '%' ,8;
                                         INSERT INTO tcs.tcs_template_component_map(
                                        template_component_map_id, template_id, component_id, title, display_title,
                                        title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
                                        created_date, updated_date, created_by, updated_by, 
                                          is_active, is_deleted, is_published, tcmap_guid, parent_container_id, 
                                          parent_tcmap_id,META_INFO)
                                        VALUES (v_c_template_component_map_id, V_template_id,v_coc_component_id,v_coc_title,
                                        v_coc_display_title, v_coc_title_mobile, v_coc_title_app,  v_coc_show_in_web ,
                                        v_coc_show_in_mobile ,v_coc_show_in_app ,v_coc_fetch_from , 
                                        v_sysdate, v_sysdate, V_updated_by, V_updated_by, 1, 0, V_status,
                                        v_c_asset_guid1, v_coc_parent_container_id,
                                        COALESCE(v_co_template_component_map_id,v_template_component_map_id),
                                        v_coc_meta);
                                 ELSE
                                        UPDATE tcs.tcs_template_component_map
                                        SET   component_id=v_coc_component_id, title=v_coc_title, 
                                        display_title=v_coc_display_title, title_mobile=v_coc_title_mobile,
                                        title_app=v_coc_title_app , show_in_web=v_coc_show_in_web, show_in_mobile=v_coc_show_in_mobile, 
                                        show_in_app=v_coc_show_in_app, fetch_from=v_coc_fetch_from, updated_date=v_sysdate,  
                                        updated_by=V_updated_by, is_active=1, is_deleted=0, is_published=V_status, 
                                        parent_container_id=v_coc_parent_container_id,
                                        parent_tcmap_id=COALESCE(v_co_template_component_map_id,v_template_component_map_id),
                                        META_INFO=v_coc_meta
                                        WHERE template_component_map_id=v_coc_template_component_map_id ;
                                        
                                 END IF;
                                 
                              -- raise notice '%' ,10; 
                                     --  ENTITY DATA---     
                                     DELETE FROM tcs.tcs_asset_entity_map 
                                     WHERE ASSET_TYPE_ID=v_asset_type
                                     AND ASSET_ID=COALESCE(v_coc_template_component_map_id,v_c_template_component_map_id);
                                     
                                     select v_childcomponentdata->'entitydata'
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
                
                                           v_assetentitymapid   := nextval('tcs.seq_tcs_asset_entity_map_id');
                                          v_assetentitymapguid := uuid_generate_v4();
                
                                           insert into tcs.tcs_asset_entity_map
                                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                                            is_deleted, is_published, aemap_guid)
                                          values(v_assetentitymapid, COALESCE(v_coc_template_component_map_id,v_c_template_component_map_id), v_asset_type, 
                                          v_entityrolemapid, COALESCE(v_islinkable,0), v_isvisible, v_priority,
                                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                                          1, v_assetentitymapguid);
                                       END IF;
                                      END LOOP;
                                    END IF;
                              -- ENTITY DATA --
                                   
                             end loop;     
                          end if;
                   --  CHILD COMPONENTS END
             end loop;     
          end if;
    -- ==============
		p_result := V_template_id;

		p_data := v_json;

END;

    $$;


--
