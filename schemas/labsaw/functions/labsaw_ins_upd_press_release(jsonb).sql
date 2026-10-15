-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_ins_upd_press_release(jsonb)
-- Type: FUNCTION

-- Name: labsaw_ins_upd_press_release(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_ins_upd_press_release(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
		v_json->'data'->>'is_trashed'-- ,
		 -- v_json->'data'->'items'
		
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
		v_is_trashed-- ,
		-- v_items_data
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
         	

    v_assetdraftid := nextval('labsaw.seq_labsaw_asset_draft_id');
    v_assetdraftguid := uuid_generate_v4();

if v_press_release_id is null then 
        
		  v_press_release_id :=nextval('labsaw.seq_labsaw_press_release_id');
	      v_guid := uuid_generate_v4();
		  v_json := jsonb_set(v_json, '{data,press_release_id}', v_press_release_id::text::jsonb, true);
		
		  v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);
	      v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);
		  
		v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_sysdate||'"')::text::jsonb, true);
		
		   v_published_date:=coalesce(v_published_date,v_sysdate);
			
			-- select * from labsaw.labsaw_press_release_master
	     v_json := jsonb_set(v_json, '{data,press_release_id}', v_press_release_id::text::jsonb, true);
		insert into labsaw.labsaw_press_release_master
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
		    is_trashed
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
				v_is_trashed
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
	               
		              v_press_release_map_id :=nextval('labsaw.seq_labsaw_press_release_map_id');
	                 -- raise notice '%', v_press_release_map_id;
	                 insert into labsaw.labsaw_press_release_map
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
		
			update 	labsaw.labsaw_press_release_master
			set press_release_json=v_json
			where press_release_id=v_press_release_id ;
	      insert into labsaw.labsaw_asset_draft(asset_draft_id,
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
                from   labsaw.labsaw_press_release_master
                where  press_release_id = v_press_release_id;
				
				 select max(version_number)
                into   strict v_version_number
                from   labsaw.labsaw_asset_draft
                where  asset_type_id = v_assettypeid
                and    asset_id      = v_press_release_id;
				 v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_sysdate||'"')::text::jsonb, true);
		
			  if v_version_number > v_pubversionnumber then
                	-- v_json := jsonb_set(v_json, '{data,version_number}', v_pubversionnumber::text::jsonb, true);
			
                    update labsaw.labsaw_asset_draft ad
                    set    asset_data        = v_json,
                    		updated_date     = v_sysdate
					where  asset_id          = v_press_release_id
                    and    asset_type_id     = v_assettypeid
                    and    ad.version_number = (select max(ad1.version_number)
                                                from   labsaw.labsaw_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
												
		    -- v_json := jsonb_set(v_json, '{data,version_number}', v_pubversionnumber::text::jsonb, true);
								
			    else 
				
				 v_version_number := v_version_number + 1;
				
				
				v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);
						
				 insert into labsaw.labsaw_asset_draft(asset_draft_id,
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
		   
		
		       update labsaw.labsaw_press_release_master
                set    status  = v_status,
                		is_trashed   = 1,
                        updated_date = v_sysdate,
						press_release_json=v_json
				where  press_release_id    = v_press_release_id;
                
                update labsaw.labsaw_asset_draft ad
                set    asset_data         = v_json,
                		updated_date      = v_sysdate
				where  asset_id           = v_press_release_id
		               and    asset_type_id      = v_assettypeid
                     and    ad.version_number  = (select max(ad1.version_number)
                                             from  labsaw.labsaw_asset_draft ad1
                                             where  ad1.asset_id = ad.asset_id
                                             and ad1.asset_type_id = ad.asset_type_id);
		
		
		 end if ;
	  
	else 
	     
		    select max(version_number)
            into   strict v_version_number
            from   labsaw.labsaw_asset_draft
            where  asset_type_id = v_assettypeid
            and    asset_id      = v_press_release_id;
	
	        v_version_number := v_version_number + 1;
	      v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_sysdate||'"')::text::jsonb, true);
		 v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);
	
		 insert into labsaw.labsaw_asset_draft(asset_draft_id,
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
			
		  update labsaw.labsaw_press_release_master	
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
				zip_size=v_zip_size
		where press_release_id=v_press_release_id;
			
			
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
		              v_press_release_map_id :=nextval('labsaw.seq_labsaw_press_release_map_id');
	                 -- raise notice '%', v_press_release_map_id;
	                 insert into labsaw.labsaw_press_release_map
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
						
						update labsaw.labsaw_press_release_map
						set title=v_title,
							short_title=v_short_title,
							description=v_desc,
							lang_id=v_lang_id,
							lang_name=v_lang_name,
							attachments=v_attachments,
							updated_date=v_sysdate
						where press_release_map_id=v_press_release_map_id
						  and press_release_id=v_press_release_id;
						
						
						
						end if ;
								
								
		                v_counter:=v_counter+1;
						
						
	                end loop;
					
			
			
			
			
				
	  end if ;
	
	

end if ;

p_result=1;
p_data=v_json;

exception 
    when others then
	    --err_code := SQLSTATE;
          err_msg := SQLERRM;
		  p_result := -1;
		  p_data := '{"data":{"message" :"'||coalesce(err_msg, '')||'" ,"result":"'||coalesce(p_result, 0)||'"}}';

end ;

$$;


--
