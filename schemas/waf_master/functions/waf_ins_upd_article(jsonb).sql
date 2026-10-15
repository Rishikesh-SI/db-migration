-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ins_upd_article(jsonb)
-- Type: FUNCTION

-- Name: waf_ins_upd_article(jsonb); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_ins_upd_article(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
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
    	v_slugtitle        	  varchar(4000);
    	v_titlealias       	  varchar(4000);
    	v_browsertitle     	  varchar(4000);
    	v_shortheadline    	  varchar(4000);
    	v_place            	  varchar(4000);
    	v_country             varchar(4000);
    	v_fulltext            text;
    	v_introtext           text;
    	v_articleguid         varchar(50);
    	v_assetentitymapid    numeric;
    	v_entitymasterid      numeric;
    	v_priority 	    	  numeric;
     v_islinkable  		  numeric;
     v_isvisible  		  numeric;
    	v_assetentitymapguid  varchar(50);
    	v_seojson 		  jsonb;
    	v_seodataid 		  numeric;
    	v_seodataguid 		  varchar(50);
    	v_entityjson 		  json;
    	v_entity 			  json;
	v_articleexists 	  numeric;
	v_seoexists 		  numeric;
    	v_entityexists 	  numeric;
     v_currenttimestamp    timestamp;
     v_articleassetmapjson json;
     v_articleassetmap	  json;
     v_aam_assetid		  numeric;
     v_aam_assettypeid	  numeric;
     v_articleassetmapid   numeric;
     v_articleassetmapguid numeric;
     v_assetmetajson       jsonb;
     
begin
	
     v_currenttimestamp := current_timestamp;
     
     v_json := p_json;
     
	select v_json->'data'->>'article_id',
     	  v_json->'data'->>'status',
            v_json->'data'->>'asset_type',
            v_json->'data'->>'created_by',
            v_json->'data'->>'edited_by',
            v_json->'data'->>'content_source_id',
		  v_json->'data'->>'slug_title',
            v_json->'data'->>'title_alias',
            v_json->'data'->>'browser_title',
            v_json->'data'->>'short_headline',
            v_json->'data'->>'place',
            v_json->'data'->>'country',
            v_json->'data'->>'full_text',
            v_json->'data'->>'intro_text',
            v_json->'data'->'seo',
            v_json->'data'->'asset_meta'
    	into   v_articleid,
     	  v_status,
            v_assettypeid,
            v_createdby,
            v_updatedby,
            v_contentsourceid,
            v_slugtitle,
            v_titlealias,
            v_browsertitle,
            v_shortheadline,
            v_place,
            v_country,
            v_fulltext,
            v_introtext,
            v_seojson,
            v_assetmetajson;
     
	if v_articleid is null then
     	
          v_assetdraftid   := nextval('waf_master.seq_waf_asset_draft_id');
    		v_assetdraftguid := uuid_generate_v4();
          v_assetid        := nextval('waf_master.seq_waf_article_id');
		v_articleguid 	  := uuid_generate_v4();
          v_seodataid   	  := nextval('waf_master.seq_waf_seo_data_id');
		v_seodataguid 	  := uuid_generate_v4();
		v_json 	       := jsonb_set(v_json, '{data,article_id}', v_assetid::text::jsonb, true);
		v_json 		  := jsonb_set(v_json, '{data,guid}', ('"'||v_articleguid||'"')::text::jsonb, true);
          
          insert into waf_master.waf_asset_draft(asset_draft_id,
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
                 v_versionnumber,
                 v_json,
                 v_currenttimestamp,
                 v_currenttimestamp,
                 v_createdby,
                 v_updatedby,
                 1,
                 0,
                 v_assetdraftguid);
          
          insert into waf_master.waf_article(article_id,
                                             content_source_id,
                                             asset_meta,
                                             slug_title,
                                             title_alias,
                                             browser_title,
                                             short_headline,
                                             content_source,
                                             place, country,
                                             show_in_app,
                                             disclaimer_text,
                                             checked_out_by,
                                             full_text,
                                             intro_text,
                                             published_version_number,
                                             created_date,
                                             updated_date,
                                             created_by,
                                             updated_by,
                                             is_active,
                                             is_deleted,
                                             is_published,
                                             is_trashed,
                                             article_guid)
		values(v_assetid,
                 v_contentsourceid,
                 v_assetmetajson,
                 v_slugtitle,
                 v_titlealias,
                 v_browsertitle,
                 v_shortheadline,
                 null,
                 v_place,
                 v_country,
                 0,
                 null,
                 null,
                 v_fulltext,
                 v_introtext,
                 v_versionnumber,
                 v_currenttimestamp,
                 v_currenttimestamp,
                 v_createdby,
                 v_updatedby,
                 1,
                 0,
                 v_status,
                 0,
                 v_articleguid);
          
		insert into waf_master.waf_seo_data(seo_data_id,
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
     	
          if v_status = 0 then
          	
               update waf_master.waf_asset_draft ad
               set    asset_data        = v_json,
               	  updated_date      = v_currenttimestamp
               where  asset_id          = v_articleid
               and    ad.version_number = (select max(ad1.version_number)
                                           from   waf_master.waf_asset_draft ad1
                                           where  ad1.asset_id = ad.asset_id);
               
          else
          	
               v_assetdraftid   := nextval('waf_master.seq_waf_asset_draft_id');
    			v_assetdraftguid := uuid_generate_v4();
               
               select max(version_number)
			into   strict v_versionnumber
        		from   waf_master.waf_asset_draft
        		where  asset_type_id = v_assettypeid
			and    asset_id      = v_articleid;
          	
			v_versionnumber := v_versionnumber + 1;
               
               insert into waf_master.waf_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                                    created_by, updated_by, is_active, is_deleted, asset_draft_guid)
    			values(v_assetdraftid, v_articleid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby,
                      1, 0, v_assetdraftguid);
               
               update waf_master.waf_article
			set    content_source_id 	  = v_contentsourceid,
				  asset_meta        	  = v_assetmetajson,
				  slug_title        	  = v_slugtitle,
				  title_alias       	  = v_titlealias,
				  browser_title     	  = v_browsertitle,
				  short_headline    	  = v_shortheadline,
				  content_source    	  = null,
				  place             	  = v_place,
				  country 			  = v_country,
				  show_in_app       	  = 0,
				  disclaimer_text   	  = null,
				  checked_out_by    	  = null,
				  full_text         	  = v_fulltext,
				  intro_text        	  = v_introtext,
				  published_version_number = v_versionnumber,
				  updated_date      	  = v_currenttimestamp,
				  created_by        	  = v_createdby,
				  updated_by        	  = v_updatedby,
				  is_active         	  = 1,
				  is_deleted        	  = 0,
				  is_published      	  = v_status,
				  is_trashed        	  = 0
			where  article_id        	  = v_articleid;
               
			update waf_master.waf_seo_data
			set    meta_info 	 = v_seojson,
               	  updated_date  = v_currenttimestamp
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_articleid;
               
               delete
			from   waf_master.waf_asset_entity_map
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_articleid;
               
               delete
			from   waf_master.waf_article_asset_map
			where  asset_type_id = v_assettypeid
			and    asset_id      = v_articleid;
               
          end if;
          
	end if;
     
     select v_json->'data'->>'entitydata'
	into   v_entityjson;
   
	if v_entityjson is not null then
     	
          for v_entity in select * from json_array_elements(v_entityjson)
          loop
          	
               select v_entity->>'entity_master_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
               into   v_entitymasterid, v_priority, v_islinkable, v_isvisible;
            	
               if (v_entitymasterid is not null and v_priority is not null) then
               
               	v_assetentitymapid   := nextval('waf_master.seq_waf_asset_entity_map_id');
            		v_assetentitymapguid := uuid_generate_v4();
				
                    insert into waf_master.waf_asset_entity_map(asset_entity_map_id,
                                                                asset_id,
                                                                asset_type_id,
                                                                entity_master_id,
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
                           coalesce(v_articleid, v_assetid),
                           v_assettypeid,
                           v_entitymasterid,
                           v_islinkable,
                           v_isvisible,
                           0,
                           v_priority,
                           v_currenttimestamp,
                           v_currenttimestamp,
                           1,
                           0,
                           1,
                           0,
                           1,
                           v_assetentitymapguid);
            	
               end if;
          
          end loop;
          
     end if;
     
     select v_json->'data'->>'asset_map'
	into   v_articleassetmapjson;
     
     if v_articleassetmapjson is not null then
     	
          for v_articleassetmap in select * from json_array_elements(v_articleassetmapjson)
          loop
          	
               select v_articleassetmap->>'asset_id', v_articleassetmap->>'asset_type_id'
               into   v_aam_assetid, v_aam_assettypeid;
               
               if (v_aam_assetid is not null and v_aam_assettypeid is not null) then
               	
                    v_articleassetmapid   := nextval('waf_master.seq_waf_article_asset_map_id');
            		v_articleassetmapguid := uuid_generate_v4();
                    
                    insert into waf_master.waf_article_asset_map(article_asset_map_id,
                                                                 article_id,
                                                                 asset_id,
                                                                 asset_type_id,
                                                                 created_date,
                                                                 updated_date,
                                                                 created_by,
                                                                 updated_by,
                                                                 is_active,
                                                                 is_deleted,
                                                                 is_published,
                                                                 aamap_guid)
				values(v_articleassetmapid,
                           coalesce(v_articleid, v_assetid),
                           v_aam_assetid,
                           v_aam_assettypeid,
                           v_currenttimestamp,
                           v_currenttimestamp,
                           v_createdby,
                           v_updatedby,
                           1,
                           0,
                           v_status,
                           v_articleassetmapguid);
                    
               end if;
               
          end loop;
          
     end if;
     
     p_result := 1;
     
    	if p_result = 1 then
    		
          p_data := v_json;
          
    	end if;
     
exception
	
     when others then
    		p_result := -1;
	
end;

$$;


--
