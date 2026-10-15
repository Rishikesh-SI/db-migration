-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: labecn_ins_upd_topic_partial(jsonb)
-- Type: FUNCTION

-- Name: labecn_ins_upd_topic_partial(jsonb); Type: FUNCTION; Schema: labecn_bkp05092024; Owner: -
--

CREATE FUNCTION labecn_bkp05092024.labecn_ins_upd_topic_partial(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
  v_createdby numeric := 41;
  v_updatedby numeric := 41;
  v_status numeric := 0;
  v_publisheddate timestamp;
  v_istrashed numeric := 0;
  v_versionnumber numeric := 1;
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
  v_entity json;
  v_entityrolemapid numeric;
  v_priority numeric;
  v_islinkable numeric;
  v_isvisible numeric;
  v_assetentitymapid numeric;
  v_assetentitymapguid varchar(256);
  v_topicassetmapjson json;
  v_topicassetmap json;
  v_aamassetid numeric;
  v_aamassettypeid numeric;
  v_iscover numeric;
  v_topicassetmapid numeric;
  v_topicassetmapguid varchar(256);
  v_authordatajson json;
  v_authordata json;
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
  v_is_pub numeric;
  
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
            v_json->'data'->'handles'
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
          v_handlejson;
	
  	begin
    		select topic_id
    		into strict v_topicid
    		from   labecn.labecn_topic
    		where  channel_id = v_channelid;
  	exception
     	when no_data_found then
          	v_topicid := null;
  	end;
  	
     
     
	if v_handlejson is not null then
     
    		select string_agg(value->>'handle_value',',')
    		into   v_handlevalue
    		from   json_array_elements(v_handlejson::json);
          
	end if;
     
  	v_publisheddate  := coalesce(v_publisheddate, v_currenttimestamp);
	v_assetdraftid   := nextval('labecn.seq_labecn_asset_draft_id');
	v_assetdraftguid := uuid_generate_v4();
     
  	if v_topicid is null then
     	
    		v_assetid := nextval('labecn.seq_labecn_topic_id');
		v_topicguid := uuid_generate_v4();
		v_seodataid := nextval('labecn.seq_labecn_seo_data_id');
		v_seodataguid := uuid_generate_v4();
		v_assetlistid := nextval ('labecn.seq_labecn_asset_list_id');
		v_json := jsonb_set(v_json, '{data,topic_id}', v_assetid::text::jsonb, true);
		v_json := jsonb_set(v_json, '{data,topic_guid}', ('"'||v_topicguid||'"')::text::jsonb, true);
    		
          v_titlealias := v_sportid||'-'||v_channelid||'-'||labecn.labecn_get_url(v_channelname);
     	v_slugtitle := v_channelname;
          
		insert into labecn.labecn_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active,
                                          is_deleted, asset_draft_guid)
		values(v_assetdraftid, v_assetid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby, 1, 0, v_assetdraftguid);
		
		insert into labecn.labecn_topic(topic_id, sport_id, sport_name, edition, edition_name, match_id, match_name, channel_type, channel_id, channel_name, channel_desc, created_date,
                                    updated_date, created_by, updated_by, is_active, is_deleted, is_published, topic_guid, is_trashed, published_version_number, published_date,
                                    content_source_id, title_alias, handle_value)
		values(v_assetid, v_sportid, v_sportname, v_editionid, v_editionname, v_matchid, v_matchname, v_channeltype, v_channelid, v_channelname, v_channeldesc,
                 v_currenttimestamp, v_currenttimestamp, v_updatedby, v_updatedby, 1, 0, v_status, v_topicguid, v_istrashed, v_versionnumber, v_publisheddate, v_contentsourceid,
                 v_titlealias, v_handlevalue);
		
		insert into labecn.labecn_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags, primary_entity_role_map_id,
                                         secondary_entity_role_map_id, total_assets, image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                                         published_version_number, is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
                                         published_date, asset_guid, show_copyright, order_number)
		values(v_assetlistid, v_assetid, v_assettypeid, v_slugtitle, v_titlealias, null, v_channeldesc, null, null, null, null, v_imagefilename, v_imagepath, null, v_showinweb,
                 v_showinmobile, 0, v_versionnumber, v_istrashed, v_currenttimestamp, v_currenttimestamp, v_updatedby, v_updatedby, 1, 0, v_status, v_publisheddate, v_topicguid,
                 v_showcopyright, v_ordernumber);
		
		insert into labecn.labecn_seo_data(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, updated_date, created_by, updated_by, is_active,
                                       is_deleted, is_published, seo_data_guid)
		values(v_seodataid, v_assetid, v_assettypeid, v_seojson, v_versionnumber, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby, 1, 0, v_status, v_seodataguid);
          
	else
     	
          select coalesce(max(published_version_number),1), max(is_published)
          into   strict v_pubversionnumber, v_is_pub
          from   labecn.labecn_topic
          where  topic_id = v_topicid;
          
          select max(version_number)
          into   strict v_versionnumber
          from   labecn.labecn_asset_draft
          where  asset_type_id = v_assettypeid
          and    asset_id      = v_topicid;
          
          if ((v_versionnumber > v_pubversionnumber) or (v_is_pub = 0 and v_versionnumber = v_pubversionnumber)) then
          	
               select asset_data
               into   v_json
               from   labecn.labecn_asset_draft
               where  asset_id = v_topicid
               and    asset_type_id = v_assettypeid
               and    version_number = v_versionnumber;
               
               v_json := jsonb_set(v_json, '{data,channel_name}', ('"'||v_channelname||'"')::text::jsonb, true);
               v_json := jsonb_set(v_json, '{data,channel_description}', ('"'||v_channeldesc||'"')::text::jsonb, true);
               v_json := jsonb_set(v_json, '{data,handlelist}', ('"'||v_handlevalue||'"')::text::jsonb, true);
               v_json := jsonb_set(v_json, '{data,handles}', v_handlejson::text::jsonb, true);
               
               update labecn.labecn_asset_draft ad
               set    asset_data        = v_json,
               	  updated_date      = v_currenttimestamp
			where  asset_id          = v_topicid
               and    asset_type_id     = v_assettypeid
               and    ad.version_number = v_versionnumber;
			
		else
          	
               v_versionnumber := v_versionnumber + 1;
               
               select asset_data
               into v_json
               from labecn.labecn_asset_draft ad
               join  labecn.labecn_topic t
               on t.topic_id = ad.asset_id
               where t.topic_id = v_topicid
               and ad.asset_type_id = v_assettypeid
               and ad.version_number = published_version_number;
               
               v_json := jsonb_set(v_json, '{data,channel_name}', ('"'||v_channelname||'"')::text::jsonb, true);
               v_json := jsonb_set(v_json, '{data,channel_description}', ('"'||v_channeldesc||'"')::text::jsonb, true);
               v_json := jsonb_set(v_json, '{data,handlelist}', ('"'||v_handlevalue||'"')::text::jsonb, true);
               v_json := jsonb_set(v_json, '{data,handles}', v_handlejson::text::jsonb, true);
               
               insert into labecn.labecn_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active,
                                               is_deleted, asset_draft_guid)
			values(v_assetdraftid, v_topicid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby, 1, 0, v_assetdraftguid);
               
		end if;
	
     end if;
     
     v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
	
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
