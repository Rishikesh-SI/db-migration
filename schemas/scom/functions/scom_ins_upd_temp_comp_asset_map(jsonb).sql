-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_ins_upd_temp_comp_asset_map(jsonb)
-- Type: FUNCTION

-- Name: scom_ins_upd_temp_comp_asset_map(jsonb); Type: FUNCTION; Schema: scom; Owner: -
--

CREATE FUNCTION scom.scom_ins_upd_temp_comp_asset_map(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

-- do
-- $$
declare
	/*p_json jsonb := '{
  "data": {
    "count": null,
    "status": "1",
    "version_number": "972",
    "updated_by": "1",
    "template_component_map_id": "163859",
    "published_date": "2018-04-06 04:07:00",
    "asset_map": [
      {
        "asset_id": null,
        "total_assets": null,
        "author": null,
        "entitydata": [
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "indvswi",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "6908",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Asia Cup 2018",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "6901",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Facebook Instant Article",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "4551",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Cricket",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "1",
            "entity_role_map_id": "4572",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Virat Kohli",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "317",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "English",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "0",
            "priority": "0",
            "entity_role_map_id": "4571",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "News",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "2",
            "entity_role_map_id": "4554",
            "canonical": null
          }
        ],
        "publish_date": null,
        "asset_meta": {
          "asset_id": "64184",
          "image_path": "31/d1/57/0/",
          "title": "Virat Kohli not in favour of new 100-ball cricketing format",
          "url": "/en/news/virat-kohli-not-interested-for-new-100-ball-cricketing-format-64184",
          "title_alias": "virat-kohli-not-interested-for-new-100-ball-cricketing-format-64184",
          "image_name": "wKomGjJu2t.jpg",
          "image_id": "765089",
          "content_type": "1",
          "video_embed": "",
          "score_wicket": null,
          "desc": "The ECB''s new eight-team tournament is set to begin in 2020 and sees each side facing 15 six-ball overs, culminating in final 10 deliveries."
        },
        "asset_type": "12",
        "asset_order": "1"
      },
      {
        "asset_id": "25614",
        "total_assets": null,
        "author": null,
        "entitydata": [
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "IndVsEng",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "6896",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Facebook Instant Article",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "4551",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Cricket",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "1",
            "entity_role_map_id": "4572",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Jonny Bairstow",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "1822",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Mohammed Shami",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "758",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "English",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "0",
            "priority": "0",
            "entity_role_map_id": "4571",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "News",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "2",
            "entity_role_map_id": "4554",
            "canonical": null
          }
        ],
        "publish_date": null,
        "asset_meta": {
          "asset_id": "64180",
          "image_path": "5b/7c/72/0/",
          "title": "Shami reveals India''s master plan to tackle Jonny Bairstow in 4th Test",
          "url": "/en/news/eng-v-ind-shami-reveals-indias-master-plan-to-tackle-jonny-bairstow-in-4th-test-64180",
          "title_alias": "eng-v-ind-shami-reveals-indias-master-plan-to-tackle-jonny-bairstow-in-4th-test-64180",
          "image_name": "nqCPTwMe8Q.jpg",
          "image_id": "764500",
          "content_type": "1",
          "video_embed": "",
          "score_wicket": null,
          "desc": "Bairstow injured his finger during the second day of the Nottingham Test. However, the conditions are now better and he is looking forward to the next face-off."
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
            "name": "Cricket",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "1",
            "entity_role_map_id": "4572",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "English",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "0",
            "priority": "0",
            "entity_role_map_id": "4571",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "News",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "2",
            "entity_role_map_id": "4554",
            "canonical": null
          }
        ],
        "publish_date": null,
        "asset_meta": {
          "asset_id": null,
          "image_path": "00/9b/1a/0/",
          "title": "Score card",
          "url": "/media-pr/press-release/statement-from-procam-international",
          "title_alias": null,
          "image_name": "xmrYas0tqc.jpg",
          "image_id": "765485",
          "content_type": null,
          "video_embed": "",
          "score_wicket": null,
          "desc": "Score card"
        },
        "asset_type": "12",
        "asset_order": "3"
      },
      {
        "asset_id": null,
        "total_assets": null,
        "author": null,
        "entitydata": [
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "indvswi",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "6908",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Asia Cup 2018",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "6901",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "1",
            "name": "Cricket",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "0",
            "priority": "1",
            "entity_role_map_id": "4572",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "English",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "0",
            "priority": "0",
            "entity_role_map_id": "4571",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "1",
            "name": "Videos",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "0",
            "priority": "2",
            "entity_role_map_id": "4564",
            "canonical": null
          }
        ],
        "publish_date": null,
        "asset_meta": {
          "asset_id": "3996",
          "image_path": "16/d3/fc/0/",
          "title": "Morning Headlines ",
          "url": "/en/videos/morning-headlines-3-3996",
          "title_alias": "morning-headlines-3-3996",
          "image_name": "25e117bd6e65b0a5d6feb35e591eb00a.jpg",
          "image_id": "694106",
          "content_type": "4",
          "video_embed": "",
          "score_wicket": null,
          "desc": "Morning Headlines&nbsp;Indian skipper Virat Kohli has indicated that the team management might include two spinners in the playing XI for the second Test against at Lord&rsquo;s on Thursday.&nbsp;"
        },
        "asset_type": "12",
        "asset_order": "4"
      },
      {
        "asset_id": "25617",
        "total_assets": null,
        "author": null,
        "entitydata": [
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "David Warner",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "1360",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Steven Smith",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "1437",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "BBL",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "4618",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Australia",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "4515",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Facebook Instant Article",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "0",
            "entity_role_map_id": "4551",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Cricket",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "1",
            "entity_role_map_id": "4572",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "Hindi",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "0",
            "priority": "0",
            "entity_role_map_id": "4570",
            "canonical": null
          },
          {
            "asset_id": null,
            "is_visible": "0",
            "name": "News",
            "ent_disp_name": null,
            "is_lang": null,
            "is_linkable": "1",
            "priority": "2",
            "entity_role_map_id": "4554",
            "canonical": null
          }
        ],
        "publish_date": null,
        "asset_meta": {
          "asset_id": "63157",
          "image_path": "56/54/84/0/",
          "title": "?????-?????? ?? ??? ??? ????, ???? ????? ?? ???? ??? ?? ??????",
          "url": "/news/no-clearance-to-smith-david-warner-for-bbl-participation-63157",
          "title_alias": "no-clearance-to-smith-david-warner-for-bbl-participation-63157",
          "image_name": "LTRCeOdifC.jpg",
          "image_id": "608638",
          "content_type": "1",
          "video_embed": "",
          "score_wicket": null,
          "desc": "??? ????????? ????? ?? ??? ?? ???????????? ??????? ?? ??? ??? ??? ???????????? ??????? ??? ?? ????? ?????? ????? ????? ?? ????? ?????? ?? ??? ?? ?? ???? ??? ?? ??."
        },
        "asset_type": "12",
        "asset_order": "1"
      }
    ],
    "guid": null,
    "is_trashed": "0"
  }
}';
	p_result numeric;
	p_data jsonb;*/
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
	p_schema_prefix text := 'scom';
    v_ext_id numeric;
	v_ext_type numeric;
    
begin
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
    execute 'select  nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_asset_draft_id'')' into v_asset_draft_id ;
    select p_json->'data' into p_json;
	v_json:='{"data":'||p_json::json||'}';
	select v_json->'data'->>'template_component_map_id', v_json->'data'->>'status', v_json->'data'->>'is_trashed', v_json->'data'->>'updated_by',
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
            	select v_assetdata->>'asset_order', v_assetdata->>'asset_type', v_assetdata->>'asset_id', v_assetdata->'asset_meta'
            	into v_asset_order, v_asset_type, v_asset_id, v_asset_meta;
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
                	select v_asset_meta->>'asset_id', v_asset_meta->>'content_type' into v_ext_id, v_ext_type;
					if (v_ext_id is null and v_ext_type is null) then
                		select v_assetdata->>'entitydata' into v_entityjson;
                    	if v_entityjson is not null then
                    		for v_entity in select * from json_array_elements(v_entityjson)
                        	loop
			              		select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'is_linkable', v_entity->>'is_visible'
								into v_entityrolemapid, v_priority, v_islinkable, v_isvisible;
								v_assetentitymapid := nextval('scom.seq_scom_asset_entity_map_id');
                            	v_assetentitymapguid := uuid_generate_v4();
                            	insert into scom.scom_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable,
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
									v_assetentitymapid := nextval('scom.seq_scom_asset_entity_map_id');
                                	v_assetentitymapguid := uuid_generate_v4();
                                	insert into scom.scom_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable,
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
