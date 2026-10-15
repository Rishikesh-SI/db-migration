-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_job_profile_bkp(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_job_profile_bkp(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_job_profile_bkp(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$

declare
/*p_json jsonb:='{
    "data": {
        "status": 1,
        "job_profile": "test1",
        "is_deleted": 0,
        "job_id": "test3",
        "created_date": null,
        "is_active": 1,
        "tot_exp": "test4",
        "entitydata": [
            {
                "asset_id": null,
                "is_visible": 1,
                "name": "eng",
                "ent_disp_name": "end",
                "is_lang": null,
                "is_linkable": 1,
                "priority": 1,
                "entity_role_map_id": 1212,
                "canonical": null
            }
        ],
        "job_type": "test8",
        "job_location": "test6",
        "created_by": 1,
        "job_function": "test7",
        "job_profile_id": "2",
        "updated_by": 1,
        "seo": {
            "meta_desc": null,
            "focus_key": null,
            "browser_title": null,
            "custom_meta": null,
            "meta_fields": null,
            "keywords": "test1",
            "meta_robots": null,
            "canonical_url": null
        },
        "updated_date": null,
        "job_guid": "11q1",
        "job_exp_date": null,
        "job_descr": "test5",
        "slug_url": "test2"
    }
}';
*/

		       v_sysdate 		timestamp;
		
		       v_job_profile_id numeric;
			   v_job_profile text;
			   v_slug_url varchar(1000);
			   v_job_id text;
			   v_tot_exp text;
			   v_job_descr text;
			   v_email_id text;
			   v_job_location text;
			   v_job_function text;
			   v_job_type text;
			   v_created_by numeric;
			   v_updated_by numeric;
			   v_status numeric;
			   v_is_deleted numeric;
			   v_job_guid varchar(1000);
			   v_exp_date timestamp;
			   v_pub_date timestamp;
			   v_assetdraftid numeric;
			   v_assetdraftguid varchar(1000);
			   v_versionnumber numeric :=1;
			   v_is_trashed numeric;
			   v_pubversionnumber numeric;
			   v_seojson jsonb;
				v_seodataid numeric;
				v_seodataguid text;
				v_json jsonb;
				v_jobentityjson jsonb;
				v_entity jsonb;
				v_entityrolemapid numeric;
				v_priority numeric;
				v_is_linkable numeric;
				v_is_visible numeric;
				v_assetentitymapid numeric;
				v_assetentitymapguid varchar(1000);
				v_array numeric[]; 
				v_asset_list_id numeric;
				v_company_name text;
				v_dont_expire_job numeric;
				v_test_id numeric;
				
BEGIN

	select current_timestamp  at time zone 'utc'
	into   v_sysdate;    
    v_json:=p_json;
	
	select 	    v_json->'data'->>'job_profile_id',  
			    v_json->'data'->>'job_profile',
			    v_json->'data'->>'slug_url',
			    v_json->'data'->>'job_id',
			    v_json->'data'->>'tot_exp',
			    v_json->'data'->>'job_descr',
		        v_json->'data'->>'email_id',
			    v_json->'data'->>'job_location',
			    v_json->'data'->>'job_function',
			    v_json->'data'->>'job_type',
			    v_json->'data'->>'created_by',
			   -- p_json->'data'->>'created_date',
			    v_json->'data'->>'updated_by',
               -- p_json->'data'->>'updated_date',
                v_json->'data'->>'status',
				v_json->'data'->>'is_deleted',
				v_json->'data'->>'job_guid',
				v_json->'data'->>'job_exp_date',
				v_json->'data'->>'published_data',
				v_json->'data'->>'is_trashed',
				v_json->'data'->>'seo',
				v_json->'data'->>'company_name',
				v_json->'data'->>'dont_expire_job',
				v_json->'data'->>'test_id'
		into 
		       v_job_profile_id,
			   v_job_profile,
			   v_slug_url,
			   v_job_id,
			   v_tot_exp,
			   v_job_descr,
			   v_email_id,
			   v_job_location,
			   v_job_function,
			   v_job_type,
			   v_created_by,
			   v_updated_by,
			   v_status,
			   v_is_deleted,
			   v_job_guid,
			   v_exp_date,
			   v_pub_date,
			   v_is_trashed,
				v_seojson,
				v_company_name,
				v_dont_expire_job,
				v_test_id;

	
	v_pub_date := coalesce(v_pub_date,v_sysdate);
	v_assetdraftid   := nextval('labbsc_dev.seq_labbsc_dev_asset_draft_id');
	v_assetdraftguid := uuid_generate_v4();
	
	if v_dont_expire_job = 1 then 
	
		v_exp_date := '2099-12-31';
		
	end if;	

	 if v_job_profile_id is null then 
            
			--select 1/0;
			v_asset_list_id := nextval ('labbsc_dev.seq_labbsc_dev_asset_list_id');
			v_job_profile_id := nextval('labbsc_dev.seq_labbsc_dev_job_profile_id');
			v_job_guid      :=  uuid_generate_v4();
			v_seodataid      := nextval('labbsc_dev.seq_labbsc_dev_seo_data_id');
		    v_seodataguid    := uuid_generate_v4();
			v_slug_url := v_slug_url || '-'||v_job_profile_id;
			
			    insert into labbsc_dev.labbsc_dev_job_profile
				select v_job_profile_id,v_job_profile,v_slug_url,v_job_id,v_tot_exp,v_job_descr,v_job_location,v_job_function,v_job_type,35,
					   v_sysdate,v_created_by,v_updated_by,v_sysdate,v_job_guid,null,v_pub_date,v_email_id,v_versionnumber,v_is_trashed,
					   v_status,null,v_exp_date,v_company_name,v_dont_expire_job,v_test_id;
				
				insert into labbsc_dev.labbsc_dev_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags,
                                           primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path,
                                           duration, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, 
                                           updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid,
                                           show_copyright, order_number,short_title)
			   values(v_asset_list_id, v_job_profile_id, 36, v_job_profile, v_slug_url, null, v_job_descr, null, 121, 41, null, null,
                   null, null, null, null, 0, v_versionnumber, v_is_trashed, v_sysdate, v_sysdate,
                   1, 1, 1, 0, v_status, v_sysdate, v_job_guid, null, null,null);
			

                v_json := jsonb_set(v_json, '{data,job_guid}', ('"'||v_job_guid||'"')::text::jsonb, true);
				v_json := jsonb_set(v_json, '{data,job_profile_id}', ('"'||v_job_profile_id||'"')::text::jsonb, true);
				v_json := jsonb_set(v_json, '{data,slug_url}', ('"'||v_slug_url||'"')::text::jsonb, true);
                -- p_json := jsonb_set(p_json, '{data,contact_id}', ('"'||v_contact_id||'"')::text::jsonb, true);
                -- p_json := jsonb_set(p_json, '{data,attachment}', ('"'||coalesce(v_attachment,'')||'"')::text::jsonb, true);
			 	-- p_result := 1;
	 		 
			-- p_contactjson := p_json;

				--p_contactjson := null;
			--end if ;
			
			   insert into labbsc_dev.labbsc_dev_asset_draft
				(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
				updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
				values
				(v_assetdraftid, v_job_profile_id, 36, v_versionnumber, v_json, v_sysdate, 
				v_sysdate, v_updated_by, v_created_by, 1, 0, v_assetdraftguid);
				
				
				
				
				
				insert into labbsc_dev.labbsc_dev_seo_data
				(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, 
				updated_date, created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
				values
				(v_seodataid, v_job_profile_id, 36, v_seojson,v_versionnumber,  v_sysdate, 
				v_sysdate, v_updated_by, v_updated_by, 1, 0, v_status, v_seodataguid);
	

	else 
	
    
		if v_status = 0 then
		
		
				if v_is_trashed = 0 then
						select coalesce(max(version_number),1)
						into   strict v_pubversionnumber
						from   labbsc_dev.labbsc_dev_job_profile
						where  job_profile_id      = v_job_profile_id; 
						
						
						select max(version_number)
						into   strict v_versionnumber
						from   labbsc_dev.labbsc_dev_asset_draft
						where  asset_type_id = 36
						and    asset_id      = v_job_profile_id;
						
						update labbsc_dev.labbsc_dev_job_profile
						set  is_trashed=v_is_trashed,  
							 is_published=v_status ,
							  updated_date=v_sysdate
						where job_profile_id  = v_job_profile_id;
						
						if v_versionnumber > v_pubversionnumber then
								
								update labbsc_dev.labbsc_dev_asset_draft ad
								set     asset_data        = v_json,
										updated_date      = v_sysdate
								where  asset_id      = v_job_profile_id
								and    asset_type_id = 36
								and    ad.version_number = (select max(ad1.version_number)
								from   labbsc_dev.labbsc_dev_asset_draft ad1
								where  ad1.asset_id = ad.asset_id
								and    ad1.asset_type_id = 36);
						else
								v_versionnumber := v_versionnumber + 1;
								insert into labbsc_dev.labbsc_dev_asset_draft
								(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
								updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
								values
										(v_assetdraftid, v_job_profile_id, 36, v_versionnumber, v_json, v_sysdate, 
									v_sysdate, v_updated_by, v_created_by, 1, 0, v_assetdraftguid);

						end if;
			   -- select * from labbsc_dev.labbsc_dev_job_profile;
			   else 
			
					
			
					update labbsc_dev.labbsc_dev_job_profile
					set is_trashed=v_is_trashed,  
				       is_published=v_status ,
				        updated_date=v_sysdate
				    where job_profile_id        	  = v_job_profile_id;
				
                    update labbsc_dev.labbsc_dev_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_sysdate
					where  asset_id      = v_job_profile_id
					and    asset_type_id = 36
					and    ad.version_number = (select max(ad1.version_number)
					from   labbsc_dev.labbsc_dev_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = 36);
          
           
          		select max(ad1.version_number)
                  into v_versionnumber
                  from   labbsc_dev.labbsc_dev_asset_draft ad1
                  where  ad1.asset_id = v_job_profile_id
                  and    ad1.asset_type_id = 36;          
			
				end if;
				
		else 
			
			select max(version_number)
			into   strict v_versionnumber
			from   labbsc_dev.labbsc_dev_asset_draft
			where  asset_type_id = 36
			and    asset_id      = v_job_profile_id;

			v_versionnumber := v_versionnumber + 1;
			
			insert into labbsc_dev.labbsc_dev_asset_draft
								(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
								updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
								values
										(v_assetdraftid, v_job_profile_id, 36, v_versionnumber, v_json, v_sysdate, 
									v_sysdate, v_updated_by, v_created_by, 1, 0, v_assetdraftguid);
				
				
 				update labbsc_dev.labbsc_dev_job_profile
				set job_profile=v_job_profile,
					slug_url=v_slug_url,
					job_id=v_job_id,
					tot_exp=v_tot_exp,
					job_desc=v_job_descr,
					job_function=v_job_function,
					job_location =v_job_location,
					job_type=v_job_type,
					email_id=v_email_id,
					version_number=v_versionnumber,
					updated_by=v_updated_by,
					updated_date=v_sysdate,
					is_published = v_status,
					is_trashed = v_is_trashed,
					job_exp = v_exp_date,
					company_name = v_company_name,
					do_not_expired = v_dont_expire_job,
					test_id = v_test_id
				where job_profile_id=v_job_profile_id;
 				
				update labbsc_dev.labbsc_dev_asset_list
				set   asset_title        	   = v_job_profile,
					  title_alias       	   = v_slug_url,
                      short_desc    	       = v_job_descr,
                      published_version_number = v_versionnumber,
                      updated_date      	   = v_sysdate,
                      is_published      	   = v_status,
                      is_trashed        	   = v_is_trashed,
                      published_date           = v_sysdate,
					  primary_entity_role_map_id=121,
					  secondary_entity_role_map_id=41
                      
				where asset_id        	       = v_job_profile_id
        		and   asset_type_id            = 36;
				
				update labbsc_dev.labbsc_dev_seo_data
				set    meta_info 	 = v_seojson,
				       updated_date  = v_sysdate,
					   published_version_number=v_versionnumber
				where  asset_type_id = 36
				and    asset_id      = v_job_profile_id;
 
     end if;

 end if;
 
	if v_job_profile_id is not null then 
		
		
		
		select v_json->'data'->>'entitydata'
		into   v_jobentityjson;
		
		
	--	raise notice '%',v_jobentityjson;
		if v_jobentityjson is not null then
			
			delete
			from   labbsc_dev.labbsc_dev_asset_entity_map
			where  asset_type_id = 36
			and    asset_id      = v_job_profile_id;
			
			for v_entity in select * from jsonb_array_elements(v_jobentityjson)
			loop
				
				select v_entity->>'entity_role_map_id', v_entity->>'priority',
						v_entity->>'is_linkable', v_entity->>'is_visible'
				into   v_entityrolemapid, v_priority,v_is_linkable,v_is_visible;
				
				if v_entityrolemapid is not null then
					
					v_assetentitymapid   := nextval('labbsc_dev.seq_labbsc_dev_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
					
					insert into labbsc_dev.labbsc_dev_asset_entity_map
					(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
					priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
					is_published, aemap_guid)
					values
					(v_assetentitymapid, v_job_profile_id, 36,
					v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
					v_sysdate, v_updated_by, v_updated_by, 1, 0, 1, v_assetentitymapguid);
					
								
				end if;     
				
			end loop;
			
		end if;

end if;

			if  v_status = 1 then
		
			select array(select entity_role_map_id 
						 from labbsc_dev.labbsc_dev_asset_entity_map
						 where asset_id = v_job_profile_id
						 and asset_type_id = 36

						)	a into v_array; 
						
				v_array := 	array_append(v_array,v_tot_exp::numeric);	
				v_array := 	array_append(v_array,v_job_location::numeric);
				v_array := 	array_append(v_array,v_job_function::numeric);
				v_array := 	array_append(v_array,v_job_type::numeric);
				v_array := 	array_append(v_array,v_company_name::numeric);
				
			  update labbsc_dev.labbsc_dev_job_profile 
			  set tagged_entity=v_array
			  where job_profile_id=v_job_profile_id;

			end if;
		
p_result:=1;
p_data:=v_json;
END;
$_$;


--
