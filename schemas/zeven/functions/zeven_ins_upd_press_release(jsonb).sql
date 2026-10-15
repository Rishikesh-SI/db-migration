-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_upd_press_release(jsonb)
-- Type: FUNCTION

-- Name: zeven_ins_upd_press_release(jsonb); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_upd_press_release(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
     v_json             		jsonb;    	
     v_result 					numeric ;
     v_assetmapjson     		json;
     v_press_release_id			numeric;
     v_title					character varying;
     v_short_title				character varying;
     v_image_id					numeric;     
     v_pres_relias_asset_type_id numeric := 20;
     v_image_path 				character varying;
     v_image_name 				character varying;
     v_image_zip_path		character varying;
     v_image_zip_name		character varying;
     v_image_zip_file_name	character varying;
     v_image_zip_size		character varying;
     v_published_version_number numeric;
     v_is_published			numeric;
     v_press_release_date	timestamp;
     v_published_date	timestamp;
     v_is_trashed			numeric;
     v_press_release_guid 	character varying;
     v_createddate			timestamp;
     v_pressassetmap		json;
     v_press_release_asset_map_id numeric;
     v_name_asset 			character varying;
     v_asset_id 			numeric;
     v_asset_type_id 		numeric;
     v_pdf_link				character varying;
     v_pdf_name 			character varying;
     v_pdf_size				character varying;
     v_is_published_asset 	numeric;
     v_entityjson			json;
     v_entity				json;
     v_entityname			character varying;
    -- v_asset_id			numeric;
     v_entity_dis_name 		character varying;
     v_entityrolemapid		numeric; 
     v_priority				numeric; 
     v_islinkable			numeric; 
     v_isvisible			numeric;
     v_assetentitymapid		numeric;
     v_assetentitymapguid	character varying;
     v_guid varchar(256);
     v_updated_by numeric;
     
     v_assetdraftid numeric;
     v_assetdraftguid  varchar(256);
     
      v_version_number numeric :=1 ;
     
     v_prespublishedstatus 	numeric;
     v_pubversionnumber		numeric;
     v_created_by			numeric;
     v_file_type			character varying;
     v_language_id			numeric;
     
begin
	
    ----select * from zeven.zeven_press_release ;
    select current_timestamp at time zone 'utc'
		into   v_createddate;
    
     v_json := p_json;
     
     v_published_date:=coalesce(v_published_date,v_createddate) ;
	 
	select  v_json->'data'->>'press_release_id',
    		v_json->'data'->>'title',
            v_json->'data'->>'short_title',
            v_json->'data'->>'image_id',
            v_json->'data'->>'image_path',
            v_json->'data'->>'image_name',
            v_json->'data'->>'image_zip_path',
            v_json->'data'->>'image_zip_name',
            v_json->'data'->>'image_zip_file_name',
            v_json->'data'->>'image_zip_size',
            v_json->'data'->>'version_number',
           -- v_json->'data'->>'created_date',
           -- v_json->'data'->>'updated_date',
           -- v_json->'data'->>'is_active',
            v_json->'data'->>'created_by',
            v_json->'data'->>'edited_by',
            v_json->'data'->>'guid',
            v_json->'data'->>'status',
            v_json->'data'->>'press_release_date',
            v_json->'data'->>'published_date',
            v_json->'data'->>'is_trashed',
            v_json->'data'->>'asset_map'
    into         
		v_press_release_id	,
     	v_title				,
    	v_short_title		,
     	v_image_id			,
      	v_image_path,
      	v_image_name,
     	v_image_zip_path,
     	v_image_zip_name,
     	v_image_zip_file_name,
     	v_image_zip_size,
     	v_published_version_number ,
        v_created_by,
      	v_updated_by,
      	v_guid,
    	v_is_published,
     	v_press_release_date,
      	v_published_date,
     	v_is_trashed	,
      	v_assetmapjson
   
        ;
       
       
       
        v_assetdraftid   := nextval('zeven.seq_zeven_asset_draft_id');
	    v_assetdraftguid := uuid_generate_v4();
       
       
        if (v_press_release_id is null ) then 
        	
            v_press_release_id := nextval('zeven.seq_zeven_press_release_id');
            v_press_release_guid := uuid_generate_v4();
            v_json 	         := jsonb_set(v_json, '{data,press_release_id}', v_press_release_id::text::jsonb, true);
            v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_press_release_guid||'"')::text::jsonb, true);

           --  v_createddate := current_timestamp;
            
            insert into zeven.zeven_press_release
            (
                press_release_id ,
                title ,
                short_title ,
                image_id ,
                image_zip_path ,
                image_zip_name,
                image_zip_file_name ,
                image_zip_size ,
                published_version_number ,
                created_date ,
                updated_date,
                created_by,
                updated_by ,
                is_active ,
                is_deleted ,
                is_published ,
                press_release_date,
                published_date ,
                is_trashed,
                press_release_guid 
            )
            values (v_press_release_id, 
                    v_title	,
    				v_short_title,
     				v_image_id,
                    v_image_zip_path,
                    v_image_zip_name,
                    v_image_zip_file_name,
                    v_image_zip_size,
                    v_version_number,
                    v_createddate,
                    v_createddate,
                    v_created_by,
                    v_updated_by,
                    1,
                    0,
                    v_is_published,
                    v_press_release_date,
                    v_published_date,
     				v_is_trashed,
                    v_press_release_guid
         );
			
      
           insert into zeven.zeven_asset_draft
		           ( asset_draft_id, 
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
               values
                       (v_assetdraftid,
                        v_press_release_id,
                        v_pres_relias_asset_type_id, 
                        v_version_number,
                        v_json, 
                        v_createddate, 
                        v_createddate, 
                        v_created_by, 
                        V_updated_by, 
                        1, 
                        0, 
                        v_assetdraftguid);
      
      
      
       /*   for v_pressassetmap in select * from json_array_elements(v_assetmapjson)
        loop            	
            ----select * from zeven.zeven_press_release_asset_map ;            
            
          		select    v_pressassetmap->>'press_release_asset_map_id',
        			          v_pressassetmap->>'name',
                        v_pressassetmap->>'asset_id',
                        v_pressassetmap->>'asset_type_id',
                        v_pressassetmap->>'pdf_link',
                        v_pressassetmap->>'pdf_name',
                        v_pressassetmap->>'pdf_size',
                        v_pressassetmap->>'is_published'
                into 
                		    v_press_release_asset_map_id,
                		    v_name_asset,
                        v_asset_id,
                        v_asset_type_id,
                        v_pdf_link,
                        v_pdf_name,
                        v_pdf_size,
                        v_is_published_asset ; 
                        
               insert into   zeven.zeven_press_release_asset_map
               (
                press_release_asset_map_id,
                press_release_id,
                asset_id ,
                asset_type_id ,
                pdf_link ,
                pdf_name,
                pdf_size,
                created_date ,
                updated_date ,
                created_by,
                updated_by,
                is_active ,
                is_deleted ,
                is_published ,
                pramap_guid 
            )
            values(nextval('zeven.seq_zeven_press_release_asset_map_id') ,
                   v_press_release_id,
                   v_asset_id,
                   v_asset_type_id,
                   v_pdf_link,
                   v_pdf_name,
                   v_pdf_size,
                   v_createddate,
                   v_createddate,
                   1,
                   1,
                   1,
                   0,
                   v_is_published_asset,
                   uuid_generate_v4()
              )
              ;
          end loop;    
          */
          	 
 else 
       
            select is_published
            into v_prespublishedstatus
            from zeven.zeven_press_release 
            where press_release_id= v_press_release_id;
       
       		 if v_is_published = 0 then
                  if v_is_trashed = 0 then
       
                        select coalesce(published_version_number,1)
                        into   strict v_pubversionnumber
                        from zeven.zeven_press_release 
                        where press_release_id= v_press_release_id;
                        
                        select max(version_number)
						into   strict v_version_number
					 	from   zeven.zeven_asset_draft
						where  asset_type_id = v_pres_relias_asset_type_id
						and    asset_id      = v_press_release_id;
       
       					if ((v_version_number = v_pubversionnumber ) or (v_version_number > v_pubversionnumber))
					    then
                    
							   update zeven.zeven_asset_draft ad
								set    asset_data        = v_json,
							  		   updated_date      = v_createddate
								where  asset_id          = v_press_release_id
							  	and    asset_type_id     = v_pres_relias_asset_type_id
							  	and    ad.version_number = (select max(ad1.version_number)
															from   zeven.zeven_asset_draft ad1
															where  ad1.asset_id = ad.asset_id
															and    ad1.asset_type_id = ad.asset_type_id);
															
															
                                                 
							 update zeven.zeven_press_release
							 set   	title = v_title,
                                    short_title = v_short_title ,
                                    image_id = v_image_id ,
                                    image_zip_path = v_image_zip_path ,
                                    image_zip_name = v_image_zip_name,
                                    image_zip_file_name = v_image_zip_file_name ,
                                    image_zip_size = v_image_zip_size ,
                                    published_version_number = v_version_number  ,
                                    created_date = v_createddate ,
                                    updated_date = v_createddate,
                                    created_by = V_updated_by,
                                    updated_by = V_updated_by,
                                    is_active = 1,
                                    is_deleted = 0  ,
                                    is_published = v_is_published,
                                    press_release_date = v_press_release_date ,
                                    published_date = v_published_date ,
                                    is_trashed  =  v_is_trashed                              
							where  press_release_id= v_press_release_id;
       					
                        else           
                          	v_version_number := v_version_number + 1; 
       
       						insert into zeven.zeven_asset_draft
                            ( asset_draft_id, 
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
                            values
                                  (v_assetdraftid,
                                    v_press_release_id,
                                    v_pres_relias_asset_type_id, 
                                    v_version_number,
                                    v_json, 
                                    v_createddate, 
                                    v_createddate, 
                                    v_created_by, 
                                    V_updated_by, 
                                    1, 
                                    0, 
                                    v_assetdraftguid);

       						end if;
       				else
           				
                        update zeven.zeven_press_release
					       set    is_published = v_is_published,
                                   is_trashed   = 1,
						           updated_date = v_createddate
						where press_release_id = v_press_release_id;
        				
                        update zeven.zeven_asset_draft ad
                         set    asset_data        = v_json,
                    	        updated_date      = v_createddate
					    where  asset_id          = v_press_release_id
					    and    asset_type_id     = v_pres_relias_asset_type_id
                        and    ad.version_number = (select max(ad1.version_number)
                                                from   zeven.zeven_asset_draft  ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
        
        			end if;
                else 
                	raise notice '1' ;
                    
                    select max(version_number)
			    	 into   strict v_version_number
				    from   zeven.zeven_asset_draft
					where  asset_type_id = v_pres_relias_asset_type_id
					and    asset_id      = v_press_release_id;
             		
                    v_version_number := v_version_number + 1;
                    
                    insert into zeven.zeven_asset_draft
                            ( asset_draft_id, 
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
                            values
                                  (v_assetdraftid,
                                    v_press_release_id,
                                    v_pres_relias_asset_type_id, 
                                    v_version_number,
                                    v_json, 
                                    v_createddate, 
                                    v_createddate, 
                                    v_created_by, 
                                    V_updated_by, 
                                    1, 
                                    0, 
                                    v_assetdraftguid);
                           
                           
                            update zeven.zeven_press_release
							 set   	title = v_title,
                                    short_title = v_short_title ,
                                    image_id = v_image_id ,
                                    image_zip_path = v_image_zip_path ,
                                    image_zip_name = v_image_zip_name,
                                    image_zip_file_name = v_image_zip_file_name ,
                                    image_zip_size = v_image_zip_size ,
                                    published_version_number = v_version_number  ,
                                    created_date = v_createddate ,
                                    updated_date = v_createddate,
                                    created_by = V_updated_by,
                                    updated_by = V_updated_by,
                                    is_active = 1,
                                    is_deleted = 0  ,
                                    is_published = v_is_published,
                                    press_release_date = v_press_release_date ,
                                    published_date = v_published_date ,
                                    is_trashed  =  v_is_trashed                              
							where  press_release_id= v_press_release_id;
     end if ; 
                    
            
  end if ;
       
    	  delete  from zeven.zeven_press_release_asset_map          
          where press_release_id = v_press_release_id 
          and asset_type_id = v_pres_relias_asset_type_id ;
          
          for v_pressassetmap in select * from json_array_elements(v_assetmapjson)
		  loop            	
           		select 
        			    v_pressassetmap->>'name',
                     	v_pressassetmap->>'asset_id',
        			    v_pressassetmap->>'asset_type_id',
        				v_pressassetmap->>'file_link',
        				v_pressassetmap->>'file_name',
                        v_pressassetmap->>'file_size',
        				v_pressassetmap->>'is_published',
                         v_pressassetmap->>'language_id',
                         v_pressassetmap->>'file_type'
                         
                into 
                		
                		v_name_asset,
                        v_asset_id,
                        v_asset_type_id,
                        v_pdf_link,
                        v_pdf_name,
                        v_pdf_size,
                        v_is_published_asset,
                        v_language_id,
                        v_file_type; 
                        
               insert into zeven.zeven_press_release_asset_map
               (
                press_release_asset_map_id,
                press_release_id,
                asset_id ,
                asset_type_id ,
                file_link ,
                file_name,
                file_size,
                created_date ,
                updated_date ,
                created_by,
                updated_by,
                is_active ,
                is_deleted ,
                is_published ,
                pramap_guid,
                language_id,
                file_type
            )
            values(nextval('zeven.seq_zeven_press_release_asset_map_id') ,
                   v_press_release_id,
                   v_asset_id,
                   v_asset_type_id,
                   v_pdf_link,
                   v_pdf_name,
                   v_pdf_size,
                   v_createddate,
                   v_createddate,
                   V_updated_by,
                   V_updated_by,
                   1,
                   0,
                   v_is_published_asset,
                   uuid_generate_v4(),
                   v_language_id,
                	v_file_type
              )
              ;
                    
            
          end loop;
      
         
       p_result := v_press_release_id ;
       
   exception 
   		when others then 
        	 p_result := -1 ;
      
end;

$$;


--
