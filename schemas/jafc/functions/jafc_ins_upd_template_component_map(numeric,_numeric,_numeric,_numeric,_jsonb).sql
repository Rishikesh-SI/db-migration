-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_ins_upd_template_component_map(numeric, numeric, numeric, numeric, jsonb)
-- Type: FUNCTION

-- Name: jafc_ins_upd_template_component_map(numeric, numeric, numeric, numeric, jsonb); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_ins_upd_template_component_map(p_template_id numeric, p_updated_by numeric, p_status numeric, p_parent_tcmap_id numeric, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
--v_template_id        					jafc.jafc_template.template_id%type;
--
--v_template_name        				jafc.jafc_template.template_name%type;
--v_template_desc        				jafc.jafc_template.template_desc%type;
--v_page_id							jafc.jafc_template.page_id%type;
--v_layout_id							jafc.jafc_template.layout_id%type;
--v_parent_id							jafc.jafc_template.parent_id%type;
--v_is_inherited							jafc.jafc_template.is_inherited%type;
--v_published_version_number        	jafc.jafc_template.published_version_number%type:=1;
--v_created_date        				jafc.jafc_template.created_date%type;
--v_updated_date        				jafc.jafc_template.updated_date%type;
--v_created_by        				jafc.jafc_template.created_by%type;
v_updated_by        				jafc.jafc_template.updated_by%type;
--v_is_active        					jafc.jafc_template.is_active%type;
--v_is_deleted        				jafc.jafc_template.is_deleted%type;
--v_is_published        				jafc.jafc_template.is_published%type;
--v_template_guid        				jafc.jafc_template.template_guid%type;
--v_master_id						jafc.jafc_template.is_master%type;

v_sysdate 							 timestamp;
--v_is_master                             numeric;
--v_master_template_id                    numeric;
--v_template_html        				jafc.jafc_layout.layout_html%type;

--v_version_number numeric;
v_status numeric;
--v_guid varchar(256);

v_componentjson json; 
v_componentdata json;
--v_is_responsive jafc.jafc_template.is_responsive%type;
--v_desktop_html  jafc.jafc_template.desktop_html%type;
--v_mobile_html  jafc.jafc_template.mobile_html%type;

-- template component variables
v_co_template_component_map_id numeric;
v_co_component_id numeric;
v_co_title varchar(500);
v_co_display_title varchar(500);
v_co_title_mobile varchar(500);
v_co_title_app varchar(500);
v_co_show_in_web numeric;
v_co_show_in_mobile numeric;
v_co_show_in_app numeric;
v_co_fetch_from numeric;
v_co_parent_container_id varchar(256); 
v_co_meta json;

-- child component variables
v_childcomponentjson json;
--v_childcomponentdata json;
--
--v_coc_template_component_map_id numeric;
--v_coc_component_id numeric;
--v_coc_title varchar(500);
--v_coc_display_title varchar(500);
--v_coc_title_mobile varchar(500);
--v_coc_title_app varchar(500);
--v_coc_show_in_web numeric;
--v_coc_show_in_mobile numeric;
--v_coc_show_in_app numeric;
--v_coc_fetch_from numeric;
--v_coc_parent_container_id varchar(256); 
--v_c_template_component_map_id numeric;
--v_c_asset_guid1 varchar(256);
--v_coc_meta json;

--v_template_component_map_id numeric;
v_asset_guid1 varchar(256);

--  entity variables
v_entityjson json;
v_entity json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type numeric:=13;

-- recursion variables
v_child_ret numeric;
begin

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
    v_updated_by:=p_updated_by;
    v_status:=p_status;
		-------------------------------------------------------------
		/***
		get data from json
		***/
		-------------------------------------------------------------
		
		---------------------------------------------------------------        
    
    update jafc.jafc_template_component_map
    set is_deleted=1,is_active=0
    where template_id = p_template_id;
    
    -- ==============
          select v_json->>'componentdata'
               into   v_componentjson; 
          raise notice '%' ,6;
          
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
                       v_componentdata->>'meta' 
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
        
                if  v_co_template_component_map_id is null then
                        
                        v_co_template_component_map_id :=nextval('jafc.seq_jafc_template_component_map_id');
                        v_asset_guid1       := uuid_generate_v4();
               -- raise notice '%' ,8;
                         insert into jafc.jafc_template_component_map(
                        template_component_map_id, template_id, component_id, title, display_title,
                        title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
                        created_date, updated_date, created_by, updated_by, 
                          is_active, is_deleted, is_published, tcmap_guid, parent_container_id, parent_tcmap_id,meta_info)
                        values (v_co_template_component_map_id, p_template_id,v_co_component_id,v_co_title,
                        v_co_display_title, v_co_title_mobile, v_co_title_app,  v_co_show_in_web ,
                        v_co_show_in_mobile ,v_co_show_in_app ,v_co_fetch_from , 
                        v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, v_status,
                        v_asset_guid1, v_co_parent_container_id,p_parent_tcmap_id,v_co_meta);
                 else
                        update jafc.jafc_template_component_map
                        set   component_id=v_co_component_id, title=v_co_title, 
                        display_title=v_co_display_title, title_mobile=v_co_title_mobile,
                        title_app=v_co_title_app , show_in_web=v_co_show_in_web, show_in_mobile=v_co_show_in_mobile, 
                        show_in_app=v_co_show_in_app, fetch_from=v_co_fetch_from, updated_date=v_sysdate,  
                        updated_by=v_updated_by, is_active=1, is_deleted=0, is_published=v_status, 
                        parent_container_id=v_co_parent_container_id,meta_info=v_co_meta,
                        parent_tcmap_id=p_parent_tcmap_id
                        where template_component_map_id=v_co_template_component_map_id;
                        
                 end if;
                 
              -- raise notice '%' ,10; 
                     --  entity data---     
                     delete from jafc.jafc_asset_entity_map 
                     where asset_type_id=v_asset_type
                     and asset_id=v_co_template_component_map_id;
                     
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

                           v_assetentitymapid   := nextval('jafc.seq_jafc_asset_entity_map_id');
                           v_assetentitymapguid := uuid_generate_v4();

                           insert into jafc.jafc_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid)
                          values(v_assetentitymapid, v_co_template_component_map_id, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                          1, v_assetentitymapguid);
                       end if;
                      end loop;
                    end if;
              -- entity data --
                   
                   --  child components start
                          select v_componentdata->>'child_components'
                               into   v_childcomponentjson; 
                          raise notice '%' ,6;
                          
                          if v_childcomponentjson is not null then 
                               select s.p_result into v_child_ret  
                               from jafc.jafc_ins_upd_template_component_map  
                                      (p_template_id,p_updated_by ,p_status ,v_co_template_component_map_id, v_childcomponentjson::jsonb) s;
                          end if;
                   --  child components end
             end loop;     
          end if;
    -- ==============
		p_result := v_co_template_component_map_id;

		p_data := v_json;

end;

$$;


--
