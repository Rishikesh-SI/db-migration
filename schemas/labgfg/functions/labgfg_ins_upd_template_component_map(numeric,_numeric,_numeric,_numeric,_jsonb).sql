-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_ins_upd_template_component_map(numeric, numeric, numeric, numeric, jsonb)
-- Type: FUNCTION

-- Name: labgfg_ins_upd_template_component_map(numeric, numeric, numeric, numeric, jsonb); Type: FUNCTION; Schema: labgfg; Owner: -
--

CREATE FUNCTION labgfg.labgfg_ins_upd_template_component_map(p_template_id numeric, p_updated_by numeric, p_status numeric, p_parent_tcmap_id numeric, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

  

 

declare

v_json 								jsonb;
--V_template_id        					labgfg.labgfg_template.template_id%TYPE;
--
--V_template_name        				labgfg.labgfg_template.template_name%TYPE;
--V_template_desc        				labgfg.labgfg_template.template_desc%TYPE;
--v_page_id							labgfg.labgfg_template.page_id%type;
--v_layout_id							labgfg.labgfg_template.layout_id%type;
--v_parent_id							labgfg.labgfg_template.parent_id%type;
--v_is_inherited							labgfg.labgfg_template.is_inherited%type;
--V_published_version_number        	labgfg.labgfg_template.published_version_number%TYPE:=1;
--V_created_date        				labgfg.labgfg_template.created_date%TYPE;
--V_updated_date        				labgfg.labgfg_template.updated_date%TYPE;
--V_created_by        				labgfg.labgfg_template.created_by%TYPE;
V_updated_by        				labgfg.labgfg_template.updated_by%TYPE;
--V_is_active        					labgfg.labgfg_template.is_active%TYPE;
--V_is_deleted        				labgfg.labgfg_template.is_deleted%TYPE;
--V_is_published        				labgfg.labgfg_template.is_published%TYPE;
--V_template_guid        				labgfg.labgfg_template.template_guid%TYPE;
--v_master_id						labgfg.labgfg_template.is_master%type;

v_sysdate 							 timestamp;
--V_is_master                             numeric;
--V_master_template_id                    numeric;
--V_template_html        				labgfg.labgfg_layout.layout_html%TYPE;

--V_version_number numeric;
v_status numeric;
--v_guid varchar(256);

v_componentjson json; 
v_componentdata json;
--v_is_responsive labgfg.labgfg_template.is_responsive%type;
--v_desktop_html  labgfg.labgfg_template.desktop_html%type;
--v_mobile_html  labgfg.labgfg_template.mobile_html%type;

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
v_co_parent_container_id numeric :=null; 
v_co_meta json;
v_co_layout_info json ;
v_tcmap VARCHAR(500);

-- child component variables
v_childcomponentjson json;
--v_childcomponentdata json;
--
--v_coc_template_component_map_id numeric;
--v_coc_component_id numeric;
--v_coc_title VARCHAR(500);
--v_coc_display_title VARCHAR(500);
--v_coc_title_mobile VARCHAR(500);
--v_coc_title_app VARCHAR(500);
--v_coc_show_in_web NUMERIC;
--v_coc_show_in_mobile NUMERIC;
--v_coc_show_in_app NUMERIC;
--v_coc_fetch_from NUMERIC;
--v_coc_parent_container_id VARCHAR(256); 
--v_c_template_component_map_id NUMERIC;
--v_c_asset_guid1 VARCHAR(256);
--v_coc_meta json;

--V_template_component_map_id NUMERIC;
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
v_is_required numeric;
v_asset_type NUMERIC:=13;
v_ent_ord_number numeric;
-- Recursion variables
v_child_ret numeric;
v_is_protected numeric;
v_co_is_protected numeric;
BEGIN

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
    v_updated_by:=P_updated_by;
    v_status:=P_status;
		-------------------------------------------------------------
		/***
		Get data from JSON
		***/
		-------------------------------------------------------------
		
		---------------------------------------------------------------        
    
--    UPDATE labgfg.labgfg_TEMPLATE_COMPONENT_MAP
--    SET IS_DELETED=1,IS_ACTIVE=0
--    WHERE template_id = p_template_id;
    
    -- ==============
          select v_json->>'componentdata'
               into   v_componentjson; 
         -- raise notice '%' ,6;
         
          if v_componentjson is not null  then 

            for v_componentdata in select * from json_array_elements(v_componentjson)
              loop
             -- raise notice '%' ,7;
                IF v_componentdata::text not in ('null') THEN 
                    IF p_parent_tcmap_id IS NOT NULL  THEN
--                     insert into labgfg.labgfg_error_log values (nextval('labgfg.seq_labgfg_template_component_map_id')
--                                                    ,1,v_componentdata->>'component_id',v_sysdate);
                     select 
                           v_componentdata->'data'->>'template_component_map_id',
                           v_componentdata->'data'->>'component_id',
                           v_componentdata->'data'->>'title',
                           v_componentdata->'data'->>'display_title',
                           v_componentdata->'data'->>'title_mobile',
                           v_componentdata->'data'->>'title_app',
                           v_componentdata->'data'->>'show_in_web',
                           v_componentdata->'data'->>'show_in_mobile',
                           v_componentdata->'data'->>'show_in_app',
						   v_componentdata->'data'->>'is_protected',
                           v_componentdata->'data'->>'fetch_from',
                           --v_componentdata->'data'->>'parent_container_id' ,
                           v_componentdata->'data'->>'meta_info',
                           v_componentdata->'data'->>'layout_info',
                        	v_componentdata->'data'->>'tcmap_guid'
							
                            -- changes done by rakesh bhatkar tcmap_guid added--
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
							v_is_protected,
                            v_co_fetch_from ,
                            --v_co_parent_container_id ,
                            v_co_meta 
                            ,
                            v_co_layout_info,
                            v_tcmap
							
                            ;
                            
                            -- raise notice '% test case 1',v_co_component_id;
                            -- select 1/0;
                    ELSE
--                    insert into labgfg.labgfg_error_log values (nextval('labgfg.seq_labgfg_template_component_map_id')
--                                                    ,2,v_componentdata->'data'->>'component_id',v_sysdate);
                

                    select
                           v_componentdata->'data'->>'template_component_map_id',
                           v_componentdata->'data'->>'component_id',
                           v_componentdata->'data'->>'title',
                           v_componentdata->'data'->>'display_title',
                           v_componentdata->'data'->>'title_mobile',
                           v_componentdata->'data'->>'title_app',
                           v_componentdata->'data'->>'show_in_web',
                           v_componentdata->'data'->>'show_in_mobile',
                           v_componentdata->'data'->>'show_in_app',
						   v_componentdata->'data'->>'is_protected',
                           v_componentdata->'data'->>'fetch_from',
						 --v_componentdata->'data'->>'parent_container_id' ,
                           v_componentdata->'data'->>'meta_info' ,
                           v_componentdata->'data'->>'layout_info',
                           v_componentdata->'data'->>'tcmap_guid'
						   
                         -- changes done by rakesh bhatkar tcmap_guid added--
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
							v_is_protected,
                            v_co_fetch_from ,
                            --v_co_parent_container_id ,
                            v_co_meta,
                            v_co_layout_info,
                            v_tcmap
							
                            ;
                            
                            
                             
                           --   raise notice '%',v_co_layout_info;
                             
                             -- raise notice '% test case 1',v_co_component_id;
                             -- select 1/0;
                    END IF;
                
                IF  v_co_template_component_map_id IS NULL THEN
                        
                        v_co_template_component_map_id :=nextval('labgfg.seq_labgfg_template_component_map_id');
                        v_asset_guid1       := uuid_generate_v4();

                         INSERT INTO labgfg.labgfg_template_component_map(
                        template_component_map_id, template_id, component_id, title, display_title,
                        title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
                        created_date, updated_date, created_by, updated_by, 
                          is_active, is_deleted, is_published, 
                             tcmap_guid, parent_container_id, parent_tcmap_id,meta_info,layout_info,is_protected)
                        VALUES (v_co_template_component_map_id, p_template_id,v_co_component_id,v_co_title,
                        v_co_display_title, v_co_title_mobile, v_co_title_app,  v_co_show_in_web ,
                        v_co_show_in_mobile ,v_co_show_in_app ,v_co_fetch_from , 
                        v_sysdate, v_sysdate, V_updated_by, V_updated_by, 1, 0, 
                                V_status,
                               v_tcmap,
                                --v_asset_guid1,
                                v_co_parent_container_id,
                                P_parent_tcmap_id,
                                v_co_meta,v_co_layout_info,v_is_protected);
                 ELSE
                        UPDATE labgfg.labgfg_template_component_map
                        SET   component_id=v_co_component_id, title=v_co_title, 
                        display_title=v_co_display_title, title_mobile=v_co_title_mobile,
                        title_app=v_co_title_app , show_in_web=v_co_show_in_web, show_in_mobile=v_co_show_in_mobile, 
                        show_in_app=v_co_show_in_app, fetch_from=v_co_fetch_from, updated_date=v_sysdate,  
                        updated_by=V_updated_by, is_active=1, is_deleted=0, 
                        is_published=V_status, 
                        parent_container_id=v_co_parent_container_id,
                        meta_info=v_co_meta,
                        layout_info=v_co_layout_info,
                        parent_tcmap_id=P_parent_tcmap_id,
						is_protected=v_is_protected
                        WHERE template_component_map_id=v_co_template_component_map_id;
                        
                 END IF;
                             
                     --  ENTITY DATA---     
                     DELETE FROM labgfg.labgfg_asset_entity_map 
                     WHERE ASSET_TYPE_ID=v_asset_type
                     AND ASSET_ID=v_co_template_component_map_id;
                     
                     IF p_parent_tcmap_id IS NOT NULL THEN
                   
                     select v_componentdata->'data'->'entity_data'
                         into   v_entityjson; 
                     ELSE  
                     select v_componentdata->'data'->'entity_data'
                         into   v_entityjson;
                        
                     END IF;
                     
                        if v_entityjson is not null and v_entityjson::text not in ('null') then

                         for v_entity in select * from json_array_elements(v_entityjson)
                           loop
  
                           select v_entity->>'entity_role_map_id',
                                  v_entity->>'priority',
                                  v_entity->>'is_linkable',
                                  v_entity->>'is_visible',
                                  v_entity->>'is_required',
								  v_entity->>'entity_order_number'
								  
                           into   v_entityrolemapid,
                                  v_priority,
                                  v_islinkable,
                                  v_isvisible,
                                  v_is_required,
								  v_ent_ord_number;

                      if (v_entityrolemapid is not null and v_priority is not null) then

                           v_assetentitymapid   := nextval('labgfg.seq_labgfg_asset_entity_map_id');
                           v_assetentitymapguid := uuid_generate_v4();

                           insert into labgfg.labgfg_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required,order_number)
                          values(v_assetentitymapid, v_co_template_component_map_id, v_asset_type, 
                          v_entityrolemapid, COALESCE(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                          1, v_assetentitymapguid,v_is_required,v_ent_ord_number);
                       END IF;
                       
                      END LOOP;
                    END IF;
              -- ENTITY DATA --
                   
                   --  CHILD COMPONENTS START
                          IF p_parent_tcmap_id IS NOT NULL THEN
                          select v_componentdata->>'child_components'
                               into   v_childcomponentjson; 
                          ELSE
                          select v_componentdata->'data'->>'child_components'
                               into   v_childcomponentjson; 
                          END IF;     
                        raise notice '% CHECK 2' ,v_childcomponentjson;
                        raise notice '% CHECK 2' ,v_co_template_component_map_id;
                          
                          if v_childcomponentjson is not null then 
                               SELECT S.p_result INTO v_child_ret  
                               FROM labgfg.labgfg_ins_upd_template_component_map  
                                      (p_template_id,P_updated_by ,P_status ,v_co_template_component_map_id, v_childcomponentjson::jsonb) S;
                           raise notice '% CHECK 2' ,v_child_ret;
                          end if;
                          
                          
                   --  CHILD COMPONENTS END
                   END IF;
             end loop;     
          end if;
    -- ==============
		p_result := v_co_template_component_map_id;

		p_data := v_json;

END;

 

  

 
$$;


--
