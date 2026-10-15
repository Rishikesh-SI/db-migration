-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_ins_duplicate_page(jsonb)
-- Type: FUNCTION

-- Name: labfih_ins_duplicate_page(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_ins_duplicate_page(p_input jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
/*p_input jsonb := '{
  "data": {
    "ref_page_id": 81,
    "title": "News Duplicate",
    "title_mobile": "News Duplicate",
    "title_app": "News Duplicate",
    "title_alias": "news_duplicate",
    "seo_title": "abc",
    "seo_desc": "New Page",
    "canonical_url": "news_duplicate",
    "template_name": "News Duplicate"
  }
}';*/
v_ref_page_id numeric;
v_title character varying;
v_title_alias character varying;
v_template_name character varying;
v_page_id numeric;
v_page_guid character varying;
v_sysdate timestamp;
V_template_id numeric;
v_template_id1 numeric;
v_parent_id numeric;
i record;
v_parent_tcmap_id numeric;
v_position_entity numeric;
v_ad_id numeric ;
v_published_version_number numeric ;
v_ad_json jsonb;
v_entity_master_id numeric;
v_entity_role_map_id numeric;
v_json jsonb;
v_title_mob character varying;
v_title_app character varying;
v_seo_title character varying;
v_seo_desc character varying;
v_canonical_url character varying;
v_metainfo jsonb;
v_required_entities numeric[];
begin
	select p_input->'data'->>'ref_page_id',
		   p_input->'data'->>'title',
		   p_input->'data'->>'alias',
		   p_input->'data'->>'template_name',
		   p_input->'data'->>'title_mobile',
		   p_input->'data'->>'title_app',
		   p_input->'data'->>'seo_title',
		   p_input->'data'->>'seo_desc',
		   p_input->'data'->>'canonical_url'		   	   
	into  v_ref_page_id,
	      v_title,
		  v_title_alias,
		  v_template_name,
		  v_title_mob,
		  v_title_app,
		  v_seo_title,
		  v_seo_desc,
		  v_canonical_url;
	
    	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'ins_page_duplicate',
	'{"exception":""}',uuid_generate_v4(),p_input,current_timestamp,'labfih','db-error');

		  
		 if not exists( select 1 from labfih.labfih_page where alias = v_title_alias ) then
		 
			 v_title_mob := coalesce(v_title_mob,v_title);
			 v_title_app := coalesce(v_title_app,v_title);
			 v_canonical_url := coalesce(v_canonical_url,v_title_alias);

			select current_timestamp at time zone 'utc'
			into   v_sysdate;
			v_page_guid    	 := uuid_generate_v4();	
			v_page_id        := nextval('labfih.seq_labfih_page_id');

			insert into labfih.labfih_page
			select  v_page_id,v_title_alias,v_title,page_level, upfront, upfront_app,
					upfront_mobile, is_wrapper, parent_id,visible, visible_app, visible_mobile,scheduled_publish,
					scheduled_unpublish,ordering,v_title_mob,v_title_app,is_redirect,1,
					v_sysdate,v_sysdate,created_by,updated_by,is_active,is_deleted,
					is_published,v_page_guid,asset_type_id,breadcrumbs,is_custom_menu,is_amp,show_in_sitemap,
					is_protected,meta_info,required_entities
			from labfih.labfih_page
			where page_id = v_ref_page_id;

			insert into labfih.labfih_asset_list
			select nextval('labfih.seq_labfih_asset_list_id'),v_page_id,11,v_title,v_title_alias,author_id,
				   short_desc,tags,primary_entity_role_map_id,secondary_entity_role_map_id,
				   total_assets,image_file_name,image_path,duration,show_in_web,show_in_mobile,
				   show_in_app,published_version_number,is_trashed,v_sysdate,v_sysdate,
				   created_by,updated_by,is_active,is_deleted,is_published,v_sysdate,
				   uuid_generate_v4(),show_copyright,order_number,short_title,language_id,web_detail_jsn,language_url,
				   web_listing_json,tagged_entity
			from labfih.labfih_asset_list
			where asset_id = v_ref_page_id and asset_type_id = 11 ;

			insert into labfih.labfih_asset_entity_map
			select  nextval('labfih.seq_labfih_asset_entity_map_id'),v_page_id,11,entity_role_map_id,is_linkable,
					is_visible, priority, v_sysdate, v_sysdate, created_by, updated_by, is_active,
					is_deleted, is_published, uuid_generate_v4(),is_required,order_number
			from labfih.labfih_asset_entity_map
			where asset_id = v_ref_page_id and asset_type_id = 11 ;

			insert into labfih.labfih_seo_data
			select nextval('labfih.seq_labfih_seo_data_id'),v_page_id,11,meta_info,
				  1,v_sysdate,v_sysdate,created_by,updated_by,is_active,is_deleted,is_published,uuid_generate_v4()
			from labfih.labfih_seo_data
			where asset_id = v_ref_page_id and asset_type_id = 11 ;

			select meta_info into v_metainfo from labfih.labfih_seo_data
			where asset_id = v_page_id and asset_type_id = 11 ;

			v_metainfo := jsonb_set(v_metainfo, '{browser_title}', ('"'||v_seo_title||'"')::text::jsonb, true);
			v_metainfo := jsonb_set(v_metainfo, '{meta_desc}', ('"'||v_seo_desc||'"')::text::jsonb, true);
			v_metainfo := jsonb_set(v_metainfo, '{canonical_url}', ('"'||v_canonical_url||'"')::text::jsonb, true);

			update labfih.labfih_seo_data
			set meta_info = v_metainfo
			where asset_id = v_page_id and asset_type_id = 11 ;

			select template_id,parent_id into
				   v_template_id,v_parent_id
			from labfih.labfih_template
			where page_id = v_ref_page_id ;

			--V_template_guid    := uuid_generate_v4();	
			v_template_id1      := nextval('labfih.seq_labfih_template_id');

			insert into labfih.labfih_template
			select v_template_id1,page_id,v_template_name,v_template_name,layout_id, 
				   is_inherited,parent_id,1,v_sysdate,v_sysdate,
				   created_by,updated_by,is_active,is_deleted,is_published,uuid_generate_v4(),is_master, 
				   template_html,is_responsive,mobile_html,use_default_bg_color,use_default_bg_image,
				   bg_color,bg_image_id 
			from labfih.labfih_template
			where template_id = v_parent_id ;

			insert into labfih.labfih_template
			select nextval('labfih.seq_labfih_template_id'),v_page_id,v_template_name,v_template_name,layout_id, 
				   is_inherited,v_template_id1,1,v_sysdate,v_sysdate,
				   created_by,updated_by,is_active,is_deleted,is_published,uuid_generate_v4(),is_master, 
				   template_html,is_responsive,mobile_html,use_default_bg_color,use_default_bg_image,
				   bg_color,bg_image_id 
			from labfih.labfih_template
			where template_id = v_template_id ;

			for i in select * from labfih.labfih_template_component_map
					 where template_id = v_parent_id and is_active = 1
					order by coalesce(parent_tcmap_id,0)
			loop

					if i.parent_tcmap_id is not null then

						select template_component_map_id into v_parent_tcmap_id  
						from labfih.labfih_template_component_map
						where tcmap_guid in(select tcmap_guid
											from labfih.labfih_template_component_map
											where template_component_map_id = i.parent_tcmap_id) 
											and template_id = v_template_id1 ;

					else

						v_parent_tcmap_id := null;

					end if;

					if i.component_id = 1 then
					  select entityid
					  into v_position_entity
					  from unnest(i.required_entities) u(entityid)
					  where entityid in(select erm.entity_role_map_id
							from labfih.labfih_entity_category ec
							join labfih.labfih_entity_role_map erm
							on erm.entity_role_id = ec.entity_role_id
							join labfih.labfih_entity_master em
							on em.entity_master_id = erm.entity_master_id
							where category_name = 'Ad Positions');

					select ad_id,published_version_number
					into v_ad_id,v_published_version_number
					from labfih.labfih_advertisement
					where ad_position = v_position_entity;

					SELECT p_ad_json into v_ad_json from labfih.labfih_get_ad_detail(v_ad_id,v_published_version_number);

					v_entity_master_id := nextval('labfih.seq_labfih_entity_master_id');
					v_entity_role_map_id := nextval('labfih.seq_labfih_entity_role_map_id');

					Insert into labfih.labfih_entity_master (entity_master_id,waf_entity_master_id,client_id,entity_name,entity_display_name,canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name)
					values (v_entity_master_id,0,1,i.title||'-'||v_template_name,i.title||'-'||v_template_name,null,1,current_timestamp,current_timestamp,1,1,1,0,null,null,null,i.title||'-'||v_template_name,null,null,null,uuid_generate_v4(),i.title||'-'||v_template_name,i.title||'-'||v_template_name);

					Insert into labfih.labfih_entity_role_map (entity_role_map_id,entity_role_id,entity_master_id,priority,is_active,source_object_id,created_date,updated_date,hyperlink,tour_id)
					values(v_entity_role_map_id,9,v_entity_master_id,1,1,null,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0,null); 

					v_ad_json := jsonb_set(v_ad_json, '{data,ad_position}', ('"'||v_entity_role_map_id||'"')::text::jsonb, true);
					v_ad_json := jsonb_set(v_ad_json, '{data,ad_id}','null'::jsonb, true);
					v_ad_json := jsonb_set(v_ad_json, '{data,title}', ('"'||v_template_name||'"')::text::jsonb, true);
					
					v_required_entities := array_agg(v_entity_role_map_id);

					insert into labfih.labfih_template_component_map
					select nextval('labfih.seq_labfih_template_component_map_id'),v_template_id1,component_id, title, display_title,
						   title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
						   v_sysdate, v_sysdate, created_by, updated_by,is_active,is_deleted, is_published, 
						   tcmap_guid, v_parent_tcmap_id,meta_info,parent_container_id,menu_id,layout_info,is_protected,v_required_entities,
						   other_entities,exclude_entities
					from labfih.labfih_template_component_map	   
					where template_component_map_id = i.template_component_map_id;

						insert into labfih.labfih_asset_entity_map
						select nextval('labfih.seq_labfih_asset_entity_map_id'),currval('labfih.seq_labfih_template_component_map_id'), 13,  
								v_entity_role_map_id, is_linkable,is_visible, priority, v_sysdate, v_sysdate,
								created_by, updated_by, is_active,is_deleted, is_published,uuid_generate_v4(),is_required,order_number
						from labfih.labfih_asset_entity_map
						where asset_id = i.template_component_map_id and asset_type_id = 13;

						perform labfih.labfih_ins_upd_ad(v_ad_json);

					else

					insert into labfih.labfih_template_component_map
					select nextval('labfih.seq_labfih_template_component_map_id'),v_template_id1,component_id, title, display_title,
						   title_mobile, title_app,  show_in_web, show_in_mobile, show_in_app, fetch_from, 
						   v_sysdate, v_sysdate, created_by, updated_by,is_active,is_deleted, is_published, 
						   tcmap_guid, v_parent_tcmap_id,meta_info,parent_container_id,menu_id,layout_info,is_protected,required_entities,
						   other_entities,exclude_entities
					from labfih.labfih_template_component_map	   
					where template_component_map_id = i.template_component_map_id;

						insert into labfih.labfih_asset_entity_map
						select nextval('labfih.seq_labfih_asset_entity_map_id'),currval('labfih.seq_labfih_template_component_map_id'), 13,  
								entity_role_map_id, is_linkable,is_visible, priority, v_sysdate, v_sysdate,
								created_by, updated_by, is_active,is_deleted, is_published,uuid_generate_v4(),is_required,order_number
						from labfih.labfih_asset_entity_map
						where asset_id = i.template_component_map_id and asset_type_id = 13;

					end if;

			end loop;

			select ('{"data":'||row_to_json(row)||'}')::text into v_json
			from
			(
			select t.template_id, t.template_name, t.template_desc, t.published_version_number version_number, t.updated_by, t.is_published status,
				  t.template_guid as guid, t.is_master, t.layout_id, t.is_inherited, t.parent_id, t.template_html,t.is_responsive,
				  t.mobile_html, use_default_bg_color,use_default_bg_image , bg_color , bg_image_id ,
				  i1.image_path,i1.image_file_name,
				 ( select array_to_json(array_agg(a))
					from(
						select page_id
						from labfih.labfih_template
						where parent_id= v_template_id1
						and is_active=1
						and is_deleted=0
						and is_published=1
				)a) as pagedata,

				  (select array_to_json(array_agg(a)) componentdata
					   from(select *
							from   labfih.data(null::numeric,v_template_id1)
						   )a
					  )
			   from   labfih.labfih_template t
			   left join labfih.labfih_image i1 on i1.image_id=t.bg_image_id
			   where  t.template_id = v_template_id1
			   --  and t.is_published=1
			) as row;

			  insert into labfih.labfih_asset_draft
			  select nextval('labfih.seq_labfih_asset_draft_id'), 
			   v_template_id1, 13, 1, v_json, v_sysdate, v_sysdate,
			   1, 1, 1, 0, uuid_generate_v4();

			p_result := 1 ;
			
		else
		   
		   p_result := -1 ;
		
		end if;

	
end;

$$;


--
