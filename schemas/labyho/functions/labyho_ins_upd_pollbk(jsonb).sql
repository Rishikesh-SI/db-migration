-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_ins_upd_pollbk(jsonb)
-- Type: FUNCTION

-- Name: labyho_ins_upd_pollbk(jsonb); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_ins_upd_pollbk(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_json jsonb := p_json;
     v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
     v_pollid numeric;
     v_pollalias varchar(500);
     v_polltitle varchar(500);
     v_polldesc varchar(4000);
     v_polltype numeric;
     v_startdate timestamp;
     v_enddate timestamp;
     v_metainfo jsonb;
	v_imageurl varchar(500);
     v_pollguid varchar(256);
     v_pollexists numeric;
     v_continue numeric;
     v_publisheddate timestamp;
     v_assetdraftid numeric;
     v_assetdraftguid varchar(256);
     v_seodataid numeric;
     v_seodataguid varchar(256);
     v_assetlistid numeric;
     v_assettypeid numeric := 6;
     v_versionnumber numeric := 1;
     v_createdby numeric;
     v_updatedby numeric;
     v_ispublished numeric;
     v_showinapp numeric;
     v_showinweb numeric;
     v_showinmobile numeric;
     v_slugurl varchar(500);
     v_istrashed numeric;
     v_showcopyright numeric;
     v_ordernumber numeric;
     v_publishedversionnumber numeric := 1;
     v_imagefilename varchar(500);
     v_entityjson json;
     v_entity json;
     v_entityrolemapid numeric;
     v_priority numeric;
     v_islinkable numeric;
     v_isvisible numeric;
     v_assetentitymapid numeric;
	v_assetentitymapguid varchar(256);
     v_assetmapjson json;
     v_assetmap json;
     v_imageid numeric;
     v_iscover numeric;
     v_imageorder numeric;
     v_assetmapid numeric;
     v_imagepath varchar(500);
     v_imagename varchar(500);
     v_authordatajson json;
     v_authordata json;
     v_authorid numeric;
     v_actionid numeric;
     v_authoractionid numeric;
     v_polloptionjson json;
     v_polloption json;
     v_option varchar(500);
     v_optionorder numeric;
     v_polloptionid numeric;
     v_polloptionguid varchar(256);
     v_seojson jsonb;
     -- select * from labyho.labyho_poll;
     p_result1 numeric;
	 v_exp_poll varchar(20);
     
     
     
begin
	
     select v_json->'data'->>'poll_id',
     	  v_json->'data'->>'alias',
            v_json->'data'->>'title',
            v_json->'data'->>'poll_desc',
            v_json->'data'->>'poll_type',
            v_json->'data'->>'start_date',
            v_json->'data'->>'end_date',
            v_json->'data'->'meta_info',
            v_json->'data'->>'image_path',
            v_json->'data'->>'poll_guid',
            v_json->'data'->>'created_by',
            v_json->'data'->>'status',
            v_json->'data'->>'is_trashed',
            v_json->'data'->>'created_by',
            v_json->'data'->'seo',
			v_json->'data'->>'do_not_expire_this_poll'
	into   v_pollid,
     	  v_pollalias,
            v_polltitle,
            v_polldesc,
            v_polltype,
            v_startdate,
            v_enddate,
            v_metainfo,
            v_imagepath,
            v_pollguid,
            v_createdby,
            v_ispublished,
            v_istrashed,
            v_createdby,
            v_seojson,
			v_exp_poll;
			
			
			if v_exp_poll='true' then 
			
			   v_enddate:=current_timestamp at time zone 'utc' + ('10 year')::interval;
			  
			  end if;
			   
			-- v_json  := jsonb_set(v_json, '{data,end_date}', v_enddate::timestamp::jsonb, true);
	
  
            -- insert entry in labyho_redirect table :- changes done by rakesh bhatkar --
             select labyho.labyho_ins_up_redirect(v_pollid,v_pollalias,v_ispublished,v_assettypeid) into p_result1;
            -- insert entry in labyho_redirect table :- changes done by rakesh bhatkar --
     /*begin
          
          select poll_id
     	into strict v_pollexists
     	from   labyho.labyho_poll
     	where  upper(slug_url) = upper(v_slugurl);
          
          if v_pollid is null then
          	v_continue := -1;
          else
          	if v_pollexists = v_pollid then
          		v_continue := 1;
          	else
           		v_continue := -1;
          	end if;
          end if;
          
     exception
     	when others then
          	v_continue := 1;
     end;
     
     if v_continue = 1 then*/
     	
          v_publisheddate := coalesce(v_publisheddate,v_currenttimestamp);
		v_assetdraftid   := nextval('labyho.seq_labyho_asset_draft_id');
		v_assetdraftguid := uuid_generate_v4();
          
          if v_pollid is null then
          
          	v_pollid   := nextval('labyho.seq_labyho_poll_id');
			v_pollguid      := uuid_generate_v4();
			v_seodataid      := nextval('labyho.seq_labyho_seo_data_id');
			v_seodataguid    := uuid_generate_v4();
			v_assetlistid  := nextval ('labyho.seq_labyho_asset_list_id');
			v_json 	       := jsonb_set(v_json, '{data,poll_id}', v_pollid::text::jsonb, true);
			v_json 	       := jsonb_set(v_json, '{data,poll_guid}', ('"'||v_pollguid||'"')::text::jsonb, true);
               
			insert into labyho.labyho_asset_draft
			(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values
			(v_assetdraftid, v_pollid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_assetdraftguid);
               -- select * from labyho.labyho_poll
			insert into labyho.labyho_poll
			(poll_id, alias, title, poll_desc, poll_type, start_date, end_date, meta_info, image_url, published_version_number, created_date, updated_date, created_by,
                updated_by, is_active, is_deleted, is_published, poll_guid, show_in_app, show_in_web, show_in_mobile, slug_url, is_trashed)
			values 
			(v_pollid, v_pollalias, v_polltitle, v_polldesc, v_polltype, v_startdate, v_enddate, v_metainfo, v_imagepath, v_versionnumber, v_currenttimestamp,
                v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_ispublished, v_pollguid, v_showinapp, v_showinweb, v_showinmobile, v_slugurl, v_istrashed);
                
			insert into labyho.labyho_asset_list
			(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id,
                total_assets, image_file_name, image_path, duration, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, updated_date, created_by,
                updated_by, is_active, is_deleted, is_published, published_date, asset_guid, show_copyright, order_number)
			values
			(v_assetlistid, v_pollid, v_assettypeid, v_polltitle, v_pollalias, null, v_polldesc, null, null, null, null, v_imagefilename, v_imagepath, null, v_showinmobile,
                v_showinapp, v_versionnumber, v_istrashed, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_ispublished, v_publisheddate, v_pollguid,
                v_showcopyright, v_ordernumber);
                
			insert into labyho.labyho_seo_data
			(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
           	seo_data_guid)
			values
			(v_seodataid, v_pollid, v_assettypeid, v_seojson, v_versionnumber, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_ispublished,
                v_seodataguid);
                
                select v_json->'data'->>'poll_option'
                into   v_polloptionjson;
                
			if v_polloptionjson is not null then
               	
                    for v_polloption in select * from json_array_elements(v_polloptionjson)
                    loop
                    	
                         select v_polloption->>'option', v_polloption->>'option_order'
					into   v_option, v_optionorder;
                         
               		if (v_option is not null) then
                         
               			v_polloptionid := nextval('labyho.seq_labyho_poll_option_id');
                              v_polloptionguid := uuid_generate_v4();
                              -- select * from labyho.labyho_poll_option
                    		insert into labyho.labyho_poll_option(poll_option_id, poll_id, option, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                                              poll_option_guid, option_order)
						values(v_polloptionid, v_pollid, v_option, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_polloptionguid, v_optionorder);
                         	-- select * from labyho.labyho_poll_option
					end if;
                         
				end loop;
                    
			end if;
               
          else
          	
               if v_ispublished = 0 then
               	
                    if v_istrashed = 0 then
                    	
					select coalesce(max(published_version_number),1)
					into   strict v_publishedversionnumber
					from   labyho.labyho_poll
					where  poll_id = v_pollid;
					
					select max(version_number)
					into   strict v_versionnumber
					from   labyho.labyho_asset_draft
					where  asset_type_id = v_assettypeid
					and    asset_id      = v_pollid;
					
                         if v_versionnumber > v_publishedversionnumber then
                         	
						update labyho.labyho_asset_draft ad
						set    asset_data = v_json,
							  updated_date = v_currenttimestamp
						where  asset_id      = v_pollid
						and    asset_type_id = v_assettypeid
						and    ad.version_number = (select max(ad1.version_number)
                                                          from   labyho.labyho_asset_draft ad1
                                                          where  ad1.asset_id = ad.asset_id
                                                          and    ad1.asset_type_id = v_assettypeid);
						
					else
						
						v_versionnumber := v_versionnumber + 1;
                              
						insert into labyho.labyho_asset_draft
                              (asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                               asset_draft_guid)
						values
						(v_assetdraftid, v_pollid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0,
                               v_assetdraftguid);
						
					end if;
                         
				else
                    
					update labyho.labyho_asset_list
					set is_trashed = v_istrashed,  
                             is_published = v_ispublished,
                             updated_date = v_currenttimestamp
					where asset_id = v_pollid
					and asset_type_id = v_assettypeid;
                         
					update labyho.labyho_poll
					set is_trashed = v_istrashed,  
                             is_published = v_ispublished,
                             updated_date = v_currenttimestamp
					where  poll_id = v_pollid;
                         
                    	update labyho.labyho_asset_draft ad
					set    asset_data = v_json,
                                updated_date = v_currenttimestamp
					where  asset_id = v_pollid
					and    asset_type_id = v_assettypeid
					and    ad.version_number = (select max(ad1.version_number)
                                                     from   labyho.labyho_asset_draft ad1
                                                     where  ad1.asset_id = ad.asset_id
                                                     and    ad1.asset_type_id = v_assettypeid);
                         
				end if;
                    
			else
               	
				select max(version_number)
                    into v_versionnumber
                    from labyho.labyho_asset_draft
                    where asset_id = v_pollid
                    and asset_type_id = v_assettypeid;
                    
				v_versionnumber := v_versionnumber + 1;
                    
				insert into labyho.labyho_asset_draft
				(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                     asset_draft_guid)
				values(v_assetdraftid, v_pollid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0,
                           v_assetdraftguid);
                    
				update labyho.labyho_poll
				set 	  alias = v_pollalias,
                    	  title = v_polltitle,
                           poll_desc = v_polldesc,
                           poll_type = v_polltype,
                           start_date = v_startdate,
                           end_date = v_enddate,
                           meta_info = v_metainfo,
                           published_version_number = v_versionnumber,
                           updated_date = v_currenttimestamp,
                           updated_by = v_createdby,
                           is_published = v_ispublished,
                           show_in_app = v_showinapp,
                           show_in_web = v_showinweb,
                           show_in_mobile = v_showinmobile,
                           slug_url = v_slugurl,
                           is_trashed = v_istrashed
				where  poll_id = v_pollid;
                    
                    update labyho.labyho_asset_list
				set asset_title = v_polltitle,
                        title_alias = v_pollalias,
                        short_desc = v_polldesc,
                        show_in_web = v_showinweb,
                        show_in_mobile = v_showinmobile,
                        show_in_app = v_showinapp,
                        image_file_name = v_imagefilename,
                        image_path = v_imagepath,
                        total_assets = null,
                        published_version_number = v_versionnumber,
                        is_trashed = v_istrashed,
                        updated_date = v_currenttimestamp,
                        updated_by = v_createdby,
                        is_published = v_ispublished,
                        published_date = v_publisheddate,
                        show_copyright = v_showcopyright,
                        order_number = v_ordernumber
				where asset_id = v_pollid
        and asset_type_id = v_assettypeid;
                    
				update labyho.labyho_seo_data
				set    meta_info = v_seojson,
                    	  updated_date = v_currenttimestamp
				where  asset_type_id = v_assettypeid
				and    asset_id = v_pollid;
                    
			end if;
               
          end if;
          
          select v_json->'data'->>'entitydata'
          into   v_entityjson;
          
		if v_entityjson is not null then
          	
			delete
			from   labyho.labyho_asset_entity_map
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_pollid;
			
			for v_entity in select * from json_array_elements(v_entityjson)
			loop
               	
				select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
				into   v_entityrolemapid, v_priority, v_islinkable, v_isvisible;
                    
				if v_entityrolemapid is not null then
                    	
					v_assetentitymapid   := nextval('labyho.seq_labyho_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
                         
					insert into labyho.labyho_asset_entity_map
					(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible, priority, created_date, updated_date, created_by, updated_by,
                          is_active, is_deleted, is_published, aemap_guid)
					values
					(v_assetentitymapid, v_pollid, v_assettypeid, v_entityrolemapid, v_islinkable, v_isvisible, v_priority, v_currenttimestamp,
                          v_currenttimestamp, v_createdby, v_createdby, 1, 0, 1, v_assetentitymapguid);
                         
					update labyho.labyho_asset_list
					set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
                             secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
					where asset_id = v_pollid
          and asset_type_id = v_assettypeid;
                         
				end if;
                    
			end loop;
               
		end if;
          
		select v_json->'data'->>'asset_map'
		into   v_assetmapjson;
          
          delete
          from   labyho.labyho_poll_asset_map
          where  poll_id = v_pollid;
          
		if v_assetmapjson is not null then
          	
			for v_assetmap in select * from json_array_elements(v_assetmapjson)
			loop
               	
				select v_assetmap->>'asset_id', v_assetmap->>'is_cover', v_assetmap->>'order_number'
				into   v_imageid, v_iscover, v_imageorder;
				
				v_assetmapid   := nextval('labyho.seq_labyho_asset_draft_id');
				
               	insert into labyho.labyho_poll_asset_map
                    (poll_asset_map_id, poll_id, asset_order, asset_id, asset_type_id, created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
                     is_cover)
                    values
                    (v_assetmapid, v_pollid, v_imageorder, v_imageid, 3, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_ispublished, v_iscover);
				
                    if v_iscover = 1 then
                    
					select image_path,image_file_name
					into   v_imagepath ,v_imagefilename
					from   labyho.labyho_image
					where  image_id = v_imageid;
                         
					update labyho.labyho_asset_list
					set    image_path = v_imagepath,
                                image_file_name = v_imagefilename
					where  asset_id = v_pollid
          and asset_type_id = v_assettypeid;
					
				end if;
                    
			end loop;
               
		end if;
          
  		select v_json->'data'->>'author_data'
		into   v_authordatajson;
          
		if v_authordatajson is not null then
          
          	delete
			from   labyho.labyho_author_action
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_pollid;
               
			for v_authordata in select * from json_array_elements(v_authordatajson)
			loop
               
               	select v_authordata->>'author_id', v_authordata->>'action_id'
				into   v_authorid, v_actionid;
				
               	if (v_author_id is not null and v_action_id is not null) then
                    	
               		v_authoractionid := nextval('labyho.seq_labyho_author_action_id');
                         
                    	insert into labyho.labyho_author_action(author_action_id, author_id, asset_id, asset_type_id, action_id, created_date, updated_date)
					values(v_authoractionid, v_author_id, v_pollid, v_assettypeid, v_action_id, v_currenttimestamp, v_currenttimestamp);
                         
                    	update labyho.labyho_asset_list
					set    author_id  = v_author_id
					where  asset_id   = v_pollid
					and    author_id is null
          and asset_type_id = v_assettypeid;
                         
				end if;
                    
			end loop;
               
		end if;
          
          v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
          
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
