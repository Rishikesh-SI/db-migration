-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_ins_upd_video_bak(jsonb)
-- Type: FUNCTION

-- Name: labmcfc_v1_ins_upd_video_bak(jsonb); Type: FUNCTION; Schema: labmcfc_v1; Owner: -
--

CREATE FUNCTION labmcfc_v1.labmcfc_v1_ins_upd_video_bak(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     	v_json             	  jsonb;
    	v_videoid        	  numeric;
    	v_status           	  numeric;
    	v_assetdraftid     	  numeric;
    	v_assetid          	  numeric;
    	v_assettypeid      	  numeric;
    	v_createdby        	  numeric;
    	v_updatedby        	  numeric;
    	v_assetdraftguid   	  varchar(50);
    	v_versionnumber    	  numeric := 1;
    	v_contentsourceid  	  numeric;

      	v_title                varchar(4000);
    	v_titlealias       	  varchar(4000);
    	v_shorttitle     	  varchar(4000);
    	v_shortheadline    	  varchar(4000);
    	v_place            	  varchar(4000);
    	v_country             varchar(4000);
    	v_fulltext            text;
    	v_introtext           text;
      v_published_date      timestamp;
    	v_videoguid         varchar(50);
    	v_assetentitymapid    numeric;
    	v_entityrolemapid      numeric;
    	v_priority 	    	  numeric;
     v_islinkable  		  numeric;
     v_isvisible  		  numeric;
    	v_assetentitymapguid  varchar(50);
    	v_seojson 		  jsonb;
    	v_seodataid 		  numeric;
    	v_seodataguid 		  varchar(50);
    	v_entityjson 		  json;
    	v_entity 			  json;
     v_videoexists 	      numeric;
     v_seoexists 		        numeric;
     v_entityexists 	      numeric;
     v_currenttimestamp     timestamp;
     v_videoassetmapjson  json;
     v_videoassetmap	    json;
     v_aam_assetid		      numeric;
     v_aam_assettypeid	    numeric;
     v_videoassetmapid    numeric;
     v_videoassetmapguid  numeric;
     v_videometajson        jsonb;
     v_videodesc            varchar(1000);
     v_duration             varchar(1000);
     v_partnerid            numeric;
    v_showinmweb            numeric;
     v_showinmobile           numeric;
     v_showinapp           numeric;
     v_videourl              varchar(4000);   
     
     v_is_trashed           numeric;
     
     
     v_authordatajson       json;
     v_authordata           jsonb;
     v_author_id            numeric;        
     v_action_id            numeric;
     v_authoractionid       numeric;
     
     
     v_pubversionnumber     numeric;
     v_show_copyright numeric;
     v_content_source_link varchar(4000);
     v_order_number numeric;
     v_asset_list_id numeric;
     v_image_file_name varchar(4000);
     v_image_path varchar(4000);
     v_imageid numeric;
     v_slugurl varchar(4000);
     v_continue numeric := 0;
     p_result1 numeric ;
      v_videopublishedstatus numeric;
    v_videotrashedstatus numeric;
    v_video_views numeric;
	v_is_viblr_upd numeric = 0;
	v_hls_url varchar(4000);
    v_asset_data jsonb;
begin
	
     v_currenttimestamp := current_timestamp at time zone 'utc';
     
     v_json := p_json;
	select v_json->'data'->>'video_id',
     	    v_json->'data'->>'status',
            v_json->'data'->>'asset_type',
            v_json->'data'->>'uploaded_by',
            v_json->'data'->>'updated_by',
            v_json->'data'->>'content_source_id',
            v_json->'data'->>'title',
            -- v_json->'data'->>'title_alias',
            v_json->'data'->>'short_title',
            v_json->'data'->>'video_meta',
            v_json->'data'->>'desc',
            v_json->'data'->>'duration',
            v_json->'data'->>'partner_id',
            v_json->'data'->>'show_in_web',
            v_json->'data'->>'show_in_mobile',
            v_json->'data'->>'show_in_app',
            v_json->'data'->>'video_url',            
            v_json->'data'->'seo',
            v_json->'data'->>'published_date',
            v_json->'data'->>'is_trashed',
             v_json->'data'->>'show_copyright',
              v_json->'data'->>'content_source_link',
         v_json->'data'->>'order_number',
            v_json->'data'->>'image_file_name',
         v_json->'data'->>'image_path',
         v_json->'data'->>'image_id',
         v_json->'data'->>'slug_url',
         v_json->'data'->>'hls_url' ,
         v_json->'data'->>'video_views'
         
    	into   v_videoid,
     	  v_status,
            v_assettypeid,
            v_createdby,
            v_updatedby,
            v_contentsourceid,
            v_title,
            -- v_titlealias,
            v_shorttitle,
            v_videometajson,
            v_videodesc,
            v_duration,
            v_partnerid,
            v_showinmweb,
            v_showinmobile,
            v_showinapp,
            v_videourl,
            v_seojson,
            v_published_date,
            v_is_trashed,
           v_show_copyright,
          v_content_source_link,
            v_order_number,
            v_image_file_name,
          v_image_path,
          v_imageid,
          v_titlealias,
          v_hls_url,
          v_video_views;
            
               -- insert entry in labmcfc_v1_redirect table :- changes done by rakesh bhatkar --
             select labmcfc_v1.labmcfc_v1_ins_up_redirect(v_videoid,v_titlealias,v_status,v_assettypeid) into p_result1;
               -- insert entry in labmcfc_v1_redirect table :- changes done by rakesh bhatkar --
            
        begin
     	
			if (v_contentsourceid != 10) 
			then 
				select video_id
				into strict v_videoexists
				from   labmcfc_v1.labmcfc_v1_video
				where  upper(slug_url) = upper(slug_url) ;
				  
				  if v_videoid is null then
					v_continue := -1;
				  else
					if v_videoexists = v_videoid then
						v_continue := 1;
					else
						v_continue := -1;
					end if;
				  end if;
			end if ;	  
			
            exception
			 	when others then
					v_continue := 1;
			
		end;
          -- if v_continue = 1 then   
     v_published_date:=coalesce(v_published_date,v_currenttimestamp);
	 v_assetdraftid   := nextval('labmcfc_v1.seq_labmcfc_v1_asset_draft_id');
     v_assetdraftguid := uuid_generate_v4();
	 
	 -- --- this logic written for viblr video on dated 20171211  ---------
    if (v_contentsourceid = 10 and v_videoid is null ) 
    then 
		
		if exists (select 1 from labmcfc_v1.labmcfc_v1_video where video_url = v_videourl)
		then 
			select video_id into v_videoid 
			from labmcfc_v1.labmcfc_v1_video where video_url = v_videourl ;			
			
			if v_videoid is not null 
			then 
				
				select  ad.asset_data 
				into  v_asset_data
				from labmcfc_v1.labmcfc_v1_asset_draft ad							    
				where  asset_id          = v_videoid
				and    asset_type_id = v_assettypeid
				and    ad.version_number = (select max(ad1.version_number)
											from   labmcfc_v1.labmcfc_v1_asset_draft ad1
											where  ad1.asset_id = ad.asset_id
											and ad.asset_type_id = ad1.asset_type_id);
				
				v_asset_data := jsonb_set(v_asset_data, '{data,desc}', ('"'||coalesce(v_videodesc,'')||'"')::text::jsonb, true);
				v_asset_data := jsonb_set(v_asset_data, '{data,video_url}', ('"'||coalesce(v_videourl,'')||'"')::text::jsonb, true);
				v_asset_data := jsonb_set(v_asset_data, '{data,hls_url}', ('"'||coalesce(v_hls_url,'')||'"')::text::jsonb, true);
				v_asset_data := jsonb_set(v_asset_data, '{data,duration}', ('"'||coalesce(v_duration,'')||'"')::text::jsonb, true);
				v_asset_data := jsonb_set(v_asset_data, '{data,image_file_name}', ('"'||coalesce(v_image_file_name,'')||'"')::text::jsonb, true);
				v_asset_data := jsonb_set(v_asset_data, '{data,image_path}', ('"'||coalesce(v_image_path,'')||'"')::text::jsonb, true);
				v_asset_data := jsonb_set(v_asset_data, '{data,image_id}', coalesce(v_imageid,0)::text::jsonb, true);
				 v_asset_data := jsonb_set(v_asset_data, '{data,video_id}', coalesce(v_videoid,0)::text::jsonb, true);
				
				v_json := v_asset_data ;
				
				v_is_viblr_upd := 2 ; 
				
			end if;
			
	    end if ;
    
    end if ; -- -- viblr code end 
	 
    --raise notice '1 : % ' , v_json ;
     
	if v_videoid is null then
     	raise notice '2 : % ' , 11 ;
          
          v_assetid        := nextval('labmcfc_v1.seq_labmcfc_v1_video_id');
            v_videoguid 	  := uuid_generate_v4();
          v_seodataid   	  := nextval('labmcfc_v1.seq_labmcfc_v1_seo_data_id');
            v_seodataguid 	  := uuid_generate_v4();
            v_asset_list_id :=  nextval('labmcfc_v1.seq_labmcfc_v1_asset_list_id');
            
          v_json 	       := jsonb_set(v_json, '{data,video_id}', v_assetid::text::jsonb, true);
          v_json 		  := jsonb_set(v_json, '{data,guid}', ('"'||v_videoguid||'"')::text::jsonb, true);
              
          
          insert into labmcfc_v1.labmcfc_v1_asset_draft(asset_draft_id,
                                                 asset_id,
                                                 asset_type_id,
                                                 version_number,
                                                 asset_data,
                                                 created_date,
                                                 updated_date,
                                                 created_by,
                                                 updated_by,
                                                 is_active,
                                                 is_deleted,
                                                 asset_draft_guid)
    		values(v_assetdraftid,
                 v_assetid,
                 4,
                 v_versionnumber,
                 v_json,
                 v_currenttimestamp,
                 v_currenttimestamp,
                 v_updatedby,
                 v_updatedby,
                 1,
                 0,
                 v_assetdraftguid);
          insert into labmcfc_v1.labmcfc_v1_video(
                                    video_id, content_source_id, title, title_alias,
                                    short_title, video_meta, video_desc, duration, 
                                    partner_id, show_in_web, show_in_mobile, show_in_app,
                                    published_version_number, video_url, is_trashed, created_date,
                                    updated_date, created_by, updated_by, is_active, 
                                    is_deleted, is_published, video_guid, published_date,
              show_copyright,content_source_link,order_number,image_id,slug_url, video_views, hls_url)
                            values (
                                    v_assetid,  v_contentsourceid, 
                                v_title,v_titlealias,
                                    v_shorttitle, v_videometajson, v_videodesc, v_duration,
                                    v_partnerid, v_showinmweb, v_showinmobile, v_showinapp,
                                    v_versionnumber, v_videourl,
                                v_is_trashed,
                                v_currenttimestamp, 
                                    v_currenttimestamp, v_updatedby, v_updatedby, 1, 
                                    0, v_status, v_videoguid, v_published_date,
                            v_show_copyright,
            v_content_source_link,v_order_number,v_imageid,v_slugurl, v_video_views, v_hls_url);
            
              
                    insert into labmcfc_v1.labmcfc_v1_asset_list
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
                                  values
                                  (
                                      v_asset_list_id,
                                      v_assetid,
                                      4,
                                      v_title,
                                      v_titlealias,
                                      null,
                                      v_videodesc,
                                      null,
                                      null,
                                      null,
                                      null,
                                      v_image_file_name,
                                      v_image_path,
                                      v_duration,
                                      v_showinmweb,
                                      v_showinmobile,
                                      v_showinapp,
                                      v_versionnumber,
                                      v_is_trashed,
                                      v_currenttimestamp,
                                      v_currenttimestamp,
                                      v_updatedby, 
                                      v_updatedby,
                                      1,
                                      0,
                                      v_status,
                                      v_published_date,
                                      v_videoguid,
                                      v_show_copyright,
                                      v_order_number,
                                      v_shorttitle
                                  );

		
          
		insert into labmcfc_v1.labmcfc_v1_seo_data(seo_data_id,
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
                 v_assetid,
                 v_assettypeid,
                 v_seojson,
                 v_versionnumber,
                 v_currenttimestamp,
                 v_currenttimestamp,
                 v_createdby,
                 v_updatedby,
                 1,
                 0,
                 v_status,
                 v_seodataguid);
          
     else
     	
         select is_published, is_trashed
            into v_videopublishedstatus, v_videotrashedstatus
            from labmcfc_v1.labmcfc_v1_video
            where video_id = v_videoid;
        
          if v_status = 0 then
                
				if v_is_trashed = 0 then
					
					select coalesce(max(published_version_number),1)
					into   strict v_pubversionnumber
                    from   labmcfc_v1.labmcfc_v1_video
                    where  video_id      = v_videoid;
					
					select max(version_number)
					into   strict v_versionnumber
                    from   labmcfc_v1.labmcfc_v1_asset_draft
                    where  asset_type_id = v_assettypeid
					and    asset_id      = v_videoid;
					
					if v_versionnumber > v_pubversionnumber then
						
						update labmcfc_v1.labmcfc_v1_asset_draft ad
						set    asset_data        = v_json,
								updated_date      = v_currenttimestamp
						where  asset_id          = v_videoid
						and    asset_type_id = v_assettypeid
						and    ad.version_number = (select max(ad1.version_number)
													from   labmcfc_v1.labmcfc_v1_asset_draft ad1
													where  ad1.asset_id = ad.asset_id);
					else
						
						 
						v_versionnumber := v_versionnumber + 1;
                         
						insert into labmcfc_v1.labmcfc_v1_asset_draft
						(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
						updated_date,created_by, updated_by, is_active, is_deleted, asset_draft_guid)
						values
						( v_assetdraftid, v_videoid, v_assettypeid, v_versionnumber, v_json, 
						v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby,
						1, 0, v_assetdraftguid);
						
					end if;
					
				else
					
					update labmcfc_v1.labmcfc_v1_asset_list
					set is_trashed=v_is_trashed,  
					is_published=v_status ,
					updated_date=v_currenttimestamp
					where  asset_id        	  = v_videoid
					and    asset_type_id=v_assettypeid;
					
					update labmcfc_v1.labmcfc_v1_video
					set 
					is_trashed=v_is_trashed,  
					is_published=v_status ,
					updated_date=v_currenttimestamp,
                    video_views = v_video_views
					where  video_id        	  = v_videoid;
					
					update labmcfc_v1.labmcfc_v1_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_currenttimestamp
					where  asset_id      = v_videoid
					and    asset_type_id = v_assettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   labmcfc_v1.labmcfc_v1_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_assettypeid);
					
          select max(ad1.version_number)
                  into v_versionnumber
                  from   labmcfc_v1.labmcfc_v1_asset_draft ad1
                  where  ad1.asset_id = v_videoid
                  and    ad1.asset_type_id = v_assettypeid;
				end if;
				
          else
               
               select max(version_number)
			into   strict v_versionnumber
        		from   labmcfc_v1.labmcfc_v1_asset_draft
        		where  asset_type_id = v_assettypeid
			and    asset_id      = v_videoid;
          	
			v_versionnumber := v_versionnumber + 1;
               
               insert into labmcfc_v1.labmcfc_v1_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                                    created_by, updated_by, is_active, is_deleted, asset_draft_guid)
    			values(v_assetdraftid, v_videoid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby,
                      1, 0, v_assetdraftguid);
               
               update labmcfc_v1.labmcfc_v1_video
			set    content_source_id 	  = v_contentsourceid,
				  title        	          = v_title,
				  title_alias       	  = v_titlealias,
				  short_title     	      = v_shorttitle, 
				  video_meta        	  = v_videometajson,
				  video_desc              = v_videodesc,
				  duration       	      = v_duration,
                  partner_id              = v_partnerid,
				  show_in_web       	  = v_showinmweb,
                  show_in_mobile     	  = v_showinmobile,
                  show_in_app       	  = v_showinapp,
				  published_version_number = v_versionnumber,
                  video_url               = v_videourl,
				  updated_date      	  = v_currenttimestamp,
				  updated_by        	  = v_updatedby,
				  is_active         	  = 1,
				  is_deleted        	  = 0,
				  is_published      	  = v_status,
				  is_trashed        	  = v_is_trashed,
          		  published_date        = v_published_date,
         		  show_copyright = v_show_copyright,
        		  content_source_link =    v_content_source_link,
        		  order_number = v_order_number,
        		  slug_url = v_slugurl,
        		  image_id=v_imageid,
        		  video_views = v_video_views,
                  hls_url = v_hls_url
			where  video_id        	  = v_videoid;
            
             select image_path,image_file_name
                into v_image_path ,v_image_file_name
                from labmcfc_v1.labmcfc_v1_image
                where image_id = v_imageid;
                 
            
          update labmcfc_v1.labmcfc_v1_asset_list
          set   
                  asset_title        	  = v_title,
                  title_alias       	  = v_titlealias,
                  short_desc            = v_videodesc,
                  duration       	      = v_duration,
                  show_in_web       	  = v_showinmweb,
                  show_in_mobile     	  = v_showinmobile,
                  show_in_app       	  = v_showinapp,
                  published_version_number = v_versionnumber,
                  updated_date      	  = v_currenttimestamp,
                  updated_by        	  = v_updatedby,
                  is_active         	  = 1,
                  is_deleted        	  = 0,
                  is_published      	  = v_status,
                  is_trashed        	  = v_is_trashed,
                  published_date        = v_published_date,
                  show_copyright        = v_show_copyright,
                  order_number          = v_order_number,
                  image_path            = v_image_path,
                  image_file_name       = v_image_file_name,
                  short_title = v_shorttitle
			where  asset_id        	  = v_videoid
      and    asset_type_id=v_assettypeid;
               
			update labmcfc_v1.labmcfc_v1_seo_data
			set    meta_info 	 = v_seojson,
               	  updated_date  = v_currenttimestamp
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_videoid;
    
          end if;
          
	end if;
     
     if (v_videoid is null or(v_videoid is not null and v_status = 1)or (v_videopublishedstatus = 0 and v_videotrashedstatus = 0)) then
     select v_json->'data'->>'entitydata'
	into   v_entityjson;
   
	if v_entityjson is not null then
          delete
			from   labmcfc_v1.labmcfc_v1_asset_entity_map
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_videoid;
      
          for v_entity in select * from json_array_elements(v_entityjson)
          loop
          	
               select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
               into   v_entityrolemapid, v_priority, v_islinkable, v_isvisible;
            	
               if (v_entityrolemapid is not null and v_priority is not null) then
               
               	v_assetentitymapid   := nextval('labmcfc_v1.seq_labmcfc_v1_asset_entity_map_id');
            		v_assetentitymapguid := uuid_generate_v4();
				
                    insert into labmcfc_v1.labmcfc_v1_asset_entity_map(asset_entity_map_id,
                                                                asset_id,
                                                                asset_type_id,
                                                                entity_role_map_id,
                                                                is_linkable,
                                                                is_visible,
                                                                priority,
                                                                created_date,
                                                                updated_date,
                                                                created_by,
                                                                updated_by,
                                                                is_active,
                                                                is_deleted,
                                                                is_published,
                                                                aemap_guid)
            		values(v_assetentitymapid,
                           coalesce(v_videoid, v_assetid),
                           v_assettypeid,
                           v_entityrolemapid,
                           coalesce(v_islinkable,0),
                           v_isvisible,
                           v_priority,
                           v_currenttimestamp,
                           v_currenttimestamp,
                           1,
                           0,
                           1,
                           0,
                           1,
                           v_assetentitymapguid);
                           
      update labmcfc_v1.labmcfc_v1_asset_list
        set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
        secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
         where asset_id =     coalesce(v_videoid, v_assetid)
         and    asset_type_id=v_assettypeid;
            	
               end if;
          
          end loop;
          
     end if;
     
     select v_json->'data'->>'author_data'
	into   v_authordatajson;
     
	if v_authordatajson is not null then
		
          delete
		from   labmcfc_v1.labmcfc_v1_author_action
		where  asset_type_id = v_assettypeid
		and    asset_id      = v_videoid;
		
		for v_authordata in select * from json_array_elements(v_authordatajson)
		loop
          	
               select v_authordata->>'author_id',
               	  v_authordata->>'action_id'
			into   v_author_id,
               	  v_action_id;
			
               if (v_author_id is not null and v_action_id is not null) then
               
               	v_authoractionid := nextval('labmcfc_v1.seq_labmcfc_v1_author_action_id');
                    
                    insert into labmcfc_v1.labmcfc_v1_author_action(author_action_id,
                                                      author_id,
                                                      asset_id,
                                                      asset_type_id,
                                                      action_id,
                                                      created_date,
                                                      updated_date)
				values(v_authoractionid,
                           v_author_id,
                           coalesce(v_videoid, v_assetid),
                           v_assettypeid,
                           v_action_id,
                           v_currenttimestamp,
                           v_currenttimestamp);
               if v_action_id = 4 then       
                    update labmcfc_v1.labmcfc_v1_asset_list
                    set    author_id  = coalesce(v_author_id,author_id)
                    where  asset_id   = coalesce(v_videoid, v_assetid)
                  --	and    author_id is null
                    and    asset_type_id=v_assettypeid;
               end if;
			end if;
		
		end loop;
	
	end if;
 end if;
	v_json  := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
     p_result := 1;
     /*else
     	 p_result := 0;
	end if;*/
    	if p_result = 1 then
    		
          p_data := v_json; 
		end if;
     
	
exception
	
     when others then
    		p_result := -1;
	
end;

 

$$;


--
