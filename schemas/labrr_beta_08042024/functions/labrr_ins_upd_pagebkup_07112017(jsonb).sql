-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_ins_upd_pagebkup_07112017(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_pagebkup_07112017(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_ins_upd_pagebkup_07112017(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

 
 

 

 

declare 

v_page_id        				labRR.labRR_page.page_id%type;
v_alias        					labRR.labRR_page.alias%type;
v_title        					labRR.labRR_page.title%type;
v_page_level        			labRR.labRR_page.page_level%type;
v_upfront        				labRR.labRR_page.upfront%type;
v_upfront_app        			labRR.labRR_page.upfront_app%type;
v_upfront_mobile        		labRR.labRR_page.upfront_mobile%type;
v_is_wrapper        			labRR.labRR_page.is_wrapper%type;
v_page_parent_id        	    labRR.labRR_page.parent_id%type;
v_visible        				labRR.labRR_page.visible%type;
v_visible_app       	 		labRR.labRR_page.visible_app%type;
v_visible_mobile        		labRR.labRR_page.visible_mobile%type;
v_scheduled_publish        		labRR.labRR_page.scheduled_publish%type;
v_scheduled_unpublish        	labRR.labRR_page.scheduled_unpublish%type;
v_ordering        				labRR.labRR_page.ordering%type;
v_title_mobile        			labRR.labRR_page.title_mobile%type;
v_title_app        				labRR.labRR_page.title_app%type;
v_is_redirect        			labRR.labRR_page.is_redirect%type;
v_published_version_number      labRR.labRR_page.published_version_number%type;
v_created_date        			labRR.labRR_page.created_date%type;
v_updated_date        			labRR.labRR_page.updated_date%type;
v_created_by        			labRR.labRR_page.created_by%type;
v_updated_by        			labRR.labRR_page.updated_by%type;
v_is_active        				labRR.labRR_page.is_active%type;
v_is_deleted        			labRR.labRR_page.is_deleted%type;
v_status        			labRR.labRR_page.is_published%type;
v_page_guid        				labRR.labRR_page.page_guid%type;

v_template_id        			labRR.labRR_template.template_id%type;
v_template_name        			labRR.labRR_template.template_name%type;
v_template_desc        			labRR.labRR_template.template_desc%type;
v_layout_id        				labRR.labRR_template.layout_id%type;
v_is_inherited        			labRR.labRR_template.is_inherited%type;
v_template_parent_id            labRR.labRR_template.parent_id%type;
v_template_guid        			labRR.labRR_template.template_guid%type;
v_json							jsonb;
v_sysdate						timestamp;
v_is_responsive labRR.labRR_template.is_responsive%type;
v_mobile_html  labRR.labRR_template.mobile_html%type;

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
                v_json->'data'->>'is_custom'
               --  v_json->'data'->>'is_required',
                

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
                v_is_custom
                -- v_is_required
                ;
                
    select 'custom_'  
	into v_custom_alias;
			
	-- --raise notice '%',v_page_id;
   --  select 1/0;
    --------------------------------------------------------------------------------------------------------
    if (v_page_id  is null )
    then
		
        /***
        insert page information
        ***/
        
        v_page_guid    	 := uuid_generate_v4();	
        v_page_id        := nextval('labRR.seq_labRR_page_id');
        
        v_json 	         := jsonb_set(v_json, '{data,page_id}', v_page_id::text::jsonb, true);
        v_json 	         := jsonb_set(v_json, '{data,page_guid}', ('"'||v_page_guid||'"')::text::jsonb, true);
          
          
          
          v_custom_alias:=v_custom_alias||v_page_id::text;
          insert into labRR.labRR_page
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
          is_custom_menu
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
          v_is_custom
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
        
        
        ----insert data into seo data ---
        
        
        
        else
        
          update labRR.labRR_page
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
              is_custom_menu=v_is_custom
              
          where page_id=v_page_id;
       
         -- update seo data ----
         
          --raise notice '%',v_seojson;
          --raise notice '%',v_page_id;
          --raise notice '%',v_asset_type;
          
       -- select 1/0;
         
         -- update labRR.labRR_seo_data
			-- set    meta_info 	 = v_seojson,
			--  updated_date  = v_sysdate
				--  where  asset_type_id = v_asset_type
				--  and    asset_id      = v_page_id;
        
        -- update seo data----
    end if;
    -----------
    delete from labRR.labRR_seo_data
    where asset_id=v_page_id
    and asset_type_id=v_asset_type ;
    v_seodataid := nextval('labRR.seq_labRR_seo_data_id');
	v_seodataguid := uuid_generate_v4();
    
    insert into labRR.labRR_seo_data(seo_data_id,
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
                     delete from labRR.labRR_asset_entity_map 
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
                                  v_entity->>'is_required'
                           into   v_entityrolemapid,
                                  v_priority,
                                  v_islinkable,
                                  v_isvisible,
                                  v_is_required
                                  ;

                      if (v_entityrolemapid is not null and v_priority is not null) then

                           v_assetentitymapid   := nextval('labRR.seq_labRR_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();

                           insert into labRR.labRR_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required)
                          values(v_assetentitymapid, v_page_id, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                          1, v_assetentitymapguid,v_is_required);
                       end if;
                      end loop;
                    end if;
              -- entity data -- 
      p_result:=v_page_id;        
      p_data := v_json;

end;

 

 
 

 
$$;


--
