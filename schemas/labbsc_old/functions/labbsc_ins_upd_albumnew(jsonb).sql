-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_ins_upd_albumnew(jsonb)
-- Type: FUNCTION

-- Name: labbsc_ins_upd_albumnew(jsonb); Type: FUNCTION; Schema: labbsc_old; Owner: -
--

CREATE FUNCTION labbsc_old.labbsc_ins_upd_albumnew(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
  
  v_json             	  jsonb;
  -- album table regarding variables --
  --v_version_number   numeric := 1 ;
  v_albumid        	    numeric;
  v_assettypeid         numeric;
  v_content_source_id   numeric;
  v_currenttimestamp    timestamp;
  v_albummeta           jsonb;
  v_albumtype       numeric;
  v_title      varchar(4000);
  v_shorttitle varchar(4000);
  v_desc       text;
  v_partnerid  numeric;
  v_coverimage numeric ;
  v_total_assets    numeric;
  v_status          numeric;
  v_is_trashed      numeric;
  v_published_date  timestamp;
  v_created_date    timestamp;
  v_updated_by     numeric;
  v_created_by      numeric;
  v_version_number    numeric := 1 ;
  v_show_copyright   numeric;
  v_slug_url         varchar(4000);
  v_content_source_link varchar(4000);
  v_titlealias varchar(4000);
  v_guid varchar(4000);
  v_assetdraftguid varchar(4000);
-- album table regarding variables --
-- sequence variables
  v_assetid  numeric ;
  v_asset_list_id  numeric;
  v_assetdraftid numeric;
  v_seodataid numeric;
-- sequence variables
-- seodata
  v_seodataguid  varchar(4000);
  v_seojson 		      jsonb;
-- seodata  
  
  
  v_sequence_prefix text := '$1'||'.seq_'||'$1';
  v_album_exists numeric;
  
  err_code numeric;
  err_msg  text;
  v_assetentitymapid    numeric;
  v_publishedstatus numeric;
  v_trashedstatus numeric;
  v_pubversionnumber    numeric;
  v_ispublished         numeric ;
  p_result1             numeric;
  v_entityjson 		  json;
  v_entity 			  json;
  
  v_entityrolemapid numeric;
  v_priority numeric;
  v_islinkable numeric;
  v_isvisible numeric;
  v_assetentitymapguid  varchar(4000);
  v_albumassetmapjson json;
  v_albumassetmap json;
  
  --image --
  v_image_id numeric; 
  v_is_cover numeric;
  v_image_order numeric;
  v_imagealbstatus numeric; 
  v_isdeleted numeric;
  v_isactive numeric;
  v_albumassetmapid numeric;
  v_image_file_name      varchar(4000);
  v_image_path           varchar(4000);
  
  v_imagealt text;
  v_imagecopyright text;
  v_imagetitle varchar(2000);
  v_imagedescription text;
  
  --author -
  
  v_authordatajson json;
  v_authordata json;
  
  v_author_id numeric;
  v_action_id numeric;
  v_authoractionid numeric;
  
  v_photo_type_id numeric;
  v_photo_type_name text ;
  
  	v_lang_id numeric ;
	v_lang_index numeric ;
    v_lang_erm_id numeric;
	v_canonical_url text;
	p_schema_prefix text;
--********************************PREFACE BLOCK*******************************
--  NAME: _ins_upd_album
--
--  Purpose:
-- 
--  Parameters:  
--
--
--  External Output:  
--                    
--
--  Written/Modified by:   Date:           Reason:
--  R. BHATKAR             17/07/2018     CREATION(Generic SP)
--********************************END PREFACE BLOCK***************************
	
	
begin
	
	/*if exists(select 1 from information_schema.routines where specific_schema = p_schema_prefix and routine_name = specific_schema||'_ins_upd_article') then
		
		execute 'select * from '||$1||'.'||$1||'_ins_upd_album($2)'
		using p_schema_prefix,p_json
		into p_result,p_data;
		
	else*/
	
	/*
    p_result code desc
	 0 :- alias alredy exists
    */
	   
	   p_schema_prefix='labbsc';
	   
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
	select p_json->'data' into p_json;
	v_json:='{"data":'||p_json::json||'}';
	
	select v_json->'data'->>'album_id',
     	   v_json->'data'->>'asset_type',
           v_json->'data'->>'content_source_id',
           v_json->'data'->>'album_meta',         
           v_json->'data'->>'album_type',
           v_json->'data'->>'title',
           v_json->'data'->>'short_title',
           v_json->'data'->>'album_desc',
           v_json->'data'->>'partner_id',
           v_json->'data'->>'total_assets',
           v_json->'data'->>'is_trashed',
           v_json->'data'->>'status',
           v_json->'data'->>'updated_by',         
           v_json->'data'->>'show_copyright',
           v_json->'data'->>'content_source_link',
           v_json->'data'->>'published_date',        
           v_json->'data'->>'slug_url',
		   v_json->'data'->'seo'
	into   v_albumid,
		   v_assettypeid,
           v_content_source_id,
           v_albummeta,
           v_albumtype,
           v_title,
           v_shorttitle,
           v_desc,
           v_partnerid,
           v_total_assets,
           v_is_trashed,
           v_status,
           v_updated_by,
           v_show_copyright,
           v_content_source_link,
           v_published_date,
           v_titlealias,
		       v_seojson
            ;
                 
				
			with coverimage(t_json)
              as(
               values ((v_json->'data'->>'images')::json)
                 )
             select (obj->'data'->>'image_id') into v_coverimage
             
	        from   coverimage ci, json_array_elements(ci.t_json#>'{}') obj
	         where  (obj->'data'->>'is_cover')::numeric = 1
			   ;
			
			  execute 'select  nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_draft_id'')'
            	     into     v_assetdraftid
                     using p_schema_prefix;
				
			 v_published_date := coalesce(v_published_date, v_currenttimestamp);
	         v_assetdraftguid := uuid_generate_v4();	
				
				
				
  
   if (v_albumid is null) then        
         --raise notice '%' ,1;
		     
               execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_album 
			        where upper(title_alias) = upper($2) and is_trashed=0'
               into v_album_exists
               using p_schema_prefix, v_titlealias;    
               
               if v_album_exists =0 then 
                     execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_album_id''), 
                                     nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_list_id''),
                                     nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_seo_data_id'')'
			                into     v_albumid, 
						             v_asset_list_id, 
								     v_seodataid
			                using p_schema_prefix;
                     
                     	v_guid := uuid_generate_v4();
			            v_seodataguid := uuid_generate_v4();
                       
                    
                    	v_json := jsonb_set(v_json, '{data,album_id}', v_albumid::text::jsonb, true);
			            v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);
                      
                      -- insert data in assset draft table --
                        execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
            													            updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
				                             	values($2, $3, $4, $5, $6, $7, $7, $8, $9, 1, 0, $10)'
			                       using p_schema_prefix, v_assetdraftid, v_albumid, v_assettypeid, v_version_number, v_json, v_currenttimestamp, v_updated_by, v_updated_by,v_assetdraftguid;
                      
                      
					
					execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_album
				           ( album_id, content_source_id, album_meta, album_type, title, title_alias, 
				             short_title, album_desc, partner_id, show_in_web, show_in_mobile, show_in_app,
				             cover_image, total_assets, published_version_number, is_trashed, created_date, 
				             updated_date, created_by, updated_by, is_active, is_deleted, is_published, 
							 album_guid,published_date,show_copyright,content_source_link,
				             order_number)
							values
							($2,$3,$4,$5,$6,$7,$8,$9,$10,1,1,1,$11,$12,$13,$14,$15,$16,$17,$18,1,0,$19,$20,$21,$22,$23,1)'
				       using  p_schema_prefix,
					          v_albumid,v_content_source_id,v_albummeta,v_albumtype,v_title,v_titlealias,
                              v_shorttitle,v_desc,v_partnerid,v_coverimage,v_total_assets,v_version_number,
                              v_is_trashed,v_currenttimestamp,v_currenttimestamp,v_updated_by,v_updated_by,v_status,
							  v_guid,v_published_date,v_show_copyright,v_content_source_link ;
                       
					execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc,
            													tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
																image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
																published_version_number, is_trashed, created_date, updated_date, created_by, updated_by,
																is_active, is_deleted, is_published, published_date, asset_guid, show_copyright,
																order_number,short_title)
					                                values($2, $3, $4, $5, $6, null, $7, null, null, null, $8, null,null, null, 1, 
													1, 1, $9, $10, $11, $12, $13, $14, 1, 0, $15, $16,
                    		                        $17, $18, 1, $19)'
			                      using p_schema_prefix, v_asset_list_id, v_albumid, v_assettypeid, v_title, v_titlealias, v_desc,v_total_assets,		          
								  v_version_number, v_is_trashed, v_currenttimestamp,v_currenttimestamp, v_updated_by,v_updated_by, v_status, 
								  v_published_date,
                                  v_guid, v_show_copyright, v_shorttitle;
					    
						execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_seo_data(seo_data_id, asset_id, asset_type_id, meta_info)
					    values($2, $3, $4, $5)'
			            using p_schema_prefix, v_seodataid, v_albumid, v_assettypeid, v_seojson;
				
				else 
				 
				   p_data := '{"data":{"message" :"Alias Already Exist"}}';
                   p_result := 0; 
                   return;
					
            end if ;
		
 else 
 
           	execute 'select is_published, is_trashed from '||p_schema_prefix||'.'||p_schema_prefix||'_album where album_id = $2'
		    into v_publishedstatus, v_trashedstatus
		    using p_schema_prefix, v_albumid;
	--- album draft mode --		
	 if v_status = 0 then 
	       
		     if v_is_trashed=0 then 
			       
				    	execute 'select coalesce(published_version_number, 1), is_published from '||$1||'.'||$1||'_album 
                                  where album_id = $2'
				        into strict v_pubversionnumber, v_ispublished
				        using p_schema_prefix, v_albumid;
			            
						execute 'select max(version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft 
						         where asset_type_id = $2 and asset_id = $3'
				        into strict v_version_number
				        using p_schema_prefix, v_assettypeid, v_albumid;
						
						if ((v_version_number = v_pubversionnumber and v_ispublished = 0) or (v_version_number > v_pubversionnumber))  then
						  
						  execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
								set asset_data = $2, updated_date = $3
								where asset_id = $4
								and asset_type_id = $5
								and ad.version_number = (select max(ad1.version_number)
															from '||$1||'.'||$1||'_asset_draft ad1
															where ad1.asset_id = ad.asset_id
															and ad1.asset_type_id = ad.asset_type_id)'
					        using p_schema_prefix, v_json, v_currenttimestamp, v_albumid, v_assettypeid;
				        else 
						
						 v_version_number := v_version_number + 1;
						 
						 execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data,
																		created_date, updated_date, created_by, updated_by, is_active, is_deleted,
																		asset_draft_guid)
							values($2, $3, $4, $5, $6, $7, $7, $8, $9, 1, 0, $10)'
					       using p_schema_prefix, v_assetdraftid, v_albumid, v_assettypeid, v_version_number, v_json, v_currenttimestamp, v_updatedby,
							v_updatedby, v_assetdraftguid;
					
						end if;
			
      
			 else 
			     
				  		    execute 'update '||$1||'.'||$1||'_album
							         set is_published = $2, is_trashed = 1, updated_date = $3
							         where album_id = $4'
				            using p_schema_prefix, v_status, v_currenttimestamp, v_albumid;
			            
							execute 'update '||$1||'.'||$1||'_asset_draft ad
							         set asset_data = $2, 
									 updated_date = $3
							         where asset_id = $4
							         and asset_type_id = $5
							         and ad.version_number = (select max(ad1.version_number)
														from '||$1||'.'||$1||'_asset_draft ad1
														where ad1.asset_id = ad.asset_id
														and ad1.asset_type_id = ad.asset_type_id)'
				           using p_schema_prefix, v_json, v_currenttimestamp, v_albumid, v_assettypeid;
			 
			               execute 'update '||$1||'.'||$1||'_asset_list
							set updated_date = $2, updated_by = $3, is_published = $4, is_trashed = $5
							where asset_id = $6
							and asset_type_id = $7'
				          using p_schema_prefix, v_currenttimestamp, v_updatedby, v_status, v_is_trashed, v_albumid, v_assettypeid;
			
			
			
			 end if ;
		
	  -- album published  ---
		else 	
			 
			 execute 'select max(version_number) from '||$1||'.'||$1||'_asset_draft 
			          where asset_type_id = $2 and asset_id = $3'
			 into strict v_version_number
			 using p_schema_prefix, v_assettypeid, v_albumid;
			
			v_version_number := v_version_number + 1;
			
            execute 'select is_published from '||$1||'.'||$1||'_album where album_id = $2'
            into v_ispublished
            using p_schema_prefix,v_albumid;
			
			if v_ispublished = 1 then
            	
				execute 'select '||$1||'.'||$1||'_ins_up_redirect($2, $3, $4, $5)'
                into p_result1
               using p_schema_prefix, v_albumid, v_titlealias, v_status, v_assettypeid;
                
			end if;
			
			  execute 'insert into '||$1||'.'||$1||'_asset_draft(asset_draft_id, 
        asset_id, asset_type_id, version_number, asset_data, created_date,
          updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
				                             	values($2, $3, $4, $5, $6, $7, $7, $8, $9, 1, 0, $10)'
           using p_schema_prefix, v_assetdraftid, v_albumid, v_assettypeid, v_version_number, v_json, v_currenttimestamp, v_updated_by, v_updated_by,v_assetdraftguid;
              
			  
			  execute 'update '||$1||'.'||$1||'_album
			           set 
					       album_meta=$2,
						   album_type=$3,
						   title=$4,
						   title_alias=$5,
						   short_title=$6,
						   album_desc=$7,
						   partner_id=$8,
						   cover_image=$9,
						   total_assets=$10,
						   published_version_number=$11,
						   updated_date=$12 ,
						   updated_by=$13 ,
			               is_published=$14,
						   published_date=$15,
					       show_copyright=$16,
						   content_source_link=$17,
						   content_source_id=$18
						   where  album_id    =$19
					   '
                   using p_schema_prefix,v_albummeta, v_albumtype,v_title,v_titlealias,v_shorttitle,v_desc,v_partnerid,v_coverimage,
				         v_total_assets,v_version_number,v_currenttimestamp,v_updated_by,v_status,v_published_date,v_show_copyright,
						v_content_source_link,v_content_source_id,v_albumid ;
						
			       execute 'update '||$1||'.'||$1||'_seo_data
						    set meta_info = $2
						    where asset_type_id = $4
						    and asset_id = $5'
			       using p_schema_prefix, v_seojson, v_currenttimestamp, v_assettypeid, v_albumid;
			
			execute 'update '||$1||'.'||$1||'_asset_list
						set   asset_title = $2, 
						      title_alias = $3, 
							  short_desc = $4,  
							  published_version_number = $5, 
							  updated_date = $6,
							  updated_by = $7, 
							  is_active = 1, 
							  is_deleted = 0,
							  is_published = $8, 
							  is_trashed = $9, 
							  published_date = $10, 
							  short_title = $11
						where asset_id = $12
						and asset_type_id = $13'
			using p_schema_prefix, v_title, v_titlealias, v_desc, v_version_number, v_currenttimestamp, v_updated_by, v_status, v_is_trashed,
					v_published_date, v_shorttitle, v_albumid, v_assettypeid;
			
			
 
      end if ;

               
 end if ;

 	
 	if (v_albumid is null or (v_albumid is not null and v_status = 1)
		or (v_publishedstatus = 0 and v_trashedstatus = 0)) then
		
         select v_json->'data'->>'entitydata' into v_entityjson;
 
         if v_entityjson is not null then
			
			execute 'delete from '||$1||'.'||$1||'_asset_entity_map where asset_type_id = $2 and asset_id = $3'
			using p_schema_prefix, v_assettypeid, v_albumid;
			 
			for v_entity in select * from json_array_elements(v_entityjson)
			loop 
			    select v_entity->>'entity_role_map_id', 
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
							values($2, $3, $4, $5, coalesce($6, 0), $7, $8, $9, $10, $11, $12, 1, 0, 1, $13)'
					using p_schema_prefix, v_assetentitymapid, v_albumid, v_assettypeid, v_entityrolemapid, v_islinkable, v_isvisible,
							v_priority, v_currenttimestamp,v_currenttimestamp, v_updated_by, v_updated_by, v_assetentitymapguid;
					
			      
				   	execute 'update '||$1||'.'||$1||'_asset_list
								set primary_entity_role_map_id = case when $2 = 1 then $3 else primary_entity_role_map_id end,
									 secondary_entity_role_map_id = case when $2 = 2 then $3 else secondary_entity_role_map_id end
								where  asset_id = $4
								and asset_type_id = $5'
					using p_schema_prefix, v_priority, v_entityrolemapid, v_albumid, v_assettypeid;
			  end if ;
			
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
				            where  asset_id = $3
						    and asset_type_id = $5'
					using p_schema_prefix,v_lang_id, v_albumid, null, v_assettypeid,v_canonical_url;
					else 
				    v_json := jsonb_set(v_json, ('{data,entitydata,'||v_lang_index||',is_lang}')::text[], ('"0"')::text::jsonb, true);

				  end if ;
			
			
			
			
			end loop;
      
		end if;
		
			
		select v_json->'data'->>'images' into v_albumassetmapjson;
 
            if v_albumassetmapjson is not null then
			  	execute 'delete from '||$1||'.'||$1||'_album_asset_map where album_id = $2'
			    using p_schema_prefix, v_albumid;
				
				  for v_albumassetmap in select * from json_array_elements(v_albumassetmapjson)
			      loop
			              	select
                                   v_albumassetmap->'data'->>'image_id',
				                   v_albumassetmap->'data'->>'is_cover',
				                   v_albumassetmap->'data'->>'order_number',
				                   v_albumassetmap->'data'->>'status',
                                   v_albumassetmap->'data'->>'is_delete',
                                   v_albumassetmap->'data'->>'is_active',
								   v_albumassetmap->'data'->>'image_alt',
				                   v_albumassetmap->'data'->>'image_copyright',
			        	           v_albumassetmap->'data'->>'title',
			        	           v_albumassetmap->'data'->>'image_desc',
								   v_albumassetmap->'data'->>'phototypeid',
								   v_albumassetmap->'data'->>'phototypename'
								
				            into   v_image_id, 
							       v_is_cover,
								   v_image_order,
								   v_imagealbstatus, 
								   v_isdeleted,
								   v_isactive,
								   v_imagealt, 
								   v_imagecopyright, 
								   v_imagetitle,
								   v_imagedescription,
								   v_photo_type_id,
								   v_photo_type_name;
								
								
			              if (v_image_id is not null ) then
						
						   execute 'select nextval('''||$1||'.seq_'||$1||'_album_asset_map_id'')'
					       into v_albumassetmapid
					       using p_schema_prefix;
					
					      
			              execute 'insert into  '||$1||'.'||$1||'_album_asset_map
                    	   ( album_asset_map_id, album_id, asset_order, asset_id, asset_type_id, created_date, 
                     	     updated_date, created_by, updated_by, is_active, is_deleted, is_published,is_cover,phototypeid,phototypename)
                     	values ($2,$3,$4,$5,3,$6,$6,$7,$7,coalesce($8,0),coalesce($9,0),1,$10,coalesce($11,0),$12)'
											
						using p_schema_prefix,v_albumassetmapid,v_albumid,v_image_order,v_image_id,v_currenttimestamp,
						      v_updated_by,v_isactive,v_isdeleted,v_is_cover,v_photo_type_id,v_photo_type_name;
								
						end if;
					  if v_is_cover = 1 then
					   
					    execute 'select image_path,image_file_name
						         from '||$1||'.'||$1||'_image
						         where image_id = $2'
						 into v_image_path ,v_image_file_name
						 using p_schema_prefix,v_image_id
						;
						
						execute 'update '||$1||'.'||$1||'_asset_list
						set   image_path =$2 ,
						      image_file_name =$3 
						where asset_id = $4
						and    asset_type_id=$5'
						using p_schema_prefix,v_image_path,v_image_file_name,v_albumid,v_assettypeid;
						
						else 
						
                           execute 'update '||$1||'.'||$1||'_image
                             set  image_caption = $2,
                                  copyright_text = $3,
                                  title_alias = $4,
                                  image_desc = $5
                            where image_id = $6'
							using p_schema_prefix,v_imagealt,v_imagecopyright,v_imagetitle,v_imagetitle,v_image_id;
                        
						
						
						end if;
			       end loop;
			end if ;
			
			select v_json->'data'->>'author_data'
			into   v_authordatajson;
      		if v_authordatajson is not null then
			
                 execute   'delete
					        from   '||$1||'.'||$1||'_author_action
					        where  asset_type_id = $2
					        and    asset_id      = $3'
					using p_schema_prefix,v_assettypeid,v_albumid ;
					
					for v_authordata in select * from json_array_elements(v_authordatajson)
					loop
				          	
               			select v_authordata->>'author_id',
               	  		v_authordata->>'action_id'
						into   v_author_id,
               	  		       v_action_id;
			
               			if (v_author_id is not null and v_action_id is not null) then
						    
								execute 'select nextval('''||$1||'.seq_'||$1||'_author_action_id'')'
					                 into v_authoractionid
					                using p_schema_prefix;
							
	               		
     		               	
               	     		execute 'insert into '||$1||'.'||$1||'_author_action(
							                 author_action_id,author_id,asset_id,asset_type_id,action_id, created_date,updated_date)
							               values($2,$3,$4,$5,$6,$7,$7)'
							 using  p_schema_prefix,v_authoractionid,v_author_id,v_albumid,v_assettypeid,v_action_id,
							        v_currenttimestamp;
		                    	
                          if v_action_id = 4 then 
                           execute' update '||$1||'.'||$1||'_asset_list
                            set    author_id  =$2 
                            where  asset_id   = $3
                       
                            and    asset_type_id=$4'
							using p_schema_prefix,v_author_id,v_albumid,v_assettypeid;
                          end if;
							
						end if;
		
					end loop;
	
				end if;
 

     end if ;
	 
 

v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_version_number||'"')::text::jsonb, true);

 p_result := 1;
	
	if p_result = 1 then
        p_data := v_json;
		
		
		
	end if;
	/*
   exception 
    when others then
	    --err_code := SQLSTATE;
          err_msg := SQLERRM;
		  p_result := -1;
		  p_data := '{"data":{"message" :"'||coalesce(err_msg, '')||'" ,"result":"'||coalesce(p_result, 0)||'"}}';
    */
	-- return	;
	--  INSERT INTO audit_table (error_number, error_message,schema_name,sp_name,log_date)
    --  VALUES (SQLSTATE, err_msg,p_schema_prefix,'_ins_upd_album',current_timestamp);
	
    
	
end;

$_$;


--
