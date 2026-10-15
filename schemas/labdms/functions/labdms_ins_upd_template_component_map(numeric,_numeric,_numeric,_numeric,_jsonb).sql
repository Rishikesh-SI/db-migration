-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_ins_upd_template_component_map(numeric, numeric, numeric, numeric, jsonb)
-- Type: FUNCTION

-- Name: labdms_ins_upd_template_component_map(numeric, numeric, numeric, numeric, jsonb); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_ins_upd_template_component_map(p_template_id numeric, p_updated_by numeric, p_status numeric, p_parent_tcmap_id numeric, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

  

 

declare

v_json 								jsonb;
--v_template_id        					labdms.labdms_template.template_id%type;
--
--v_template_name        				labdms.labdms_template.template_name%type;
--v_template_desc        				labdms.labdms_template.template_desc%type;
--v_page_id							labdms.labdms_template.page_id%type;
--v_layout_id							labdms.labdms_template.layout_id%type;
--v_parent_id							labdms.labdms_template.parent_id%type;
--v_is_inherited							labdms.labdms_template.is_inherited%type;
--v_published_version_number        	labdms.labdms_template.published_version_number%type:=1;
--v_created_date        				labdms.labdms_template.created_date%type;
--v_updated_date        				labdms.labdms_template.updated_date%type;
--v_created_by        				labdms.labdms_template.created_by%type;
v_updated_by        				labdms.labdms_template.updated_by%type;
--v_is_active        					labdms.labdms_template.is_active%type;
--v_is_deleted        				labdms.labdms_template.is_deleted%type;
--v_is_published        				labdms.labdms_template.is_published%type;
--v_template_guid        				labdms.labdms_template.template_guid%type;
--v_master_id						labdms.labdms_template.is_master%type;

v_sysdate 							 timestamp;
--v_is_master                             numeric;
--v_master_template_id                    numeric;
--v_template_html        				labdms.labdms_layout.layout_html%type;

--v_version_number numeric;
v_status numeric;
--v_guid varchar(256);

v_componentjson json; 
v_componentdata json;
--v_is_responsive labdms.labdms_template.is_responsive%type;
--v_desktop_html  labdms.labdms_template.desktop_html%type;
--v_mobile_html  labdms.labdms_template.mobile_html%type;

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
v_co_parent_container_id numeric :=null; 
v_co_meta json;
v_co_layout_info json ;
v_tcmap varchar(500);

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
v_is_required numeric;
v_asset_type numeric:=13;
v_ent_ord_number numeric;
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
    
--    update labdms.labdms_template_component_map
--    set is_deleted=1,is_active=0
--    where template_id = p_template_id;
    
    -- ==============
          select v_json->>'componentdata'
               into   v_componentjson; 
         -- raise notice '%' ,6;
         
          if v_componentjson is not null  then 

            for v_componentdata in select * from json_array_elements(v_componentjson)
              loop
             -- raise notice '%' ,7;
                if v_componentdata::text not in ('null') then 
                    if p_parent_tcmap_id is not null  then
--                     insert into labdms.labdms_error_log values (nextval('labdms.seq_labdms_template_component_map_id')
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
                            v_co_fetch_from ,
                            --v_co_parent_container_id ,
                            v_co_meta 
                            ,
                            v_co_layout_info,
                            v_tcmap
                            ;
                            
                            -- raise notice '% test case 1',v_co_component_id;
                            -- select 1/0;
                    else
--                    insert into labdms.labdms_error_log values (nextval('labdms.seq_labdms_template_component_map_id')
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
                            v_co_fetch_from ,
                            --v_co_parent_container_id ,
                            v_co_meta,
                            v_co_layout_info,
                            v_tcmap
                            ;
                            
                            
                             
                           --   raise notice '%',v_co_layout_info;
                             
                             -- raise notice '% test case 1',v_co_component_id;
                             -- select 1/0;
                    end if;
                
                if  v_co_template_component_map_id is null then
                        
                        v_co_template_component_map_id :=nextval('labdms.seq_labdms_template_component_map_id');
                        v_asset_guid1       := uuid_generate_v4();
       --        raise notice '%' ,8;
--               raise notice '%' ,p_parent_tcmap_id;
--               raise notice '%' ,v_componentdata->>'component_id';
--               raise notice '%' ,v_componentdata;
                         insert into labdms.labdms_template_component_map(
                        template_component_map_id, template_id, component_id, title, display_title,
                        title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
                        created_date, updated_date, created_by, updated_by, 
                          is_active, is_deleted, is_published, 
                             tcmap_guid, parent_container_id, parent_tcmap_id,meta_info,layout_info)
                        values (v_co_template_component_map_id, p_template_id,v_co_component_id,v_co_title,
                        v_co_display_title, v_co_title_mobile, v_co_title_app,  v_co_show_in_web ,
                        v_co_show_in_mobile ,v_co_show_in_app ,v_co_fetch_from , 
                        v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                                v_status,
                               v_tcmap,
                                --v_asset_guid1,
                                v_co_parent_container_id,
                                p_parent_tcmap_id,
                                v_co_meta,v_co_layout_info);
                 else
                        update labdms.labdms_template_component_map
                        set   component_id=v_co_component_id, title=v_co_title, 
                        display_title=v_co_display_title, title_mobile=v_co_title_mobile,
                        title_app=v_co_title_app , show_in_web=v_co_show_in_web, show_in_mobile=v_co_show_in_mobile, 
                        show_in_app=v_co_show_in_app, fetch_from=v_co_fetch_from, updated_date=v_sysdate,  
                        updated_by=v_updated_by, is_active=1, is_deleted=0, 
                        is_published=v_status, 
                        parent_container_id=v_co_parent_container_id,
                        meta_info=v_co_meta,
                        layout_info=v_co_layout_info,
                        parent_tcmap_id=p_parent_tcmap_id
                        where template_component_map_id=v_co_template_component_map_id;
                        
                 end if;
                             
                     --  entity data---     
                     delete from labdms.labdms_asset_entity_map 
                     where asset_type_id=v_asset_type
                     and asset_id=v_co_template_component_map_id;
                     
                     if p_parent_tcmap_id is not null then
                   
                     select v_componentdata->'data'->'entity_data'
                         into   v_entityjson; 
                     else  
                     select v_componentdata->'data'->'entity_data'
                         into   v_entityjson;
                        
                     end if;
                     
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

                           v_assetentitymapid   := nextval('labdms.seq_labdms_asset_entity_map_id');
                           v_assetentitymapguid := uuid_generate_v4();

                           insert into labdms.labdms_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required,order_number)
                          values(v_assetentitymapid, v_co_template_component_map_id, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                          1, v_assetentitymapguid,v_is_required,v_ent_ord_number);
                       end if;
                       
                      end loop;
                    end if;
              -- entity data --
                   
                   --  child components start
                          if p_parent_tcmap_id is not null then
                          select v_componentdata->>'child_components'
                               into   v_childcomponentjson; 
                          else
                          select v_componentdata->'data'->>'child_components'
                               into   v_childcomponentjson; 
                          end if;     
                        raise notice '% check 2' ,v_childcomponentjson;
                        raise notice '% check 2' ,v_co_template_component_map_id;
                          
                          if v_childcomponentjson is not null then 
                               select s.p_result into v_child_ret  
                               from labdms.labdms_ins_upd_template_component_map  
                                      (p_template_id,p_updated_by ,p_status ,v_co_template_component_map_id, v_childcomponentjson::jsonb) s;
                           raise notice '% check 2' ,v_child_ret;
                          end if;
                          
                          
                   --  child components end
                   end if;
             end loop;     
          end if;
    -- ==============
		p_result := v_co_template_component_map_id;

		p_data := v_json;

end;

 

  

 
$$;


--
