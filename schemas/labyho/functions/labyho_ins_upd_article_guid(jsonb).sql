-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_ins_upd_article_guid(jsonb)
-- Type: FUNCTION

-- Name: labyho_ins_upd_article_guid(jsonb); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_ins_upd_article_guid(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_schema_prefix jsonb;
	v_array numeric[];
	v_web_listing_json jsonb;
	v_json             	  jsonb := p_json;
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
	v_title        	  varchar(4000);
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
	v_currenttimestamp    timestamp := current_timestamp at time zone 'utc';
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
	p_result1 numeric;
	v_content_provider_name varchar(1024);
	v_ipl_ermid numeric := 95421;
	v_ipl_entity_insert numeric := 0;
	v_new_entity_jsonb jsonb;
	v_titlealias1 text;
	v_modified_date timestamp;
	v_created_date timestamp;
	v_expiry_date timestamp;
	v_asset_cnt numeric;
	v_source_object_id text;
	v_counter numeric:=0;
	v_entity_role_id numeric;
	v_entity_group_type text;
	v_entity_name text;
	v_cnt numeric;
	v_entity_cnt numeric;
	v_upd_entity_jsonb jsonb;
	v_json1 jsonb;
	v_update_slug numeric;
	
begin
	
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
			v_json->'data'->>'guid',
			v_json->'data'->>'modified_date',
			v_json->'data'->>'created_date',
			v_json->'data'->>'expiry_date'
	into v_articleid,
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
			v_articleguid,
			v_modified_date,
			v_created_date,
			v_expiry_date;
	
	if v_titlealias = '' or v_titlealias is null then
		
		v_titlealias1 := regexp_replace(lower(v_titlealias), '[^a-z0-9\\-_]+', '-', 'g');
		
		if not exists(select 1 from labyho.labyho_asset_list
					  where title_alias = v_titlealias1) then
			v_titlealias := v_titlealias1;
		else
			v_titlealias := v_titlealias1||'-'||to_char(current_date,'ddmmyyyy');
		end if;
		
	end if;
	
	if exists(select 1 from labyho.labyho_article
			  where lower(trim(title)) = lower(trim(v_title))
			  and content_source_id = v_contentsourceid) then
		
		select article_guid
		into v_articleguid
		from labyho.labyho_article
		where lower(trim(title)) = lower(trim(v_title))
		and content_source_id = v_contentsourceid;
		
		v_update_slug := 0;
		
	end if;
	
	if ((v_createdby <> 231 and v_contentsourceid <> 242) or (v_createdby <> 231 and v_contentsourceid = 242)) then
		
		select labyho.labyho_ins_up_redirect(v_articleid,v_titlealias,v_status,v_assettypeid)
		into p_result1;
		
		v_published_date := coalesce(v_published_date,v_currenttimestamp);
		v_modified_date := coalesce(v_modified_date,v_currenttimestamp);
		v_created_date := coalesce(v_created_date,v_currenttimestamp);
-- 		v_expiry_date := coalesce(v_expiry_date,null);
		
		v_assetdraftid := nextval('labyho.seq_labyho_asset_draft_id');
		
		v_assetdraftguid := uuid_generate_v4();
		
		select content_provider_name
		into v_content_provider_name
		from labyho.labyho_content_provider
		where content_provider_id = v_contentsourceid
		and is_active = 1;
		
		select count(1)
		into v_cnt
		from labyho.labyho_article
		where article_guid = v_articleguid;
		
		if not exists (select 1 from labyho.labyho_article
					   where article_guid = v_articleguid) then
			
			v_assetid := nextval('labyho.seq_labyho_article_id');
			v_seodataid := nextval('labyho.seq_labyho_seo_data_id');
			v_asset_list_id := nextval('labyho.seq_labyho_asset_list_id');
			v_articleid = v_assetid;
			v_seodataguid := uuid_generate_v4();
			
			v_json := jsonb_set(v_json, '{data,article_id}', v_assetid::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_articleguid||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,content_provider_name}', ('"'||v_content_provider_name||'"')::text::jsonb, true);
			
			insert into labyho.labyho_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
												  updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values(v_assetdraftid, v_assetid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby,
                      v_updatedby, 1, 0, v_assetdraftguid);
			
			insert into labyho.labyho_article(article_id, content_source_id, asset_meta, title, title_alias, browser_title, highlights, content_source,
                                           place, country, show_in_app, disclaimer_text, checked_out_by, full_text, intro_text,
                                           published_version_number, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                           is_published, is_trashed, article_guid, published_date, show_in_web, show_in_mobile, show_copyright,
                                           content_source_link, order_number, slug_url,expiry_date)
			values(v_assetid, v_contentsourceid, v_assetmetajson, v_title, v_titlealias, v_browsertitle, v_highlights, null, v_place, v_country, 0,
                      null, null, v_fulltext, v_introtext, v_versionnumber, v_created_date, v_modified_date, v_createdby, v_updatedby, 1, 0,
                      v_status, v_is_trashed, v_articleguid, v_published_date, v_show_in_web, v_show_in_mobile, v_show_copyright, v_content_source_link,
                      v_order_number, v_slugurl,v_expiry_date);
			
			insert into labyho.labyho_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags,
                                              primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path,
                                              duration, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date,
                                              updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid,
                                              show_copyright, order_number)
			values(v_asset_list_id, v_assetid, v_assettypeid, v_title, v_titlealias, null, v_introtext, null, null, null, null, v_image_file_name,
                      v_image_path, null, v_show_in_web, v_show_in_mobile, 0, v_versionnumber, v_is_trashed, v_created_date, v_modified_date,
                      v_updatedby, v_updatedby, 1, 0, v_status, v_published_date, v_articleguid, v_show_copyright, v_order_number);
			
            	insert into labyho.labyho_seo_data(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, updated_date,
                                            created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
			   values(v_seodataid, v_assetid, v_assettypeid, v_seojson, v_versionnumber, v_currenttimestamp, v_currenttimestamp, v_createdby,
                      v_updatedby, 1, 0, v_status, v_seodataguid);
			
		else
          	
               select article_id into v_articleid
               from labyho.labyho_article
               where article_guid = v_articleguid;
               
               select max(version_number) into strict v_versionnumber
               from labyho.labyho_asset_draft
               where asset_type_id = v_assettypeid
               and asset_id = v_articleid;
               
               v_versionnumber := v_versionnumber + 1;
               
               v_json := jsonb_set(v_json, '{data,article_id}', ('"'||v_articleid||'"')::text::jsonb, true);
               
               insert into labyho.labyho_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                               created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values(v_assetdraftid, v_articleid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby,
                      v_updatedby, 1, 0, v_assetdraftguid);
				
			update labyho.labyho_article
               set  content_source_id = v_contentsourceid,
               		asset_meta = v_assetmetajson,
                    title = v_title,
                    title_alias = case v_update_slug when 0 then title_alias else v_titlealias end,
                    browser_title = v_browsertitle,
                    highlights = v_highlights,
                    content_source = null,
                    place = v_place,
                    country = v_country,
                    show_in_app = 0,
                    disclaimer_text = null,
                    checked_out_by = null,
                    full_text = v_fulltext,
                    intro_text = v_introtext,
                    published_version_number = v_versionnumber,
                    updated_date = v_modified_date,
                    created_by = v_createdby,
                    updated_by = v_updatedby,
                    is_active = 1,
                    is_deleted = 0,
                    is_published = v_status,
                    is_trashed = v_is_trashed,
                    published_date = v_published_date,
                    show_in_web = v_show_in_web,
                    show_in_mobile = v_show_in_mobile,
                    show_copyright = v_show_copyright,
                    content_source_link = v_content_source_link,
                    order_number = v_order_number,
                    slug_url = v_slugurl,
					created_date=v_created_date,
					expiry_date=v_expiry_date
			where article_id = v_articleid;
               
               update labyho.labyho_seo_data
               set meta_info = v_seojson,
               	updated_date = v_currenttimestamp
			where asset_type_id = v_assettypeid
               and asset_id = v_articleid;
               
               update labyho.labyho_asset_list
               set  asset_title = v_title,
               	    title_alias = case v_update_slug when 0 then title_alias else v_titlealias end,
                    short_desc = v_introtext,
                    show_in_app = 0,
                    published_version_number = v_versionnumber,
                    updated_date = v_modified_date,
                    updated_by = v_updatedby,
                    is_active = 1,
                    is_deleted = 0,
                    is_published = v_status,
                    is_trashed = v_is_trashed,
                    published_date = v_published_date,
                    show_in_web = v_show_in_web,
                    show_in_mobile = v_show_in_mobile,
                    show_copyright = v_show_copyright,
                    order_number = v_order_number,
					created_date =v_created_date
			where asset_id = v_articleid
               and asset_type_id = v_assettypeid;
               
		end if;
		
          if (v_articleid is null or (v_articleid is not null and v_status = 1)) then
          	
			--if v_cnt =0 then 
               select v_json->'data'->>'entitydata' into v_entityjson;
              
			   
               if v_entityjson is not null then
                    
                    if exists(select 1 from labyho.labyho_asset_entity_map
                              where asset_type_id = v_assettypeid
                              and asset_id = v_articleid
                              and entity_role_map_id = v_ipl_ermid) then
					if not exists(select 1 from (select json_array_elements(v_entityjson) as a) as b
                                       where (a->>'entity_role_map_id')::numeric = v_ipl_ermid) then
						v_ipl_entity_insert := 1;
					end if;
                    end if;
                    
					
					
				
                  v_counter := 0;   
				for v_entity in select * from json_array_elements(v_entityjson)
                    loop
                    	
                         select v_entity->>'entity_role_map_id', 
						 		v_entity->>'priority', 
								v_entity->>'is_linkable',
						 		v_entity->>'is_visible',
						 		v_entity->>'source_object_id',
						  		v_entity->>'entity_group_type'
						into v_entityrolemapid, v_priority, v_islinkable, v_isvisible,
							 v_source_object_id,v_entity_group_type;
                    --raise notice '% v_entityrolemapid',v_entityrolemapid;
					--v_entityrolemapid=coalesce(v_entityrolemapid,0) ;
					--raise notice '% v_entityrolemapid',v_source_object_id;
					--select 1/0;
					if (v_entityrolemapid is null and  v_source_object_id is not null   ) then 
				  	
					-- select 1/0;
					-- raise notice '% v_entityrolemapid',v_source_object_id;
					--select 1/0;
					--v_entity_group_type:= case when v_entity_group_type='Player' then 'Players'
					  --                    else v_entity_group_type end ;
						
					if 	v_entity_group_type='Series' then 
					
					select entity_role_map_id , b.entity_name 
					into  v_entityrolemapid ,v_entity_name
				   	from labyho.labyho_entity_role_map a 
					join labyho.labyho_entity_master b 
					on a.entity_master_id=b.entity_master_id
				    where entity_role_id in (4,8)
					and source_object_id::text=v_source_object_id::text;
				  
					
				  else
				    
					
					select b.entity_role_id into v_entity_role_id 
					from labyho.labyho_entity_type a
					join labyho.labyho_entity_role b on a.entity_type_id=b.entity_type_id
					where lower(entity_type_name) = lower(v_entity_group_type) limit 1;
					
					select entity_role_map_id , b.entity_name 
					into  v_entityrolemapid ,v_entity_name
				   	from labyho.labyho_entity_role_map a 
					join labyho.labyho_entity_master b 
					on a.entity_master_id=b.entity_master_id
				    where entity_role_id =v_entity_role_id
					and source_object_id::text=v_source_object_id::text;
					
					end if;
						
				   
					
				   	
				  
				  if v_entityrolemapid is not null then 
				   v_json= jsonb_set(v_json,('{data,entitydata,'||v_counter::text||',entity_role_map_id}')::text[],
                                  ('"'||v_entityrolemapid||'"')::text::jsonb,true);
				   v_json= jsonb_set(v_json,('{data,entitydata,'||v_counter::text||',name}')::text[],
                                  ('"'||v_entity_name||'"')::text::jsonb,true);			  
				  end if;
				  v_counter:=v_counter+1;
				  --raise notice '% v_entityrolemapid % % %' ,v_entityrolemapid,v_entity, v_counter,v_json;
				   
				   end if;
					
					if (v_entityrolemapid is not null and v_priority is not null) then
                         	
							begin
							
							
							 select 1 into strict v_entity_cnt
							 from labyho.labyho_asset_entity_map
                    			 where asset_type_id = v_assettypeid
                  				 and asset_id = v_articleid
								 and entity_role_map_id=v_entityrolemapid ;
								 
								 
							 --raise notice 'v_source_object_id: % v_entityrolemapid: %',v_source_object_id ,v_entityrolemapid;

						    exception when no_data_found then  
							 
                              v_assetentitymapid := nextval('labyho.seq_labyho_asset_entity_map_id');
                              v_assetentitymapguid := uuid_generate_v4();
						
						
						-- raise notice 'source_object_id: % entityrolemapid: % ',v_source_object_id ,v_entityrolemapid;
                              insert into labyho.labyho_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable,
                                                                   is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                                                                   is_deleted, is_published, aemap_guid)
								values(v_assetentitymapid, coalesce(v_articleid, v_assetid), v_assettypeid, v_entityrolemapid, coalesce(v_islinkable,0),
                                     v_isvisible, v_priority, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby, 1, 0, 1,
                                     v_assetentitymapguid);
						
								update labyho.labyho_asset_list
                              	set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
                              	secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
								where asset_id = coalesce(v_articleid, v_assetid)
                              	and asset_type_id = v_assettypeid;
                              
						end ;	  
					end if;
                         
				end loop;
                    
                    if v_ipl_entity_insert = 1 then
                    	
                         v_assetentitymapid := nextval('labyho.seq_labyho_asset_entity_map_id');
                         v_assetentitymapguid := uuid_generate_v4();
                    	
                         insert into labyho.labyho_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
                                                              priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                                              is_published, aemap_guid)
					values(v_assetentitymapid, coalesce(v_articleid, v_assetid), v_assettypeid, v_ipl_ermid, 0, 1, 0, v_currenttimestamp,
                                v_currenttimestamp, v_createdby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
					
                         select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
                    	from (select aem.priority, aem.is_visible, em.entity_name as name, 
							  em.entity_display_name as ent_disp_name, aem.is_linkable,
                               		aem.entity_role_map_id
                               from labyho.labyho_asset_entity_map aem
                               join labyho.labyho_entity_role_map erm
                               on erm.entity_role_map_id = aem.entity_role_map_id
                               join labyho.labyho_entity_master em
                               on em.entity_master_id = erm.entity_master_id
                               where asset_id = v_articleid
                               and asset_type_id = v_assettypeid
                              ) as row
					into v_new_entity_jsonb;
					
					
					     
					
                         v_json := jsonb_set(v_json, '{data,entitydata}', v_new_entity_jsonb, false);
                         
						 
                    end if;
					
		--	end if;
					
                    
				with tab as (select asset_id, asset_type_id, aem.entity_role_map_id
                                 from labyho.labyho_asset_entity_map aem
                                 join labyho.labyho_entity_role_map erm
                                 on erm.entity_role_map_id = aem.entity_role_map_id
                                 join labyho.labyho_entity_category ec
                                 on ec.entity_role_id = erm.entity_role_id
                                 where ec.category_name = 'Language'
                                 and aem.asset_id = coalesce(v_articleid, v_assetid)
                                 and aem.asset_type_id = v_assettypeid)
				update labyho.labyho_asset_list al
                    set language_id = t.entity_role_map_id
                    from tab t
                    where al.asset_id = t.asset_id
                    and al.asset_type_id = t.asset_type_id;
                    
			end if;
			
			
			              
			   
			select v_json->'data'->>'asset_map' into v_articleassetmapjson;
               
               if v_articleassetmapjson is not null then
               	
                    delete from labyho.labyho_article_asset_map
                    where article_id = v_articleid;
                    
				for v_articleassetmap in select * from json_array_elements(v_articleassetmapjson)
                    loop
                    	
                         select v_articleassetmap->>'asset_id', v_articleassetmap->>'asset_type_id', v_articleassetmap->>'is_cover'
                         into v_aam_assetid, v_aam_assettypeid, v_is_cover;
                         
                         if (v_aam_assetid is not null and v_aam_assettypeid is not null) then
                         	
                              v_articleassetmapid := nextval('labyho.seq_labyho_article_asset_map_id');
						v_articleassetmapguid := uuid_generate_v4();
						
                              insert into labyho.labyho_article_asset_map(article_asset_map_id, article_id, asset_id, asset_type_id, created_date,
                                                                    updated_date, created_by, updated_by, is_active, is_deleted, is_published,
                                                                    aamap_guid, is_cover)
						values(v_articleassetmapid, coalesce(v_articleid, v_assetid), v_aam_assetid, v_aam_assettypeid, v_currenttimestamp,
                                     v_currenttimestamp, v_createdby, v_updatedby, 1, 0, v_status, v_articleassetmapguid, v_is_cover);
						
                              if v_is_cover = 1 then
                              	
                                   select image_path, image_file_name into v_image_path ,v_image_file_name
                                   from labyho.labyho_image
                                   where image_id = v_aam_assetid;
                                   
                                   update labyho.labyho_asset_list
                                   set image_path = v_image_path,
                                   	image_file_name = v_image_file_name
							       where asset_id = coalesce(v_articleid, v_assetid)
                                   and asset_type_id = v_assettypeid;
                                   
						end if;
                              
					end if;
                         
				end loop;
                    
			end if;
               
			select v_json->'data'->>'author_data' into v_authordatajson;
               
			if v_authordatajson is not null then
               	
                    delete from labyho.labyho_author_action
                    where asset_type_id = v_assettypeid
                    and asset_id = v_articleid;
                    
				for v_authordata in select * from json_array_elements(v_authordatajson)
                    loop
                    	
                         select v_authordata->>'author_id', v_authordata->>'action_id' into v_author_id, v_action_id;
                         
				   	if (v_author_id is not null and v_action_id is not null) then
                         	
						v_authoractionid := nextval('labyho.seq_labyho_author_action_id');
                              
						insert into labyho.labyho_author_action(author_action_id, author_id, asset_id, asset_type_id, action_id, created_date,
                                                                updated_date)
						values(v_authoractionid, v_author_id, coalesce(v_articleid, v_assetid), v_assettypeid, v_action_id, v_currenttimestamp,
                                     v_currenttimestamp);
						
             				if v_action_id = 4 then
                              	
                                   update labyho.labyho_asset_list
                                   set author_id = coalesce(v_author_id, author_id)
                                   where asset_id = coalesce(v_articleid, v_assetid)
                                   and asset_type_id = v_assettypeid;
                                   
						end if;
                              
					end if;
                         
				end loop;
                    
			end if;
               
		end if;
          
          v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
        	
			if v_cnt =0 then 
		 	select v_json->'data'->>'entitydata' into v_entityjson;
			
			--raise notice '%',v_entityjson;
			-- select 1/0;
		
-- 				select jsonb_agg(value) into v_entityjson
-- 				from (
-- 				SELECT  value
--              		  from jsonb_array_elements(v_entityjson::jsonb) obj(value)
--              		  where obj.value->>'entity_role_map_id' is not null
-- 				)tab;
				
			select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
                    	from (select aem.priority, 
							          aem.is_visible, 
							  		  em.entity_name as name, 
							          em.entity_display_name as ent_disp_name, 
							          aem.is_linkable,
                               		  aem.entity_role_map_id,
							          em.canonical_url as canonical,
									  et.entity_type_name as entity_group_type,
							  et.entity_type_id, et.entity_type_name, coalesce(erm.source_object_id,'') source_object_id
                               from labyho.labyho_asset_entity_map aem
                               join labyho.labyho_entity_role_map erm
                               on erm.entity_role_map_id = aem.entity_role_map_id
                               join labyho.labyho_entity_master em
                               on em.entity_master_id = erm.entity_master_id
							   join labyho.labyho_entity_role er 
							   on er.entity_role_id =erm.entity_role_id
							   join labyho.labyho_entity_type et
							   on et.entity_type_id=er.entity_type_id
							   where aem.asset_id = coalesce(v_articleid, v_assetid)
                               and aem.asset_type_id = v_assettypeid
                              ) as row
		    into v_entityjson;
			
			
          v_json := jsonb_set(v_json, '{data,entitydata}', v_entityjson::jsonb, true);
		  
		  else 
		  
		  select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
                    	from (select aem.priority, 
							          aem.is_visible, 
							  		  em.entity_name as name, 
							          em.entity_display_name as ent_disp_name, 
							          aem.is_linkable,
                               		  aem.entity_role_map_id,
							          em.canonical_url as canonical,
									  et.entity_type_name as entity_group_type,
							  et.entity_type_id, et.entity_type_name, coalesce(erm.source_object_id,'') source_object_id
                               from labyho.labyho_asset_entity_map aem
                               join labyho.labyho_entity_role_map erm
                               on erm.entity_role_map_id = aem.entity_role_map_id
                               join labyho.labyho_entity_master em
                               on em.entity_master_id = erm.entity_master_id
							   join labyho.labyho_entity_role er 
							   on er.entity_role_id =erm.entity_role_id
							   join labyho.labyho_entity_type et
							   on et.entity_type_id=er.entity_type_id
							   where aem.asset_id = coalesce(v_articleid, v_assetid)
                               and aem.asset_type_id = v_assettypeid
                              ) as row
		    into v_upd_entity_jsonb;
					
            v_json1 := jsonb_set(v_json, '{data,entitydata}', coalesce(v_upd_entity_jsonb,'[]'), false);
             
			 if v_json1 is null then 
			 
			 select v_json->'data'->>'entitydata' into v_entityjson;
			
			--raise notice '%',v_entityjson;
			-- select 1/0;
		
				select jsonb_agg(value) into v_entityjson
				from (
				SELECT  value
             		  from jsonb_array_elements(v_entityjson::jsonb) obj(value)
             		  where obj.value->>'entity_role_map_id' is not null
				)tab;
				
			
             v_json := jsonb_set(v_json, '{data,entitydata}', v_entityjson::jsonb, true);
			 v_json1:=v_json;
			 else 
			 v_json:=v_json1;
			 end if  ;
		  end if;
		  
          update labyho.labyho_asset_draft
          set asset_data = v_json
          where asset_id = coalesce(v_articleid, v_assetid)
          and asset_type_id = v_assettypeid
          and version_number = v_versionnumber;
          
          p_result := 1;
          
	else
     	
          p_result := 0;
          
	end if;
	
	
     if p_result = 1 then
     	
          p_data := v_json;
          
      if v_status = 1
     then
	 
	 select count(1) into v_asset_cnt from labyho.labyho_article
     where is_published=1 
	 and is_deleted=0 
	 and is_active=1;
	 
     update labyho.labyho_asset_list
     set tvs = setweight(to_tsvector(coalesce(asset_title,'')), 'A')    ||
               setweight(to_tsvector(coalesce(short_desc,'')), 'B')
     where asset_id = coalesce(v_articleid, v_assetid)
	 and asset_type_id=v_assettypeid; 
    
	--v_schema_prefix:='labyho';

    execute 'select array(select entity_role_map_id 
					 from labyho.labyho_asset_entity_map
					 where asset_id = coalesce($1, $2) 
					 and asset_type_id = $3
					)	a '
					into v_array
					using v_articleid, v_assetid,v_assettypeid;
					
			execute 'select labyho._get_web_list_json(''labyho'',$2,$3)' 
			into v_web_listing_json
			 using v_schema_prefix , v_assettypeid , coalesce(v_articleid, v_assetid) ;
			
            execute 'update labyho.labyho_asset_list 
					 set web_listing_json = $1,
						 web_detail_jsn = $2 ,
						 tagged_entity=$6
					 where asset_id = coalesce($3, $4) and asset_type_id = $5'
           using  v_web_listing_json, v_json, v_articleid, v_assetid, v_assettypeid,v_array;
            

     end if;        
          
          
	end if;
     
/*exception
	
	when others then
		p_result := -1;*/
     
end;

 

$_$;


--
