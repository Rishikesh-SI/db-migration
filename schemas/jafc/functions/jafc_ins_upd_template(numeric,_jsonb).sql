-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_ins_upd_template(numeric, jsonb)
-- Type: FUNCTION

-- Name: jafc_ins_upd_template(numeric, jsonb); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_ins_upd_template(p_page_id numeric, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
   

declare

v_json 								jsonb;
v_template_id        			    jafc.jafc_template.template_id%type;

v_template_name        				jafc.jafc_template.template_name%type;
v_template_desc        				jafc.jafc_template.template_desc%type;
v_page_id							jafc.jafc_template.page_id%type;
v_layout_id							jafc.jafc_template.layout_id%type;
v_parent_id							jafc.jafc_template.parent_id%type;
v_is_inherited							jafc.jafc_template.is_inherited%type;
v_published_version_number        	jafc.jafc_template.published_version_number%type:=1;
v_created_date        				jafc.jafc_template.created_date%type;
v_updated_date        				jafc.jafc_template.updated_date%type;
v_created_by        				jafc.jafc_template.created_by%type;
v_updated_by        				jafc.jafc_template.updated_by%type;
v_is_active        					jafc.jafc_template.is_active%type;
v_is_deleted        				jafc.jafc_template.is_deleted%type;
v_is_published        				jafc.jafc_template.is_published%type;
v_template_guid        				jafc.jafc_template.template_guid%type;
v_master_id						jafc.jafc_template.is_master%type;

v_sysdate 							 timestamp;
v_is_master                             numeric;
v_master_template_id                    numeric;
v_template_html        				jafc.jafc_layout.layout_html%type;

v_version_number numeric;
v_status numeric;
v_guid varchar(256);

v_componentjson json;
v_componentdata json;
v_is_responsive jafc.jafc_template.is_responsive%type;
v_mobile_html  jafc.jafc_template.mobile_html%type;

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
v_childcomponentdata json;

v_coc_template_component_map_id numeric;
v_coc_component_id numeric;
v_coc_title varchar(500);
v_coc_display_title varchar(500);
v_coc_title_mobile varchar(500);
v_coc_title_app varchar(500);
v_coc_show_in_web numeric;
v_coc_show_in_mobile numeric;
v_coc_show_in_app numeric;
v_coc_fetch_from numeric;
v_coc_parent_container_id varchar(256); 
v_c_template_component_map_id numeric;
v_c_asset_guid1 varchar(256);
v_coc_meta json;

v_template_component_map_id numeric;
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

begin

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/***
		get data from json
		***/
		-------------------------------------------------------------
      --  raise notice '%', v_json;
         
		select 	v_json->'data'->>'template_id',
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

		into            
				v_template_id,
                v_template_name,
                v_template_desc,
                v_version_number,
                v_updated_by,
                v_status,
                v_guid,
                v_is_master,
                v_layout_id,
                v_is_inherited,
                v_parent_id,
                v_template_html,
                v_is_responsive,
				v_mobile_html;
		---------------------------------------------------------------        
--raise notice '%',v_is_inherited;

		if (v_template_id is null)
		then
        
          v_template_guid    := uuid_generate_v4();	
          v_template_id      := nextval('jafc.seq_jafc_template_id');
                v_json 	         := jsonb_set(v_json, '{data,template_id}', v_template_id::text::jsonb, true);
                v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_template_guid||'"')::text::jsonb, true);
    
          insert into jafc.jafc_template
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
          v_template_id,
              p_page_id, 
              v_template_name,
              v_template_desc, 
              v_layout_id, 
              v_is_inherited, 
              v_parent_id,
          v_version_number, 
              v_sysdate, 
              v_sysdate, 
              1, 
              1, 
              1, 
              0, 
              v_status, 
              v_template_guid,
              v_is_master, 
              v_template_html, 
              v_is_responsive, 
              v_mobile_html
          );    
		else
        
			update jafc.jafc_template
            set 	page_id = v_page_id,
                    template_name = v_template_name,
                    template_desc = v_template_desc,
                    layout_id = v_layout_id,
                    is_inherited = 1,
                    parent_id = v_parent_id,
                    published_version_number = v_published_version_number,
                    updated_date = v_sysdate,
                    updated_by = v_updated_by,
                    is_active = 1,
                    is_deleted = 0,
                    is_published = v_status,
                    is_master = v_is_master,
                    template_html = v_template_html,
                    is_responsive = v_is_responsive,
                    mobile_html = v_mobile_html
		   where    template_id = v_template_id;

		end if;
    
    update jafc.jafc_template_component_map
    set is_deleted=1,is_active=0
    where template_id = v_template_id;
    
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
        
                if  v_co_template_component_map_id is null then
                        
                        v_template_component_map_id :=nextval('jafc.seq_jafc_template_component_map_id');
                        v_asset_guid1       := uuid_generate_v4();
               -- raise notice '%' ,8;
                         insert into jafc.jafc_template_component_map(
                        template_component_map_id, template_id, component_id, title, display_title,
                        title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
                        created_date, updated_date, created_by, updated_by, 
                          is_active, is_deleted, is_published, tcmap_guid, parent_container_id, parent_tcmap_id,meta_info)
                        values (v_template_component_map_id, v_template_id,v_co_component_id,v_co_title,
                        v_co_display_title, v_co_title_mobile, v_co_title_app,  v_co_show_in_web ,
                        v_co_show_in_mobile ,v_co_show_in_app ,v_co_fetch_from , 
                        v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, v_status,
                        v_asset_guid1, v_co_parent_container_id,null,v_coc_meta);
                 else
                        update jafc.jafc_template_component_map
                        set   component_id=v_co_component_id, title=v_co_title, 
                        display_title=v_co_display_title, title_mobile=v_co_title_mobile,
                        title_app=v_co_title_app , show_in_web=v_co_show_in_web, show_in_mobile=v_co_show_in_mobile, 
                        show_in_app=v_co_show_in_app, fetch_from=v_co_fetch_from, updated_date=v_sysdate,  
                        updated_by=v_updated_by, is_active=1, is_deleted=0, is_published=v_status, 
                        parent_container_id=v_co_parent_container_id,meta_info=v_coc_meta
                        where template_component_map_id=v_co_template_component_map_id;
                        
                 end if;
                 
              -- raise notice '%' ,10; 
                     --  entity data---     
                     delete from jafc.jafc_asset_entity_map 
                     where asset_type_id=v_asset_type
                     and asset_id=coalesce(v_co_template_component_map_id,v_template_component_map_id);
                     
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
                          values(v_assetentitymapid, v_template_component_map_id, v_asset_type, 
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
                        
                                if  v_coc_template_component_map_id is null then
                                        
                                        v_c_template_component_map_id :=nextval('jafc.seq_jafc_template_component_map_id');
                                        v_c_asset_guid1       := uuid_generate_v4();
                               -- raise notice '%' ,8;
                                         insert into jafc.jafc_template_component_map(
                                        template_component_map_id, template_id, component_id, title, display_title,
                                        title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
                                        created_date, updated_date, created_by, updated_by, 
                                          is_active, is_deleted, is_published, tcmap_guid, parent_container_id, 
                                          parent_tcmap_id,meta_info)
                                        values (v_c_template_component_map_id, v_template_id,v_coc_component_id,v_coc_title,
                                        v_coc_display_title, v_coc_title_mobile, v_coc_title_app,  v_coc_show_in_web ,
                                        v_coc_show_in_mobile ,v_coc_show_in_app ,v_coc_fetch_from , 
                                        v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, v_status,
                                        v_c_asset_guid1, v_coc_parent_container_id,
                                        coalesce(v_co_template_component_map_id,v_template_component_map_id),
                                        v_coc_meta);
                                 else
                                        update jafc.jafc_template_component_map
                                        set   component_id=v_coc_component_id, title=v_coc_title, 
                                        display_title=v_coc_display_title, title_mobile=v_coc_title_mobile,
                                        title_app=v_coc_title_app , show_in_web=v_coc_show_in_web, show_in_mobile=v_coc_show_in_mobile, 
                                        show_in_app=v_coc_show_in_app, fetch_from=v_coc_fetch_from, updated_date=v_sysdate,  
                                        updated_by=v_updated_by, is_active=1, is_deleted=0, is_published=v_status, 
                                        parent_container_id=v_coc_parent_container_id,
                                        parent_tcmap_id=coalesce(v_co_template_component_map_id,v_template_component_map_id),
                                        meta_info=v_coc_meta
                                        where template_component_map_id=v_coc_template_component_map_id ;
                                        
                                 end if;
                                 
                              -- raise notice '%' ,10; 
                                     --  entity data---     
                                     delete from jafc.jafc_asset_entity_map 
                                     where asset_type_id=v_asset_type
                                     and asset_id=coalesce(v_coc_template_component_map_id,v_c_template_component_map_id);
                                     
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
                
                                           v_assetentitymapid   := nextval('jafc.seq_jafc_asset_entity_map_id');
                                          v_assetentitymapguid := uuid_generate_v4();
                
                                           insert into jafc.jafc_asset_entity_map
                                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                                            is_deleted, is_published, aemap_guid)
                                          values(v_assetentitymapid, coalesce(v_coc_template_component_map_id,v_c_template_component_map_id), v_asset_type, 
                                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                                          1, v_assetentitymapguid);
                                       end if;
                                      end loop;
                                    end if;
                              -- entity data --
                                   
                             end loop;     
                          end if;
                   --  child components end
             end loop;     
          end if;
    -- ==============
		p_result := v_template_id;

		p_data := v_json;

end;

   
$$;


--
