-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_ruf
-- Object: labecn_ins_upd_download(jsonb)
-- Type: FUNCTION

-- Name: labecn_ins_upd_download(jsonb); Type: FUNCTION; Schema: labecn_ruf; Owner: -
--

CREATE FUNCTION labecn_ruf.labecn_ins_upd_download(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

--do
--$$
declare
/*	p_json jsonb:='{
  "data": {
    "download_id": 31,
    "title": "test for new module",
    "published_date": "2018-10-25 12:32:58.434235",
    "created_date": "2018-10-25 12:32:58.434235",
    "modified_date": "2018-10-25 07:37:41.22106",
    "guid": "220b8dcc-50a7-482b-8e11-032f62f52260",
    "is_trashed": 0,
    "created_by": 1,
    "edited_by": 1,
    "version_number": 1,
    "status": "1",
    "items": [
      {
        "download_id": null,
        "download_map_id": "21",
        "title": "testing module",
        "desc": "testing module",
        "lang_id": null,
        "lang_name": null,
        "file_id": "11",
        "file_name": "test",
        "file_path": "0/s/2/sd/",
        "file_size": "10 mb",
        "asset_type_id": "3",
        "file_type": "1",
        "img_height": "21kb",
        "img_width": "sa",
        "modified_date": "2018-10-25 12:32:58.434235",
        "entitydata": [
          {
            "priority": "1",
            "entity_role_map_id": "122",
            "name": "as",
            "is_linkable": "1",
            "is_visible": "1",
            "asset_id": "",
            "ent_disp_name": "as",
            "is_lang": "",
            "canonical": ""
          },
          {
            "priority": "2",
            "entity_role_map_id": "232",
            "name": "as",
            "is_linkable": "1",
            "is_visible": "1",
            "asset_id": "",
            "ent_disp_name": "as",
            "is_lang": "",
            "canonical": ""
          }
        ]
      }
    ],
    "img_id": "1",
    "img_name": "sa",
    "img_path": "dasd",
    "is_cover": 1,
    "description": "adad"
  }
}';
	-- p_result numeric :=1;
	-- p_data jsonb;
	*/
    v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
    v_json jsonb;
    v_download_id numeric;
    v_downloadguid text;
    v_title text;
    v_guid text;
    v_published_date timestamp without time zone;
    v_created_date  timestamp without time zone;
    v_modified_date  timestamp without time zone;
    v_is_trashed numeric;
    v_created_by numeric;
    v_edited_by numeric;
    v_version_number numeric :=1;
    v_status numeric;
    v_img_id numeric;
    v_img_name text;
    v_img_path text;
    v_desc text;
    v_is_cover numeric;
   -- draft--
    v_assetdraftid numeric;
    v_assetdraftguid varchar(1000);
   --draft--
    v_items_data                    json;
    v_items                         jsonb ;

   -- map table data-
    v_download_map_id numeric;
    v_map_title text;
    v_map_desc text;
    v_lang_id numeric;
    v_lang_name text;
	v_file_id numeric;
	v_file_name text;
	v_file_path text;
	v_file_size text;
	v_asset_type_id numeric;
	v_file_type numeric;
	v_img_height text;
	v_img_width text;
	v_map_modified_date timestamp without time zone;
	v_entity_data jsonb;
	v_counter numeric;
	v_assettypeid numeric :=27;
	v_canonical_url text;

	v_pubversionnumber numeric ;

	v_entityjson 		  json;
	v_entity 			  json;

	err_msg text;
	--p_result numeric;
	--p_data jsonb;
	v_error_check text;

	v_entityrolemapid numeric;
	v_priority numeric;
	v_islinkable numeric;
	v_isvisible numeric;
	v_assetentitymapid  numeric;
	v_assetentitymapguid text;
	v_image_path text;
	v_entity_name text;
	v_dow_is_active numeric;
	v_dow_is_deleted numeric;
begin

	select p_json->'data' into p_json;
	v_json:='{"data":'||p_json::json||'}';
	--v_json:=p_json;
     select v_json->'data'->>'download_id',
     	  	v_json->'data'->>'guid',
            v_json->'data'->>'title',
            v_json->'data'->>'published_date',
            v_json->'data'->>'created_date',
     	  	v_json->'data'->>'modified_date',
            v_json->'data'->>'is_trashed',
            v_json->'data'->>'created_by',
     	  	v_json->'data'->>'edited_by',
            v_json->'data'->>'status',
            v_json->'data'->>'img_id',
            v_json->'data'->>'img_name',
     	  	v_json->'data'->>'img_path',
            v_json->'data'->>'description',
            v_json->'data'->>'is_cover'

	into 	v_download_id,
     		v_downloadguid,
          	v_title,
			v_published_date,
			v_created_date,
			v_modified_date,
			v_is_trashed,
			v_created_by,
			v_edited_by,
			v_status,
			v_img_id,
			v_img_name,
			v_image_path,
			v_desc,
			v_is_cover;
      -- raise notice '% check ', v_created_by;

		v_published_date := coalesce(v_published_date,v_currenttimestamp);
		v_assetdraftid := nextval('labecn.seq_labecn_asset_draft_id');
		v_assetdraftguid := uuid_generate_v4();

     	if v_download_id is null then 
		 	v_download_id :=nextval('labecn.seq_labecn_download_master_id');
			v_guid := uuid_generate_v4();
			v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);
	      	v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);

			v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_currenttimestamp||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,download_id}', v_download_id::text::jsonb, true);

			-- select * from labecn.labecn_download_map;

			insert into labecn.labecn_download_master(download_master_id,title,description,is_cover,image_id,image_path,image_name,is_active,is_deleted,is_published,is_trashed,created_date,updated_date,published_date,download_guid,version_number,created_by,updated_by)
			values(v_download_id,v_title,v_desc,v_is_cover,v_img_id,v_image_path,v_img_name,1,0,v_status,0,v_currenttimestamp,v_currenttimestamp,v_published_date,v_guid,v_version_number,v_created_by,v_edited_by);

			  select v_json->'data'->>'items'
	       	  into   v_items_data; 
			  v_counter := 0;
				for v_items in select * from json_array_elements(v_items_data)
				loop
					select  v_items->>'download_map_id',
							v_items->>'title',
							v_items->>'desc',
							v_items->>'lang_id',
							v_items->>'lang_name',
							v_items->>'file_id',
							v_items->>'file_name',
							v_items->>'file_path',
							v_items->>'file_size',
							v_items->>'asset_type_id',
							v_items->>'file_type',
							v_items->>'img_height',
							v_items->>'img_width',
							v_items->>'is_deleted',
							v_items->>'is_active',
							--v_items->>'modified_date',
							v_items->>'entitydata'
					into 	v_download_map_id,
							v_map_title,
							v_map_desc,
							v_lang_id,
							v_lang_name,
							v_file_id,
							v_file_name,
							v_file_path,
							v_file_size,
							v_asset_type_id,
							v_file_type,
							v_img_height,
							v_img_width,
							v_dow_is_deleted,
							v_dow_is_active,
							--v_map_modified_date,
							v_entity_data ;

						 v_download_map_id :=nextval('labecn.seq_labecn_download_map_id');

						 insert into labecn.labecn_download_map
									(
									download_map_id,
									download_id,
									title,
									description,
									lang_id,
									file_id,
									file_name,
									file_size,
									file_type,
									created_date,
									updated_date,
									primary_ent_id,
									secondary_ent_id,
									is_deleted,
									is_active,
									img_height,
									img_width,
									file_path
									)
							values (
						       		v_download_map_id,
									v_download_id,
									v_map_title,
									v_map_desc,
									v_lang_id,
									v_file_id,
									v_file_name,
									v_file_size,
									v_file_type,
									v_currenttimestamp,
									v_currenttimestamp,
									null,
									null,
									v_dow_is_deleted,
									v_dow_is_active,
									v_img_height,
									v_img_width,
									v_file_path
									);

							v_json= jsonb_set(v_json,('{data,items,'||v_counter::text||',download_map_id}')::text[],
                                  ('"'||v_download_map_id||'"')::text::jsonb,true);
		                	v_counter:=v_counter+1;

						delete from labecn.labecn_asset_entity_map
						where asset_id=v_download_map_id
						and asset_type_id=v_assettypeid;
						for v_entity in select * from jsonb_array_elements(v_entity_data)
						loop	
							select  v_entity->>'entity_role_map_id', 
									v_entity->>'priority', 
				        			v_entity->>'is_linkable', 
									v_entity->>'is_visible',
									v_entity->>'canonical_url'
							into v_entityrolemapid, v_priority, v_islinkable, v_isvisible,v_canonical_url;
							
							v_canonical_url:=replace(v_canonical_url,'players','emojis');
							 v_assetentitymapid   := nextval('labecn.seq_labecn_asset_entity_map_id');
							v_assetentitymapguid := uuid_generate_v4();

							insert into labecn.labecn_asset_entity_map(asset_entity_map_id,asset_id,asset_type_id,entity_role_map_id,is_linkable,is_visible,priority,
                                                         created_date,updated_date,created_by,updated_by,is_active,is_deleted,is_published,aemap_guid)
							values(v_assetentitymapid,v_download_map_id,v_assettypeid,v_entityrolemapid,coalesce(v_islinkable,0),v_isvisible,
                           	v_priority,v_currenttimestamp,v_currenttimestamp,v_created_by,v_edited_by,1,0,1,v_assetentitymapguid);

							 select entity_name into v_entity_name
							 from labecn.labecn_entity_master a
							 join labecn.labecn_entity_role_map b on a.entity_master_id=b.entity_master_id
                             where entity_role_map_id=v_entityrolemapid;

							update labecn.labecn_download_map
                    		set    primary_ent_id 	 = case when v_priority = 1 then v_entityrolemapid else primary_ent_id end,
                    		secondary_ent_id = case when v_priority = 2 then v_entityrolemapid else secondary_ent_id end,
							primary_ent_name=case when v_priority = 1 then v_entity_name else primary_ent_name end,
							secondary_ent_name=case when v_priority = 2 then v_entity_name else secondary_ent_name end,
							pri_canonicle_url=case when v_priority = 1 then v_canonical_url else pri_canonicle_url end
							
							where  download_map_id 				     = v_download_map_id
           					;

							end loop;

						end loop;

			insert into labecn.labecn_asset_draft(asset_draft_id,
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
										 values(
												v_assetdraftid,
												v_download_id,
												v_assettypeid,
												v_version_number,
												v_json,
												v_currenttimestamp,
												v_currenttimestamp,
												v_created_by,
												v_edited_by,
												1,
												0,
                   								v_assetdraftguid
				   								);

		else 
			if v_status = 0 then
			   if v_is_trashed=0 then 
					select coalesce(max(version_number),1)
                	into   strict v_pubversionnumber
                	from   labecn.labecn_download_master
                	where  download_master_id = v_download_id;

					select max(version_number)
                	into   strict v_version_number
                	from   labecn.labecn_asset_draft
                	where  asset_type_id = v_assettypeid
                	and    asset_id      = v_download_id;

				  v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_currenttimestamp||'"')::text::jsonb, true);

			      if v_version_number > v_pubversionnumber then

					update labecn.labecn_asset_draft ad
                    set     asset_data        = v_json,
                    		updated_date     = v_currenttimestamp
					where  asset_id          = v_download_id
                    and    asset_type_id     = v_assettypeid
                    and    ad.version_number = (select max(ad1.version_number)
                                                from   labecn.labecn_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
				  else 

					v_version_number := v_version_number + 1;
					v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);

					insert into labecn.labecn_asset_draft(asset_draft_id,
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
										 values(
												v_assetdraftid,
												v_download_id,
												v_assettypeid,
												v_version_number,
												v_json,
												v_currenttimestamp,
												v_currenttimestamp,
												v_edited_by,
												v_edited_by,
												1,
												0,
                   								v_assetdraftguid
				   								);

				  end if;
				else 
					update labecn.labecn_download_master
                	set    is_published  = v_status,
                			is_trashed   = 1,
                        	updated_date = v_currenttimestamp

				where  download_master_id    = v_download_id;

                update labecn.labecn_asset_draft ad
                set    asset_data         = v_json,
                		updated_date      = v_currenttimestamp
				where  asset_id           = v_download_id
		               and    asset_type_id      = v_assettypeid
                     and    ad.version_number  = (select max(ad1.version_number)
                                             from  labecn.labecn_asset_draft ad1
                                             where  ad1.asset_id = ad.asset_id
                                             and ad1.asset_type_id = ad.asset_type_id);

			   end if;

	else 

			select max(version_number)
            into   strict v_version_number
            from   labecn.labecn_asset_draft
            where  asset_type_id = v_assettypeid
            and    asset_id      = v_download_id;

	        v_version_number := v_version_number + 1;

			v_json := jsonb_set(v_json, '{data,modified_date}', ('"'||v_currenttimestamp||'"')::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,version_number}', v_version_number::text::jsonb, true);

			update labecn.labecn_download_master
			set title=v_title,
				description=v_desc,
				is_cover=v_is_cover,
				image_id=v_img_id,
				image_path=v_image_path,
				image_name=v_img_name,
				is_published=v_status,
				is_trashed=v_is_trashed,
				version_number=v_version_number,
				updated_by=v_edited_by,
				updated_date=v_modified_date
			where download_master_id=v_download_id;

			select v_json->'data'->>'items'
	       	  into   v_items_data; 
			  v_counter := 0;
			for v_items in select * from json_array_elements(v_items_data)
				loop
					select  v_items->>'download_map_id',
							v_items->>'title',
							v_items->>'desc',
							v_items->>'lang_id',
							v_items->>'lang_name',
							v_items->>'file_id',
							v_items->>'file_name',
							v_items->>'file_path',
							v_items->>'file_size',
							v_items->>'asset_type_id',
							v_items->>'file_type',
							v_items->>'img_height',
							v_items->>'img_width',
							v_items->>'is_deleted',
							v_items->>'is_active',
							--v_items->>'modified_date',
							v_items->>'entitydata'
					into 	v_download_map_id,
							v_map_title,
							v_map_desc,
							v_lang_id,
							v_lang_name,
							v_file_id,
							v_file_name,
							v_file_path,
							v_file_size,
							v_asset_type_id,
							v_file_type,
							v_img_height,
							v_img_width,
							v_dow_is_deleted,
							v_dow_is_active,
							--v_map_modified_date,
							v_entity_data ;

							--raise notice '% che`ck download id',v_download_map_id;

						if v_download_map_id is null then 
						v_download_map_id :=nextval('labecn.seq_labecn_download_map_id');
						 insert into labecn.labecn_download_map
									(
									download_map_id,
									download_id,
									title,
									description,
									lang_id,
									file_id,
									file_name,
									file_size,
									file_type,
									created_date,
									updated_date,
									primary_ent_id,
									secondary_ent_id,
									is_deleted,
									is_active,
									img_height,
									img_width,
									file_path
									)
							values (
						       		v_download_map_id,
									v_download_id,
									v_map_title,
									v_map_desc,
									v_lang_id,
									v_file_id,
									v_file_name,
									v_file_size,
									v_file_type,
									v_currenttimestamp,
									v_currenttimestamp,
									null,
									null,
									v_dow_is_deleted,
									v_dow_is_active,
									v_img_height,
									v_img_width,
									v_file_path
									);
				v_json= jsonb_set(v_json,('{data,items,'||v_counter::text||',download_map_id}')::text[],
                                  ('"'||v_download_map_id||'"')::text::jsonb,true);
			--	v_json=jsonb_set(v_json, '{data,items}'::text[], v_json->'data'->'is_deleted'->'items' #- '{1}'::jsonb	);	

						else 

						update labecn.labecn_download_map
						set title=v_map_title,
							description=v_map_desc,
							lang_id=v_lang_id,
							file_id=v_file_id,
							file_name=v_file_name,
							file_size=v_file_size,
							file_type=v_file_type,
							updated_date=v_currenttimestamp,
							primary_ent_id=null,
							secondary_ent_id=null,
							is_active=v_dow_is_active,
							is_deleted=v_dow_is_deleted,
							img_height=v_img_height,
							img_width=v_img_width

						where download_map_id= v_download_map_id;

				-- if v_dow_is_deleted=0 then 
                --   select v_json #- '{data,items,'||v_counter||'}' 
				--   into v_json;
				-- end if			;
						end if;	

		                v_counter:=v_counter+1;

						delete from labecn.labecn_asset_entity_map
						where asset_id=v_download_map_id
						and asset_type_id=v_assettypeid;
						for v_entity in select * from jsonb_array_elements(v_entity_data)
						loop	
							select  v_entity->>'entity_role_map_id', 
									v_entity->>'priority', 
				        			v_entity->>'is_linkable', 
									v_entity->>'is_visible',
									v_entity->>'canonical_url'
							into v_entityrolemapid, v_priority, v_islinkable, v_isvisible,v_canonical_url;
							
							  v_canonical_url:=replace(v_canonical_url,'players','emojis');
							  v_assetentitymapid   := nextval('labecn.seq_labecn_asset_entity_map_id');
							  v_assetentitymapguid := uuid_generate_v4();

							insert into labecn.labecn_asset_entity_map(asset_entity_map_id,asset_id,asset_type_id,entity_role_map_id,is_linkable,is_visible,priority,
                                                         created_date,updated_date,created_by,updated_by,is_active,is_deleted,is_published,aemap_guid)
							values(v_assetentitymapid,v_download_map_id,v_assettypeid,v_entityrolemapid,coalesce(v_islinkable,0),v_isvisible,
                           	v_priority,v_currenttimestamp,v_currenttimestamp,v_created_by,v_edited_by,1,0,1,v_assetentitymapguid);

							select entity_name into v_entity_name
							 from labecn.labecn_entity_master a
							 join labecn.labecn_entity_role_map b on a.entity_master_id=b.entity_master_id
                             where entity_role_map_id=v_entityrolemapid;

							update labecn.labecn_download_map
                    		set    primary_ent_id 	 = case when v_priority = 1 then v_entityrolemapid else primary_ent_id end,
                    		secondary_ent_id = case when v_priority = 2 then v_entityrolemapid else secondary_ent_id end,
							primary_ent_name=case when v_priority = 1 then v_entity_name else primary_ent_name end,
							secondary_ent_name=case when v_priority = 2 then v_entity_name else secondary_ent_name end,
							pri_canonicle_url=case when v_priority = 1 then v_canonical_url else pri_canonicle_url end
							where  download_map_id 				     = v_download_map_id
           					;

						end loop;	

				end loop;

			insert into labecn.labecn_asset_draft(asset_draft_id,
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
										 values(
												v_assetdraftid,
												v_download_id,
												v_assettypeid,
												v_version_number,
												v_json,
												v_currenttimestamp,
												v_currenttimestamp,
												v_edited_by,
												v_edited_by,
												1,
												0,
                   								v_assetdraftguid
				   								);

	end if;

	end if ;

p_result=1;
p_data=v_json;

exception 
    when others then
	    --err_code := SQLSTATE;
        get stacked diagnostics 
		v_error_check =pg_exception_context;
         err_msg := SQLERRM;
		  p_result := -1;
		  p_data := '{"Error_message" :"'||coalesce(err_msg||'-'||v_error_check, '')||'"}';  

end;

$_$;


--
