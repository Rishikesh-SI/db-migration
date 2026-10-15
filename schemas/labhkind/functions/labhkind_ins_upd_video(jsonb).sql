-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_ins_upd_video(jsonb)
-- Type: FUNCTION

-- Name: labhkind_ins_upd_video(jsonb); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_ins_upd_video(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_json             	  jsonb;
    v_videoid        	  numeric;
    v_status           	  numeric;
    v_assetdraftid     	  numeric;
    v_assettypeid      	  numeric;
    v_createdby        	  numeric;
    v_updatedby        	  numeric;
    v_assetdraftguid   	  varchar(50);
    v_versionnumber    	  numeric := 1;
    v_contentsourceid  	  numeric;
	v_title               VARCHAR(4000);
    v_titlealias       	  varchar(4000);
    v_shorttitle     	  varchar(4000);
    v_shortheadline    	  varchar(4000);
    v_place            	  varchar(4000);
    v_country             varchar(4000);
    v_fulltext            text;
    v_introtext           text;
    v_published_date      timestamp;
    v_videoguid           varchar(50);
    v_assetentitymapid    numeric;
    v_entityrolemapid     numeric;
    v_priority 	    	  numeric;
    v_labhkindinkable  		  numeric;
    v_isvisible  		  numeric;
    v_assetentitymapguid  varchar(50);
    v_seojson 		      jsonb;
    v_seodataid 		  numeric;
    v_seodataguid 		  varchar(50);
    v_entityjson 		  json;
    v_entity 			  json;
    v_videoexists 	      numeric;
    v_seoexists 		  numeric;
    v_entityexists 	      numeric;
    v_currenttimestamp    timestamp;
    v_videoassetmapjson   json;
    v_videoassetmap	      json;
    v_aam_assetid		  numeric;
    v_aam_assettypeid	  numeric;
    v_videoassetmapid     numeric;
    v_videoassetmapguid   numeric;
    v_videometajson       jsonb;
    v_videodesc           VARCHAR(1000);
    v_duration            VARCHAR(1000);
    v_partnerid           numeric;
    v_showinmweb          numeric;
    v_showinmobile        numeric;
    v_showinapp           numeric;
    v_videourl            VARCHAR(4000);
    v_is_trashed          numeric;
	v_authordatajson      json;
    v_authordata          jsonb;
    v_author_id           NUMERIC;
    v_action_id           NUMERIC;
    v_authoractionid      NUMERIC;
    v_pubversionnumber    NUMERIC;
	v_show_copyright      numeric;
    v_content_source_link varchar(4000);
    v_order_number        numeric;
    v_asset_list_id       numeric;
    v_image_file_name     varchar(4000);
    v_image_path          varchar(4000);
    v_imageid             numeric;
    v_slugurl             varchar(4000);
    v_continue            numeric := 0;
    p_result1             numeric;
    v_hls_url             varchar(4000);
    -- v_notification_status numeric;
    -- v_notification_json   jsonb;
    v_entityroleid        numeric;
    -- v_languageid          numeric;
    -- v_sportid             numeric;
    -- v_matchid             numeric;
    -- v_coverimage          text;
    v_azure_id            numeric;
    v_entity_lang_id numeric;
	v_web_listing_json jsonb ;
	v_year text;
	v_ent 	numeric[];	
	v_month text;
	p_entity_json jsonb;
	p_entity_data jsonb;
	v_array numeric[];
	
begin
	
    v_currenttimestamp := current_timestamp at time zone 'utc';
   	select p_json->'data' into p_json;
	v_json:='{"data":'||p_json::json||'}';
    
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
         	v_json->'data'->>'hls_url',
         	-- v_json->'data'->>'trigger_notification',
         	v_json->'data'->>'azure_id'
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
          	v_hls_url,
          	-- v_notification_status,
          	v_azure_id;
	
    select labhkind.labhkind_ins_up_redirect(v_videoid,v_titlealias,v_status,v_assettypeid) into p_result1;
    
	-- v_videodesc := replace(v_videodesc,'''','''''');
    -- v_videodesc := regexp_replace(v_videodesc, E'\r\n', ' ', 'g');
    v_title := regexp_replace(v_title, E'\"', '\"', 'g');
    v_published_date := COALESCE(v_published_date,v_currenttimestamp);
	v_assetdraftid   := nextval('labhkind.seq_labhkind_asset_draft_id');
    v_assetdraftguid := uuid_generate_v4();
    v_videourl := replace(v_videourl,'http:','https:');
    
    if v_videoid is null and v_azure_id is not null then
    	select video_id into v_videoid from labhkind.labhkind_video where azure_id = v_azure_id;
    end if;
    
	if v_videoid is null then
    	
        v_videoid        := nextval('labhkind.seq_labhkind_video_id');
        v_videoguid 	 := uuid_generate_v4();
        v_seodataid   	 := nextval('labhkind.seq_labhkind_seo_data_id');
        v_seodataguid 	 := uuid_generate_v4();
        v_asset_list_id  := nextval('labhkind.seq_labhkind_asset_list_id');
        v_json 		     := jsonb_set(v_json, '{data,guid}', ('"'||v_videoguid||'"')::text::jsonb, true);
        
        insert into labhkind.labhkind_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,created_by,
                                        updated_by,is_active,is_deleted,asset_draft_guid)
		values(v_assetdraftid,v_videoid,4,v_versionnumber,v_json,v_currenttimestamp,v_currenttimestamp,v_updatedby,v_updatedby,1,0,v_assetdraftguid);
        
        INSERT INTO labhkind.labhkind_video(video_id,content_source_id,title,title_alias,short_title,video_meta,video_desc,duration,partner_id,show_in_web,
                                  show_in_mobile,show_in_app,published_version_number,video_url,is_trashed,created_date,updated_date,created_by,
                                  updated_by,is_active,is_deleted,is_published,video_guid,published_date,show_copyright,content_source_link,
                                  order_number,image_id,slug_url,hls_url,azure_id)
		VALUES(v_videoid,v_contentsourceid,v_title,v_titlealias,v_shorttitle,v_videometajson,v_videodesc,v_duration,v_partnerid,v_showinmweb,
               v_showinmobile,v_showinapp,v_versionnumber,v_videourl,v_is_trashed,v_currenttimestamp,v_currenttimestamp,v_updatedby,v_updatedby,1,0,
               v_status,v_videoguid,v_published_date,v_show_copyright,v_content_source_link,v_order_number,v_imageid,v_slugurl,v_hls_url,v_azure_id);
		
        INSERT INTO labhkind.labhkind_asset_list(asset_list_id,asset_id,asset_type_id,asset_title,title_alias,author_id,short_desc,tags,
                                       primary_entity_role_map_id,secondary_entity_role_map_id,total_assets,image_file_name,image_path,duration,
                                       show_in_web,show_in_mobile,show_in_app,published_version_number,is_trashed,created_date,updated_date,created_by,
                                       updated_by,is_active,is_deleted,is_published,published_date,asset_guid,show_copyright,order_number)
		VALUES(v_asset_list_id,v_videoid,4,v_title,v_titlealias,null,v_videodesc,null,null,null,null,v_image_file_name,v_image_path,v_duration,
               v_showinmweb,v_showinmobile,v_showinapp,v_versionnumber,v_is_trashed,v_currenttimestamp,v_currenttimestamp,v_updatedby,v_updatedby,1,0,
               v_status,v_published_date,v_videoguid,v_show_copyright,v_order_number);
		
        insert into labhkind.labhkind_seo_data(seo_data_id,asset_id,asset_type_id,meta_info,published_version_number,created_date,updated_date,created_by,
                                     updated_by,is_active,is_deleted,is_published,seo_data_guid)
		values(v_seodataid,v_videoid,v_assettypeid,v_seojson,v_versionnumber,v_currenttimestamp,v_currenttimestamp,v_updatedby,v_updatedby,1,0,
               v_status,v_seodataguid);
		
	else
    	
        if v_status = 0 then
        	
            if v_is_trashed = 0 then
            	
                select COALESCE(max(published_version_number),1) into strict v_pubversionnumber from labhkind.labhkind_video where video_id = v_videoid;
                
                select max(version_number) into strict v_versionnumber from labhkind.labhkind_asset_draft where asset_type_id = v_assettypeid
                and asset_id = v_videoid;
                
                IF v_versionnumber > v_pubversionnumber THEN
                	
                    update labhkind.labhkind_asset_draft ad
                    set    asset_data = v_json, updated_date = v_currenttimestamp
					where  asset_id = v_videoid
                    and    asset_type_id = v_assettypeid
                    and    ad.version_number = (select max(ad1.version_number) from labhkind.labhkind_asset_draft ad1 where ad1.asset_id = ad.asset_id);
                    
				ELSE
                	
                    v_versionnumber := v_versionnumber + 1;
                    
                    insert into labhkind.labhkind_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,
                                                    created_by,updated_by,is_active,is_deleted,asset_draft_guid)
					values(v_assetdraftid,v_videoid,v_assettypeid,v_versionnumber,v_json,v_currenttimestamp,v_currenttimestamp,v_createdby,v_updatedby,
                           1,0,v_assetdraftguid);
					
				END IF;
                
			else
            	
                update labhkind.labhkind_asset_list
                set is_trashed = v_is_trashed, is_published = v_status, updated_date = v_currenttimestamp
                where asset_id = v_videoid and asset_type_id = v_assettypeid;
                
                update labhkind.labhkind_video
                set is_trashed = v_is_trashed, is_published = v_status, updated_date = v_currenttimestamp
                where video_id = v_videoid;
                
                update labhkind.labhkind_asset_draft ad
                set asset_data = v_json, updated_date = v_currenttimestamp
                where  asset_id = v_videoid and asset_type_id = v_assettypeid
                and ad.version_number = (select max(ad1.version_number) from labhkind.labhkind_asset_draft ad1 where ad1.asset_id = ad.asset_id
                                         and ad1.asset_type_id = v_assettypeid);
				
          		select max(ad1.version_number) into v_versionnumber from labhkind.labhkind_asset_draft ad1 where ad1.asset_id = v_videoid
                and ad1.asset_type_id = v_assettypeid;
                
			end if;
            
		else
        	
            select max(version_number) into strict v_versionnumber from labhkind.labhkind_asset_draft where asset_type_id = v_assettypeid
            and asset_id = v_videoid;
            
			v_versionnumber := v_versionnumber + 1;
            
            insert into labhkind.labhkind_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,created_by,
                                            updated_by,is_active,is_deleted,asset_draft_guid)
			values(v_assetdraftid,v_videoid,v_assettypeid,v_versionnumber,v_json,v_currenttimestamp,v_currenttimestamp,v_createdby,v_updatedby,1,0,
                   v_assetdraftguid);
			
			update labhkind.labhkind_video
            set content_source_id = v_contentsourceid, title = v_title, title_alias = v_titlealias, short_title = v_shorttitle, 
            	video_meta = v_videometajson, video_desc = v_videodesc, duration = v_duration, partner_id = v_partnerid, show_in_web = v_showinmweb,
                show_in_mobile = v_showinmobile, show_in_app = v_showinapp, published_version_number = v_versionnumber, video_url = v_videourl,
                updated_date = v_currenttimestamp, updated_by = v_updatedby, is_active = 1, is_deleted = 0, is_published = v_status,
                is_trashed = v_is_trashed, published_date = v_published_date, show_copyright = v_show_copyright,
                content_source_link = v_content_source_link, order_number = v_order_number, slug_url = v_slugurl, image_id=v_imageid,
                hls_url = v_hls_url
			where  video_id = v_videoid;
            
            select image_path, image_file_name into v_image_path, v_image_file_name from labhkind.labhkind_image where image_id = v_imageid;
            
            update labhkind.labhkind_asset_list
          	set asset_title = v_title, title_alias = v_titlealias, short_desc = v_videodesc, duration = v_duration, show_in_web = v_showinmweb,
            	show_in_mobile = v_showinmobile, show_in_app = v_showinapp, published_version_number = v_versionnumber,
                updated_date = v_currenttimestamp, updated_by = v_updatedby, is_active = 1, is_deleted = 0, is_published = v_status,
                is_trashed = v_is_trashed, published_date = v_published_date, show_copyright = v_show_copyright, order_number = v_order_number,
                image_path = v_image_path, image_file_name = v_image_file_name
			where  asset_id = v_videoid and asset_type_id = v_assettypeid;
            
			update labhkind.labhkind_seo_data
			set meta_info = v_seojson, updated_date = v_currenttimestamp
			where asset_type_id = v_assettypeid and asset_id = v_videoid;
            
		end if;
        
	end if;
	
	
    
    if ((v_json->'data'->>'video_id') is null or ((v_json->'data'->>'video_id') is not null and v_status = 1)) then
        
        select v_json->'data'->>'entitydata' into v_entityjson;
		
		
        
        if v_entityjson is not null then
            
            delete from labhkind.labhkind_asset_entity_map where asset_type_id = v_assettypeid and asset_id = v_videoid;
            
          	for v_entity in select * from json_array_elements(v_entityjson)
          	loop
            	
                select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
                into v_entityrolemapid, v_priority, v_labhkindinkable, v_isvisible;
                
               	if (v_entityrolemapid is not null and v_priority is not null) then
                
               		/*select entity_role_id into v_entityroleid from labhkind.labhkind_entity_role_map where entity_role_map_id = v_entityrolemapid;
                    
               		if v_entityroleid = 2 then
                    	v_languageid := v_entityrolemapid;
               		elsif v_entityroleid = 3 then
               			v_sportid := v_entityrolemapid;
               		elsif v_entityroleid = 6 then
               			v_matchid := v_entityrolemapid;
               		end if;*/
                    
               		v_assetentitymapid   := nextval('labhkind.seq_labhkind_asset_entity_map_id');
            		v_assetentitymapguid := uuid_generate_v4();
                    
                    insert into labhkind.labhkind_asset_entity_map(asset_entity_map_id,asset_id,asset_type_id,entity_role_map_id,is_linkable,is_visible,priority,
                                                         created_date,updated_date,created_by,updated_by,is_active,is_deleted,is_published,aemap_guid)
            		values(v_assetentitymapid,v_videoid,v_assettypeid,v_entityrolemapid,coalesce(v_labhkindinkable,0),v_isvisible,v_priority,
                           v_currenttimestamp,v_currenttimestamp,1,0,1,0,1,v_assetentitymapguid);
					
      				update labhkind.labhkind_asset_list
                    set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
                    	secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
         			where asset_id = v_videoid and asset_type_id = v_assettypeid;
                    
				end if;
                
			end loop;
			
			SELECT date_part('year', coalesce( v_published_date,current_timestamp) ) into v_year;
				SELECT to_char( to_timestamp(date_part('month', coalesce(v_published_date,current_timestamp) )::text, 'MM'), 'TMmon') into v_month;
				
				
				if not exists(select entity_master_id from labhkind.labhkind_entity_master
							 where lower (entity_name) = lower(v_year)) then
					p_entity_json := '{"data": {
										   "role_id": 30,
										   "entity_name": "'||v_year||'",
										   "entity_display_name": "'||v_year||'",
										   "entity_id": null,
										   "is_submit": 1,
										   "pagenumber":1,
										   "itemnumber":1            
										 }
										 }';	 
							
				SELECT siwaf._ins_upd_del_entity('labhkind',p_entity_json)
				into p_entity_data;
							 
				end if;	
				
				if not exists(select entity_master_id from labhkind.labhkind_entity_master
							 where lower (entity_name) = lower(v_month)) then
							 
					
					
					p_entity_json := '{
									  "data": {
										"role_id": 31,
										"entity_name": "'||v_month||'",
										"entity_display_name" : "'||v_month||'",
										"entity_id": null,
										"is_submit": 1,
										"pagenumber": 1,
										"itemnumber": 10
									  }
									}';	 
							
						
							
				SELECT siwaf._ins_upd_del_entity('labhkind',p_entity_json)
				into p_entity_data;
							 
				end if;	

				
				select array(select entity_role_map_id from labhkind.labhkind_entity_role_map
							 where entity_master_id in (select entity_master_id from labhkind.labhkind_entity_master
							 where lower (entity_name) in (lower(v_year),lower(v_month)))) into v_ent ;
							 
				
				
				 insert into labhkind.labhkind_asset_entity_map
						values(nextval('labhkind.seq_labhkind_asset_entity_map_id'),v_videoid,v_assettypeid,unnest(v_ent),
						   	  1,0,0,current_timestamp at time zone 'utc',current_timestamp at time zone 'utc',1,1,1,0,1,uuid_generate_v4(),null );	
            
     	end if;
        
		     SELECT  obj.value->>'entity_role_map_id' into v_entity_lang_id
             from jsonb_array_elements(v_entityjson::jsonb) obj(value)
             where obj.value->>'is_lang'='1';   
				
            
			 update labhkind.labhkind_asset_list
             set    language_id=v_entity_lang_id
             where  asset_id        = v_videoid
             and    asset_type_id   = v_assettypeid;
		
		
     	select v_json->'data'->>'author_data' into v_authordatajson;
        
		if v_authordatajson is not null then
        	
            delete from labhkind.labhkind_author_action where asset_type_id = v_assettypeid and asset_id = v_videoid;
            
			for v_authordata in select * from json_array_elements(v_authordatajson)
			loop
            	
                select v_authordata->>'author_id',v_authordata->>'action_id' into v_author_id,v_action_id;
                
               	if (v_author_id is not null and v_action_id is not null) then
                	
               		v_authoractionid := nextval('labhkind.seq_labhkind_author_action_id');
                    
                    insert into labhkind.labhkind_author_action(author_action_id,author_id,asset_id,asset_type_id,action_id,created_date,updated_date)
					values(v_authoractionid,v_author_id,v_videoid,v_assettypeid,v_action_id,v_currenttimestamp,v_currenttimestamp);
               		
                    if v_action_id = 4 then
                    	
                        update labhkind.labhkind_asset_list set author_id = coalesce(v_author_id,author_id) where asset_id = v_videoid
                        and asset_type_id = v_assettypeid;
                        
               		end if;
                    
				end if;
                
			end loop;
            
		end if;
        
        /*v_notification_json := ('{"OperationType": "2",
                                "EventID": "",
                                "SportID": "",
                                "LanguageID": "",
                                "DeepLinkInfo": "",
                                "Thumbnail": "",
                                "Object_ImageID": "",
                                "AssetType": "MATCH UPDATE",
                                "TriggerID": "",
                                "LeagueID": "",
                                "NotificationID": "",
                                "NotificationText": [
                                {
                                	"clientId": "",
                                	"title": "",
                                	"payloadData": ""
                                }]}')::jsonb;
		
    	v_coverimage := v_image_path||'/'||v_image_file_name;
        v_videodesc := replace(v_videodesc,'''','''''');
    	v_videodesc := regexp_replace(v_videodesc, E'\r\n', ' ', 'g');
        v_notification_json := jsonb_set(v_notification_json, '{SportID}', v_sportid::text::jsonb, true);
    	v_notification_json := jsonb_set(v_notification_json, '{LanguageID}', v_languageid::text::jsonb, true);
    	v_notification_json := jsonb_set(v_notification_json, '{DeepLinkInfo}', ('"'||coalesce(v_matchid::text,'')||'"')::text::jsonb, true);
    	v_notification_json := jsonb_set(v_notification_json, '{Thumbnail}', ('"'||coalesce(v_coverimage,'')||'"')::text::jsonb, true);
    	v_notification_json := jsonb_set(v_notification_json, '{NotificationText,0,title}', ('"'||v_title||'"')::text::jsonb, true);
    	v_notification_json := jsonb_set(v_notification_json, '{NotificationText,0,payloadData}', ('"'||v_videodesc||'"')::text::jsonb, true);
        
    	if not exists(select 1 from labhkind.labhkind_video_notification_map where video_id = v_videoid) then
        	
            insert into labhkind.labhkind_video_notification_map
            select nextval('labhkind.seq_labhkind_video_notification_map_id'),v_videoid,v_notification_json,v_notification_status,1,0,v_updatedby,v_updatedby,
            v_currenttimestamp,v_currenttimestamp;
			
		else
        	
        	update labhkind.labhkind_video_notification_map
        	set notification_json = v_notification_json, status = v_notification_status, updated_by = v_updatedby, updated_date = v_currenttimestamp
        	where video_id = v_videoid;
            
    	end if;
        
        if v_notification_json is null then
        	v_notification_json := ('{"OperationType": "2",
                                "EventID": "",
                                "SportID": "",
                                "LanguageID": "",
                                "DeepLinkInfo": "",
                                "Thumbnail": "",
                                "Object_ImageID": "",
                                "AssetType": "MATCH UPDATE",
                                "TriggerID": "",
                                "LeagueID": "",
                                "NotificationID": "",
                                "NotificationText": [
                                {
                                	"clientId": "",
                                	"title": "",
                                	"payloadData": ""
                                }]}')::jsonb;
        end if;*/
    	
        -- v_json  := jsonb_set(v_json, '{data,notification}', v_notification_json, true);
        
 	end if;
	
    v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
    v_json := jsonb_set(v_json, '{data,video_id}', v_videoid::text::jsonb, true);
    -- v_json := jsonb_set(v_json, '{data,video_url}', ('"'||v_videourl||'"')::text::jsonb, true);
    v_json := jsonb_set(v_json, '{data,video_url}', ('"'||coalesce(v_videourl,'')||'"')::text::jsonb, true);
    
    update labhkind.labhkind_asset_draft set asset_data = v_json where asset_id = v_videoid and asset_type_id = 4 and version_number = v_versionnumber;
    
	
	
	
	if  v_status = 1 then
        	
			
			select labhkind._get_web_list_json(null,4,v_videoid ) 
			into strict v_web_listing_json;
			
			v_web_listing_json:= jsonb_set(v_web_listing_json, '{video_url}', ('"'||v_videourl||'"')::text::jsonb, true);
			v_web_listing_json:= jsonb_set(v_web_listing_json, '{content_source_id}', ('"'||v_contentsourceid||'"')::text::jsonb, true);
			
			select array(select entity_role_map_id 
					 from labhkind.labhkind_asset_entity_map
					 where asset_id = v_videoid
					 and asset_type_id = v_assettypeid
         
					)	a into v_array;
					
					raise notice '%',v_array;
			
          update labhkind.labhkind_asset_list 
		  set web_listing_json = v_web_listing_json,
			  web_detail_jsn = v_json,
			  tagged_entity=v_array
		  where asset_id = v_videoid and asset_type_id = v_assettypeid;
            
        end if;
		
    p_result := 1;
    
    if p_result = 1 then
    	p_data := v_json;
	end if;
     
/*exception
	when others then
    	p_result := -1;*/
	
end;

$$;


--
