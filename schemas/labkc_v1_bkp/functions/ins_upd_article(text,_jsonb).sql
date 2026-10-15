-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: _ins_upd_article(text, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_article(text, jsonb); Type: FUNCTION; Schema: labkc_v1_bkp; Owner: -
--

CREATE FUNCTION labkc_v1_bkp._ins_upd_article(p_schema_prefix text, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

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
    v_ispublished         numeric;
    v_articlepublishedstatus numeric;
    v_articletrashedstatus numeric;
    v_shorttitle varchar(4000);
	v_sequence_prefix text := '$1'||'.seq_'||'$1';
    v_article_exists numeric;
	err_msg text;
	v_error_check text;
	v_lang_id numeric ;
	v_lang_index numeric ;
    v_lang_erm_id numeric;
	v_canonical_url text;
    v_web_listing_json jsonb;
    
	
--********************************PREFACE BLOCK*******************************
--  NAME: _ins_upd_article
--
--  Purpose: CMS
--
--  Parameters:  
--
--
--  External Output:  
--                    
--
--  Written/Modified by:   Date:           Reason:
--  R. BHATKAR             27/11/2018      purpose of generic CMS
--********************************END PREFACE BLOCK***************************
	
begin
	
	/*if exists(select 1 from information_schema.routines where specific_schema = p_schema_prefix and routine_name = specific_schema||'_ins_upd_article') then
		
		execute 'select * from '||$1||'.'||$1||'_ins_upd_article($2)'
		using p_schema_prefix,p_json
		into p_result,p_data;
		
	else*/
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
	p_schema_prefix:='labkc_v1';
	
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
           v_json->'data'->>'short_title'
	into   v_articleid,
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
           v_shorttitle;
    
	v_published_date := coalesce(v_published_date, v_currenttimestamp);
	v_assetdraftguid := uuid_generate_v4();
	
	execute 'select nextval('''||$1||'.seq_'||$1||'_asset_draft_id'')'
	into v_assetdraftid
	using p_schema_prefix;
	
	if v_articleid is null then
		
        execute 'select count(1) from '||$1||'.'||$1||'_article
		where upper(title_alias) = upper($2)'
        into v_article_exists
        using p_schema_prefix, v_titlealias;
        
        if v_article_exists = 0 then
        	
            execute 'select nextval('''||$1||'.seq_'||$1||'_article_id''), 
			             	nextval('''||$1||'.seq_'||$1||'_asset_list_id''),
            				nextval('''||$1||'.seq_'||$1||'_seo_data_id'')'
			into v_assetid,
			     v_asset_list_id, 
			     v_seodataid
			using p_schema_prefix;
			
			v_articleguid := uuid_generate_v4();
			v_seodataguid := uuid_generate_v4();
			v_json := jsonb_set(v_json, '{data,article_id}', v_assetid::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_articleguid||'"')::text::jsonb, true);
			
			execute 'insert into '||$1||'.'||$1||'_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
            													updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			                                             values($2, $3, $4, $5, $6, $7, $7, $8, $9, 1, 0, $10)'
			using p_schema_prefix, v_assetdraftid, v_assetid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_createdby, v_updatedby,
            		v_assetdraftguid;
			
			execute 'insert into '||$1||'.'||$1||'_article(article_id, content_source_id, asset_meta, title, title_alias, browser_title, highlights,
            												content_source, place, country, 
															show_in_app, disclaimer_text, 
															checked_out_by, full_text,
															intro_text, published_version_number, 
															created_date, updated_date, created_by, updated_by,
															is_active, is_deleted, is_published, is_trashed, 
															article_guid, published_date, show_in_web,
															show_in_mobile, show_copyright, content_source_link,
															order_number, slug_url, short_title)
					        values($2, $3, $4, $5, $6, $7, $8, null, $9, $10, 0, null, null, $11, $12, 
							       $13, $14, $14, $15, $16, 1, 0, $17, $18, $19, $20, $21,
                    		      $22, $23, $24, $25, $26, $27)'
			                using p_schema_prefix, v_assetid, v_contentsourceid, v_assetmetajson,
							      v_title, v_titlealias, --6
								  v_browsertitle, v_highlights, v_place,
            		              v_country, v_fulltext, v_introtext, v_versionnumber, 
								  v_currenttimestamp, v_createdby, v_updatedby, v_status,
                                  v_is_trashed, v_articleguid, v_published_date, v_show_in_web, v_show_in_mobile,
							      v_show_copyright, v_content_source_link,
                                  v_order_number, v_slugurl, v_shorttitle;
			
			execute 'insert into '||$1||'.'||$1||'_asset_list(asset_list_id, 
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
																short_title)
					values($2, $3, $4, $5, $6, null, $7, null, null, null, null, $8, $9, null, $10, $11, 0, $12, $13, $14, $14, $15, $15, 1, 0, $16, $17,
                    		$18, $19, $20, $21)'
			using   p_schema_prefix, v_asset_list_id, v_assetid, v_assettypeid, v_title, v_titlealias,--6
			        v_introtext, v_image_file_name, v_image_path, --9
            		v_show_in_web, v_show_in_mobile, v_versionnumber, --12
					v_is_trashed, v_currenttimestamp, v_updatedby, v_status,--16
					v_published_date,
                    v_articleguid, v_show_copyright, v_order_number, v_shorttitle;
			

			execute 'insert into '||$1||'.'||$1||'_seo_data(seo_data_id, asset_id, asset_type_id, meta_info)
					values($2, $3, $4, $5)'
			using p_schema_prefix, v_seodataid, v_assetid, v_assettypeid, v_seojson;
            
        else
        	
            p_data := '{"data":{"message" :"Alias Already Exist"}}';
            p_result := 0; 
            return;
            
        end if;
       
	else
		
		execute 'select is_published, is_trashed from '||$1||'.'||$1||'_article where article_id = $2'
		into v_articlepublishedstatus, v_articletrashedstatus
		using p_schema_prefix, v_articleid;
		
		if v_status = 0 then
			
			if v_is_trashed = 0 then
				
				execute 'select coalesce(published_version_number, 1), 
				         is_published from '||$1||'.'||$1||'_article 
						 where article_id = $2'
				into strict v_pubversionnumber, v_ispublished
				using p_schema_prefix, v_articleid;
				
				execute 'select max(version_number) from '||$1||'.'||$1||'_asset_draft 
				         where asset_type_id = $2 and asset_id = $3'
				into strict v_versionnumber
				using p_schema_prefix, v_assettypeid, v_articleid;
				
				if ((v_versionnumber = v_pubversionnumber and v_ispublished = 0) or (v_versionnumber > v_pubversionnumber)) then
					
					execute 'update '||$1||'.'||$1||'_asset_draft ad
								set asset_data = $2, updated_date = $3
								where asset_id = $4
								and asset_type_id = $5
								and ad.version_number = (select max(ad1.version_number)
															from '||$1||'.'||$1||'_asset_draft ad1
															where ad1.asset_id = ad.asset_id
															and ad1.asset_type_id = ad.asset_type_id)'
					using p_schema_prefix, v_json, v_currenttimestamp, v_articleid, v_assettypeid;
				
				else
					
					v_versionnumber := v_versionnumber + 1;
					
					execute 'insert into '||$1||'.'||$1||'_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data,
																		created_date, updated_date, created_by, updated_by, is_active, is_deleted,
																		asset_draft_guid)
							values($2, $3, $4, $5, $6, $7, $7, $8, $9, 1, 0, $10)'
					using p_schema_prefix, v_assetdraftid, v_articleid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_createdby,
							v_updatedby, v_assetdraftguid;
					
				end if;
				
			else
				
				execute 'update '||$1||'.'||$1||'_article
							set is_published = $2, is_trashed = 1, updated_date = $3
							where article_id = $4'
				using p_schema_prefix, v_status, v_currenttimestamp, v_articleid;
				
				execute 'update '||$1||'.'||$1||'_asset_draft ad
							set asset_data = $2, updated_date = $3
							where asset_id = $4
							and asset_type_id = $5
							and ad.version_number = (select max(ad1.version_number)
														from '||$1||'.'||$1||'_asset_draft ad1
														where ad1.asset_id = ad.asset_id
														and ad1.asset_type_id = ad.asset_type_id)'
				using p_schema_prefix, v_json, v_currenttimestamp, v_articleid, v_assettypeid;
				
				execute 'update '||$1||'.'||$1||'_asset_list
							set updated_date = $2, updated_by = $3, is_published = $4, is_trashed = $5
							where asset_id = $6
							and asset_type_id = $7'
				using p_schema_prefix, v_currenttimestamp, v_updatedby, v_status, v_is_trashed, v_articleid, v_assettypeid;
				
				execute 'select max(version_number) from '||$1||'.'||$1||'_asset_draft where asset_id = $2 and asset_type_id = $3'
				into v_versionnumber
				using p_schema_prefix, v_articleid, v_assettypeid;
				
			end if;
			
		else
			
			execute 'select max(version_number) from '||$1||'.'||$1||'_asset_draft where asset_type_id = $2 and asset_id = $3'
			into strict v_versionnumber
			using p_schema_prefix, v_assettypeid, v_articleid;
			
			v_versionnumber := v_versionnumber + 1;
			
            execute 'select is_published from '||$1||'.'||$1||'_article where article_id = $2'
            into v_ispublished
            using p_schema_prefix, v_articleid;
            
			if v_ispublished = 1 then
            	
				execute 'select '||$1||'.'||$1||'_ins_up_redirect($2, $3, $4, $5)'
                into p_result1
                using p_schema_prefix, v_articleid, v_titlealias, v_status, v_assettypeid;
                
			end if;
            
			execute 'insert into '||$1||'.'||$1||'_asset_draft(asset_draft_id, 
							asset_id, asset_type_id, version_number, 
							asset_data, created_date,
							updated_date, created_by, updated_by, is_active, 
							is_deleted, asset_draft_guid)
					values($2, $3, $4, $5, $6, $7, $7, $8, $9, 1, 0, $10)'
			using p_schema_prefix, v_assetdraftid, v_articleid, v_assettypeid, v_versionnumber, 
			v_json, v_currenttimestamp, v_createdby, v_updatedby,
					v_assetdraftguid;
			
			execute 'update '||$1||'.'||$1||'_article
						set content_source_id = $2, asset_meta = $3, title = $4, title_alias = $5, browser_title = $6, highlights = $7,
							content_source = null, place = $8, country = $9, show_in_app = 0, disclaimer_text = null, checked_out_by = null,
							full_text = $10, intro_text = $11, 
							published_version_number = $12, 
							updated_date = $13, 
							updated_by = $14, 
							is_active = 1,
							is_deleted = 0, 
							is_published = $15, 
							is_trashed = $16, 
							published_date = $17, show_in_web = $18, show_in_mobile = $19,
							show_copyright = $20, content_source_link = $21, order_number = $22, slug_url = $23, short_title = $24
						where article_id = $25'
			using p_schema_prefix, v_contentsourceid, v_assetmetajson, v_title, v_titlealias, v_browsertitle, v_highlights, v_place, v_country,
					v_fulltext, v_introtext, v_versionnumber, v_currenttimestamp, v_updatedby, v_status, v_is_trashed, v_published_date, v_show_in_web,
					v_show_in_mobile, v_show_copyright, v_content_source_link, v_order_number, v_slugurl, v_shorttitle, v_articleid;
			
			execute 'update '||$1||'.'||$1||'_seo_data
						set meta_info = $2
						where asset_type_id = $4
						and asset_id = $5'
			using p_schema_prefix, v_seojson, v_currenttimestamp, v_assettypeid, v_articleid;
			
			execute 'update '||$1||'.'||$1||'_asset_list
						set asset_title = $2, title_alias = $3, short_desc = $4, 
						show_in_app = 0, published_version_number = $5, 
						    updated_date = $6,
							updated_by = $7, is_active = 1, 
							is_deleted = 0, 
							is_published = $8, is_trashed = $9, 
							published_date = $10,
							show_in_web = $11, show_in_mobile = $12, 
							show_copyright = $13, order_number = $14, 
							short_title = $15
						where asset_id = $16
						and asset_type_id = $17'
			using p_schema_prefix, v_title, v_titlealias, v_introtext, v_versionnumber, v_currenttimestamp, v_updatedby, v_status, v_is_trashed,
					v_published_date, v_show_in_web, v_show_in_mobile, v_show_copyright, v_order_number, v_shorttitle, v_articleid, v_assettypeid;
			
		end if;
	
	end if;
	
	
	--------------
	if (v_articleid is null or (v_articleid is not null and v_status = 1) or (v_articlepublishedstatus = 0 and v_articletrashedstatus = 0)) then
		
        v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
        
		select v_json->'data'->>'entitydata' into v_entityjson;
		
		if v_entityjson is not null then
			
			execute 'delete from '||$1||'.'||$1||'_asset_entity_map 
			         where asset_type_id = $2 and asset_id = $3'
			         using p_schema_prefix, v_assettypeid, v_articleid;
			
			for v_entity in select * from json_array_elements(v_entityjson)
			loop
				
				select  v_entity->>'entity_role_map_id', 
						v_entity->>'priority', 
				        v_entity->>'is_linkable', 
						v_entity->>'is_visible'
				into v_entityrolemapid, v_priority, v_islinkable, v_isvisible;
				
				if (v_entityrolemapid is not null and v_priority is not null) then
					
					execute 'select nextval('''||$1||'.seq_'||$1||'_asset_entity_map_id'')'
					into v_assetentitymapid
					using p_schema_prefix;
					
					v_assetentitymapguid := uuid_generate_v4();
					
					execute 'insert into '||$1||'.'||$1||'_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id,
																			is_linkable, is_visible, priority, created_date, updated_date, created_by,
																			updated_by, is_active, is_deleted, is_published, aemap_guid)
							values($2, coalesce($3, $4), $5, $6, coalesce($7, 0), $8, $9, $10, $10, $11, $12, 1, 0, 1, $13)'
					using p_schema_prefix, v_assetentitymapid, v_articleid, v_assetid, v_assettypeid, v_entityrolemapid, v_islinkable, v_isvisible,
							v_priority, v_currenttimestamp, v_createdby, v_updatedby, v_assetentitymapguid;
					
					execute 'update '||$1||'.'||$1||'_asset_list
								set primary_entity_role_map_id = case when $2 = 1 then $3 else primary_entity_role_map_id end,
									secondary_entity_role_map_id = case when $2 = 2 then $3 else secondary_entity_role_map_id end
								where  asset_id = coalesce($4, $5)
								and asset_type_id = $6'
					using p_schema_prefix, v_priority, v_entityrolemapid, v_articleid, v_assetid, v_assettypeid;
					
				end if;
				execute 'SELECT '||p_schema_prefix||'.'||p_schema_prefix||'_get_entity_language_from_entities(array['||v_entityrolemapid||'])' 
				  into  v_lang_id;
				
				  --v_lang_erm_id := v_entityrolemapid;
			     select array_position(entity_arr,v_entityrolemapid::text) - 1 into v_lang_index
                 from (select array((select json_array_elements(v_entityjson)->>'entity_role_map_id')) 
				  entity_arr) a;
				  if v_lang_id is not null then 
				
				execute ' select canonical_url
                         
                         from   '||$1||'.'||$1||'_entity_master
                         where  entity_master_id =(select entity_master_id
                         from  '||$1||'.'||$1||'_entity_role_map
                          where  entity_role_map_id = $2)'
						into strict  v_canonical_url
				  using p_schema_prefix,v_entityrolemapid;
								
				  v_json := jsonb_set(v_json, ('{data,entitydata,'||v_lang_index||',is_lang}')::text[], ('"1"')::text::jsonb, true);
				-- if v_canonical_url is not null then
				 v_json := jsonb_set(v_json, ('{data,entitydata,'||v_lang_index||',canonical_url}')::text[], ('"'||coalesce(v_canonical_url,'')||'"')::text::jsonb, true);
			     --end if;
				execute 'update '||$1||'.'||$1||'_asset_list
				            set language_id=$2,
							    language_url=$6
				            where  asset_id = coalesce($3, $4)
						    and asset_type_id = $5'
					using p_schema_prefix,v_lang_id, v_articleid, v_assetid, v_assettypeid,v_canonical_url;
					else 
				    v_json := jsonb_set(v_json, ('{data,entitydata,'||v_lang_index||',is_lang}')::text[], ('"0"')::text::jsonb, true);

				  end if ;
			end loop;
			
		end if;
		
		select v_json->'data'->>'asset_map' into v_articleassetmapjson;
		
		if v_articleassetmapjson is not null then
			
			execute 'delete from '||$1||'.'||$1||'_article_asset_map where article_id = $2'
			using p_schema_prefix, v_articleid;
			
			for v_articleassetmap in select * from json_array_elements(v_articleassetmapjson)
			loop
				
				select v_articleassetmap->>'asset_id',
				v_articleassetmap->>'asset_type_id', 
				v_articleassetmap->>'is_cover'
				into v_aam_assetid, v_aam_assettypeid, v_is_cover;
				
				if (v_aam_assetid is not null and v_aam_assettypeid is not null) then
					
					execute 'select nextval('''||$1||'.seq_'||$1||'_article_asset_map_id'')'
					into v_articleassetmapid
					using p_schema_prefix;
					
					v_articleassetmapguid := uuid_generate_v4();
					
					execute 'insert into '||$1||'.'||$1||'_article_asset_map(article_asset_map_id, article_id, asset_id,
					                                                            asset_type_id, created_date,
																				updated_date, created_by, updated_by,
																				is_active, is_deleted,
																				is_published, aamap_guid, is_cover)
							values($2, coalesce($3, $4), $5, $6, $7, $7, $8, $8, 1, 0, $9, $10, $11)'
					using p_schema_prefix, v_articleassetmapid, v_articleid, v_assetid, v_aam_assetid, v_aam_assettypeid, v_currenttimestamp,
							 v_updatedby, v_status, v_articleassetmapguid, v_is_cover;
					
					if v_is_cover = 1 then
						
						execute 'select image_path, image_file_name from '||$1||'.'||$1||'_image where image_id = $2'
						into v_image_path, v_image_file_name
						using p_schema_prefix, v_aam_assetid;
						
						execute 'update '||$1||'.'||$1||'_asset_list
									set image_path = $2, image_file_name = $3
									where asset_id = coalesce($4, $5)
									and asset_type_id = $6'
						using p_schema_prefix, v_image_path, v_image_file_name, v_articleid, v_assetid, v_assettypeid;
						
					end if;
					
				end if;
				
				
				
			end loop;
			
		end if;
		
		select v_json->'data'->>'author_data' into v_authordatajson;
		
		if v_authordatajson is not null then
			
			execute 'delete from '||$1||'.'||$1||'_author_action where asset_type_id = $2 and asset_id = $3'
			using p_schema_prefix, v_assettypeid, v_articleid;
			
			for v_authordata in select * from json_array_elements(v_authordatajson)
			loop
				
				select v_authordata->>'author_id', v_authordata->>'action_id'
				into v_author_id, v_action_id;
				
				if (v_author_id is not null and v_action_id is not null) then
					
					execute 'select nextval('''||$1||'.seq_'||$1||'_author_action_id'')'
					into v_authoractionid
					using p_schema_prefix;
					
					execute 'insert into '||$1||'.'||$1||'_author_action(author_action_id, 
					                    author_id, asset_id, asset_type_id, action_id, created_date,updated_date)
							values($2, $3, coalesce($4, $5), $6, $7, $8, $8)'
					using p_schema_prefix, v_authoractionid, v_author_id, v_articleid, v_assetid, v_assettypeid, v_action_id, v_currenttimestamp;
					
					if v_action_id = 4 then
						
						execute 'update '||$1||'.'||$1||'_asset_list
									set author_id = coalesce($2, author_id)
									where asset_id = coalesce($3, $4)
									and asset_type_id = $5'
						using p_schema_prefix, v_author_id, v_articleid, v_assetid, v_assettypeid;
						
					end if;
					
				end if;
				
			end loop;
			
		end if;
        
        if  v_status = 1 then
        	
			select labkc_v1._get_web_list_json(p_schema_prefix,1,v_articleid ) 
			into strict v_web_listing_json;
			
            execute 'update '||$1||'.'||$1||'_asset_list 
					 set web_listing_json = $2,
						web_detail_jsn = $3 
						where asset_id = coalesce($4, $5) and asset_type_id = $6'
            using p_schema_prefix, v_web_listing_json, v_json, v_articleid, v_assetid, v_assettypeid;
            
        end if;
			
	end if;
		
	
	p_result := 1;
	
	if p_result = 1 then
        p_data := v_json;
	end if;
   -- end if;

    exception 
    when others then
	    --err_code := SQLSTATE;
		 get stacked diagnostics 
		 v_error_check =pg_exception_context;
         err_msg := SQLERRM;
		  p_result := -1;
		  p_data := '{"Error_message" :"'||coalesce(err_msg||'-'||v_error_check, '')||'"}';
     --   return	;
	 --   INSERT INTO audit_table (error_number, error_message,schema_name,sp_name,log_date)
     --   VALUES (SQLSTATE, err_msg,p_schema_prefix,'_ins_upd_article',current_timestamp);

end;

$_$;


--
