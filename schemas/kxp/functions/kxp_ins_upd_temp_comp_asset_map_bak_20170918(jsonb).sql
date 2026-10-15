-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_ins_upd_temp_comp_asset_map_bak_20170918(jsonb)
-- Type: FUNCTION

-- Name: kxp_ins_upd_temp_comp_asset_map_bak_20170918(jsonb); Type: FUNCTION; Schema: kxp; Owner: -
--

CREATE FUNCTION kxp.kxp_ins_upd_temp_comp_asset_map_bak_20170918(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
   

declare
	
	v_json jsonb;
	v_currenttimestamp timestamp;
	v_template_component_map_id numeric;
	v_status numeric;
	v_trashed numeric;
	v_published_date timestamp;
	v_asset_draft_id numeric;
	v_asset_draft_guid varchar(256);
	v_asset_guid1 varchar(256);
	v_asset_type_id numeric :=8 ;
	v_versionnumber numeric :=1;
	v_updated_by numeric;
	v_template_asset_component_map_id numeric;
	v_asset_map_json json;
	v_assetdata json;
	v_asset_order numeric;
	v_asset_type numeric;
	v_asset_id numeric;
	v_asset_meta json;
	v_pubversionnumber numeric;
	v_version_number numeric;
	v_ext_asset_id numeric;
	v_entityjson json;
	v_entity json; 
	v_assetentitymapid numeric;
	v_assetentitymapguid varchar(256);
	v_entityrolemapid numeric;
	v_priority numeric;
	v_islinkable numeric;
	v_isvisible  numeric;
	v_counter numeric:=0;
    v_set_data text[];
    v_ent_json jsonb;
	v_asset_map_json_data jsonb;
  
   V_max_version_number numeric;
  
begin
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
	
	v_json:=p_json;
	
	select v_json->'data'->>'template_component_map_id',
		   v_json->'data'->>'status',
		   v_json->'data'->>'is_trashed',
		   v_json->'data'->>'updated_by',
		   v_json->'data'->>'published_date'
	into   v_template_component_map_id,
		   v_status,
		   v_trashed,
		   v_updated_by,
		   v_published_date;
	   
	v_published_date   := coalesce(v_published_date,v_currenttimestamp);
	v_asset_draft_id   := nextval('kxp.seq_kxp_asset_draft_id');
	v_asset_draft_guid := uuid_generate_v4();
	
	if not exists (select template_component_map_id
				   from   kxp.kxp_template_component_asset_map
				   where  template_component_map_id = v_template_component_map_id) then
		
		           insert into kxp.kxp_asset_draft(asset_draft_id, 
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
		                                      values(v_asset_draft_id, 
											  v_template_component_map_id, 
											  v_asset_type_id, 
											  v_versionnumber, 
											  v_json, 
											  v_currenttimestamp, 
											  v_currenttimestamp, 
											  v_updated_by, 
											  v_updated_by, 
											  1, 
											  0,
			                                  v_asset_draft_guid);
		
									select v_json->'data'->>'asset_map'
									into   v_asset_map_json; 
		
					if v_asset_map_json is not null then
										v_counter := 0;
										for v_assetdata in select * from json_array_elements(v_asset_map_json)
										loop
				
				
				
										v_template_asset_component_map_id := nextval('kxp.seq_kxp_template_component_asset_map_id');
										v_asset_guid1                     := uuid_generate_v4();
				
											select v_assetdata->>'asset_order',
												   v_assetdata->>'asset_type',
												   v_assetdata->>'asset_id',
												   v_assetdata->'asset_meta'
											into  v_asset_order,
												   v_asset_type,
												   v_asset_id,
												   v_asset_meta;
				                       
				                    if v_asset_type = 12 then
					
					                    v_ext_asset_id := nextval('kxp.seq_kxp_template_externalasset_id');
					
					                           insert into kxp.kxp_template_component_asset_map(
											                         template_component_asset_map_id, 
                                                                     template_component_map_id, 
                                                                     asset_order,
                                                                     asset_id,
                                                                     asset_type_id, 
                                                                     asset_meta,
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
                                                                     asset_guid)
																values(v_template_asset_component_map_id,
																	   v_template_component_map_id, 
																	   v_asset_order, 
																	   v_ext_asset_id,
																	   v_asset_type, 
																	   v_asset_meta, 
																	   1,
																	   1, 
																	   1, 
																	   v_versionnumber,
																	   v_trashed,
																				   v_currenttimestamp, 
																	   v_currenttimestamp, 
																	   v_updated_by, 
																	   v_updated_by,
																	   1, 
																	   0,
																	   v_status, 
																	   v_published_date, 
																	   v_asset_guid1);
					
                    
												v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',asset_id',',')  ;
												v_counter:=v_counter+1;
																			raise notice '%' ,v_set_data;
					
					                            v_json := jsonb_set(to_jsonb(v_json), v_set_data, v_ext_asset_id::text::jsonb, false);
                    
                                                raise notice '%' ,'vj1'||COALESCE(v_json::varchar,'')||'';
                
												select v_assetdata->>'entitydata'
											    into   v_entityjson;
					raise notice '%' ,v_entityjson;
					              if v_entityjson is not null  then
						
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
												
												v_assetentitymapid   := nextval('kxp.seq_kxp_asset_entity_map_id');
												v_assetentitymapguid := uuid_generate_v4();
												
												insert into kxp.kxp_asset_entity_map(asset_entity_map_id,
																					 asset_id, asset_type_id, 
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
																			   v_ext_asset_id, 
																			   v_asset_type,
																			   v_entityrolemapid, 
																			   coalesce(v_islinkable,0), 
																			   v_isvisible, v_priority,
																			   v_currenttimestamp, 
																			   v_currenttimestamp, 
																			   v_updated_by, 
																			   v_updated_by, 
																			   1, 
																			   0, 
																			   1, 
																			   v_assetentitymapguid
																			   );
														
											end if;
											
										end loop;
										
									end if;
		              
                      else
					
					     insert into kxp.kxp_template_component_asset_map(template_component_asset_map_id, 
						 template_component_map_id, asset_order, asset_id, asset_type_id, asset_meta,
																	 show_in_web, 
																	 show_in_mobile, 
																	 show_in_app, 
																	 published_version_number, 
																	 is_trashed, created_date,
																	 updated_date, created_by,
																	 updated_by, is_active,
																	 is_deleted, 
																	 is_published, 
																	 published_date, 
																	 asset_guid)
					   values(v_template_asset_component_map_id, v_template_component_map_id, 
					   v_asset_order, v_asset_id, v_asset_type, v_asset_meta, 1, 1, 1, 
					   v_versionnumber, v_trashed,
						   v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 
						   1, 0, v_status, v_published_date, v_asset_guid1);
				
--                -- entiydata for asset_type_id <> 12---
                select ad.asset_data->'data'->'entitydata' into  v_ent_json
                from kxp.kxp_asset_draft ad
                where ad.asset_type_id=v_asset_type
                and ad.asset_id=v_asset_id
                and ad.version_number=(select max(version_number) 
                                      from  kxp.kxp_asset_draft ad1 
                                      where ad1.asset_type_id=ad.asset_type_id 
               and ad1.asset_id=ad.asset_id);
               v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',entitydata',',')  ;
               --v_counter:=v_counter+1;
               if (v_ent_json is not null) then
                v_json := jsonb_set(v_json, v_set_data, v_ent_json::jsonb, false);
               end if;
--                
--                
                
                
                
--                
                select row_to_json(a) into v_asset_map_json_data
                                  from((select 
                                            asset_title as title,
                                            image_path,
                                            image_file_name as image_name,
                                            ' ' as video_url,
                                            ' ' image_id,
                                            ' 'content_type,
                                            ' ' video_embed
                                            from  kxp.kxp_asset_list
                                            where asset_id=v_asset_id
                                            and asset_type_id=v_asset_type
                                            ))A;

              v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',asset_meta',',')  ;
                 --v_counter:=v_counter+1;
                 if (v_asset_map_json_data is not null) then
              v_json := jsonb_set(v_json, v_set_data, v_asset_map_json_data::jsonb, false);
             end if;
               v_counter:=v_counter+1;       
            
                -- entiydata for asset_type_id <> 12--
				end if;

			end loop;
	---------------asset update--------
         -- v_versionnumber := v_versionnumber + 1;
         
				select max(version_number)
				into   strict V_max_version_number
				from   kxp.kxp_asset_draft
				where  asset_type_id = v_asset_type_id
				and    asset_id      = v_template_component_map_id;
         	v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(V_max_version_number,1)||'"')::text::jsonb, true);
          
         update kxp.kxp_asset_draft ad
					set    asset_data        = v_json,
					updated_date      		 = v_currenttimestamp,
					updated_by               = v_updated_by
					where  asset_id          = v_template_component_map_id
					and    asset_type_id     = v_asset_type_id
					and    ad.version_number = (select max(ad1.version_number)
          from   kxp.kxp_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and ad1.asset_type_id = ad.asset_type_id);
	 ---------------asset update--------
        
		
		end if;
    
        
else
	
		if v_status = 0 then
			
			    if v_trashed =0 then
		---------------------new added------
		           select max(version_number)
			         into   strict v_version_number
			         from   kxp.kxp_asset_draft
			         where  asset_type_id = v_asset_type_id
			         and    asset_id      = v_template_component_map_id;
			
			      v_version_number := v_version_number + 1;
			         	v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(v_version_number,1)||'"')::text::jsonb, true);
			     insert into kxp.kxp_asset_draft(
                 asset_draft_id, 
                 asset_id, 
                 asset_type_id, 
                 version_number, 
                 asset_data, created_date,
				 updated_date, created_by, updated_by, is_active, is_deleted,
											asset_draft_guid)
						values(v_asset_draft_id, 
						 v_template_component_map_id,
						 v_asset_type_id, 
						 v_version_number, 
						 v_json, v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0,
							   v_asset_draft_guid);

			       select v_json->'data'->>'asset_map'
			       into   v_asset_map_json;
			
			      if v_asset_map_json is not null then
				  v_counter := 0;
				  for v_assetdata in select * from json_array_elements(v_asset_map_json)
				  loop
					
					v_template_asset_component_map_id := nextval('kxp.seq_kxp_template_component_asset_map_id');
					v_asset_guid1                     := uuid_generate_v4();
					
					select v_assetdata->>'asset_order',
						   v_assetdata->>'asset_type',
						   v_assetdata->>'asset_id',
						   v_assetdata->'asset_meta'
					into v_asset_order,
						 v_asset_type,
						 v_asset_id,
						 v_asset_meta;
					
					if v_asset_type = 12 then
						
                            v_ext_asset_id := nextval('kxp.seq_kxp_template_externalasset_id');
--						
--						insert into kxp.kxp_template_component_asset_map
--                                             (template_component_asset_map_id, 
--                                             template_component_map_id,
--                                             asset_order, 
--                                             asset_id, 
--                                             asset_type_id,
--                                             asset_meta,
--																		 show_in_web, show_in_mobile, 
--                                     show_in_app, published_version_number,
--                                     is_trashed, created_date,
--                                     updated_date,
--																		 created_by, updated_by, 
--                                     is_active, is_deleted, is_published, published_date, asset_guid)
--                                     values( v_template_asset_component_map_id, 
--                                             v_template_component_map_id,
--                                             v_asset_order,
--                                             v_ext_asset_id,
--                                             v_asset_type,
--                                             v_asset_meta,
--                                             1, 1, 1,
--                                             v_version_number,
--                                             v_trashed, v_currenttimestamp,
--                                             v_currenttimestamp, v_updated_by, 
--                                             v_updated_by, 1, 0, v_status, 
--                                             v_published_date, v_asset_guid1);
--						
               v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',asset_id',',')  ;
               v_counter:=v_counter+1;
                 raise notice '%' ,v_set_data;
                 raise notice '%' ,v_ext_asset_id;
					-- v_json := jsonb_set(v_json, '{data,asset_map,0,asset_id}', 1::jsonb, true);
					  --    v_json := jsonb_set(to_jsonb(v_json), v_set_data, v_ext_asset_id::text::jsonb, false);
                    -- v_json := jsonb_set(to_jsonb(v_json), '{data,asset_map,1,asset_id}', v_ext_asset_id::text::jsonb, true);
                    raise notice '%' ,'vj2'||COALESCE(v_json::varchar,'')||'';
  

						select v_assetdata->>'entitydata'
						into   v_entityjson;
						
						if v_entityjson is not null then
							
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
									
									v_assetentitymapid   := nextval('kxp.seq_kxp_asset_entity_map_id');
									v_assetentitymapguid := uuid_generate_v4();
									
									insert into kxp.kxp_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible, priority, created_date, 
																		 updated_date, created_by, updated_by, is_active, is_deleted, is_published, aemap_guid)
									values(v_assetentitymapid, v_ext_asset_id, v_asset_type, v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
										   v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0, 1, v_assetentitymapguid);
									
								end if;
								
							end loop;
	         
						end if;
            
          ---------------existing update-------------
          
          
				select max(version_number)
				into   strict V_max_version_number
				from   kxp.kxp_asset_draft
				where  asset_type_id = v_asset_type_id
				and    asset_id      = v_template_component_map_id;
           raise notice '%' ,'vj3'||COALESCE(v_json::varchar,'')||'';
        v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(V_max_version_number,1)||'"')::text::jsonb, true);
        
          update kxp.kxp_asset_draft ad
					set    asset_data        = v_json,
					updated_date      		 = v_currenttimestamp,
					updated_by               = v_updated_by
					where  asset_id          = v_template_component_map_id
					and    asset_type_id     = v_asset_type_id
					and    ad.version_number = (select max(ad1.version_number)
												from   kxp.kxp_asset_draft ad1
												where  ad1.asset_id = ad.asset_id
												and ad1.asset_type_id = ad.asset_type_id);
                        
                        ---------------existing update-------------
						
					else
--						select max(version_number)
--				into   strict V_max_version_number
--				from   kxp.kxp_asset_draft
--				where  asset_type_id = v_asset_type_id
--				and    asset_id      = v_template_component_map_id;
--						insert into kxp.kxp_template_component_asset_map(
--            template_component_asset_map_id,
--            template_component_map_id,
--            asset_order, asset_id, 
--            asset_type_id, asset_meta,
--																		 show_in_web, 
--                                     show_in_mobile,
--                                     show_in_app, 
--                                     published_version_number, is_trashed, created_date, updated_date,
--																		 created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid)
--						values(v_template_asset_component_map_id, v_template_component_map_id, v_asset_order, v_asset_id, v_asset_type, v_asset_meta, 1, 1, 1, V_max_version_number, v_trashed,
--							   v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0, v_status, v_published_date, v_asset_guid1);
						
--             -- entiydata for asset_type_id <> 12---
                select ad.asset_data->'data'->'entitydata' into v_ent_json
                from kxp.kxp_asset_draft ad
                where ad.asset_type_id=v_asset_type
                and ad.asset_id=v_asset_id
                and ad.version_number=(select max(version_number) 
                                     from  kxp.kxp_asset_draft ad1 
                                       where ad1.asset_type_id=ad.asset_type_id 
              and ad1.asset_id=ad.asset_id);
              
                v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',entitydata',',')  ;
                
               if (v_ent_json is not null) then
              v_json := jsonb_set(v_json, v_set_data, v_ent_json::jsonb, false);
              end if;
--                -- entiydata for asset_type_id <> 12--
--            
--            
           select row_to_json(a) into v_asset_map_json_data
                                from((select 
                                            asset_title as title,
                                            image_path,
                                            image_file_name as image_name,
                                            ' ' as video_url,
                                            ' ' image_id,
                                            ' 'content_type,
                                            ' ' video_embed
                                            from  kxp.kxp_asset_list
                                            where asset_id=v_asset_id
                                            and asset_type_id=v_asset_type
                                            ))A;
--
                v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',asset_meta',',')  ;
--                -- v_counter:=v_counter+1;
             if (v_asset_map_json_data is not null) then
              v_json := jsonb_set(v_json, v_set_data, v_asset_map_json_data::jsonb, false);
              end if;
--            
               v_counter:=v_counter+1;       
--            
--            
--            
--            
				end if;
--					

			end loop;
--				     -- v_json := jsonb_set(v_json, '{data,asset_map,0,asset_id}', '1'::jsonb, true);
		  end if;
      	     select max(version_number)
				into   strict V_max_version_number
				from   kxp.kxp_asset_draft
				where  asset_type_id = v_asset_type_id
				and    asset_id      = v_template_component_map_id;
           v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(V_max_version_number,1)||'"')::text::jsonb, true);
        
		   update kxp.kxp_asset_draft ad
					set    asset_data        = v_json,
					updated_date      		 = v_currenttimestamp,
					updated_by               = v_updated_by
					where  asset_id          = v_template_component_map_id
					and    asset_type_id     = v_asset_type_id
					and    ad.version_number = (select max(ad1.version_number)
												from   kxp.kxp_asset_draft ad1
												where  ad1.asset_id = ad.asset_id
												and ad1.asset_type_id = ad.asset_type_id);

    
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
			         -- select coalesce(max(published_version_number),1)
				     -- into   strict v_pubversionnumber
				     -- from   kxp.kxp_template_component_asset_map
				     -- where  template_component_map_id = v_template_component_map_id;
				
				      -- select max(version_number)
				     -- into   strict v_version_number
				     -- from   kxp.kxp_asset_draft
				     -- where  asset_type_id = v_asset_type_id
				     -- and    asset_id      = v_template_component_map_id;
				
				     --  if v_version_number > v_pubversionnumber then
					         	-- v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(v_version_number,1)||'"')::text::jsonb, true);
					-- update kxp.kxp_asset_draft ad
					  -- set    asset_data        = v_json,
					-- updated_date      		 = v_currenttimestamp,
					-- updated_by               = v_updated_by
					-- where  asset_id          = v_template_component_map_id
					-- and    asset_type_id     = v_asset_type_id
					 -- and    ad.version_number = (select max(ad1.version_number)
											-- 	from   kxp.kxp_asset_draft ad1
											-- 	where  ad1.asset_id = ad.asset_id
											-- 	and ad1.asset_type_id = ad.asset_type_id);
					
				--else
					
				---	v_version_number := v_version_number + 1;
					         	--v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(v_version_number,1)||'"')::text::jsonb, true);
					--insert into kxp.kxp_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date, created_by, updated_by, is_active,
													--is_deleted, asset_draft_guid)
				--values (v_asset_draft_id, v_template_component_map_id, v_asset_type_id, v_version_number, v_json, v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1,
						--	0, v_asset_draft_guid);
					
				--end if;
		---		
		 else
				
--				update kxp.kxp_template_component_asset_map
--				set    is_published 			 = v_status,
--					   is_trashed   			 = 1,
--					   updated_date 			 = v_currenttimestamp
--				where  template_component_map_id = v_template_component_map_id;
				
--				select max(version_number)
--				into   strict V_max_version_number
--				from   kxp.kxp_asset_draft
--				where  asset_type_id = v_asset_type_id
--				and    asset_id      = v_template_component_map_id;
        
--                v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(V_max_version_number,1)||'"')::text::jsonb, true);
        
				update kxp.kxp_asset_draft ad
				set    asset_data        = v_json,
					   updated_date      = v_currenttimestamp
				where  asset_id          = v_template_component_map_id
				and    asset_type_id     = v_asset_type_id
				and    ad.version_number = (select max(ad1.version_number)
											from   kxp.kxp_asset_draft ad1
											where  ad1.asset_id   = ad.asset_id
											and ad1.asset_type_id = ad.asset_type_id);
				
			end if;
		
        
  else
			
			select max(version_number)
			into   strict v_version_number
			from   kxp.kxp_asset_draft
			where  asset_type_id = v_asset_type_id
			and    asset_id      = v_template_component_map_id;
			
			v_version_number := v_version_number + 1;
			         	v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(v_version_number,1)||'"')::text::jsonb, true);
			insert into kxp.kxp_asset_draft(
           asset_draft_id, 
             asset_id, 
           asset_type_id, 
            version_number, 
           asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
											asset_draft_guid)
			values(v_asset_draft_id, 
             v_template_component_map_id,
             v_asset_type_id, 
             v_version_number, 
             v_json, v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0,
				   v_asset_draft_guid);
			
			delete
			from   kxp.kxp_template_component_asset_map
			where  template_component_map_id = v_template_component_map_id;
			
			select v_json->'data'->>'asset_map'
			into   v_asset_map_json;
			
			if v_asset_map_json is not null then
				v_counter := 0;
				for v_assetdata in select * from json_array_elements(v_asset_map_json)
				loop
					
					v_template_asset_component_map_id := nextval('kxp.seq_kxp_template_component_asset_map_id');
					v_asset_guid1                     := uuid_generate_v4();
					
					select v_assetdata->>'asset_order',
						   v_assetdata->>'asset_type',
						   v_assetdata->>'asset_id',
						   v_assetdata->'asset_meta'
					into v_asset_order,
						 v_asset_type,
						 v_asset_id,
						 v_asset_meta;
					
					if v_asset_type = 12 then
						
						v_ext_asset_id := nextval('kxp.seq_kxp_template_externalasset_id');
						
						insert into kxp.kxp_template_component_asset_map
                                             (template_component_asset_map_id, 
                                             template_component_map_id,
                                             asset_order, 
                                             asset_id, 
                                             asset_type_id,
                                             asset_meta,
																		 show_in_web, show_in_mobile, 
                                     show_in_app, published_version_number,
                                     is_trashed, created_date,
                                     updated_date,
																		 created_by, updated_by, 
                                     is_active, is_deleted, is_published, published_date, asset_guid)
                                     values( v_template_asset_component_map_id, 
                                             v_template_component_map_id,
                                             v_asset_order,
                                             v_ext_asset_id,
                                             v_asset_type,
                                             v_asset_meta,
                                             1, 1, 1,
                                             v_version_number,
                                             v_trashed, v_currenttimestamp,
                                             v_currenttimestamp, v_updated_by, 
                                             v_updated_by, 1, 0, v_status, 
                                             v_published_date, v_asset_guid1);
						
               v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',asset_id',',')  ;
               v_counter:=v_counter+1;
                 raise notice '%' ,v_set_data;
					-- v_json := jsonb_set(v_json, '{data,asset_map,0,asset_id}', 1::jsonb, true);
					      v_json := jsonb_set(to_jsonb(v_json), v_set_data, v_ext_asset_id::text::jsonb, false);
                    -- v_json := jsonb_set(to_jsonb(v_json), '{data,asset_map,1,asset_id}', v_ext_asset_id::text::jsonb, true);
                    raise notice '%' ,'vj4'||COALESCE(v_json::varchar,'')||'';
  

						select v_assetdata->>'entitydata'
						into   v_entityjson;
						
						if v_entityjson is not null then
							
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
									
									v_assetentitymapid   := nextval('kxp.seq_kxp_asset_entity_map_id');
									v_assetentitymapguid := uuid_generate_v4();
									
									insert into kxp.kxp_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible, priority, created_date, 
																		 updated_date, created_by, updated_by, is_active, is_deleted, is_published, aemap_guid)
									values(v_assetentitymapid, v_ext_asset_id, v_asset_type, v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
										   v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0, 1, v_assetentitymapguid);
									
								end if;
								
							end loop;
	         
						end if;
            
          ---------------existing update-------------
          
          
				select max(version_number)
				into   strict V_max_version_number
				from   kxp.kxp_asset_draft
				where  asset_type_id = v_asset_type_id
				and    asset_id      = v_template_component_map_id;
        v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(V_max_version_number,1)||'"')::text::jsonb, true);
        
          update kxp.kxp_asset_draft ad
					set    asset_data        = v_json,
					updated_date      		 = v_currenttimestamp,
					updated_by               = v_updated_by
					where  asset_id          = v_template_component_map_id
					and    asset_type_id     = v_asset_type_id
					and    ad.version_number = (select max(ad1.version_number)
												from   kxp.kxp_asset_draft ad1
												where  ad1.asset_id = ad.asset_id
												and ad1.asset_type_id = ad.asset_type_id);
                        
                        ---------------existing update-------------
						
					else
						select max(version_number)
				into   strict V_max_version_number
				from   kxp.kxp_asset_draft
				where  asset_type_id = v_asset_type_id
				and    asset_id      = v_template_component_map_id;
						insert into kxp.kxp_template_component_asset_map(template_component_asset_map_id, template_component_map_id, asset_order, asset_id, asset_type_id, asset_meta,
																		 show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, updated_date,
																		 created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid)
						values(v_template_asset_component_map_id, v_template_component_map_id, v_asset_order, v_asset_id, v_asset_type, v_asset_meta, 1, 1, 1, V_max_version_number, v_trashed,
							   v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0, v_status, v_published_date, v_asset_guid1);
						
--             -- entiydata for asset_type_id <> 12---
                select ad.asset_data->'data'->'entitydata' into v_ent_json
                from kxp.kxp_asset_draft ad
                where ad.asset_type_id=v_asset_type
                and ad.asset_id=v_asset_id
                and ad.version_number=(select max(version_number) 
                                     from  kxp.kxp_asset_draft ad1 
                                       where ad1.asset_type_id=ad.asset_type_id 
              and ad1.asset_id=ad.asset_id);
              
                v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',entitydata',',')  ;
                
               if (v_ent_json is not null) then
              v_json := jsonb_set(v_json, v_set_data, v_ent_json::jsonb, false);
              end if;
--                -- entiydata for asset_type_id <> 12--
--            
--            
           select row_to_json(a) into v_asset_map_json_data
                                from((select 
                                            asset_title as title,
                                            image_path,
                                            image_file_name as image_name,
                                            ' ' as video_url,
                                            ' ' image_id,
                                            ' 'content_type,
                                            ' ' video_embed
                                            from  kxp.kxp_asset_list
                                            where asset_id=v_asset_id
                                            and asset_type_id=v_asset_type
                                            ))A;
--
                v_set_data :=string_to_array('data,asset_map,'||v_counter::text||',asset_meta',',')  ;
--                -- v_counter:=v_counter+1;
             if (v_asset_map_json_data is not null) then
              v_json := jsonb_set(v_json, v_set_data, v_asset_map_json_data::jsonb, false);
              end if;
--            
               v_counter:=v_counter+1;       
--            
--            
--            
--            
				end if;
--					

			end loop;
--				     -- v_json := jsonb_set(v_json, '{data,asset_map,0,asset_id}', '1'::jsonb, true);
		  end if;
      	     select max(version_number)
				into   strict V_max_version_number
				from   kxp.kxp_asset_draft
				where  asset_type_id = v_asset_type_id
				and    asset_id      = v_template_component_map_id;
           v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(V_max_version_number,1)||'"')::text::jsonb, true);
        
		   update kxp.kxp_asset_draft ad
					set    asset_data        = v_json,
					updated_date      		 = v_currenttimestamp,
					updated_by               = v_updated_by
					where  asset_id          = v_template_component_map_id
					and    asset_type_id     = v_asset_type_id
					and    ad.version_number = (select max(ad1.version_number)
												from   kxp.kxp_asset_draft ad1
												where  ad1.asset_id = ad.asset_id
												and ad1.asset_type_id = ad.asset_type_id);

    	end if;
		
    
end if;
	
--	v_json   := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(v_version_number,1)||'"')::text::jsonb, true);
	
    
   
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
