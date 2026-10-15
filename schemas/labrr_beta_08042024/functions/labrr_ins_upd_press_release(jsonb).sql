-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_ins_upd_press_release(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_press_release(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_ins_upd_press_release(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
-- input 
--p_data jsonb;
/*p_result numeric :=1;
p_json jsonb :='{
  "data": {
    "guid": "c5f0d577-21b1-47a5-9d66-651c6cb4309c",
    "image": [
      {
        "id": 1,
        "name": "",
        "path": "",
        "size": "",
        "is_cover": 1
      }
    ],
    "items": [
      {
        "desc": "1909",
        "title": "test1",
        "lang_id": 10,
        "lang_name": "english",
        "attachments": [
          {
            "file_id": "11",
            "file_name": "test.pdf",
            "file_path": "ed/2e/44",
            "file_size": "24kb",
            "file_type": "1",
            "asset_type_id": "26"
          }
        ],
        "short_title": "1",
        "attachment_count": null,
        "press_release_id": null,
        "press_release_map_id": "94"
      },
      {
        "desc": "1909",
        "title": "marathi",
        "lang_id": 23,
        "lang_name": "marathi",
        "attachments": [
          {
            "file_id": "11",
            "file_name": "test.pdf",
            "file_path": "ed/2e/44",
            "file_size": "24kb",
            "file_type": "1",
            "asset_type_id": "26"
          }
        ],
        "short_title": "1",
        "attachment_count": null,
        "press_release_id": null,
        "press_release_map_id": "95"
      },
      {
        "desc": "1909",
        "title": "test",
        "lang_id": 12,
        "lang_name": "hindi",
        "attachments": [
          {
            "file_id": "11",
            "file_name": "test.pdf",
            "file_path": "ed/2e/44",
            "file_size": "24kb",
            "file_type": "1",
            "asset_type_id": "26"
          }
        ],
        "short_title": "1",
        "attachment_count": null,
        "press_release_id": null,
        "press_release_map_id": "96"
      },
      {
        "desc": "1909",
        "title": "test12",
        "lang_id": 12,
        "lang_name": "malvani",
        "attachments": [
          {
            "file_id": "11",
            "file_name": "test.pdf",
            "file_path": "ed/2e/44",
            "file_size": "24kb",
            "file_type": "1",
            "asset_type_id": "26"
          }
        ],
        "short_title": "1",
        "attachment_count": null,
        "press_release_id": null,
        "press_release_map_id": "97"
      },
	   {
        "desc": "1909",
        "title": "test12asa",
        "lang_id": 12,
        "lang_name": "malvani-kokni",
        "attachments": [
          {
            "file_id": "11",
            "file_name": "test.pdf",
            "file_path": "ed/2e/44",
            "file_size": "24kb",
            "file_type": "1",
            "asset_type_id": "26"
          }
        ],
        "short_title": "1",
        "attachment_count": null,
        "press_release_id": null,
        "press_release_map_id": null
      }
    ],
    "title": "1",
    "status": 1,
    "zip_id": 123,
    "zip_name": "",
    "zip_path": "",
    "zip_size": "",
    "edited_by": 1,
    "created_by": "",
    "is_trashed": 0,
    "created_date": null,
    "modified_date": null,
    "published_date": null,
    "version_number": 1,
    "press_release_id": 81
  }
}';
*/
v_json							jsonb;
v_items_data                    json;
v_items                         jsonb ;
v_sysdate						timestamp;

-- v_press_release_map_id numeric;
v_press_release_id numeric;
v_title varchar(2000);
--v_short_title varchar(2000);
--v_desc text;
--v_lang_id numeric;
--v_lang_name varchar(2000);
v_version_number    numeric := 1 ;
v_status numeric;
v_published_date timestamp;
v_updated_by numeric;

v_pubversionnumber numeric;
v_guid text;
v_press_release_map_id numeric;

v_press_title text;
v_short_title text;
v_desc text;
v_lang_id numeric;
v_lang_name varchar(2000);
v_attachment_count numeric ;
v_attachments  jsonb;
v_assettypeid numeric :=20;

v_zip_id numeric;
v_zip_name text;
v_zip_path text;
v_zip_size text;

v_image_id numeric;
v_is_cover numeric;
v_image_name text;
v_image_path text;
v_is_trashed numeric;
 v_counter numeric:=0;
 
 v_assetdraftid numeric ;
 v_assetdraftguid text;
 err_msg text;
 v_array int[];
 v_p_map_array int[];
 v_entityrolemapid     numeric;
	v_priority 	    	  numeric;
	v_islinkable  		  numeric;
	v_isvisible  		  numeric;
	v_entityjson 		  json;
	v_entity 			  json;
	v_assetentitymapid numeric;
	v_assetentitymapguid varchar(500);
	v_link varchar;
	v_web_list_json jsonb;
	v_asset_list_id numeric;
	v_title_alias varchar;
begin
       select current_timestamp at time zone 'utc'
       into   v_sysdate;  

      -------------------------------------------------------
      
      v_json := p_json;
      -------------------------------------------------------
select   v_json->'data'->>'press_release_id',
		 v_json->'data'->>'title',
		 v_json->'data'->>'guid',
		 v_json->'data'->>'status',
		 v_json->'data'->>'published_date',	
		 v_json->'data'->>'edited_by',
		 v_json->'data'->>'zip_id',
		 v_json->'data'->>'zip_name',
		 v_json->'data'->>'zip_path',
		 v_json->'data'->>'zip_size',
		v_json->'data'->>'is_trashed',
        v_json->'data'->>'link',
		v_json->'data'->>'slug_url'
		
into    v_press_release_id,
		v_title,
		v_guid,
		v_status,
		v_published_date,
		v_updated_by ,
		v_zip_id,
		v_zip_name,
		v_zip_path,
		v_zip_size ,
		v_is_trashed,
		v_link,
		v_title_alias
        ;

---select  v_image_data->>'id',
  --      v_image_data->>'name',
--		v_image_data->>'path',
	--	v_image_data->>'is_cover'
		
--into 	v_image_id ,
 --       v_image_name,
--		v_image_path,
 ---       v_is_cover 
--;
         	

    v_assetdraftid := nextval('labrr.seq_labrr_asset_draft_id');
    v_assetdraftguid := uuid_generate_v4();

if v_press_release_id is null then 
        
		  v_press_release_id :=nextval('labrr.seq_labrr_press_release_id');
		  v_asset_list_id := nextval ('labRR.seq_labRR_asset_list_id');
	      v_guid := uuid_generate_v4();
		  v_json := jsonb_set(v_json, '{data,press_release_id}', v_press_release_id::text::jsonb, true);
		
		  v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);
	      v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);
		  
		v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_sysdate||'"')::text::jsonb, true);
		
		   v_published_date := coalesce(v_published_date,v_sysdate);
			
			-- select * from labrr.labrr_press_release_master
	     v_json := jsonb_set(v_json, '{data,press_release_id}', v_press_release_id::text::jsonb, true);
		insert into labrr.labrr_press_release_master
		 (	press_release_id,
			title,
		    status,
		 	published_date,
		  	guid,
		  	version_number,
		  	created_date,
	      	updated_date,
		  	created_by,
		  	updated_by,
		  	image_id ,
		    is_cover,
		    image_name,
		    image_path,
		    press_release_json,
		    zip_id,
		    zip_name,
		    zip_path,
		    zip_size,
		    is_trashed,
		    title_alias,
		    link
		    )
		values (v_press_release_id,
				v_title,
				v_status,
				v_published_date,
				v_guid,
				v_version_number,
				v_sysdate,
				v_sysdate,
				v_updated_by,
				v_updated_by,
				v_image_id,
				v_is_cover,
				v_image_name,
				v_image_path,
				v_json,
				v_zip_id,
				v_zip_name,
				v_zip_path,
				v_zip_size,
				v_is_trashed,
				v_title_alias,
				v_link
				);

         
		
              select v_json->'data'->>'items'
	       	  into   v_items_data;  
			     v_counter := 0;
                 for v_items in select * from json_array_elements(v_items_data)
					loop
	               select   v_items->>'press_release_map_id',
							v_items->>'title',
							v_items->>'short_title',
							v_items->>'desc',
							v_items->>'lang_id',
							v_items->>'lang_name',
							v_items->>'attachment_count',
							v_items->'attachments'
				    
					into    v_press_release_map_id,
					        v_title,
						    v_short_title,
						    v_desc,
							v_lang_id,
							v_lang_name,
							v_attachment_count,
							v_attachments
					  ;
	               
		              v_press_release_map_id :=nextval('labrr.seq_labrr_press_release_map_id');
	                 -- raise notice '%', v_press_release_map_id;
	                 insert into labrr.labrr_press_release_map
		 							 (	press_release_map_id,
										press_release_id,
										title,
										short_title,
									 	description,
		  								lang_id,
		  								lang_name,
		  								attachments,
	      								is_active,
		  								is_deleted,
		  								is_published,
		  								created_date ,
		  								updated_date,
		   								published_date
									    
		                                )
	 				values (v_press_release_map_id,
							v_press_release_id,
							v_title,
							v_short_title,
							v_desc,
							v_lang_id,
							v_lang_name,
							v_attachments,
							1,
							0,
							v_status,
							v_sysdate,
							v_sysdate,
							v_published_date
							
							);
	                     
						v_json= jsonb_set(v_json,('{data,items,'||v_counter::text||',press_release_map_id}')::text[],
                                  ('"'||v_press_release_map_id||'"')::text::jsonb,true);
		                v_counter:=v_counter+1;
						
						
	                end loop;
		
			update 	labrr.labrr_press_release_master
			set press_release_json=v_json
			where press_release_id=v_press_release_id ;
			
			insert into labRR.labRR_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias,
											   is_active, is_deleted, is_published)
			values(v_asset_list_id, v_press_release_id, v_assettypeid, v_title, v_title_alias,1,0,1 );
			
	      insert into labrr.labrr_asset_draft(asset_draft_id,
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
					v_press_release_id,
					v_assettypeid,
					v_version_number,
					v_json,
					v_sysdate,
					v_sysdate,
					v_updated_by,
					v_updated_by,
					1,
					0,
                   v_assetdraftguid);
				
	else 
	
	  if v_status = 0 then
	  
	      if v_is_trashed = 0 then
		
		     select coalesce(max(version_number),1)
                into   strict v_pubversionnumber
                from   labrr.labrr_press_release_master
                where  press_release_id = v_press_release_id;
				
				 select max(version_number)
                into   strict v_version_number
                from   labrr.labrr_asset_draft
                where  asset_type_id = v_assettypeid
                and    asset_id      = v_press_release_id;
				 v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_sysdate||'"')::text::jsonb, true);
		
			  if v_version_number > v_pubversionnumber then
                	-- v_json := jsonb_set(v_json, '{data,version_number}', v_pubversionnumber::text::jsonb, true);
			
                    update labrr.labrr_asset_draft ad
                    set    asset_data        = v_json,
                    		updated_date     = v_sysdate
					where  asset_id          = v_press_release_id
                    and    asset_type_id     = v_assettypeid
                    and    ad.version_number = (select max(ad1.version_number)
                                                from   labrr.labrr_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
												
		    -- v_json := jsonb_set(v_json, '{data,version_number}', v_pubversionnumber::text::jsonb, true);
								
			    else 
				
				 v_version_number := v_version_number + 1;
				
				
				v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);
						
				 insert into labrr.labrr_asset_draft(asset_draft_id,
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
					v_press_release_id,
					v_assettypeid,
					v_version_number,
					v_json,
					v_sysdate,
					v_sysdate,
					v_updated_by,
					v_updated_by,
					1,
					0,
                   v_assetdraftguid);
				
			end if ;
		     
	
		
		
		else 
		   
		
		       update labrr.labrr_press_release_master
                set    status  = v_status,
                		is_trashed   = 1,
                        updated_date = v_sysdate,
						press_release_json=v_json
				where  press_release_id    = v_press_release_id;
                
                update labrr.labrr_asset_draft ad
                set    asset_data         = v_json,
                		updated_date      = v_sysdate
				where  asset_id           = v_press_release_id
		               and    asset_type_id      = v_assettypeid
                     and    ad.version_number  = (select max(ad1.version_number)
                                             from  labrr.labrr_asset_draft ad1
                                             where  ad1.asset_id = ad.asset_id
                                             and ad1.asset_type_id = ad.asset_type_id);
		
		
		 end if ;
	  
	else 
	     
		    select max(version_number)
            into   strict v_version_number
            from   labrr.labrr_asset_draft
            where  asset_type_id = v_assettypeid
            and    asset_id      = v_press_release_id;
	
	        v_version_number := v_version_number + 1;
	      v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_sysdate||'"')::text::jsonb, true);
		 v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);
	
		 insert into labrr.labrr_asset_draft(asset_draft_id,
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
					v_press_release_id,
					v_assettypeid,
					v_version_number,
					v_json,
					v_sysdate,
					v_sysdate,
					v_updated_by,
					v_updated_by,
					1,
					0,
                   v_assetdraftguid);
			
		  update labrr.labrr_press_release_master	
		  set   title=v_title,
				status=v_status,
				published_date=v_published_date,
				version_number=v_version_number,
				updated_date=v_sysdate,
				updated_by=v_updated_by,
				press_release_json=v_json,
				zip_id=v_zip_id,
				zip_name=v_zip_name,
				zip_path=v_zip_path,
				zip_size=v_zip_size,
				is_trashed=0,
				link=v_link
		where press_release_id=v_press_release_id;
		
		update labRR.labRR_asset_list
		set asset_title = v_title, 
			title_alias = v_title_alias
		where asset_id = v_press_release_id and asset_type_id = v_assettypeid ;	
			
			
			select v_json->'data'->>'items'
	       	  into   v_items_data;  
			     v_counter := 0;
                 for v_items in select * from json_array_elements(v_items_data)
					loop
	               select   v_items->>'press_release_map_id',
							v_items->>'title',
							v_items->>'short_title',
							v_items->>'desc',
							v_items->>'lang_id',
							v_items->>'lang_name',
							v_items->>'attachment_count',
							v_items->'attachments'
				    
					into    v_press_release_map_id,
					        v_title,
						    v_short_title,
						    v_desc,
							v_lang_id,
							v_lang_name,
							v_attachment_count,
							v_attachments
					  ;
	                   
					if v_press_release_map_id is null then 
		              v_press_release_map_id :=nextval('labrr.seq_labrr_press_release_map_id');
	                 -- raise notice '%', v_press_release_map_id;
	                 insert into labrr.labrr_press_release_map
		 							 (	press_release_map_id,
										press_release_id,
										title,
										short_title,
									 	description,
		  								lang_id,
		  								lang_name,
		  								attachments,
	      								is_active,
		  								is_deleted,
		  								is_published,
		  								created_date ,
		  								updated_date,
		   								published_date
		                                )
	 				values (v_press_release_map_id,
							v_press_release_id,
							v_title,
							v_short_title,
							v_desc,
							v_lang_id,
							v_lang_name,
							v_attachments,
							1,
							0,
							v_status,
							v_sysdate,
							v_sysdate,
							v_published_date
							);
	                     
						v_json= jsonb_set(v_json,('{data,items,'||v_counter::text||',press_release_map_id}')::text[],
                                  ('"'||v_press_release_map_id||'"')::text::jsonb,true);
								
						else 
						
						 
						
						update labrr.labrr_press_release_map
						set title=v_title,
							short_title=v_short_title,
							description=v_desc,
							lang_id=v_lang_id,
							lang_name=v_lang_name,
							attachments=v_attachments,
							updated_date=v_sysdate,
							is_active=1,
							is_published=1,
							is_deleted=0
						where press_release_map_id=v_press_release_map_id
						  and press_release_id=v_press_release_id;
						
						
						
						end if ;
								
								
		                v_counter:=v_counter+1;
						
						v_p_map_array:=array_append(v_p_map_array,v_press_release_map_id::int);
						
						
	                end loop;
					
			v_p_map_array:=uniq(sort(v_p_map_array)::int[]);
			raise notice 'v_p_map_array=%',v_p_map_array;
			            update labrr.labrr_press_release_map
						set is_deleted=1,is_active=0,is_published=0
						where press_release_map_id not in (select press_release_map_id from 
                                         unnest(v_p_map_array) u(press_release_map_id))
						 and press_release_id=v_press_release_id;
			
				
	  end if ;
	
	

end if ;

---------- Entity Data Start --------
if  (v_status = 1)then
			
            select v_json->'data'->>'entitydata'
			into   v_entityjson;
            
			if v_entityjson is not null then
            	
                delete
				from   labrr.labrr_asset_entity_map
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_press_release_id;
                
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
						   
						   v_array:=array_append(v_array,v_entityrolemapid::int);
					
					if (v_entityrolemapid is not null and v_priority is not null) then
                    	
						v_assetentitymapid   := nextval('labrr.seq_labrr_asset_entity_map_id');
						v_assetentitymapguid := uuid_generate_v4();
						
						insert into labrr.labrr_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
															 priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                                             is_published, aemap_guid)
						values(v_assetentitymapid, v_press_release_id, v_assettypeid, v_entityrolemapid, coalesce(v_islinkable,0),
                               v_isvisible, v_priority, v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0, 1, v_assetentitymapguid);
						
						update labrr.labrr_press_release_master
						set    primary_entity_role_map_id 	= case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
							   secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
						where  press_release_id 		    = v_press_release_id ; 
                        
					end if;
                    
				end loop;
				
				v_array:=uniq(sort(v_array)::int[]);
				
                update labrr.labrr_press_release_master
				set tagged_entity=v_array
				where press_release_id=v_press_release_id;
			 
				
			end if;
end if;
		
--------------- Entity Data End ---------------------------

p_result = 1;
p_data=v_json;

    if p_result =  1 then 
	  
	  select row_to_json(row) into v_web_list_json
	  from(select prmaster.press_release_id,prmaster.title,prmaster.published_date,
								   prmaster.updated_date,prmaster.guid,erm1.entity_role_map_id as primary_entity_role_map_id,
								 	em1.entity_name as primary_entity_name,em1.entity_display_name as pri_ent_disp_name,
								 	erm.entity_role_map_id as secondary_entity_role_map_id,
								 	em.entity_name as secondary_entity_name,em.entity_display_name as sec_ent_disp_name,link,
									prmaster.press_release_json->'data'->'image' image,
								   (select array_to_json(array_agg(a))
									from(select prmap.press_release_id,prmap.title,prmap.short_title,prmap.description,prmap.lang_id,prmap.lang_name,
										 prmap.lang_id,prmap.lang_name,prmap.attachments
										 from labrr.labrr_press_release_map prmap
										 where prmap.press_release_id = prmaster.press_release_id
										 and is_active=1 and is_published=1
										)a)attachment	 		 
        from labrr.labrr_press_release_master prmaster
		join   labRR.labRR_entity_role_map erm
        on     erm.entity_role_map_id = secondary_entity_role_map_id
        join   labRR.labRR_entity_master em
        on     em.entity_master_id = erm.entity_master_id
        join   labRR.labRR_entity_role_map erm1
        on     erm1.entity_role_map_id = primary_entity_role_map_id
        join   labRR.labRR_entity_master em1
        on     em1.entity_master_id = erm1.entity_master_id
        where  prmaster.press_release_id = v_press_release_id and status = 1 and is_trashed = 0
         order by prmaster.published_date desc)row ;
	    
		        update labrr.labrr_press_release_master
				set web_listing_json = v_web_list_json
				where press_release_id=v_press_release_id;
	
	end if;

/*exception 
    when others then
	    --err_code := SQLSTATE;
          err_msg := SQLERRM;
		  p_result := -1;
		  p_data := '{"data":{"message" :"'||coalesce(err_msg, '')||'" ,"result":"'||coalesce(p_result, 0)||'"}}';*/

end ;
$$;


--
