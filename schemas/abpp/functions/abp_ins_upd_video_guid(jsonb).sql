-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_ins_upd_video_guid(jsonb)
-- Type: FUNCTION

-- Name: abp_ins_upd_video_guid(jsonb); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_ins_upd_video_guid(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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

      v_title                VARCHAR(4000);
    	v_titlealias       	  varchar(4000);
    	v_shorttitle     	  text;
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
     v_videodesc            text;
     v_duration             VARCHAR(1000);
     v_partnerid            numeric;
    v_showinmweb            numeric;
     v_showinmobile           numeric;
     v_showinapp           numeric;
     v_videourl              VARCHAR(4000);   
     
     v_is_trashed           numeric;
     
     
     v_authordatajson       json;
     v_authordata           jsonb;
     v_author_id            NUMERIC;        
     v_action_id            NUMERIC;
     v_authoractionid       NUMERIC;
     
     
     v_pubversionnumber     NUMERIC;
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
	 
	 v_content_provider_name varchar(1024) ;
	 
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
		 v_json->'data'->>'guid'
    	into   v_videoid,
     	  v_status,
            v_assettypeid,
            v_updatedby,
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
		      v_videoguid;
            
               -- insert entry in abp_redirect table :- changes done by rakesh Bhatkar --
             select abp.abp_ins_up_redirect(v_videoid,v_titlealias,v_status,v_assettypeid) into p_result1;
               -- insert entry in abp_redirect table :- changes done by rakesh Bhatkar --
            
            begin
     	
          select video_id
     	into strict v_videoexists
     	from   abp.abp_video
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
          
     exception
     	when others then
          	v_continue := 1;
	end;
          -- if v_continue = 1 then   
     v_published_date:=COALESCE(v_published_date,v_currenttimestamp);
	 v_assetdraftid   := nextval('abp.seq_abp_asset_draft_id');
     v_assetdraftguid := uuid_generate_v4();
	 
	 begin
	 select content_provider_name into strict v_content_provider_name
		from abp.abp_content_provider 
		where content_provider_id = v_contentsourceid
		and is_active = 1 ; 
	exception
    	when no_data_found then
        	v_content_provider_name := ' ';
    end;
		
	 
	if not exists (select 1 from abp.abp_video where video_guid = v_videoguid )
	
	
	then
     	
          
            v_assetid        := nextval('abp.seq_abp_video_id');
          --  v_videoguid 	  := uuid_generate_v4();
            v_seodataid   	  := nextval('abp.seq_abp_seo_data_id');
            v_seodataguid 	  := uuid_generate_v4();
            v_asset_list_id :=  nextval('abp.seq_abp_asset_list_id');
            
          v_json 	       := jsonb_set(v_json, '{data,video_id}', v_assetid::text::jsonb, true);
          raise notice '1-%',v_json;
          v_json 		  := jsonb_set(v_json, '{data,guid}', ('"'||v_videoguid||'"')::text::jsonb, true);
          raise notice '11-%',v_json;
		  v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_videoguid||'"')::text::jsonb, true);
          raise notice '111-%',v_json;
          -- v_json 		  := jsonb_set(v_json, '{data,published_date}', ('"'||v_published_date||'"')::text::jsonb, true);     
          v_json := jsonb_set(v_json, '{data,content_provider_name}', ('"'||v_content_provider_name||'"')::text::jsonb, true);
          
          -- new change--
          v_titlealias := v_titlealias||'-'||v_assetid;
           v_json := jsonb_set(v_json, '{data,slug_url}', ('"'||v_titlealias||'"')::text::jsonb, true);
          raise notice '1111-%',v_json;
           -- new change--
          insert into abp.abp_asset_draft(asset_draft_id,
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
          INSERT INTO abp.abp_video(
                                    video_id, content_source_id, title, title_alias,
                                    short_title, video_meta, video_desc, duration, 
                                    partner_id, show_in_web, show_in_mobile, show_in_app,
                                    published_version_number, video_url, is_trashed, created_date,
                                    updated_date, created_by, updated_by, is_active, 
                                    is_deleted, is_published, video_guid, published_date,
              show_copyright,content_source_link,order_number,image_id,slug_url)
                            VALUES (
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
            v_content_source_link,v_order_number,v_imageid,v_slugurl);
            
              
                    INSERT INTO abp.abp_asset_list
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
                            order_number
                          )
                                  VALUES
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
                                      v_order_number
                                  );

		
          
		insert into abp.abp_seo_data(seo_data_id,
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
                 v_updatedby,
                 v_updatedby,
                 1,
                 0,
                 v_status,
                 v_seodataguid);
          
     else
     	
		select video_id  into v_videoid from abp.abp_video where video_guid=v_videoguid ;
        
        v_json 	       := jsonb_set(v_json, '{data,video_id}', v_videoid::text::jsonb, true);
		
          if v_status = 0 then
                
				if v_is_trashed = 0 then
					
					select COALESCE(max(published_version_number),1)
					into   strict v_pubversionnumber
                    from   abp.abp_video
                    where  video_id      = v_videoid;
					
					select max(version_number)
					into   strict v_versionnumber
                    from   abp.abp_asset_draft
                    where  asset_type_id = v_assettypeid
					and    asset_id      = v_videoid;
					
					IF v_versionnumber > v_pubversionnumber THEN
						
						update abp.abp_asset_draft ad
						set    asset_data        = v_json,
								updated_date      = v_currenttimestamp
						where  asset_id          = v_videoid
						and    asset_type_id = v_assettypeid
						and    ad.version_number = (select max(ad1.version_number)
													from   abp.abp_asset_draft ad1
													where  ad1.asset_id = ad.asset_id);
					ELSE
						
						 
						v_versionnumber := v_versionnumber + 1;
                         
						insert into abp.abp_asset_draft
						(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
						updated_date,created_by, updated_by, is_active, is_deleted, asset_draft_guid)
						values
						( v_assetdraftid, v_videoid, v_assettypeid, v_versionnumber, v_json, 
						v_currenttimestamp, v_currenttimestamp, v_updatedby, v_updatedby,
						1, 0, v_assetdraftguid);
						
					END IF;
					
				/*else
					
					update abp.abp_asset_list
					set is_trashed=v_is_trashed,  
					is_published=v_status ,
					updated_date=v_currenttimestamp
					where  asset_id        	  = v_videoid
					and    asset_type_id=v_assettypeid;
					
					update abp.abp_video
					set 
					is_trashed=v_is_trashed,  
					is_published=v_status ,
					updated_date=v_currenttimestamp
					where  video_id        	  = v_videoid;
					
					update abp.abp_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_currenttimestamp
					where  asset_id      = v_videoid
					and    asset_type_id = v_assettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   abp.abp_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_assettypeid);
					
          select max(ad1.version_number)
                  into v_versionnumber
                  from   abp.abp_asset_draft ad1
                  where  ad1.asset_id = v_videoid
                  and    ad1.asset_type_id = v_assettypeid;*/
				end if;
				
          /*else
               
               select max(version_number)
			into   strict v_versionnumber
        		from   abp.abp_asset_draft
        		where  asset_type_id = v_assettypeid
			and    asset_id      = v_videoid;
          	
			v_versionnumber := v_versionnumber + 1;
               
               insert into abp.abp_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                                    created_by, updated_by, is_active, is_deleted, asset_draft_guid)
    			values(v_assetdraftid, v_videoid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_updatedby, v_updatedby,
                      1, 0, v_assetdraftguid);
               
               update abp.abp_video
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
        image_id=v_imageid
			where  video_id        	  = v_videoid;
            
             select image_path,image_file_name
                into v_image_path ,v_image_file_name
                from abp.abp_image
                where image_id = v_imageid;
                 
            
          update abp.abp_asset_list
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
                  image_file_name       = v_image_file_name
			where  asset_id        	  = v_videoid
      and    asset_type_id=v_assettypeid;
               
			update abp.abp_seo_data
			set    meta_info 	 = v_seojson,
               	  updated_date  = v_currenttimestamp
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_videoid;*/
    
          end if;
          
	end if;
     
     if (v_videoid is null or(v_videoid is not null and v_status = 1)) then
     select v_json->'data'->>'entitydata'
	into   v_entityjson;
   
	if v_entityjson is not null then
         /* delete
			from   abp.abp_asset_entity_map
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_videoid;
        */
          for v_entity in select * from json_array_elements(v_entityjson)
          loop
          	
               select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
               into   v_entityrolemapid, v_priority, v_islinkable, v_isvisible;
            	
               if (v_entityrolemapid is not null and v_priority is not null) then
               
               
				
                if not exists (select 1 from abp.abp_asset_entity_map
                                where  asset_type_id = v_assettypeid
								and    asset_id      = v_videoid
                                and entity_role_map_id = v_entityrolemapid)
                then
                	v_assetentitymapid   := nextval('abp.seq_abp_asset_entity_map_id');
            		v_assetentitymapguid := uuid_generate_v4();
                    
                    insert into abp.abp_asset_entity_map(asset_entity_map_id,
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
                 else
                 		update abp.abp_asset_entity_map
                        set  priority = v_priority,
                        	 is_linkable = 	v_islinkable, 
                             is_visible = v_isvisible
                           where  asset_type_id = v_assettypeid
                            and    asset_id      = v_videoid
                            and entity_role_map_id = v_entityrolemapid ;
            
                 end if ;
                 
                           
      update abp.abp_asset_list
        set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
        secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
         where asset_id =     coalesce(v_videoid, v_assetid)
         and    asset_type_id=v_assettypeid;
            	
               end if;
          
          end loop;
         
         with tab as (select asset_id,asset_type_id,aem.entity_role_map_id
					   from abp.abp_asset_entity_map aem
					   join abp.abp_entity_role_map erm
					   on erm.entity_role_map_id = aem.entity_role_map_id
					   join abp.abp_entity_category ec
					   on ec.entity_role_id = erm.entity_role_id
					   where ec.category_name = 'Language'
					   and aem.asset_id = coalesce(v_videoid, v_assetid)
					   and aem.asset_type_id = v_assettypeid)
			update abp.abp_asset_list al
			set language_entity_role_map_id = t.entity_role_map_id
			from tab t
			where al.asset_id = t.asset_id
			and al.asset_type_id = t.asset_type_id;
         
     end if;
     
     select v_json->'data'->>'author_data'
	into   v_authordatajson;
     
	if v_authordatajson is not null then
		
          delete
		from   abp.abp_author_action
		where  asset_type_id = v_assettypeid
		and    asset_id      = v_videoid;
		
		for v_authordata in select * from json_array_elements(v_authordatajson)
		loop
          	
               select v_authordata->>'author_id',
               	  v_authordata->>'action_id'
			into   v_author_id,
               	  v_action_id;
			
               if (v_author_id is not null and v_action_id is not null) then
               
               	v_authoractionid := nextval('abp.seq_abp_author_action_id');
                    
                    insert into abp.abp_author_action(author_action_id,
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
                    update abp.abp_asset_list
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
     
/*exception
	
     when others then
    		p_result := -1;*/
	
end;

 

$$;


--
