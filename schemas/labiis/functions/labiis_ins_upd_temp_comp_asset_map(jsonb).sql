-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_ins_upd_temp_comp_asset_map(jsonb)
-- Type: FUNCTION

-- Name: labiis_ins_upd_temp_comp_asset_map(jsonb); Type: FUNCTION; Schema: labiis; Owner: -
--

CREATE FUNCTION labiis.labiis_ins_upd_temp_comp_asset_map(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

 --do
-- $$
declare
/*	p_json jsonb := '{
    "data": {
        "count": null,
        "status": "1",
        "version_number": "13",
        "entity_role_map_id": null,
        "updated_by": "1",
        "template_component_map_id": "6",
        "published_date": "0001-01-01 00:00:00",
        "asset_map": [
            {
                "asset_id": null,
                "total_assets": null,
                "author": null,
                "entitydata": [
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "English",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "0",
                        "priority": "0",
                        "entity_role_map_id": "4",
                        "canonical": null
                    },
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "Mi in the media",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "1",
                        "priority": "1",
                        "entity_role_map_id": "23",
                        "canonical": null
                    },
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "Match bulletin",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "1",
                        "priority": "2",
                        "entity_role_map_id": "21",
                        "canonical": null
                    }
                ],
                "publish_date": null,
                "asset_meta": {
                    "asset_id": null,
                    "image_path": "40/4b/fe/0/",
                    "title": "Ishan Kishan slams joint-fastest fifty for MI",
                    "url": "javascript:void(0)",
                    "mob_image_id": null,
                    "mob_image_path": null,
                    "title_alias": null,
                    "image_name": "gfZ6ArcMZI.jpg",
                    "image_id": "14721",
                    "video_embed": "",
                    "content_type": null,
                    "responsive": 1,
                    "score_wicket": null,
                    "mob_image_name": null,
                    "desc": "Lights up Eden Gardens, smacks Kuldeep for four sixes on the trat"
                },
                "asset_type": "12",
                "asset_order": "1"
            },
            {
                "asset_id": null,
                "total_assets": null,
                "author": null,
                "entitydata": [
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "English",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "0",
                        "priority": "0",
                        "entity_role_map_id": "4",
                        "canonical": null
                    },
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "Mi in the media",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "1",
                        "priority": "1",
                        "entity_role_map_id": "23",
                        "canonical": null
                    },
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "Match preview",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "1",
                        "priority": "2",
                        "entity_role_map_id": "22",
                        "canonical": null
                    }
                ],
                "publish_date": null,
                "asset_meta": {
                    "asset_id": null,
                    "image_path": "81/47/79/0/",
                    "title": "Mayank Markande: Turning Heads with his leg breaks",
                    "url": "javascript:void(0)",
                    "mob_image_id": null,
                    "mob_image_path": null,
                    "title_alias": null,
                    "image_name": "U49E2N5v42.jpg",
                    "image_id": "14761",
                    "video_embed": "",
                    "content_type": null,
                    "responsive": 1,
                    "score_wicket": null,
                    "mob_image_name": null,
                    "desc": "The leggie bags Dhoni, Rayadu and Raina on debut"
                },
                "asset_type": "12",
                "asset_order": "2"
            },
            {
                "asset_id": null,
                "total_assets": null,
                "author": null,
                "entitydata": [
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "English",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "0",
                        "priority": "0",
                        "entity_role_map_id": "4",
                        "canonical": null
                    },
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "Live videos",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "1",
                        "priority": "1",
                        "entity_role_map_id": "52",
                        "canonical": null
                    },
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "Videos",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "1",
                        "priority": "0",
                        "entity_role_map_id": "3",
                        "canonical": null
                    }
                ],
                "publish_date": null,
                "asset_meta": {
                    "asset_id": null,
                    "image_path": "f9/84/5d/0/",
                    "title": "Test Video",
                    "url": "https://youtu.be/BZO_Iy6Dxys",
                    "mob_image_id": null,
                    "mob_image_path": null,
                    "title_alias": null,
                    "image_name": "swqJnZoLjB.jpg",
                    "image_id": "21241",
                    "video_embed": "",
                    "content_type": null,
                    "responsive": 0,
                    "score_wicket": null,
                    "mob_image_name": null,
                    "desc": "Test Video"
                },
                "asset_type": "12",
                "asset_order": "3"
            },
            {
                "asset_id": "4501",
                "total_assets": null,
                "author": null,
                "entitydata": [
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "Cricket",
                        "ent_disp_name": null,
                        "is_lang": "0",
                        "is_linkable": "1",
                        "priority": "1",
                        "entity_role_map_id": "26",
                        "canonical": null
                    },
                    {
                        "asset_id": "4501",
                        "is_visible": "0",
                        "name": "English",
                        "ent_disp_name": null,
                        "is_lang": null,
                        "is_linkable": "0",
                        "priority": "0",
                        "entity_role_map_id": "4",
                        "canonical": null
                    },
                    {
                        "asset_id": null,
                        "is_visible": "0",
                        "name": "Videos",
                        "ent_disp_name": null,
                        "is_lang": "0",
                        "is_linkable": "1",
                        "priority": "2",
                        "entity_role_map_id": "3",
                        "canonical": null
                    }
                ],
                "publish_date": null,
                "asset_meta": {
                    "asset_id": "4501",
                    "image_path": "e8/a1/b2/0/",
                    "title": "test video this is test",
                    "url": "/videos/cricket/test-video",
                    "mob_image_id": null,
                    "mob_image_path": null,
                    "title_alias": "test-video",
                    "image_name": "WY50QpOvWw.jpg",
                    "image_id": "21261",
                    "video_embed": "",
                    "content_type": "4",
                    "responsive": 0,
                    "score_wicket": null,
                    "mob_image_name": null,
                    "desc": "test video this is test"
                },
                "asset_type": "12",
                "asset_order": "4"
            }
        ],
        "guid": null,
        "is_trashed": "0"
    }
}';
	p_result numeric;
	p_data jsonb;
	*/
	v_json jsonb;
	v_currenttimestamp timestamp;
	v_template_component_map_id numeric;
	v_status numeric;
	v_trashed numeric;
	v_published_date timestamp;
	v_asset_draft_id numeric;
	v_assetdraftguid varchar(256);
	v_asset_guid1 varchar(256);
	v_asset_type_id numeric := 8;
	v_versionnumber numeric := 1;
	v_updated_by numeric;
	v_template_asset_component_map_id numeric;
	v_asset_map_json json;
	v_assetdata json;
	v_asset_order numeric;
	v_asset_type numeric;
	v_asset_id numeric;
	v_asset_meta jsonb;
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
	v_isvisible numeric;
	v_counter numeric := 0;
  	v_set_data text[];
  	v_ent_json jsonb;
	v_asset_map_json_data jsonb;
   	v_max_version_number numeric;
   	v_showcase_exists numeric;
	v_ispublished numeric;
	v_error_check text;
    err_msg text;
	p_schema_prefix text := 'labiis';
    v_ext_id numeric;
	v_ext_type numeric;
	v_id text;
	v_type text;
	v_url text;
    
begin
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
    execute 'select  nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_draft_id'')' into v_asset_draft_id ;
  
    select p_json->'data' into p_json;
	v_json:='{"data":'||p_json::json||'}';
	
	select v_json->'data'->>'template_component_map_id', 
	       v_json->'data'->>'status', v_json->'data'->>'is_trashed',
		   v_json->'data'->>'updated_by',
    	   v_json->'data'->>'published_date'
	into v_template_component_map_id, v_status, v_trashed, v_updated_by, v_published_date;
   
    v_published_date := coalesce(v_published_date, v_currenttimestamp);
    v_assetdraftguid := uuid_generate_v4();
    execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map where template_component_map_id = $1'
	into v_showcase_exists
    using v_template_component_map_id;
    if v_showcase_exists = 0 then
		execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data,
        			created_date, updated_date, created_by, updated_by, is_active, is_deleted,asset_draft_guid)
				values($2, $3, $4, $5, $6, $7, $8, $9, $10, 1, 0, $11)'
		using p_schema_prefix, v_asset_draft_id, v_template_component_map_id, v_asset_type_id, v_versionnumber, v_json, v_currenttimestamp,
        		v_currenttimestamp, v_updated_by, v_updated_by, v_assetdraftguid;
		select v_json->'data'->>'asset_map' into v_asset_map_json;
		if v_asset_map_json is not null then
    		v_counter := 0;
        	for v_assetdata in select * from json_array_elements(v_asset_map_json)
        	loop
        		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_template_component_asset_map_id'')'
            	into v_template_asset_component_map_id;
            	v_asset_guid1 := uuid_generate_v4();
            	select 	v_assetdata->>'asset_order', 
						v_assetdata->>'asset_type', 
						v_assetdata->>'asset_id', 
						v_assetdata->'asset_meta'
            	into v_asset_order, v_asset_type, v_asset_id, v_asset_meta;
            	
				
					-- raise notice 'v_asset_meta %',v_asset_meta;
					select v_asset_meta->>'asset_id',
					v_asset_meta->>'content_type'
					into v_id,v_type;
						 -- raise notice 'v_id %,v_type %',v_id,v_type;
						if v_type::numeric =4 then 
						-- raise notice 'v_asset_meta %',1;
						execute 'select video_url from '||p_schema_prefix||'.'||p_schema_prefix||'_video
						         where video_id='||v_id::numeric into v_url ;
					   v_asset_meta := jsonb_set(v_asset_meta, '{url}', ('"'||coalesce(v_url,'')||'"')::text::jsonb, true);	
						raise notice 'v_asset_meta %',v_asset_meta;
						end if ;
						
						
				if v_asset_type = 12 then
				
            		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_template_externalasset_id'')' into v_ext_asset_id;
                	execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map(template_component_asset_map_id,
                    			template_component_map_id, asset_order, asset_id, asset_type_id, asset_meta, show_in_web, show_in_mobile, show_in_app,
                                published_version_number, is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                is_published, published_date, asset_guid)
							values($1, $2, $3, $4, $5, $6, 1, 1, 1, $7, $8, $9, $9, $10, $10, 1, 0, $11, $12, $13)'
					using v_template_asset_component_map_id, v_template_component_map_id, v_asset_order, v_ext_asset_id, v_asset_type, v_asset_meta,
                    		v_versionnumber, v_trashed, v_currenttimestamp, v_updated_by, v_status, v_published_date, v_asset_guid1;
					
					v_set_data := string_to_array('data,asset_map,'||v_counter::text||',asset_id',',');
                	
					v_counter := v_counter + 1;
					
                	v_json := jsonb_set(to_jsonb(v_json), v_set_data, v_ext_asset_id::text::jsonb, false);
                	
					select v_asset_meta->>'asset_id',
					      v_asset_meta->>'content_type'
					into v_ext_id, v_ext_type;
					
					if (v_ext_id is null and v_ext_type is null) then
                		select v_assetdata->>'entitydata' into v_entityjson;
                    	if v_entityjson is not null then
                    		for v_entity in select * from json_array_elements(v_entityjson)
                        	loop
			              		select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
								into v_entityrolemapid, v_priority, v_islinkable, v_isvisible;
								v_assetentitymapid := nextval('labiis.seq_labiis_asset_entity_map_id');
                            	v_assetentitymapguid := uuid_generate_v4();
                            	insert into labiis.labiis_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable,
                                                                     is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                                                                     is_deleted, is_published, aemap_guid)
								values(v_assetentitymapid, v_ext_asset_id, v_asset_type, v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible,
                                       v_priority, v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0, 1, v_assetentitymapguid);
							end loop;
						end if;
					end if;     
				end if;
			end loop;
        	execute 'select max(version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft where asset_type_id = $1
            			and asset_id = $2'
			into strict v_max_version_number
        	using v_asset_type_id, v_template_component_map_id;
        	v_json := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(V_max_version_number,1)||'"')::text::jsonb, true);
        	execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
            			set asset_data = $5, updated_date = $4, updated_by = $3
                    	where asset_id = $2
                    	and asset_type_id = $1
                    	and ad.version_number = (select max(ad1.version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad1
                        							where ad1.asset_id = ad.asset_id
                                                	and ad1.asset_type_id = ad.asset_type_id)'
			using v_asset_type_id, v_template_component_map_id, v_updated_by, v_currenttimestamp, v_json;
		end if;
	else
    	if v_status = 0 then
        	if v_trashed = 0 then
            	execute 'select max(version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft
                			where asset_type_id = $1 and asset_id = $2'
				into strict v_versionnumber
                using v_asset_type_id, v_template_component_map_id;
                execute 'select distinct coalesce(published_version_number, 1), is_published
                			from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map
                            where template_component_map_id = $1'
				into strict v_pubversionnumber, v_ispublished
                using v_template_component_map_id;
                if ((v_versionnumber = v_pubversionnumber and v_ispublished = 0) or (v_versionnumber > v_pubversionnumber)) then
                	execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad
                    			set asset_data = $2, updated_date = $3
								where asset_id = $4 and asset_type_id = $5
								and ad.version_number = (select max(ad1.version_number) from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft ad1
                                							where ad1.asset_id = ad.asset_id and ad1.asset_type_id = ad.asset_type_id)'
					using null, v_json, v_currenttimestamp, v_template_component_map_id, v_asset_type_id;
				else
                	v_versionnumber := v_versionnumber + 1;
					execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data,
                    			created_date, updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
							values($2, $3, $4, $5, $6, $7, $8, $9, $10, 1, 0, $10)'
					using null, v_asset_draft_id, v_template_component_map_id, v_asset_type_id, v_versionnumber, v_json, v_currenttimestamp,
                    		v_currenttimestamp, v_updated_by, v_updated_by, v_assetdraftguid;
				end if;
			else
            	execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map
                			set is_published = $1, is_trashed = 1, updated_date = $2
                            where template_component_map_id = $3'
				using v_status, v_currenttimestamp, v_template_component_map_id;
			end if;
		else
    		execute 'select max(version_number)	from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft
            			where asset_type_id = $1 and asset_id = $2'
			into strict v_versionnumber
        	using v_asset_type_id, v_template_component_map_id;
        	v_versionnumber := v_versionnumber + 1;
        	v_json := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(v_versionnumber,1)||'"')::text::jsonb, true);
        	execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number,
            		asset_data, created_date, updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
					values($2, $3, $4, $5, $6, $7, $8, $9, $10, 1, 0, $11)'
			using null, v_asset_draft_id, v_template_component_map_id, v_asset_type_id, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp,
            		v_updated_by, v_updated_by, v_assetdraftguid;
			execute 'delete from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map where template_component_map_id = $1'
			using v_template_component_map_id;
        	select v_json->'data'->>'asset_map' into v_asset_map_json;
        	if v_asset_map_json is not null then
        		v_counter := 0;
            	for v_assetdata in select * from json_array_elements(v_asset_map_json)
            	loop
			    	execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_template_component_asset_map_id'')'
                	into v_template_asset_component_map_id;
					v_asset_guid1 := uuid_generate_v4();
					
					select v_assetdata->>'asset_order', v_assetdata->>'asset_type', v_assetdata->>'asset_id', v_assetdata->'asset_meta'
                	into v_asset_order, v_asset_type, v_asset_id, v_asset_meta;
					
					-- raise notice 'v_asset_meta %',v_asset_meta;
					select v_asset_meta->>'asset_id',
					v_asset_meta->>'content_type'
					into v_id,v_type;
						 -- raise notice 'v_id %,v_type %',v_id,v_type;
						/*if v_type::numeric =4 then 
						-- raise notice 'v_asset_meta %',1;
						execute 'select video_url from '||p_schema_prefix||'.'||p_schema_prefix||'_video
						         where video_id='||v_id::numeric into v_url ;
					   v_asset_meta := jsonb_set(v_asset_meta, '{url}', ('"'||coalesce(v_url,'')||'"')::text::jsonb, true);	
						raise notice 'v_asset_meta %',v_asset_meta;
						end if ;*/
						
						
					if v_asset_type = 12 then
                		execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_template_externalasset_id'')' into v_ext_asset_id;
				   		execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map (template_component_asset_map_id,
                        			template_component_map_id, asset_order, asset_id, asset_type_id, asset_meta,show_in_web, show_in_mobile, show_in_app,
                                	published_version_number, is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                	is_published, published_date, asset_guid)
								values($1, $2, $3, $4, $5, $6, 1, 1, 1, $7, $8, $9, $9, $10, $10, 1, 0, $11, $12, $13)'
						using v_template_asset_component_map_id, v_template_component_map_id, v_asset_order, v_ext_asset_id, v_asset_type, v_asset_meta,
                        		v_versionnumber, v_trashed, v_currenttimestamp, v_updated_by, v_status, v_published_date, v_asset_guid1;
						v_set_data := string_to_array('data,asset_map,'||v_counter::text||',asset_id',',');
				    	v_counter := v_counter + 1;
				    	v_json := jsonb_set(to_jsonb(v_json), v_set_data, v_ext_asset_id::text::jsonb, false);
				   		select v_asset_meta->>'asset_id', v_asset_meta->>'content_type' into v_ext_id, v_ext_type;
						if (v_ext_id is null and v_ext_type is null) then
							select v_assetdata->>'entitydata' into v_entityjson;
                        	if v_entityjson is not null then
					     		for v_entity in select * from json_array_elements(v_entityjson)
					  			loop
                            		select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
									into v_entityrolemapid, v_priority, v_islinkable, v_isvisible;
									v_assetentitymapid := nextval('labiis.seq_labiis_asset_entity_map_id');
                                	v_assetentitymapguid := uuid_generate_v4();
                                	insert into labiis.labiis_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable,
                                                                         is_visible, priority, created_date, updated_date, created_by, updated_by,
                                                                         is_active, is_deleted, is_published, aemap_guid)
									values(v_assetentitymapid, v_ext_asset_id, v_asset_type, v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible,
                                           v_priority, v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0, 1, v_assetentitymapguid);
								end loop;
							end if;
						end if;
			 		end if;
				end loop;
			end if;
    	end if;
	end if;
	p_data := v_json;
    p_result := 1;
    
exception
	when others then
    	get stacked diagnostics
        v_error_check = pg_exception_context;
        err_msg := SQLERRM;
        p_result := -1;
        p_data := '{"data":{"message" :"'||coalesce(err_msg||'-'||v_error_check, '')||'" ,"result":"'||coalesce(p_result, 0)||'"}}';
	
end;

$_$;


--
