-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_ins_upd_contest_new(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_ins_upd_contest_new(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_ins_upd_contest_new(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
    v_json             	  jsonb;
	v_contestid        	  numeric;
	v_status           	  numeric;
	v_assetdraftid     	  numeric;
	v_assetid          	  numeric;
	v_assettypeid      	  numeric;
	v_createdby        	  numeric;
	v_updatedby        	  numeric;
	v_assetdraftguid   	  varchar;
	v_versionnumber    	  numeric := 1;
	v_contentsourceid  	  numeric;
	v_title        	      varchar;
	v_titlealias       	  varchar;
	v_browsertitle     	  varchar;
	v_highlights    	  jsonb;
	v_place            	  varchar;
	v_country             varchar;
	v_fulltext            text;
	v_introtext           text;
	v_published_date      timestamp;
	v_contestguid         varchar;
	v_assetentitymapid    numeric;
	v_entityrolemapid     numeric;
	v_priority 	    	  numeric;
	v_labgsocinkable  		  numeric;
	v_isvisible  		  numeric;
	v_assetentitymapguid  varchar;
	v_seojson 		      jsonb;
	v_seodataid 		  numeric;
	v_seodataguid 		  varchar;
	v_entityjson 		  json;
	v_entity 			  json;
	v_contestexists 	  numeric;
	v_seoexists 		  numeric;
	v_entityexists 	      numeric;
	v_currenttimestamp    timestamp;
	v_contestassetmapjson json;
	v_contestassetmap	  json;
	v_aam_assetid		  numeric;
	v_aam_assettypeid	  numeric;
	v_contestassetmapid   numeric;
	v_contestassetmapguid varchar;
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
	v_content_source_link varchar;
	v_order_number 	      numeric;
	v_asset_list_id 	  numeric;
	v_image_file_name 	  varchar;
	v_image_path 		  varchar;
	v_imageid 		      numeric;
	v_is_cover 		      numeric;
	v_continue		      numeric := 0;
    v_slugurl			  varchar;
    p_result1             numeric;
    v_ispublished         numeric;
    v_contestpublishedstatus numeric;
    v_contesttrashedstatus numeric;
    v_shorttitle varchar;
    v_entity_lang_id numeric;
	v_web_listing_json jsonb ;
	v_array numeric[];
	v_image jsonb;
    v_entity_count numeric;
    v_sitemap_json jsonb;
begin
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
	
	select p_json->'data' into p_json;
	v_json:='{"data":'||p_json::json||'}';
	
	select v_json->'data'->>'contest_id',
     	   v_json->'data'->>'status',
           v_json->'data'->>'asset_type',
           v_json->'data'->>'created_by',
           v_json->'data'->>'edited_by',
           v_json->'data'->>'content_source_id',
           v_json->'data'->>'contest_name',
           -- v_json->'data'->>'title_alias',
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
           v_json->'data'->>'short_title'
	into   v_contestid,
		   v_status,
           v_assettypeid,
           v_createdby,
           v_updatedby,
           v_contentsourceid,
           v_title,
           -- v_titlealias,
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
           v_shorttitle;
		
           
	-- insert entry in labgsoc_redirect table :- changes done by rakesh bhatkar --
    select labgsoc.labgsoc_ins_up_redirect(v_contestid,v_titlealias,v_status,v_assettypeid) into p_result1;
  	-- insert entry in labgsoc_redirect table :- changes done by rakesh bhatkar --
	
    begin
		
        select contest_id_new
     	into strict v_contestexists
     	from   labgsoc.labgsoc_contest_new
     	where  upper(title_alias) = upper(v_titlealias);
        
		if v_contestid is null then
        	v_continue := -1;
		else
        	if v_contestexists = v_contestid then
            	v_continue := 1;
          	else
           		v_continue := -1;
          	end if;
		end if;
        
     exception
     	when others then
          	v_continue := 1;
	end;
    
    
    	
        v_published_date := coalesce(v_published_date,v_currenttimestamp); 
		v_assetdraftid := nextval('labgsoc.seq_labgsoc_asset_draft_id');
		v_assetdraftguid := uuid_generate_v4();
		
		if v_contestid is null then
			
            v_assetid := nextval('labgsoc.seq_labgsoc_contest_id_new');
			v_contestguid := uuid_generate_v4();
			v_seodataid := nextval('labgsoc.seq_labgsoc_seo_data_id');
			v_seodataguid := uuid_generate_v4();
			v_asset_list_id := nextval ('labgsoc.seq_labgsoc_asset_list_id');
			v_json := jsonb_set(v_json, '{data,contest_id_new}', v_assetid::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_contestguid||'"')::text::jsonb, true);
				
			insert into labgsoc.labgsoc_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                            created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values(v_assetdraftid, v_assetid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby,
                   1, 0, v_assetdraftguid);
			
			insert into labgsoc.labgsoc_contest_new(contest_id_new, content_source_id, asset_meta, title, title_alias, browser_title, highlights, content_source, place,
                                        country, show_in_app, disclaimer_text, checked_out_by, full_text, intro_text, published_version_number,
                                        created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published, is_trashed,
                                        contest_guid, published_date, show_in_web, show_in_mobile, show_copyright, content_source_link, order_number,
                                        slug_url,short_title)
			values(v_assetid, v_contentsourceid, v_assetmetajson, v_title, v_titlealias, v_browsertitle, v_highlights, null, v_place, v_country, 0,
                   null, null, v_fulltext, v_introtext, v_versionnumber, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby, 1, 0,
                   v_status, v_is_trashed, v_contestguid, v_published_date, v_show_in_web, v_show_in_mobile, v_show_copyright, v_content_source_link,
                   v_order_number, v_slugurl,v_shorttitle);
			
			insert into labgsoc.labgsoc_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags,
                                           primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path,
                                           duration, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, 
                                           updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid,
                                           show_copyright, order_number,short_title)
			values(v_asset_list_id, v_assetid, v_assettypeid, v_title, v_titlealias, null, v_introtext, null, null, null, null, v_image_file_name,
                   v_image_path, null, v_show_in_web, v_show_in_mobile, 0, v_versionnumber, v_is_trashed, v_currenttimestamp, v_currenttimestamp,
                   v_updatedby, v_updatedby, 1, 0, v_status, v_published_date, v_contestguid, v_show_copyright, v_order_number,v_shorttitle);
			
			insert into labgsoc.labgsoc_seo_data(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, updated_date,
                                         created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
			values(v_seodataid, v_assetid, v_assettypeid, v_seojson, v_versionnumber, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby,
                   1, 0, v_status, v_seodataguid);
			
		else
        	
            select is_published, is_trashed
            into v_contestpublishedstatus, v_contesttrashedstatus
            from labgsoc.labgsoc_contest_new
            where contest_id_new = v_contestid;
            
            if v_status = 0 then
            	
                if v_is_trashed = 0 then
                	
                    select coalesce(published_version_number,1), is_published
					into   strict v_pubversionnumber, v_ispublished
					from   labgsoc.labgsoc_contest_new
					where  contest_id_new = v_contestid;
						
					select max(version_number)
					into   strict v_versionnumber
					from   labgsoc.labgsoc_asset_draft
					where  asset_type_id = v_assettypeid
					and    asset_id      = v_contestid;
						
					if ((v_versionnumber = v_pubversionnumber and v_ispublished = 0) or (v_versionnumber > v_pubversionnumber)) then
						
                        update labgsoc.labgsoc_asset_draft ad
						set    asset_data        = v_json,
						       updated_date      = v_currenttimestamp
						where  asset_id          = v_contestid
                        and    asset_type_id     = v_assettypeid
						and    ad.version_number = (select max(ad1.version_number)
                                                    from   labgsoc.labgsoc_asset_draft ad1
                                                    where  ad1.asset_id = ad.asset_id
                                                    and    ad1.asset_type_id = ad.asset_type_id);
						
					else
						
						v_versionnumber := v_versionnumber + 1;
                        
						insert into labgsoc.labgsoc_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                                        created_by, updated_by, is_active, is_deleted, asset_draft_guid)
						values(v_assetdraftid, v_contestid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby,
                               v_updatedby, 1, 0, v_assetdraftguid);
						
                    end if;
                    
				else
					
                    update labgsoc.labgsoc_contest_new
					set    is_published = v_status,
                    	   is_trashed   = 1,
						   updated_date = v_currenttimestamp
					where  contest_id_new   = v_contestid;
					
					        delete from   labgsoc.labgsoc_asset_entity_map
							where  asset_type_id = v_assettypeid
							and    asset_id      = v_contestid;
					
                    update labgsoc.labgsoc_asset_draft ad
                    set    asset_data        = v_json,
                    	   updated_date      = v_currenttimestamp
					where  asset_id          = v_contestid
					and    asset_type_id     = v_assettypeid
                    and    ad.version_number = (select max(ad1.version_number)
                                                from   labgsoc.labgsoc_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
					
					update labgsoc.labgsoc_asset_list
					set    updated_date = v_currenttimestamp,
						   updated_by   = v_updatedby,  
                           is_published = v_status,
                           is_trashed   = v_is_trashed
					where  asset_id     = v_contestid
          			and asset_type_id   = v_assettypeid;
                    
			  		select max(ad1.version_number)
                    into   v_versionnumber
                    from   labgsoc.labgsoc_asset_draft ad1
                    where  ad1.asset_id = v_contestid
					and    ad1.asset_type_id = v_assettypeid;
                    
				end if;
                
			else
				
				select max(version_number)
				into   strict v_versionnumber
				from   labgsoc.labgsoc_asset_draft
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_contestid;
				
				v_versionnumber := v_versionnumber + 1;
				
				insert into labgsoc.labgsoc_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                                created_by, updated_by, is_active, is_deleted, asset_draft_guid)
				values(v_assetdraftid, v_contestid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, 
                       v_updatedby, 1, 0, v_assetdraftguid);
				
				update labgsoc.labgsoc_contest_new
				set    content_source_id 	    = v_contentsourceid,
					   asset_meta        	    = v_assetmetajson,
                       title        	        = v_title,
                       title_alias       	    = v_titlealias,
                       browser_title     	    = v_browsertitle,
                       highlights    	        = v_highlights,
                       content_source    	    = null,
                       place             	    = v_place,
                       country 			        = v_country,
                       show_in_app       	    = 0,
                       disclaimer_text   	    = null,
                       checked_out_by    	    = null,
                       full_text         	    = v_fulltext,
                       intro_text        	    = v_introtext,
                       published_version_number = v_versionnumber,
                       updated_date      	    = v_currenttimestamp,
                       updated_by        	    = v_updatedby,
                       is_active         	    = 1,
                       is_deleted        	    = 0,
                       is_published      	    = v_status,
                       is_trashed        	    = v_is_trashed,
                       published_date           = v_published_date,
                       show_in_web          	= v_show_in_web,
                       show_in_mobile           = v_show_in_mobile,
                       show_copyright           = v_show_copyright,
                       content_source_link      = v_content_source_link,
                       order_number             = v_order_number,
                       slug_url                 = v_slugurl,
                       short_title              = v_shorttitle
				where  contest_id_new        	    = v_contestid;
                
				update labgsoc.labgsoc_seo_data
				set    meta_info 	 = v_seojson,
					   updated_date  = v_currenttimestamp
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_contestid;
                
				update labgsoc.labgsoc_asset_list
				set   asset_title        	   = v_title,
					  title_alias       	   = v_titlealias,
                      short_desc    	       = v_introtext,
                      show_in_app       	   = 0,
                      published_version_number = v_versionnumber,
                      updated_date      	   = v_currenttimestamp,
                      updated_by        	   = v_updatedby,
                      is_active         	   = 1,
                      is_deleted        	   = 0,
                      is_published      	   = v_status,
                      is_trashed        	   = v_is_trashed,
                      published_date           = v_published_date,
                      show_in_web              = v_show_in_web ,
                      show_in_mobile           = v_show_in_mobile,
                      show_copyright           = v_show_copyright,
                      order_number 			   = v_order_number,
                      short_title              = v_shorttitle
				where asset_id        	       = v_contestid
        		and   asset_type_id            = v_assettypeid;
                
			end if;
		
		end if;
		
        if  (v_status = 1)then
			
            select v_json->'data'->>'entitydata'
			into   v_entityjson;
            
			if v_entityjson is not null then
            	
                delete
				from   labgsoc.labgsoc_asset_entity_map
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_contestid;
                
				for v_entity in select * from json_array_elements(v_entityjson)
				loop
					
                    select v_entity->>'entity_role_map_id',
					  	   v_entity->>'priority',
						   v_entity->>'is_linkable',
						   v_entity->>'is_visible'
					into   v_entityrolemapid,
					       v_priority,
						   v_labgsocinkable,
						   v_isvisible;
                           
                select count(1) into v_entity_count from labgsoc.labgsoc_asset_list
				where tagged_entity is not null and tagged_entity@> Array[v_entityrolemapid]::int[];
				 
				update labgsoc.labgsoc_entity_role_map 
				set entity_count=v_entity_count
				where entity_role_map_id= v_entityrolemapid;
					
					if (v_entityrolemapid is not null and v_priority is not null) then
                    	
						v_assetentitymapid   := nextval('labgsoc.seq_labgsoc_asset_entity_map_id');
						v_assetentitymapguid := uuid_generate_v4();
						
						insert into labgsoc.labgsoc_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
															 priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                                             is_published, aemap_guid)
						values(v_assetentitymapid, coalesce(v_contestid, v_assetid), v_assettypeid, v_entityrolemapid, coalesce(v_labgsocinkable,0),
                               v_isvisible, v_priority, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
						
						update labgsoc.labgsoc_asset_list
						set    primary_entity_role_map_id 	= case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
							   secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
						where  asset_id 				    = coalesce(v_contestid, v_assetid)
           				and    asset_type_id                = v_assettypeid;
                        
					end if;
                    
				end loop;
                
			 
				
			end if;
			SELECT  obj.value->>'entity_role_map_id' into v_entity_lang_id
             from jsonb_array_elements(v_entityjson::jsonb) obj(value)
             where obj.value->>'is_lang'='1';   
				
            
			 update labgsoc.labgsoc_asset_list
             set    language_id=v_entity_lang_id,
             language_entity_role_map_id=v_entity_lang_id
             where  asset_id        = coalesce(v_contestid, v_assetid)
             and    asset_type_id   = v_assettypeid;
			
			select v_json->'data'->>'asset_map'
			into   v_contestassetmapjson;
            
			if v_contestassetmapjson is not null then
            
				delete
				from   labgsoc.labgsoc_contest_new_asset_map
				where  contest_id_new      = v_contestid;
                
				for v_contestassetmap in select * from json_array_elements(v_contestassetmapjson)
				loop
                	
                    select v_contestassetmap->>'asset_id',
                    	   v_contestassetmap->>'asset_type_id',
                           v_contestassetmap->>'is_cover'
					into   v_aam_assetid,
                    	   v_aam_assettypeid,
                           v_is_cover;
					
					
					if (v_aam_assetid is not null and v_aam_assettypeid is not null) then
                    	
                        v_contestassetmapid   := nextval('labgsoc.seq_labgsoc_contest_asset_map_id');
						v_contestassetmapguid := uuid_generate_v4();
                        
						insert into labgsoc.labgsoc_contest_new_asset_map(contest_asset_map_id, contest_id_new, asset_id, asset_type_id, created_date, updated_date,
                                                              created_by, updated_by, is_active, is_deleted, is_published, aamap_guid, is_cover)
						values(v_contestassetmapid, coalesce(v_contestid, v_assetid), v_aam_assetid, v_aam_assettypeid, v_currenttimestamp,
							   v_currenttimestamp, v_createdby, v_updatedby, 1, 0, v_status, v_contestassetmapguid, v_is_cover);
						
              			if v_is_cover = 1 then
                			
                            select image_path, image_file_name
                			into v_image_path, v_image_file_name
                            from labgsoc.labgsoc_image
                            where image_id = v_aam_assetid;
                            
                			update labgsoc.labgsoc_asset_list
                			set    image_path      = v_image_path,
                            	   image_file_name = v_image_file_name
                			where  asset_id        = coalesce(v_contestid, v_assetid)
                			and    asset_type_id   = v_assettypeid;
                            
              			end if;
                        
					end if;
                    
				end loop;
                
			end if;
            
			select v_json->'data'->>'author_data'
			into   v_authordatajson;
            
			if v_authordatajson is not null then
            	
                delete
                from   labgsoc.labgsoc_author_action
                where  asset_type_id = v_assettypeid
                and    asset_id      = v_contestid;
                
				for v_authordata in select * from json_array_elements(v_authordatajson)
				loop
                	
                    select v_authordata->>'author_id',
					  	   v_authordata->>'action_id'
					into   v_author_id,
                    	   v_action_id;
					
				   	if (v_author_id is not null and v_action_id is not null) then
                    	
						v_authoractionid := nextval('labgsoc.seq_labgsoc_author_action_id');
						
						insert into labgsoc.labgsoc_author_action(author_action_id, author_id, asset_id, asset_type_id, action_id, created_date, updated_date)
						values(v_authoractionid, v_author_id, coalesce(v_contestid, v_assetid), v_assettypeid, v_action_id, v_currenttimestamp,
							   v_currenttimestamp);
						
             			if v_action_id = 4 then
                        	
                            update labgsoc.labgsoc_asset_list
                			set    author_id     = coalesce(v_author_id, author_id)
                			where  asset_id      = coalesce(v_contestid, v_assetid)
                			and    asset_type_id = v_assettypeid;
                            
						end if;
                        
					end if;
                    
				end loop;
                
			end if;
            
		end if;
        
        v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
		
		
		if  v_status = 1 then
        	
			select * from  labgsoc._get_web_list_json(null,1,coalesce(v_contestid, v_assetid) ) 
			into strict v_web_listing_json;
            
            
            select labgsoc.labgsoc_get_sitemap_json(v_assettypeid,coalesce(v_contestid, v_assetid)) into
            strict v_sitemap_json;
			
               --raise notice 'v_web_listing_json : %',v_web_listing_json;
               --raise notice 'v_contestid : %',v_contestid;
              ---- raise notice 'v_assetid : %',v_assetid;
              -- raise notice 'v_assettypeid : %',v_assettypeid;
               
               -- select 1/0;
			   
			   
			   	select array(select entity_role_map_id 
					 from labgsoc.labgsoc_asset_entity_map
					 where asset_id = coalesce(v_contestid, v_assetid) 
					 and asset_type_id = v_assettypeid
         
					)	a into v_array; 
					
		select row_to_json(row) into v_image from(
				select a.image_id,1 is_cover,a.image_caption,a.image_path imagePath,
				a.image_desc,a.image_caption as image_alt,a.image_file_name,a.title_alias as img_title,copyright_text image_src
				from labgsoc.labgsoc_image a
				where a.image_id in (
				select asset_id from labgsoc.labgsoc_contest_new_asset_map
				where contest_id_new= v_contestid  and is_cover = 1 ))row;
				
		v_web_listing_json := jsonb_set(v_web_listing_json, '{image_data}',v_image, true);			
               
          update labgsoc.labgsoc_asset_list 
		  set web_listing_json = v_web_listing_json,
			  web_detail_jsn = v_json,
			  tagged_entity=v_array,
              sitemap_json=v_sitemap_json
		  where asset_id = coalesce(v_contestid, v_assetid) and asset_type_id = v_assettypeid;
            
        end if;
		
		
        p_result := 1;
        
	/*else
     	 p_result := 0;
	end if;*/
    
	if p_result = 1 then
    	
        p_data := v_json;
        
	end if;
    
/*exception
	
	when others then
		p_result := -1;*/
	
end;
$$;


--
