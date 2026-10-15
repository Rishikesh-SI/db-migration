-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_ins_upd_page(jsonb)
-- Type: FUNCTION

-- Name: labmcfc_ins_upd_page(jsonb); Type: FUNCTION; Schema: labmcfc; Owner: -
--

CREATE FUNCTION labmcfc.labmcfc_ins_upd_page(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 

v_page_id        				labmcfc.labmcfc_page.page_id%type;
v_alias        					labmcfc.labmcfc_page.alias%type;
v_title        					labmcfc.labmcfc_page.title%type;
v_page_level        			labmcfc.labmcfc_page.page_level%type;
v_upfront        				labmcfc.labmcfc_page.upfront%type;
v_upfront_app        			labmcfc.labmcfc_page.upfront_app%type;
v_upfront_mobile        		labmcfc.labmcfc_page.upfront_mobile%type;
v_is_wrapper        			labmcfc.labmcfc_page.is_wrapper%type;
v_page_parent_id        	    labmcfc.labmcfc_page.parent_id%type;
v_visible        				labmcfc.labmcfc_page.visible%type;
v_visible_app       	 		labmcfc.labmcfc_page.visible_app%type;
v_visible_mobile        		labmcfc.labmcfc_page.visible_mobile%type;
v_scheduled_publish        		labmcfc.labmcfc_page.scheduled_publish%type;
v_scheduled_unpublish        	labmcfc.labmcfc_page.scheduled_unpublish%type;
v_ordering        				labmcfc.labmcfc_page.ordering%type;
v_title_mobile        			labmcfc.labmcfc_page.title_mobile%type;
v_title_app        				labmcfc.labmcfc_page.title_app%type;
v_is_redirect        			labmcfc.labmcfc_page.is_redirect%type;
v_published_version_number      labmcfc.labmcfc_page.published_version_number%type;
v_created_date        			labmcfc.labmcfc_page.created_date%type;
v_updated_date        			labmcfc.labmcfc_page.updated_date%type;
v_created_by        			labmcfc.labmcfc_page.created_by%type;
v_updated_by        			labmcfc.labmcfc_page.updated_by%type;
v_is_active        				labmcfc.labmcfc_page.is_active%type;
v_is_deleted        			labmcfc.labmcfc_page.is_deleted%type;
v_status        			labmcfc.labmcfc_page.is_published%type;
v_page_guid        				labmcfc.labmcfc_page.page_guid%type;

v_template_id        			labmcfc.labmcfc_template.template_id%type;
v_template_name        			labmcfc.labmcfc_template.template_name%type;
v_template_desc        			labmcfc.labmcfc_template.template_desc%type;
v_layout_id        				labmcfc.labmcfc_template.layout_id%type;
v_is_inherited        			labmcfc.labmcfc_template.is_inherited%type;
v_template_parent_id            labmcfc.labmcfc_template.parent_id%type;
v_template_guid        			labmcfc.labmcfc_template.template_guid%type;
v_json							jsonb;
v_sysdate						timestamp;
v_is_responsive labmcfc.labmcfc_template.is_responsive%type;
v_mobile_html  labmcfc.labmcfc_template.mobile_html%type;

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
v_seojson 		  jsonb;
v_seodataid numeric;
v_seodataguid varchar(200);

v_asset_type_id numeric;
v_is_custom numeric;
-- v_custom_alias character varying ;
v_is_required numeric;
v_custom_alias character varying ;
v_ent_role_map_id  numeric;
v_is_amp numeric;
v_is_protected numeric;
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
                v_json->'data'->>'published_version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'status',
                v_json->'data'->>'guid',
                v_json->'data'->>'asset_type_id',
                v_json->'data'->'seo',
                v_json->'data'->>'is_custom',
                v_json->'data'->>'is_amp',
				v_json->'data'->>'is_protected'
                

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
                v_page_guid,
                v_asset_type_id,
                v_seojson,
                v_is_custom,
				v_is_amp,
				v_is_protected
                -- v_is_required
                ;
                
    select 'custom_'  
	into v_custom_alias;
			
			
			v_alias := case when v_alias='home' then '' else v_alias end ;
	-- raise notice '%',v_page_id;
   --  select 1/0;
    --------------------------------------------------------------------------------------------------------
    if (v_page_id  is null )
    then
		
        /***
        insert page information
        ***/
        
        v_page_guid    	 := uuid_generate_v4();	
        v_page_id        := nextval('labmcfc.seq_labmcfc_page_id');
        
        v_json 	         := jsonb_set(v_json, '{data,page_id}', v_page_id::text::jsonb, true);
        v_json 	         := jsonb_set(v_json, '{data,page_guid}', ('"'||v_page_guid||'"')::text::jsonb, true);
          
          
          
          v_custom_alias:=v_custom_alias||v_page_id::text;
		
		   
          insert into labmcfc.labmcfc_page
          (
          page_id,
          alias,
          title, 
          page_level, 
          upfront, 
          upfront_app, 
          upfront_mobile, 
          is_wrapper, 
          parent_id,
          visible, 
          visible_app, 
          visible_mobile, 
          scheduled_publish, 
          scheduled_unpublish, 
          ordering, 
          title_mobile, 
          title_app, 
          is_redirect, 
          published_version_number, 
          created_date, 
          updated_date, 
          created_by, 
          updated_by, 
          is_active, 
          is_deleted, 
          is_published, 
          page_guid,
          asset_type_id,
          is_custom_menu,
		  is_amp,
		  show_in_sitemap,
		  is_protected  
          )    
          values
          (
          v_page_id, 
          (case when v_is_custom = 1 then v_custom_alias else v_alias end),
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
          v_sysdate, 
          v_sysdate, 
          v_updated_by, 
          v_updated_by,
          1, 
          0, 
          v_status, 
          v_page_guid,
          v_asset_type_id,
          v_is_custom,
		  v_is_amp,
		  v_visible,
			  v_is_protected
        );    
         
        -- select v_json->'data'->'templatedata'
        -- into   v_templatejson;   
         -- select v_json->'data'->'templatedata'->'data'->>'layout_id',
            --   v_json->'data'->'templatedata'->'data'->>'template_name',
           --    v_json->'data'->'templatedata'->'data'->>'parent_id',
           --    v_json->'data'->'templatedata'->'data'->>'is_responsive',
           --    v_json->'data'->'templatedata'->'data'->>'mobile_html'
        -- into   v_t_layout_id,v_t_template_name,v_t_parent_id, v_is_responsive, v_mobile_html ;
        --- insert data into seo data ---
        
          
          select v_json->'data'->>'entitydata'
                         into   v_entityjson;
         -- select A from json_array_elements(v_entityjson)
         select aa->>'entity_role_map_id' into v_ent_role_map_id 
         from (select  json_array_elements(v_entityjson) as aa
        )b 
       where (aa->>'entity_role_map_id')::text::numeric in (select erm.entity_role_map_id
                                                        from   labmcfc.labmcfc_entity_category ec
                                                       join   labmcfc.labmcfc_entity_role_map erm
                                                      on     erm.entity_role_id = ec.entity_role_id
                                                      where  category_name = 'Language'
										);
       
     
	  -- select 1/0;
        
        
        ----insert data into asset_list ---
		insert into labmcfc.labmcfc_asset_list
					(
					asset_list_id,
					asset_id,
					asset_type_id,
					asset_title,
					title_alias,
					author_id,
					short_desc,
					tags,
					primary_entity_role_map_id,
					secondary_entity_role_map_id,
					total_assets,
					image_file_name,
					image_path,
					duration,
					show_in_web,
					show_in_mobile,
					show_in_app,
					published_version_number,
					is_trashed,
					created_date,
					updated_date,
					created_by,
					updated_by,
					is_active,
					is_deleted,
					is_published,
					published_date,
					asset_guid,
					show_copyright,
					order_number,
					short_title
					) 
					   values( 
					 nextval('labmcfc.seq_labmcfc_asset_list_id'),
					 v_page_id,
				     v_asset_type,
					 v_title,
					 (case when v_is_custom = 1 then v_custom_alias else v_alias end),
					 41,
					 null,
					 null,
					 v_ent_role_map_id,
					 v_ent_role_map_id,
					 null,
					 null,
					 null,
					 null,
					 0,
					 0,
					 0,
					 1,
					 0,       
					 current_timestamp at time zone 'utc',
					 current_timestamp at time zone 'utc',
					 1,
					 1,
					 1,
					 0,
					 1,
					current_timestamp at time zone 'utc',
					uuid_generate_v4(),
					null,
					null,
					null
					);
               
        else
        
          update labmcfc.labmcfc_page
          set alias =(case when v_is_custom = 1 then v_custom_alias else v_alias end),
              title=v_title,
              page_level=v_page_level,
              upfront=v_upfront,
              ordering=v_ordering,
              updated_by=v_updated_by,
              updated_date=v_sysdate,
              visible= v_visible, 
             visible_app= v_visible_app, 
             visible_mobile=v_visible_mobile,
             title_mobile=v_title_mobile,
              title_app=v_title_app,
              is_published=v_status,
              asset_type_id=v_asset_type_id,
              is_custom_menu=v_is_custom,
              is_amp=v_is_amp,
			  show_in_sitemap=v_visible,
			  is_protected=v_is_protected
          where page_id=v_page_id;
		  
		  -- update asset_id ----
		  update labmcfc.labmcfc_asset_list
		  set title_alias=(case when v_is_custom = 1 then v_custom_alias else v_alias end),
		      asset_title=v_title
		  where asset_id=v_page_id
		  and asset_type_id=v_asset_type

		  ;
       
         -- update seo data ----
         
         -- raise notice '%',v_seojson;
         -- raise notice '%',v_page_id;
         -- raise notice '%',v_asset_type;
          
       -- select 1/0;
         
         -- update labmcfc.labmcfc_seo_data
			-- set    meta_info 	 = v_seojson,
			--  updated_date  = v_sysdate
				--  where  asset_type_id = v_asset_type
				--  and    asset_id      = v_page_id;
        
        -- update seo data----
    end if;
    -----------
    delete from labmcfc.labmcfc_seo_data
    where asset_id=v_page_id
    and asset_type_id=v_asset_type ;
    v_seodataid := nextval('labmcfc.seq_labmcfc_seo_data_id');
	v_seodataguid := uuid_generate_v4();
    
    insert into labmcfc.labmcfc_seo_data(seo_data_id,
										   asset_id,
										   asset_type_id,
										   meta_info,
										   published_version_number,
										   created_date,
										   updated_date,
										   created_by,
										   updated_by,
										   is_active,
										   is_deleted,
										   is_published,
										   seo_data_guid)
			values(v_seodataid,
					 v_page_id,
					 v_asset_type,
					 v_seojson,
					 v_published_version_number,
					 v_sysdate,
					 v_sysdate,
					 v_updated_by,
					 v_updated_by,
					 1,
					 0,
					 v_status,
					 v_seodataguid);
    
    
    
    
    --  entity data---     
                     delete from labmcfc.labmcfc_asset_entity_map 
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
                                  v_entity->>'is_visible',
                                  v_entity->>'is_required',
                                  v_entity->>'is_deleted'
                           into   v_entityrolemapid,
                                  v_priority,
                                  v_islinkable,
                                  v_isvisible,
                                  v_is_required,
                                  v_is_deleted
                                  ;

                      if (v_entityrolemapid is not null and v_priority is not null) then

                           v_assetentitymapid   := nextval('labmcfc.seq_labmcfc_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();
                           
                           insert into labmcfc.labmcfc_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required)
                          values(v_assetentitymapid, v_page_id, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, v_is_deleted, 
                          1, v_assetentitymapguid,v_is_required);
                          
                        /* comment on dated 20171208 
                        if v_asset_type_id is not null then 
                            
                           insert into labmcfc.labmcfc_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required)
                          values(v_assetentitymapid, v_page_id, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, v_is_deleted, 
                          1, v_assetentitymapguid,v_is_required);
                          else 
                           insert into labmcfc.labmcfc_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required)
                          values(v_assetentitymapid, v_page_id, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 0, v_is_deleted, 
                          0, v_assetentitymapguid,v_is_required);
                          end if;
                          */
                       end if;
                      end loop;
                    end if;
              -- entity data -- 
      p_result:=v_page_id;        
      p_data := v_json;

end;

 

 
 

 

$$;


--
