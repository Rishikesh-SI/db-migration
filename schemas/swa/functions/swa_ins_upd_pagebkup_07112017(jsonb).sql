-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_ins_upd_pagebkup_07112017(jsonb)
-- Type: FUNCTION

-- Name: swa_ins_upd_pagebkup_07112017(jsonb); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_ins_upd_pagebkup_07112017(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 
 

 

 

declare 

V_page_id        				swa.swa_page.page_id%TYPE;
V_alias        					swa.swa_page.alias%TYPE;
V_title        					swa.swa_page.title%TYPE;
V_page_level        			swa.swa_page.page_level%TYPE;
V_upfront        				swa.swa_page.upfront%TYPE;
V_upfront_app        			swa.swa_page.upfront_app%TYPE;
V_upfront_mobile        		swa.swa_page.upfront_mobile%TYPE;
V_is_wrapper        			swa.swa_page.is_wrapper%TYPE;
V_page_parent_id        	    swa.swa_page.parent_id%TYPE;
V_visible        				swa.swa_page.visible%TYPE;
V_visible_app       	 		swa.swa_page.visible_app%TYPE;
V_visible_mobile        		swa.swa_page.visible_mobile%TYPE;
V_scheduled_publish        		swa.swa_page.scheduled_publish%TYPE;
V_scheduled_unpublish        	swa.swa_page.scheduled_unpublish%TYPE;
V_ordering        				swa.swa_page.ordering%TYPE;
V_title_mobile        			swa.swa_page.title_mobile%TYPE;
V_title_app        				swa.swa_page.title_app%TYPE;
V_is_redirect        			swa.swa_page.is_redirect%TYPE;
V_published_version_number      swa.swa_page.published_version_number%TYPE;
V_created_date        			swa.swa_page.created_date%TYPE;
V_updated_date        			swa.swa_page.updated_date%TYPE;
V_created_by        			swa.swa_page.created_by%TYPE;
V_updated_by        			swa.swa_page.updated_by%TYPE;
V_is_active        				swa.swa_page.is_active%TYPE;
V_is_deleted        			swa.swa_page.is_deleted%TYPE;
V_status        			swa.swa_page.is_published%TYPE;
V_page_guid        				swa.swa_page.page_guid%TYPE;

V_template_id        			swa.swa_template.template_id%TYPE;
V_template_name        			swa.swa_template.template_name%TYPE;
V_template_desc        			swa.swa_template.template_desc%TYPE;
V_layout_id        				swa.swa_template.layout_id%TYPE;
V_is_inherited        			swa.swa_template.is_inherited%TYPE;
V_template_parent_id            swa.swa_template.parent_id%TYPE;
V_template_guid        			swa.swa_template.template_guid%TYPE;
v_json							jsonb;
v_sysdate						timestamp;
v_is_responsive swa.swa_template.is_responsive%type;
v_mobile_html  swa.swa_template.mobile_html%type;

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
                COALESCE((v_json->'data'->>'scheduled_publish')::TIMESTAMP,v_sysdate)::TIMESTAMP,
                COALESCE((v_json->'data'->>'scheduled_unpublish')::TIMESTAMP,v_sysdate)::TIMESTAMP, 
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
                V_page_guid,
                v_asset_type_id,
                v_seojson,
                v_is_custom
                -- v_is_required
                ;
                
    select 'custom_'  
	into v_custom_alias;
			
	-- raise notice '%',V_page_id;
   --  select 1/0;
    --------------------------------------------------------------------------------------------------------
    IF (V_page_id  is null )
    THEN
		
        /***
        Insert page information
        ***/
        
        V_page_guid    	 := uuid_generate_v4();	
        V_page_id        := nextval('swa.seq_swa_page_id');
        
        v_json 	         := jsonb_set(v_json, '{data,page_id}', v_page_id::text::jsonb, true);
        v_json 	         := jsonb_set(v_json, '{data,page_guid}', ('"'||v_page_guid||'"')::text::jsonb, true);
          
          
          
          v_custom_alias:=v_custom_alias||V_page_id::text;
          INSERT INTO swa.swa_PAGE
          (
          page_id,
          ALIAS,
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
          VALUES
          (
          V_page_id, 
          (case when v_is_custom = 1 then v_custom_alias else V_alias end),
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
          v_sysdate, 
          v_sysdate, 
          V_updated_by, 
          V_updated_by,
          1, 
          0, 
          V_status, 
          V_page_guid,
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
        
          update swa.swa_PAGE
          set ALIAS =(case when v_is_custom = 1 then v_custom_alias else V_alias end),
              title=V_title,
              page_level=V_page_level,
              upfront=V_upfront,
              ordering=V_ordering,
              updated_by=V_updated_by,
              updated_date=v_sysdate,
              visible= V_visible, 
             visible_app= V_visible_app, 
             visible_mobile=V_visible_mobile,
             title_mobile=V_title_mobile,
              title_app=V_title_app,
              is_published=V_status,
              asset_type_id=v_asset_type_id,
              is_custom_menu=v_is_custom
              
          where page_id=V_page_id;
       
         -- update seo data ----
         
          raise notice '%',v_seojson;
          raise notice '%',V_page_id;
          raise notice '%',v_asset_type;
          
       -- select 1/0;
         
         -- update swa.swa_seo_data
			-- set    meta_info 	 = v_seojson,
			--  updated_date  = v_sysdate
				--  where  asset_type_id = v_asset_type
				--  and    asset_id      = V_page_id;
        
        -- update seo data----
    END IF;
    -----------
    delete from swa.swa_seo_data
    where asset_id=V_page_id
    and asset_type_id=v_asset_type ;
    v_seodataid := nextval('swa.seq_swa_seo_data_id');
	v_seodataguid := uuid_generate_v4();
    
    insert into swa.swa_seo_data(seo_data_id,
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
					 V_page_id,
					 v_asset_type,
					 v_seojson,
					 V_published_version_number,
					 v_sysdate,
					 v_sysdate,
					 V_updated_by,
					 V_updated_by,
					 1,
					 0,
					 V_status,
					 v_seodataguid);
    
    
    
    
    --  ENTITY DATA---     
                     DELETE FROM swa.swa_asset_entity_map 
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
                                  v_entity->>'is_visible',
                                  v_entity->>'is_required'
                           into   v_entityrolemapid,
                                  v_priority,
                                  v_islinkable,
                                  v_isvisible,
                                  v_is_required
                                  ;

                      if (v_entityrolemapid is not null and v_priority is not null) then

                           v_assetentitymapid   := nextval('swa.seq_swa_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();

                           insert into swa.swa_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required)
                          values(v_assetentitymapid, V_page_id, v_asset_type, 
                          v_entityrolemapid, COALESCE(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 
                          1, v_assetentitymapguid,v_is_required);
                       END IF;
                      END LOOP;
                    END IF;
              -- ENTITY DATA -- 
      p_result:=V_page_id;        
      p_data := v_json;

END;

 

 
 

$$;


--
