-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_ins_upd_topic(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_ins_upd_topic(jsonb); Type: FUNCTION; Schema: labmi_v1_bkp; Owner: -
--

CREATE FUNCTION labmi_v1_bkp.labmi_v1_ins_upd_topic(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
     v_json jsonb := p_json;
     v_topicid numeric;
	v_topicguid varchar(256);
	v_sportid numeric;
	v_sportname varchar(500);
	v_editionid numeric;
	v_editionname varchar(500);
	v_matchid numeric;
	v_matchname varchar(500);
	v_channeltype varchar(500);
	v_channelid numeric;
	v_channelname varchar(500);
	v_channeldesc varchar(500);
	v_createdby numeric;
	v_updatedby numeric;
	v_status numeric;
	v_publisheddate timestamp;
	v_istrashed numeric;
	v_versionnumber numeric:=1;
	v_handlejson jsonb;
	v_entityjson json;
	v_seojson jsonb;
	v_assetmapjson jsonb;
     v_assetdraftid numeric;
     v_assetdraftguid varchar(256);
     v_assetid numeric;
     v_seodataid numeric;
     v_seodataguid varchar(256);
     v_assetlistid numeric;
     v_pubversionnumber numeric;
     v_entity jsonb;
     v_entityrolemapid numeric;
     v_priority numeric;
     v_islinkable numeric;
     v_isvisible numeric;
     v_assetentitymapid numeric;
     v_assetentitymapguid varchar(256);
     v_topicassetmapjson json;
     v_topicassetmap jsonb;
     v_aamassetid numeric;
     v_aamassettypeid numeric;
     v_iscover numeric;
     v_topicassetmapid numeric;
     v_topicassetmapguid varchar(256);
     v_authordatajson json;
     v_authordata jsonb;
     v_authorid numeric;
     v_actionid numeric;
     v_authoractionid numeric;
     v_handlevalue varchar(4000);
     v_assettypeid numeric := 5;
     v_slugtitle varchar(4000);
     v_titlealias varchar(4000);
     v_highlights varchar(4000);
     v_imagefilename varchar(500);
     v_imagepath varchar(4000);
     v_showinweb numeric;
     v_showinmobile numeric;
     v_showcopyright numeric;
     v_ordernumber numeric;
     v_contentsourceid numeric;
     v_assetorder numeric;
     v_topicexists numeric;
     v_continue numeric;
     v_slugurl varchar(4000);
     p_result1 numeric;
     
begin
	
     select v_json->'data'->>'topic_id',
     	  v_json->'data'->>'topic_guid',
            v_json->'data'->>'sport_id',
            v_json->'data'->>'sport_name',
            v_json->'data'->>'edition_id',
     	  v_json->'data'->>'edition_name',
            v_json->'data'->>'match_id',
            v_json->'data'->>'match_name',
     	  v_json->'data'->>'channel_type',
            v_json->'data'->>'channel_id',
            v_json->'data'->>'channel_name',
            v_json->'data'->>'channel_description',
            v_json->'data'->>'created_by',
     	  v_json->'data'->>'updated_by',
            v_json->'data'->>'status',
            v_json->'data'->>'published_date',
            v_json->'data'->>'is_trashed',
            v_json->'data'->>'version_number',
            v_json->'data'->>'content_source_id',
            v_json->'data'->>'title_alias',
            v_json->'data'->'handles',
            v_json->'data'->'entitydata',
            v_json->'data'->'seo',
            v_json->'data'->'asset_map',
            v_json->'data'->>'slug_url'
	into v_topicid,
     	v_topicguid,
          v_sportid,
          v_sportname,
          v_editionid,
          v_editionname,
          v_matchid,
          v_matchname,
          v_channeltype,
          v_channelid,
          v_channelname,
          v_channeldesc,
          v_createdby,
          v_updatedby,
          v_status,
          v_publisheddate,
          v_istrashed,
          v_versionnumber,
          v_contentsourceid,
          v_titlealias,
          v_handlejson,
          v_entityjson,
          v_seojson,
          v_topicassetmapjson,
          v_titlealias;
	
            -- insert entry in labmi_v1_redirect table :- changes done by rakesh bhatkar --
             select labmi_v1.labmi_v1_ins_up_redirect(v_topicid,v_titlealias,v_status,v_assettypeid) into p_result1;
            -- insert entry in labmi_v1_redirect table :- changes done by rakesh bhatkar --
  
  
     begin
     	
          select article_id
     	into strict v_topicexists
     	from   labmi_v1.labmi_v1_topic
     	where  upper(slug_url) = upper(v_slugurl) ;
          
          if v_topicid is null then
          	v_continue := -1;
          else
          	if v_topicexists = v_topicid then
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
     
     /*begin
     	
          select topic_id
          into strict v_topicid
          from   labmi_v1.labmi_v1_topic
          where  channel_id = v_channelid;
          
     exception
     	when no_data_found then
          	v_topicid := null;
     end;*/
     
	if v_handlejson is not null then
     	
          select string_agg(value->>'handle_value',',')
          into   v_handlevalue
		from   json_array_elements(v_handlejson::json) ;
          
	end if;
     
     v_publisheddate := coalesce(v_publisheddate,v_currenttimestamp);
	v_assetdraftid := nextval('labmi_v1.seq_labmi_v1_asset_draft_id');
	v_assetdraftguid := uuid_generate_v4();
     
     /*if v_topicid is null then
     	
          v_assetid := nextval('labmi_v1.seq_labmi_v1_topic_id');
		v_topicguid := uuid_generate_v4();
		v_seodataid := nextval('labmi_v1.seq_labmi_v1_seo_data_id');
		v_seodataguid := uuid_generate_v4();
		v_assetlistid := nextval ('labmi_v1.seq_labmi_v1_asset_list_id');
		v_json := jsonb_set(v_json, '{data,topic_id}', v_assetid::text::jsonb, true);
		v_json := jsonb_set(v_json, '{data,topic_guid}', ('"'||v_topicguid||'"')::text::jsonb, true);
		-- v_json := jsonb_set(v_json, '{data,published_date}', ('"'||v_publisheddate||'"')::text::jsonb, true);
		
		insert into labmi_v1.labmi_v1_asset_draft(asset_draft_id,
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
                 v_assettypeid,
                 coalesce(v_versionnumber,1),
                 v_json,
                 v_currenttimestamp,
                 v_currenttimestamp,
                 v_createdby,
                 v_updatedby,
                 1,
                 0,
                 v_assetdraftguid);
		
		insert into labmi_v1.labmi_v1_topic
          (
              topic_id,
              sport_id,
              sport_name,
              edition,
              edition_name,
              match_id,
              match_name,
              channel_type,
              channel_id,
              channel_name,
              channel_desc,
              created_date,
              updated_date,
              created_by,
              updated_by,
              is_active,
              is_deleted,
              is_published,
              topic_guid,
              is_trashed,
              published_version_number,
              published_date,
              content_source_id,
              title_alias,
              handle_value,
              slug_url
          )
		values
		(
              v_assetid,
              v_sportid,
              v_sportname,
              v_editionid,
              v_editionname,
              v_matchid,
              v_matchname,
              v_channeltype,
              v_channelid,
              v_channelname,
              v_channeldesc,
              v_currenttimestamp,
              v_currenttimestamp,
              v_updatedby,
              v_updatedby,
              1,
              0,
              v_status,
              v_topicguid,
              v_istrashed,
              coalesce(v_versionnumber,1),
              v_publisheddate,
              v_contentsourceid,
              v_titlealias,
              v_handlevalue,
              v_slugurl
		);
		
		insert into labmi_v1.labmi_v1_asset_list(asset_list_id,
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
                                         order_number)
		values(v_assetlistid,
                 v_assetid,
                 v_assettypeid,
                 v_slugtitle,
                 v_titlealias,
                 null,
                 v_highlights,
                 null,
                 null,
                 null,
                 null,
                 v_imagefilename,
                 v_imagepath,
                 null,
                 v_showinweb,
                 v_showinmobile,
                 0,
                 coalesce(v_versionnumber,1),       
                 v_istrashed,
                 v_currenttimestamp,
                 v_currenttimestamp,
                 v_updatedby,
                 v_updatedby,
                 1,
                 0,
                 v_status,
                 v_publisheddate,
                 v_topicguid,
                 v_showcopyright,
                 v_ordernumber);
		
		insert into labmi_v1.labmi_v1_seo_data(seo_data_id,
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
                 coalesce(v_versionnumber,0),
                 v_currenttimestamp,
                 v_currenttimestamp,
                 v_createdby,
                 v_updatedby,
                 1,
                 0,
                 v_status,
                 v_seodataguid);
	    
     else*/
     	if v_status = 0 then
          	
          	if v_istrashed = 0 then
               	
                    select coalesce(max(published_version_number),1)
				into   strict v_pubversionnumber
				from   labmi_v1.labmi_v1_topic
				where  topic_id = v_topicid;
                    
				select max(version_number)
				into   strict v_versionnumber
				from   labmi_v1.labmi_v1_asset_draft
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_topicid;
                    
               	if v_versionnumber > v_pubversionnumber then
                    	
                         update labmi_v1.labmi_v1_asset_draft ad
					set    asset_data        = v_json,
						  updated_date      = v_currenttimestamp
					where  asset_id          = v_topicid
                    	and    asset_type_id     = v_assettypeid
					and    ad.version_number = (select max(ad1.version_number)
                                                     from   labmi_v1.labmi_v1_asset_draft ad1
                                                     where  ad1.asset_id = ad.asset_id
                                               	   and ad1.asset_type_id = ad.asset_type_id);
                         
                    else
                    	
                         v_versionnumber := v_versionnumber + 1;
                         
					insert into labmi_v1.labmi_v1_asset_draft(asset_draft_id,
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
                                v_topicid,
                                v_assettypeid,
                                coalesce(v_versionnumber,1),
                                v_json,
                                v_currenttimestamp,
                                v_currenttimestamp,
                                v_createdby,
                                v_updatedby,
                                1,
                                0,
                                v_assetdraftguid);
                         
                    end if;
               else
               	
                    update labmi_v1.labmi_v1_topic
				set    is_published = v_status,
                           is_trashed   = 1,
                           updated_date = v_currenttimestamp
				where  topic_id     = v_topicid;
				
                    update labmi_v1.labmi_v1_asset_draft ad
                    set    asset_data        = v_json,
                    	  updated_date      = v_currenttimestamp
                    where  asset_id          = v_topicid
				and    asset_type_id     = v_assettypeid
                    and    ad.version_number = (select max(ad1.version_number)
                                                from   labmi_v1.labmi_v1_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
                    
				update labmi_v1.labmi_v1_asset_list
				set    updated_date = v_currenttimestamp,
                    	  updated_by   = v_updatedby,
                           is_active    = 0,
                           is_deleted   = 1,
                           is_published = v_status,
                           is_trashed   = v_istrashed
				where  asset_id     = v_topicid
        and asset_type_id=v_assettypeid;
                    
          		select max(ad1.version_number)
                  	into   v_versionnumber
                  	from   labmi_v1.labmi_v1_asset_draft ad1
                  	where  ad1.asset_id = v_topicid
                  	and    ad1.asset_type_id = v_assettypeid;
                    
               end if;
          else
          	
               select max(version_number)
			into   strict v_versionnumber
			from   labmi_v1.labmi_v1_asset_draft
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_topicid;
			
			v_versionnumber := v_versionnumber + 1;
			
			insert into labmi_v1.labmi_v1_asset_draft(asset_draft_id,
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
                      v_topicid,
                      v_assettypeid,
                      coalesce(v_versionnumber,1),
                      v_json,
                      v_currenttimestamp,
                      v_currenttimestamp,
                      v_createdby,
                      v_updatedby,
                      1,
                      0,
                      v_assetdraftguid);
			
			update labmi_v1.labmi_v1_topic
               set    sport_id= v_sportid,
               	  sport_name = v_sportname,
                      edition = v_editionid,
                      edition_name = v_editionname,
                      match_id = v_matchid,
                      match_name = v_matchname,
                      channel_type = v_channeltype,
                      channel_id =  v_channelid,
                      channel_name =  v_channelname,
                      channel_desc = v_channeldesc,
                      updated_date = v_currenttimestamp,
                      updated_by = v_updatedby,
                      is_trashed = v_istrashed,
                      is_published = v_status,
                      published_version_number = v_versionnumber,
                      handle_value = v_handlevalue,
                      slug_url = v_slugurl
               where  topic_id = v_topicid;
               
			update labmi_v1.labmi_v1_seo_data
			set    meta_info 	 = v_seojson,
               	  updated_date  = v_currenttimestamp
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_topicid;
               
			update labmi_v1.labmi_v1_asset_list
			set   asset_title        	 = coalesce(v_slugtitle,asset_title),
               	 title_alias       	      = coalesce(v_titlealias,title_alias),
                     short_desc    	      = v_channeldesc,
                     show_in_app       	      = 0,
                     published_version_number = v_versionnumber,
                     updated_date      	      = v_currenttimestamp,
                     updated_by        	      = v_updatedby,
                     is_active         	      = 1,
                     is_deleted        	      = 0,
                     is_published      	      = v_status,
                     is_trashed        	      = v_istrashed,
                     published_date           = v_publisheddate,
                     show_in_web              = v_showinweb ,
                     show_in_mobile           = v_showinmobile,
                     show_copyright           = v_showcopyright,
                     order_number 			 = v_ordernumber
			where asset_id        	      = v_topicid
       and asset_type_id=v_assettypeid;
               
          end if;
          
     -- end if;
     
     if v_entityjson is not null then
     	
          delete
		from   labmi_v1.labmi_v1_asset_entity_map
		where  asset_type_id = v_assettypeid
		and    asset_id      = v_topicid;
          
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
               	
                    v_assetentitymapid   := nextval('labmi_v1.seq_labmi_v1_asset_entity_map_id');
				v_assetentitymapguid := uuid_generate_v4();
                    
				insert into labmi_v1.labmi_v1_asset_entity_map(asset_entity_map_id,
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
                           coalesce(v_topicid, v_assetid),
                           v_assettypeid,
                           v_entityrolemapid,
                           coalesce(v_islinkable,0),
                           v_isvisible,
                           v_priority,
                           v_currenttimestamp,
                           v_currenttimestamp,
                           v_createdby,
                           v_updatedby,
                           1,
                           0,
                           1,
                           v_assetentitymapguid);
				
                    update labmi_v1.labmi_v1_asset_list
                    set    primary_entity_role_map_id 	 = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
                    	  secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
				where  asset_id 				 = coalesce(v_topicid, v_assetid)
        and asset_type_id=v_assettypeid;
				
			end if;
               
		end loop;
          
	end if;
     
	if v_topicassetmapjson is not null then
     
     	delete
		from   labmi_v1.labmi_v1_topic_asset_map
		where  topic_id      = v_topicid;
          
		for v_topicassetmap in select * from json_array_elements(v_topicassetmapjson)
		loop
          	
               select v_topicassetmap->>'asset_id',
               	  v_topicassetmap->>'asset_type_id',
                      v_topicassetmap->>'is_cover',
                      v_topicassetmap->>'asset_order'
			into   v_aamassetid,
               	  v_aamassettypeid,
                      v_iscover,
                      v_assetorder;
			
			if (v_aamassetid is not null and v_aamassettypeid is not null) then
               	
                    v_topicassetmapid   := nextval('labmi_v1.seq_labmi_v1_topic_asset_map_id');
				v_topicassetmapguid := uuid_generate_v4();
                    
				insert into labmi_v1.labmi_v1_topic_asset_map(topic_asset_map_id,
                                                          topic_id,
                                                        	asset_order,
                                                          asset_id,
                                                          asset_type_id,
                                                          created_date,
                                                          updated_date,
                                                          created_by,
                                                          updated_by,
                                                          is_active,
                                                          is_deleted,
                                                          is_published,
                                                          tamap_guid,
                                                          is_cover)
				values(v_topicassetmapid,
                           v_topicid,
                           v_assetorder,
                           v_aamassetid,
                           v_aamassettypeid,
                           v_currenttimestamp,
                           v_currenttimestamp,
                           v_createdby,
                           v_updatedby,
                           1,
                           0,
                           v_status,
                           v_topicassetmapguid,
                           v_iscover);
                      
         if v_iscover = 1 then
						
                select image_path,image_file_name
                into v_imagepath ,v_imagefilename
                from labmi_v1.labmi_v1_image
                where image_id = v_aamassetid;
                
                update labmi_v1.labmi_v1_asset_list
                set image_path = v_imagepath,image_file_name = v_imagefilename
                where asset_id = v_topicid
                and    asset_type_id=v_assettypeid;
                
              end if;                    
                           
			end if;
		
		end loop;
	
	end if;
	
	select v_json->'data'->>'author_data'
	into   v_authordatajson;
     
	if v_authordatajson is not null then
		
          delete
		from   labmi_v1.labmi_v1_author_action
		where  asset_type_id = v_assettypeid
		and    asset_id      = v_topicid;
		
		for v_authordata in select * from json_array_elements(v_authordatajson)
		loop
          	
               select v_authordata->>'author_id',
               	  v_authordata->>'action_id'
			into   v_authorid,
               	  v_actionid;
			
               if (v_authorid is not null and v_actionid is not null) then
               
               	v_authoractionid := nextval('labmi_v1.seq_labmi_v1_author_action_id');
                    
                    insert into labmi_v1.labmi_v1_author_action(author_action_id,
                                                      author_id,
                                                      asset_id,
                                                      asset_type_id,
                                                      action_id,
                                                      created_date,
                                                      updated_date)
				values(v_authoractionid,
                           v_authorid,
                           coalesce(v_topicid, v_assetid),
                           v_assettypeid,
                           v_actionid,
                           v_currenttimestamp,
                           v_currenttimestamp);
                    
                    update labmi_v1.labmi_v1_asset_list
				set    author_id  = v_authorid
				where  asset_id   = coalesce(v_topicid, v_assetid)
				and    author_id is null
        and asset_type_id=v_assettypeid;
			
			end if;
		
		end loop;
	
	end if;
     
     select v_json->'data'->'handles'
	into   v_handlejson;
     
	if v_handlejson is not null then
	
		select string_agg(value->>'handle_value',',')
          into   v_handlevalue
		from   json_array_elements(v_handlejson::json) ;
		
		update labmi_v1.labmi_v1_topic
		set handle_value = v_handlevalue 
		where  topic_id = v_topicid;
	
	end if;
	
     v_json := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(v_versionnumber,0)||'"')::text::jsonb, true);
	
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
