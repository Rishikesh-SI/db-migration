-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_ins_upd_poll(jsonb)
-- Type: FUNCTION

-- Name: labhkind_ins_upd_poll(jsonb); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_ins_upd_poll(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

--do
--$$
 

declare
/*p_result numeric;
	 p_data jsonb;
	p_json jsonb:='{
  "data": {
    "show_in_mobile": "1",
    "entitydata": [
      {
        "priority": "1",
        "is_visible": "0",
        "entity_role_map_id": "8081",
        "name": "Fans’ Player of the Match",
        "is_linkable": "1"
      },
      {
        "priority": "0",
        "is_visible": "0",
        "entity_role_map_id": "4",
        "name": "English",
        "is_linkable": "0"
      },
      {
        "priority": "2",
        "is_visible": "0",
        "entity_role_map_id": "1",
        "name": "News",
        "is_linkable": "1"
      }
    ],
    "next_poll_id": null,
    "do_not_expire_this_poll": "true",
    "poll_id": null,
    "seo": {
      "meta_desc": null,
      "focus_key": null,
      "custom_meta": null,
      "meta_fields": null,
      "keywords": null,
      "meta_robots": "",
      "canonical_url": null
    },
    "poll_desc": "{\"month\":\"December & January\",\"desktop\":\"December & January\",\"mobile\":\"Dec & Jan\",\"start_date\": \"01/31/2019 07:00 PM\",\"end_date\": \"04/06/2019 08:57 PM\"}",
    "total_response": null,
    "slug_url": "fans-player-of-the-month-december test ",
    "modified_date": null,
    "show_in_web": "1",
    "title": "Fans'' Player of the Month: December & January",
    "created_by": "1",
    "maximum_ans_allowed": "3",
    "author_url": "1",
    "image_thumb": "1",
    "start_date": "2019-03-17 15:27:00",
    "browser_title": "1",
    "status": "1",
    "meta_info": null,
    "edited_by": "1",
    "image_path": "c7/b0/dd/0/",
    "end_date": "2019-04-06 15:27:00",
    "published_date": "2019-03-17 15:27:00",
    "version_number": null,
    "image_id": "32661",
    "image_file_name": "V6tNxrMUnI.jpg",
    "asset_map": [
      {
        "asset_id": "32661",
        "is_cover": "1",
        "asset_type_id": "3",
        "image_name": "V6tNxrMUnI.jpg",
        "image_path": "c7/b0/dd/0/"
      }
    ],
    "poll_type": "1",
    "asset_type": null,
    "is_trashed": "0",
    "poll_option": [
      {
        "option_order": "1",
        "response_count": null,
        "option": "{\"rank\":1,\"pid\":31773,\"player_name\":\"Ferran Corominas\",\"skill\":\"FWD\",\"tid\":496,\"team_name\":\"FC Goa\",\"videourl\":\"\",\"videoimg\":\"\",\"content_source_id\":\"10\"}",
        "poll_option_guid": "",
        "poll_option_id": null
      },
      {
        "option_order": "2",
        "response_count": null,
        "option": "{\"rank\":1,\"pid\":30980,\"player_name\":\"Nishu Kumar\",\"skill\":\"DEF\",\"tid\":656,\"team_name\":\"Bengaluru FC\",\"videourl\":\" https://islcdn.azureedge.net/f8452b62-4a19-4344-9822-a4192529e72f/08102018011705.ism/manifest\",\"videoimg\":\"/c3/e0/ff/0/08102018011705.jpg\",\"content_source_id\":\"10\"}",
        "poll_option_guid": "",
        "poll_option_id": null
      },
      {
        "option_order": "3",
        "response_count": null,
        "option": " {\"rank\":3,\"pid\":31883,\"player_name\":\"Pranjal Bhumij\",\"skill\":\"FWD\",\"tid\":506,\"team_name\":\"Mumbai City FC\",\"videourl\":\"\",\"videoimg\":\"\",\"content_source_id\":\"10\"}",
        "poll_option_guid": "",
        "poll_option_id": null
      },
      {
        "option_order": "4",
        "response_count": null,
        "option": "{\"rank\":4,\"pid\":31839,\"player_name\":\"Rana Gharami\",\"skill\":\"DEF\",\"tid\":500,\"team_name\":\"Delhi Dynamos FC\",\"videourl\":\" https://islcdn.azureedge.net/c96ca5f2-8232-435d-98ad-c9360bbb4afa/08102018010704.ism/manifest\",\"videoimg\":\"\",\"content_source_id\":\"10\"}",
        "poll_option_guid": "",
        "poll_option_id": null
      },
      {
        "option_order": "5",
        "response_count": null,
        "option": "{\"rank\":5,\"pid\":55642,\"player_name\":\"Slavisla Stojanovic\",\"skill\":\"FWD\",\"tid\":498,\"team_name\":\"Kerala Blasters FC\",\"videourl\":\"\",\"videoimg\":\"/1e/8e/0a/0/07102018192041.jpg\",\"content_source_id\":\"10\"}",
        "poll_option_guid": "",
        "poll_option_id": null
      }
    ],
    "show_copyright": "1",
    "poll_guid": "1ee67959-3743-49e2-ad37-38ff2e684996",
    "short_title": "1",
    "alias": "1",
    "multiple_options": true,
    "created_date": null,
    "order_number": "1"
  }
}';
	
	*/
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
     -- select * from labhkind.labhkind_poll;
     p_result1 numeric;
	 v_exp_poll varchar(20);
   v_no_of_ans_allowed numeric;   
   v_counter numeric:=0;
     v_poll_option_id numeric;
     
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
	
  
            -- insert entry in labhkind_redirect table :- changes done by rakesh bhatkar --
             select labhkind.labhkind_ins_up_redirect(v_pollid,v_pollalias,v_ispublished,v_assettypeid) into p_result1;
            -- insert entry in labhkind_redirect table :- changes done by rakesh bhatkar --
     /*begin
          
          select poll_id
     	into strict v_pollexists
     	from   labhkind.labhkind_poll
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
		v_assetdraftid   := nextval('labhkind.seq_labhkind_asset_draft_id');
		v_assetdraftguid := uuid_generate_v4();
          
          if v_pollid is null then
          
          	v_pollid   := nextval('labhkind.seq_labhkind_poll_id');
			v_pollguid      := uuid_generate_v4();
			v_seodataid      := nextval('labhkind.seq_labhkind_seo_data_id');
			v_seodataguid    := uuid_generate_v4();
			v_assetlistid  := nextval ('labhkind.seq_labhkind_asset_list_id');
			v_json 	       := jsonb_set(v_json, '{data,poll_id}', v_pollid::text::jsonb, true);
			v_json 	       := jsonb_set(v_json, '{data,poll_guid}', ('"'||v_pollguid||'"')::text::jsonb, true);
        
          
           
			--insert into labhkind.labhkind_asset_draft
			--(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			--values
			--(v_assetdraftid, v_pollid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_assetdraftguid);
               -- select * from labhkind.labhkind_poll
			insert into labhkind.labhkind_poll
			(poll_id, alias, title, poll_desc, poll_type, start_date, end_date, meta_info, image_url, published_version_number, created_date, updated_date, created_by,
                updated_by, is_active, is_deleted, is_published, poll_guid, show_in_app, show_in_web, show_in_mobile, slug_url, is_trashed)
			values 
			(v_pollid, v_pollalias, v_polltitle, v_polldesc, v_polltype, v_startdate, v_enddate, v_metainfo, v_imagepath, v_versionnumber, v_currenttimestamp,
                v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_ispublished, v_pollguid, v_showinapp, v_showinweb, v_showinmobile, v_slugurl, v_istrashed);
                
			insert into labhkind.labhkind_asset_list
			(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id,
                total_assets, image_file_name, image_path, duration, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, updated_date, created_by,
                updated_by, is_active, is_deleted, is_published, published_date, asset_guid, show_copyright, order_number)
			values
			(v_assetlistid, v_pollid, v_assettypeid, v_polltitle, v_pollalias, null, v_polldesc, null, null, null, null, v_imagefilename, v_imagepath, null, v_showinmobile,
                v_showinapp, v_versionnumber, v_istrashed, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_ispublished, v_publisheddate, v_pollguid,
                v_showcopyright, v_ordernumber);
                
			insert into labhkind.labhkind_seo_data
			(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
           	seo_data_guid)
			values
			(v_seodataid, v_pollid, v_assettypeid, v_seojson, v_versionnumber, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_ispublished,
                v_seodataguid);
                
        /*     select v_json->'data'->>'poll_option'
                into   v_polloptionjson;
               raise notice 'v_counter % ', v_polloptionjson; 
			if v_polloptionjson is not null then
               	    -- v_counter := 0;
                    for v_polloption in select * from json_array_elements(v_polloptionjson)
                    loop
                    	
                     select v_polloption->>'option', v_polloption->>'option_order'
					into   v_option, v_optionorder;
					
					raise notice 'v_counter1 % ', v_counter;
					-- select 1/0;

               		if (v_option is not null) then
                         
						 
               			v_polloptionid := nextval('labhkind.seq_labhkind_poll_option_id');
						
						
						
                              v_polloptionguid := uuid_generate_v4();
							  	
							  v_json= jsonb_set(v_json,('{data,poll_option,'||v_counter::text||',poll_option_id}')::text[],
                                 ('"'||v_polloptionid||'"')::text::jsonb,true);
							v_counter:=v_counter+1;
							raise notice 'v_json % ', v_json;	
                              -- select * from labhkind.labhkind_poll_option
                    		insert into labhkind.labhkind_poll_option(poll_option_id, poll_id, option, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                                              poll_option_guid, option_order)
						values(v_polloptionid, v_pollid, v_option, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_polloptionguid, v_optionorder);
                         	-- select * from labhkind.labhkind_poll_option
					end if;
                         
				end loop;
               
			
			
			end if; */
			
			insert into labhkind.labhkind_asset_draft
			(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values
			(v_assetdraftid, v_pollid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_assetdraftguid);
            
			
               
          else
          	
               if v_ispublished = 0 then
               	
                    if v_istrashed = 0 then
                    	
					select coalesce(max(published_version_number),1)
					into   strict v_publishedversionnumber
					from   labhkind.labhkind_poll
					where  poll_id = v_pollid;
					
					select max(version_number)
					into   strict v_versionnumber
					from   labhkind.labhkind_asset_draft
					where  asset_type_id = v_assettypeid
					and    asset_id      = v_pollid;
					
                         if v_versionnumber > v_publishedversionnumber then
                         	
						update labhkind.labhkind_asset_draft ad
						set    asset_data = v_json,
							  updated_date = v_currenttimestamp
						where  asset_id      = v_pollid
						and    asset_type_id = v_assettypeid
						and    ad.version_number = (select max(ad1.version_number)
                                                          from   labhkind.labhkind_asset_draft ad1
                                                          where  ad1.asset_id = ad.asset_id
                                                          and    ad1.asset_type_id = v_assettypeid);
						
					else
						
						v_versionnumber := v_versionnumber + 1;
                              
						insert into labhkind.labhkind_asset_draft
                              (asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                               asset_draft_guid)
						values
						(v_assetdraftid, v_pollid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0,
                               v_assetdraftguid);
						
					end if;
                         
				else
                   
					update labhkind.labhkind_asset_list
					set is_trashed = v_istrashed,  
                             is_published = v_ispublished,
                             updated_date = v_currenttimestamp
					where asset_id = v_pollid
					and asset_type_id = v_assettypeid;
           
                         
					update labhkind.labhkind_poll
					set is_trashed = v_istrashed,  
                             is_published = v_ispublished,
                             updated_date = v_currenttimestamp
					where  poll_id = v_pollid;
                         
                    	update labhkind.labhkind_asset_draft ad
					set    asset_data = v_json,
                                updated_date = v_currenttimestamp
					where  asset_id = v_pollid
					and    asset_type_id = v_assettypeid
					and    ad.version_number = (select max(ad1.version_number)
                                                     from   labhkind.labhkind_asset_draft ad1
                                                     where  ad1.asset_id = ad.asset_id
                                                     and    ad1.asset_type_id = v_assettypeid);
                         
				end if;
                    
			else
               	
				select max(version_number)
                    into v_versionnumber
                    from labhkind.labhkind_asset_draft
                    where asset_id = v_pollid
                    and asset_type_id = v_assettypeid;
                    
				v_versionnumber := v_versionnumber + 1;
                    
				insert into labhkind.labhkind_asset_draft
				(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                     asset_draft_guid)
				values(v_assetdraftid, v_pollid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0,
                           v_assetdraftguid);
                     
           
				update labhkind.labhkind_poll
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
                           is_trashed = v_istrashed,
						   image_url = v_imagepath
						   
                           
				where  poll_id = v_pollid;
                    
                    update labhkind.labhkind_asset_list
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
                    
				update labhkind.labhkind_seo_data
				set    meta_info = v_seojson,
                    	  updated_date = v_currenttimestamp
				where  asset_type_id = v_assettypeid
				and    asset_id = v_pollid;
        
        
                    
			end if;
               
          end if;
          select v_json->'data'->>'poll_option'
                into   v_polloptionjson;
          if v_polloptionjson is not null then
               	     v_counter := 0;
                    for v_polloption in (select * from json_array_elements(v_polloptionjson)
                   )
                     
                    loop
                    	
                     select v_polloption->>'option', v_polloption->>'option_order',v_polloption->>'poll_option_id'
					into   v_option, v_optionorder,v_poll_option_id;
					
					raise notice 'v_counter1 % ', v_counter;
					-- select 1/0;
             
               		if (v_poll_option_id is null) then
                         
						 
               			v_polloptionid := nextval('labhkind.seq_labhkind_poll_option_id');
						
						
						
                              v_polloptionguid := uuid_generate_v4();
							  	
					 insert into labhkind.labhkind_poll_option(poll_option_id, poll_id, option, 
            created_date, updated_date, created_by, updated_by, is_active, is_deleted,
               poll_option_guid, option_order)
						values(v_polloptionid, v_pollid, v_option, v_currenttimestamp, v_currenttimestamp, v_createdby,
            v_createdby, 1, 0, v_polloptionguid, v_optionorder);
			v_json= jsonb_set(v_json,('{data,poll_option,'||v_counter::text||',poll_option_id}')::text[],
                                 ('"'||v_polloptionid||'"')::text::jsonb,true);
               
    else
               update labhkind.labhkind_poll_option
               set option = v_option,
                    updated_date = v_currenttimestamp,
                    option_order = v_optionorder
               where poll_option_id =v_poll_option_id;
               
  	end if;
          
            
              	raise notice 'v_json % ', v_json;	
                		v_counter:=v_counter+1;
                         
				end loop;
        
       update labhkind.labhkind_asset_draft
       set asset_data = v_json
       where asset_draft_id=v_assetdraftid
       and asset_id = v_pollid;
        end if;
          
          ----- 122 -----
          select v_json->'data'->>'entitydata'
          into   v_entityjson;
          
		if v_entityjson is not null then
          	
			delete
			from   labhkind.labhkind_asset_entity_map
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_pollid;
			
			for v_entity in select * from json_array_elements(v_entityjson)
			loop
               	
				select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
				into   v_entityrolemapid, v_priority, v_islinkable, v_isvisible;
                    
				if v_entityrolemapid is not null then
                    	
					v_assetentitymapid   := nextval('labhkind.seq_labhkind_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
                         
					insert into labhkind.labhkind_asset_entity_map
					(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible, priority, created_date, updated_date, created_by, updated_by,
                          is_active, is_deleted, is_published, aemap_guid)
					values
					(v_assetentitymapid, v_pollid, v_assettypeid, v_entityrolemapid, v_islinkable, v_isvisible, v_priority, v_currenttimestamp,
                          v_currenttimestamp, v_createdby, v_createdby, 1, 0, 1, v_assetentitymapguid);
                         
					update labhkind.labhkind_asset_list
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
          from   labhkind.labhkind_poll_asset_map
          where  poll_id = v_pollid;
          
		if v_assetmapjson is not null then
          	
			for v_assetmap in select * from json_array_elements(v_assetmapjson)
			loop
               	
				select v_assetmap->>'asset_id', v_assetmap->>'is_cover', v_assetmap->>'order_number'
				into   v_imageid, v_iscover, v_imageorder;
				
				v_assetmapid   := nextval('labhkind.seq_labhkind_asset_draft_id');
				
               	insert into labhkind.labhkind_poll_asset_map
                    (poll_asset_map_id, poll_id, asset_order, asset_id, asset_type_id, created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
                     is_cover)
                    values
                    (v_assetmapid, v_pollid, v_imageorder, v_imageid, 3, v_currenttimestamp, v_currenttimestamp, v_createdby, v_createdby, 1, 0, v_ispublished, v_iscover);
				
                    if v_iscover = 1 then
                    
					select image_path,image_file_name
					into   v_imagepath ,v_imagefilename
					from   labhkind.labhkind_image
					where  image_id = v_imageid;
                         
					update labhkind.labhkind_asset_list
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
			from   labhkind.labhkind_author_action
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_pollid;
               
			for v_authordata in select * from json_array_elements(v_authordatajson)
			loop
               
               	select v_authordata->>'author_id', v_authordata->>'action_id'
				into   v_authorid, v_actionid;
				
               	if (v_author_id is not null and v_action_id is not null) then
                    	
               		v_authoractionid := nextval('labhkind.seq_labhkind_author_action_id');
                         
                    	insert into labhkind.labhkind_author_action(author_action_id, author_id, asset_id, asset_type_id, action_id, created_date, updated_date)
					values(v_authoractionid, v_author_id, v_pollid, v_assettypeid, v_action_id, v_currenttimestamp, v_currenttimestamp);
                         
                    	update labhkind.labhkind_asset_list
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
--$$;

$_$;


--
