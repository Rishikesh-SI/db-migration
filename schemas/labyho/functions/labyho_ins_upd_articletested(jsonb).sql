-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_ins_upd_articletested(jsonb)
-- Type: FUNCTION

-- Name: labyho_ins_upd_articletested(jsonb); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_ins_upd_articletested(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

--do
--$$
declare
/*	p_json jsonb :='';
      p_result numeric;
      p_data jsonb;
      */
     -- p_asset_type numeric =
     v_json             	  jsonb;
	v_articleid        	  numeric;
	v_status           	  numeric;
	v_assetdraftid     	  numeric;
	v_assetid          	  numeric;
	v_assettypeid      	  numeric;
	v_createdby        	  numeric;
	v_updatedby        	  numeric;
	v_assetdraftguid   	  varchar(50);
	v_versionnumber    	  numeric := 1;
	v_contentsourceid  	  numeric;
	v_title        	      varchar(4000);
	v_titlealias       	  varchar(4000);
	v_browsertitle     	  varchar(4000);
	v_highlights    	  jsonb;
	v_place            	  varchar(4000);
	v_country             varchar(4000);
	v_fulltext            text;
	v_introtext           text;
	v_published_date      timestamp;
	v_articleguid         varchar(50);
	v_assetentitymapid    numeric;
	v_entityrolemapid     numeric;
	v_priority 	    	  numeric;
	v_islinkable  		  numeric;
	v_isvisible  		  numeric;
	v_assetentitymapguid  varchar(50);
	v_seojson 		      jsonb;
	v_seodataid 		  numeric;
	v_seodataguid 		  varchar(50);
	v_entityjson 		  json;
	v_entity 			  json;
	v_articleexists 	  numeric;
	v_seoexists 		  numeric;
	v_entityexists 	      numeric;
	v_currenttimestamp    timestamp;
	v_articleassetmapjson json;
	v_articleassetmap	  json;
	v_aam_assetid		  numeric;
	v_aam_assettypeid	  numeric;
	v_articleassetmapid   numeric;
	v_articleassetmapguid varchar(50);
	v_assetmetajson       jsonb;
	v_is_trashed          numeric;
	v_authordatajson      json;
	v_authordata          jsonb;
	v_author_id           numeric;        
	v_action_id           numeric;
	v_authoractionid      numeric;
	v_pubversionnumber    numeric;
	v_show_copyright 	  numeric;
	v_show_in_web 		  numeric;
	v_show_in_mobile  	  numeric;
	v_content_source_link varchar(4000);
	v_order_number 	      numeric;
	v_asset_list_id 	  numeric;
	v_image_file_name 	  varchar(4000);
	v_image_path 		  varchar(4000);
	v_imageid 		      numeric;
	v_is_cover 		      numeric;
	v_continue		      numeric := 0;
    v_slugurl			  varchar(4000);
    p_result1             numeric;
	v_titlealias_exists   numeric := 0;
    v_ispublished         numeric;
    v_lang_erm_id         numeric;
    v_lang_index          numeric;
    v_lang_curl text;
	v_assettype_liveblog  numeric ; 
	v_is_liveblog 		  numeric ; 
    v_assettype_liveblog1 numeric;
begin
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
	--v_json := p_json;
	
	select p_json->'data' into p_json;
	v_json:='{"data":'||p_json::json||'}';
	
	select v_json->'data'->>'article_id',
     	  	v_json->'data'->>'status',
            v_json->'data'->>'asset_type',
            v_json->'data'->>'created_by',
            v_json->'data'->>'edited_by',
            v_json->'data'->>'content_source_id',
            v_json->'data'->>'title',
            v_json->'data'->>'browser_title',
            v_json->'data'->>'highlights',
            v_json->'data'->>'place',
		  	v_json->'data'->>'country',
            v_json->'data'->>'full_text',
            v_json->'data'->>'intro_text',
            v_json->'data'->'seo',
            v_json->'data'->>'asset_meta',
            v_json->'data'->>'published_date',
            v_json->'data'->>'is_trashed',
            v_json->'data'->>'show_copyright',
            v_json->'data'->>'show_in_web',
            v_json->'data'->>'show_in_mobile',
            v_json->'data'->>'content_source_link',
            v_json->'data'->>'order_number',
            v_json->'data'->>'image_id',
            v_json->'data'->>'image_file_name',
            v_json->'data'->>'image_path',
            v_json->'data'->>'slug_url',
			v_json->'data'->>'is_live_blog'
	into v_articleid,
    		v_status,
            v_assettypeid,
            v_createdby,
            v_updatedby,
            v_contentsourceid,
            v_title,
            v_browsertitle,
            v_highlights,
            v_place,
            v_country,
            v_fulltext,
            v_introtext,
            v_seojson,
            v_assetmetajson,
            v_published_date,
            v_is_trashed,
            v_show_copyright,
            v_show_in_web,
            v_show_in_mobile,
            v_content_source_link,
            v_order_number,
            v_imageid,
            v_image_file_name,
            v_image_path,
            v_titlealias,
		  v_is_liveblog;
	
    -- select labyho.labyho_ins_up_redirect(v_articleid,v_titlealias,v_status,v_assettypeid) into p_result1;
	
    v_published_date := coalesce(v_published_date,v_currenttimestamp);
    v_assetdraftid := nextval('labyho.seq_labyho_asset_draft_id');
    v_assetdraftguid := uuid_generate_v4();
	
      raise notice '% check blog ',v_is_liveblog;
	--  for live blog asset type   on dated 20181113 added 
	
   
     
     
     v_assettypeid := (case when  v_is_liveblog = 1  
                              then 5 else v_assettypeid end) ;
     
       if v_is_liveblog=1 then 
      v_json := jsonb_set(v_json, '{data,asset_type}', v_assettypeid::text::jsonb, true);
      end if;
     
     raise notice '% v_assettypeid',v_assettypeid;
       if  v_articleid is not null and v_status = 1 then 
     
    		 if (v_is_liveblog is null or v_is_liveblog =0 ) then 
           
           update labyho.labyho_asset_list
           set asset_type_id=1
           where asset_id=v_articleid and asset_type_id=5;
           
            update labyho.labyho_redirect
           set asset_type_id=1
           where asset_id=v_articleid and asset_type_id=5;
  
           else 
           
		raise notice '% v_assettype_liveblog',12345;
		   
            update labyho.labyho_asset_list
            set asset_type_id=5
            where asset_id=v_articleid and asset_type_id=1;
           
           
           update labyho.labyho_redirect
           set asset_type_id=5
           where asset_id=v_articleid and asset_type_id=1;
       
       --    update labyho.labyho_asset_entity_map
       --    set asset_type_id=5
       --    where asset_id=v_articleid and asset_type_id=1;
           
            end if ;
           
         end if;
		-- v_assettype_liveblog1 := coalesce(v_assettype_liveblog1,v_assettype_liveblog);
		
		select (case is_live_blog when 1 then 5 else 1 end )  into v_assettype_liveblog from labyho.labyho_article
		where article_id=v_articleid;
		
          
		 raise notice '% v_assettype_liveblog',v_assettype_liveblog;
                    
         -- raise notice '% check asset ',v_assettype_liveblog;
    
    if v_articleid is null then
    	
        if not exists (select 1 from labyho.labyho_article where upper(title_alias) = upper(v_titlealias)) then
        	
            v_assetid := nextval('labyho.seq_labyho_article_id');
            v_articleguid := uuid_generate_v4();
            v_seodataid := nextval('labyho.seq_labyho_seo_data_id');
            v_seodataguid := uuid_generate_v4();
            v_asset_list_id := nextval ('labyho.seq_labyho_asset_list_id');
             v_json := jsonb_set(v_json, '{data,article_id}', v_assetid::text::jsonb, true);
            v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_articleguid||'"')::text::jsonb, true);
            -- v_json := jsonb_set(v_json, '{data,published_date}', ('"'||v_published_date||'"')::text::jsonb, true);
           --  v_titlealias := v_titlealias||'-'||v_assetid;
            v_json := jsonb_set(v_json, '{data,slug_url}', ('"'||v_titlealias||'"')::text::jsonb, true);
			
			
            
            insert into labyho.labyho_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,created_by,
                                            updated_by,is_active,is_deleted,asset_draft_guid)
			values(v_assetdraftid,v_assetid,v_assettypeid,v_versionnumber,v_json,v_currenttimestamp,v_currenttimestamp,v_createdby,v_updatedby,1,0,
                   v_assetdraftguid);
			
            insert into labyho.labyho_article(article_id,content_source_id,asset_meta,title,title_alias,browser_title,highlights,content_source,place,
                                        country,show_in_app,disclaimer_text,checked_out_by,full_text,intro_text,published_version_number,created_date,
                                        updated_date,created_by,updated_by,is_active,is_deleted,is_published,is_trashed,article_guid,published_date,
                                        show_in_web,show_in_mobile,show_copyright,content_source_link,order_number,slug_url,is_live_blog)
			values(v_assetid,v_contentsourceid,v_assetmetajson,v_title,v_titlealias,v_browsertitle,v_highlights,null,v_place,v_country,0,null,null,
                   v_fulltext,v_introtext,v_versionnumber,v_currenttimestamp,v_currenttimestamp,v_createdby,v_updatedby,1,0,v_status,v_is_trashed,
                   v_articleguid,v_published_date,v_show_in_web,v_show_in_mobile,v_show_copyright,v_content_source_link,v_order_number,v_slugurl,v_is_liveblog);
			
            insert into labyho.labyho_asset_list(asset_list_id,asset_id,asset_type_id,asset_title,title_alias,author_id,short_desc,tags,
                                           primary_entity_role_map_id,secondary_entity_role_map_id,total_assets,image_file_name,image_path,duration,
                                           show_in_web,show_in_mobile,show_in_app,published_version_number,is_trashed,created_date,updated_date,
                                           created_by,updated_by,is_active,is_deleted,is_published,published_date,asset_guid,show_copyright,
                                           order_number)
			values(v_asset_list_id,v_assetid,v_assettypeid, -- v_assettypeid   --== commented on 20181113 for liveblog article.
				   v_title,v_titlealias,null,v_introtext,null,null,null,null,v_image_file_name,v_image_path,
                   null,v_show_in_web,v_show_in_mobile,0,v_versionnumber,v_is_trashed,v_currenttimestamp,v_currenttimestamp,v_updatedby,v_updatedby,1,
                   0,v_status,v_published_date,v_articleguid,v_show_copyright,v_order_number);
			
            insert into labyho.labyho_seo_data(seo_data_id,asset_id,asset_type_id,meta_info,published_version_number,created_date,updated_date,created_by,
                                         updated_by,is_active,is_deleted,is_published,seo_data_guid)
			values(v_seodataid,v_assetid,v_assettypeid,v_seojson,v_versionnumber,v_currenttimestamp,v_currenttimestamp,v_createdby,v_updatedby,1,0,
                   v_status,v_seodataguid);
			
		else
        	
            v_titlealias_exists := 1;
            p_data := '{"data":{}}';
            p_result := 0; 
            return;
            
		end if;
        
	else
    	
        if v_status = 0 then
        	
            if v_is_trashed = 0 then
            	
                select coalesce(max(published_version_number),1)
                into   strict v_pubversionnumber
                from   labyho.labyho_article
                where  article_id = v_articleid;
                
				select max(version_number)
                into   strict v_versionnumber
                from   labyho.labyho_asset_draft
                where  asset_type_id = v_assettype_liveblog
                and    asset_id      = v_articleid;
                
                if v_versionnumber > v_pubversionnumber then
                	
                    update labyho.labyho_asset_draft ad
                    set    asset_data        = v_json,
                    		updated_date     = v_currenttimestamp
					where  asset_id          = v_articleid
                    and    asset_type_id     = v_assettype_liveblog
                    and    ad.version_number = (select max(ad1.version_number)
                                                from   labyho.labyho_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
					
				else
                	
                    v_versionnumber := v_versionnumber + 1;
                    
                    insert into labyho.labyho_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,
                                                    created_by,updated_by,is_active,is_deleted,asset_draft_guid)
					values(v_assetdraftid,v_articleid,v_assettypeid,v_versionnumber,v_json,v_currenttimestamp,v_currenttimestamp,v_createdby,
                           v_updatedby,1,0,v_assetdraftguid);
					
				end if;
                
			else
            	
                update labyho.labyho_article
                set    is_published  = v_status,
                		is_trashed   = 1,
                        updated_date = v_currenttimestamp
				where  article_id    = v_articleid;
                
                update labyho.labyho_asset_draft ad
                set    asset_data         = v_json,
                		updated_date      = v_currenttimestamp
				where  asset_id           = v_articleid
                and    asset_type_id      = v_assettypeid
                and    ad.version_number  = (select max(ad1.version_number)
                                             from   labyho.labyho_asset_draft ad1
                                             where  ad1.asset_id = ad.asset_id
                                             and ad1.asset_type_id = ad.asset_type_id);
				
                update labyho.labyho_asset_list
                set    updated_date  = v_currenttimestamp,
                		updated_by   = v_updatedby,
                        is_active    = 0,
                        is_deleted   = 1,
                        is_published = v_status,
                        is_trashed   = v_is_trashed
				where  asset_id      = v_articleid
          		and    asset_type_id = v_assettypeid;
                
                select max(ad1.version_number)
                into   v_versionnumber
                from   labyho.labyho_asset_draft ad1
                where  ad1.asset_id = v_articleid
                and    ad1.asset_type_id = v_assettype_liveblog;
                
			end if;
            
		else
        	
            select max(version_number)
            into   strict v_versionnumber
            from   labyho.labyho_asset_draft
            where  asset_type_id = v_assettype_liveblog
            and    asset_id      = v_articleid;
            
            v_versionnumber := v_versionnumber + 1;
            
            select is_published into v_ispublished from labyho.labyho_article where article_id = v_articleid;
            
          --  if coalesce(substring(v_titlealias,'.*-(\d+)$')::numeric,0) <> v_articleid then
            	
            --    v_titlealias := v_titlealias||'-'||v_articleid;
           --     v_json := jsonb_set(v_json, '{data,slug_url}', ('"'||v_titlealias||'"')::text::jsonb, true);
                
                
                
         --   end if;
            
            	if v_ispublished = 1 then
            		select labyho.labyho_ins_up_redirect(v_articleid,v_titlealias,v_status,v_assettypeid) into p_result1;
            	end if;
                
            
            insert into labyho.labyho_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,created_by,
                                            updated_by,is_active,is_deleted,asset_draft_guid)
			values(v_assetdraftid,v_articleid,v_assettypeid,v_versionnumber,v_json,v_currenttimestamp,v_currenttimestamp,v_createdby,v_updatedby,1,0,
                   v_assetdraftguid);
			
            update labyho.labyho_article
            set    content_source_id 	     = v_contentsourceid,
            		asset_meta        	     = v_assetmetajson,
                    title        	         = v_title,
                    title_alias       	     = v_titlealias,
                    browser_title     	     = v_browsertitle,
                    highlights    	         = v_highlights,
                    content_source    	     = null,
                    place             	     = v_place,
                    country 			     = v_country,
                    show_in_app       	     = 0,
                    disclaimer_text   	     = null,
                    checked_out_by    	     = null,
                    full_text         	     = v_fulltext,
                    intro_text        	     = v_introtext,
                    published_version_number = v_versionnumber,
                    updated_date      	     = v_currenttimestamp,
                    created_by        	     = v_createdby,
                    updated_by        	     = v_updatedby,
                    is_active         	     = 1,
                    is_deleted        	     = 0,
                    is_published      	     = v_status,
                    is_trashed        	     = v_is_trashed,
                    published_date           = v_published_date,
                    show_in_web          	 = v_show_in_web,
                    show_in_mobile           = v_show_in_mobile,
                    show_copyright           = v_show_copyright,
                    content_source_link      = v_content_source_link,
                    order_number             = v_order_number,
                    slug_url                 = v_titlealias,
					is_live_blog			 =v_is_liveblog
			where article_id        	     = v_articleid;
            
            update labyho.labyho_seo_data
            set    meta_info 	 = v_seojson,
            		updated_date = v_currenttimestamp,
					asset_type_id=v_assettypeid
			where  asset_type_id = v_assettype_liveblog
            and    asset_id      = v_articleid;
            
           
            raise notice '% check 2 ',v_assettype_liveblog;
            
            raise notice '% check 3 ',v_assettype_liveblog1;
            
            raise notice '% check 4 ',v_is_liveblog;
            
            raise notice '% check 5 ',v_articleid;
            update labyho.labyho_asset_list
            set    asset_title        	     = v_title,
            		title_alias       	     = v_titlealias,
                    short_desc    	         = v_introtext,
                    show_in_app       	     = 0,
                    published_version_number = v_versionnumber,
                    updated_date      	     = v_currenttimestamp,
                    updated_by        	     = v_updatedby,
                    is_active         	     = 1,
                    is_deleted        	     = 0,
                    is_published      	     = v_status,
                    is_trashed        	     = v_is_trashed,
                    published_date           = v_published_date,
                    show_in_web              = v_show_in_web,
                    show_in_mobile           = v_show_in_mobile,
                    show_copyright           = v_show_copyright,
                    order_number 			 = v_order_number
					-- is_live_blog			 = v_is_liveblog,
					-- asset_type_id 			 = v_assettype_liveblog 
                where asset_id        	         = v_articleid
        		and asset_type_id     	   =v_assettypeid	 ;
               
                select labyho.labyho_update_showcase_meta(v_is_liveblog,v_articleid) into p_result1;
            
		end if;
		
	end if;
    
    if (v_articleid is null or (v_articleid is not null and v_status = 1)) then
    	
        select v_json->'data'->>'entitydata'
		into   v_entityjson;
        
		if v_entityjson is not null then
        	
			
			
            delete from labyho.labyho_asset_entity_map 
            where asset_type_id =v_assettype_liveblog and asset_id = v_articleid;
            
			for v_entity in select * from json_array_elements(v_entityjson)
			loop
            	
                select v_entity->>'entity_role_map_id',
                		v_entity->>'priority',
                        v_entity->>'is_linkable',
                        v_entity->>'is_visible'
				into v_entityrolemapid,
                		v_priority,
                        v_islinkable,
                        v_isvisible;
				
				if (v_entityrolemapid is not null and v_priority is not null) then
                	
                    v_assetentitymapid   := nextval('labyho.seq_labyho_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
                    
                    if exists(select 1 from labyho.labyho_entity_role_map where entity_role_map_id = v_entityrolemapid
                              and entity_role_id = (select entity_role_id from labyho.labyho_entity_category where category_name = 'Language')) then
                    	v_lang_erm_id := v_entityrolemapid;
                    end if;
                    
					insert into labyho.labyho_asset_entity_map(asset_entity_map_id,asset_id,asset_type_id,entity_role_map_id,is_linkable,is_visible,priority,
                                                         created_date,updated_date,created_by,updated_by,is_active,is_deleted,is_published,aemap_guid)
					values(v_assetentitymapid,coalesce(v_articleid, v_assetid),v_assettypeid,v_entityrolemapid,coalesce(v_islinkable,0),v_isvisible,
                           v_priority,v_currenttimestamp,v_currenttimestamp,v_createdby,v_updatedby,1,0,1,v_assetentitymapguid);
					
                    update labyho.labyho_asset_list
                    set    primary_entity_role_map_id 	 = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
                    		secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
					where  asset_id 				     = coalesce(v_articleid, v_assetid)
           			and    asset_type_id                = v_assettypeid;
					
				end if;
                
			end loop;
            
			with tab as (select asset_id,asset_type_id,aem.entity_role_map_id
					   from labyho.labyho_asset_entity_map aem
					   join labyho.labyho_entity_role_map erm
					   on erm.entity_role_map_id = aem.entity_role_map_id
					   join labyho.labyho_entity_category ec
					   on ec.entity_role_id = erm.entity_role_id
					   where ec.category_name = 'Language'
					   and aem.asset_id = coalesce(v_articleid, v_assetid)
					   and aem.asset_type_id = v_assettypeid)
			update labyho.labyho_asset_list al
			set language_id = t.entity_role_map_id
			from tab t
			where al.asset_id = t.asset_id
			and al.asset_type_id = t.asset_type_id;
               
            select array_position(entity_arr,v_lang_erm_id::text) - 1 into v_lang_index
            from (select array((select json_array_elements(v_entityjson)->>'entity_role_map_id')) entity_arr) a;
            
            select canonical_url into v_lang_curl from labyho.labyho_entity_master em
            join labyho.labyho_entity_role_map erm
            on erm.entity_master_id = em.entity_master_id
            where erm.entity_role_map_id = v_lang_erm_id;
            
            v_json := jsonb_set(v_json, ('{data,entitydata,'||v_lang_index||',is_lang}')::text[], ('"1"')::text::jsonb, true);
            v_json := jsonb_set(v_json, ('{data,entitydata,'||v_lang_index||',canonical}')::text[], ('"'||coalesce(v_lang_curl,'')||'"')::text::jsonb, true);
            
		end if;
        
		select v_json->'data'->>'asset_map'
		into   v_articleassetmapjson;
        
		if v_articleassetmapjson is not null then
        	
            delete from labyho.labyho_article_asset_map where article_id = v_articleid;
            
			for v_articleassetmap in select * from json_array_elements(v_articleassetmapjson)
			loop
            	
                select v_articleassetmap->>'asset_id',
                		v_articleassetmap->>'asset_type_id',
                        v_articleassetmap->>'is_cover'
				into v_aam_assetid,
                		v_aam_assettypeid,
                        v_is_cover;
				
				if (v_aam_assetid is not null and v_aam_assettypeid is not null) then
                	
                    v_articleassetmapid   := nextval('labyho.seq_labyho_article_asset_map_id');
					v_articleassetmapguid := uuid_generate_v4();
                    
					insert into labyho.labyho_article_asset_map(article_asset_map_id,article_id,asset_id,asset_type_id,created_date,updated_date,created_by,
                                                          updated_by,is_active,is_deleted,is_published,aamap_guid,is_cover)
					values(v_articleassetmapid,coalesce(v_articleid, v_assetid),v_aam_assetid,v_aam_assettypeid,v_currenttimestamp,v_currenttimestamp,
                           v_createdby,v_updatedby,1,0,v_status,v_articleassetmapguid,v_is_cover);
					
                    if v_is_cover = 1 then
                    	
                		select image_path,image_file_name
                        into v_image_path ,v_image_file_name
                        from labyho.labyho_image
                        where image_id = v_aam_assetid;
                        
                		update labyho.labyho_asset_list
                		set image_path = v_image_path,
                        	image_file_name = v_image_file_name
						where asset_id = coalesce(v_articleid, v_assetid)
                        and asset_type_id = v_assettypeid;
                        
              		end if;
                    
				end if;
                
            end loop;
            
		end if;
		
		select v_json->'data'->>'author_data'
		into   v_authordatajson;
        
		if v_authordatajson is not null then
        	
            delete from labyho.labyho_author_action
			where  asset_type_id = v_assettype_liveblog
			and    asset_id      = v_articleid;
            
			for v_authordata in select * from json_array_elements(v_authordatajson)
			loop
            	
                select v_authordata->>'author_id',
                		v_authordata->>'action_id'
				into v_author_id,
                		v_action_id;
				
				if (v_author_id is not null and v_action_id is not null) then
                	
					v_authoractionid := nextval('labyho.seq_labyho_author_action_id');
                    
                    insert into labyho.labyho_author_action(author_action_id,author_id,asset_id,asset_type_id,action_id,created_date,updated_date)
					values(v_authoractionid,v_author_id,coalesce(v_articleid, v_assetid),v_assettypeid,v_action_id,v_currenttimestamp,
                           v_currenttimestamp);
					
             		if v_action_id = 4 then
                    	
                        update labyho.labyho_asset_list
                        set    author_id     = coalesce(v_author_id,author_id)
                        where  asset_id      = coalesce(v_articleid, v_assetid)
                        and    asset_type_id = v_assettypeid;
                        
             		end if;
                    
				end if;
                
			end loop;
            
		end if;
        
	end if;
	
    v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
    
    update labyho.labyho_asset_draft set asset_data = v_json     
    where  version_number = v_versionnumber
    and  asset_type_id = v_assettypeid
    and asset_id = coalesce(v_articleid, v_assetid);
    
    p_result := 1;
	
    if p_result = 1 then
    	p_data := v_json;
     
      if v_status = 1
     then
     update labyho.labyho_asset_list
     set tvs = setweight(to_tsvector(coalesce(asset_title,'')), 'A')    ||
               setweight(to_tsvector(coalesce(short_desc,'')), 'B')
     where asset_id = coalesce(v_articleid, v_assetid); 

     end if;
     
	end if;
    
/*exception
	
	when others then
		p_result := -1;*/
     
end;

$_$;


--
