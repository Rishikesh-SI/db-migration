-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_ins_upd_page(jsonb)
-- Type: FUNCTION

-- Name: labjdtest_ins_upd_page(jsonb); Type: FUNCTION; Schema: labjdtest; Owner: -
--

CREATE FUNCTION labjdtest.labjdtest_ins_upd_page(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 

v_page_id        				labJDTEST.labJDTEST_page.page_id%type;
v_alias        					labJDTEST.labJDTEST_page.alias%type;
v_title        					labJDTEST.labJDTEST_page.title%type;
v_page_level        			labJDTEST.labJDTEST_page.page_level%type;
v_upfront        				labJDTEST.labJDTEST_page.upfront%type;
v_upfront_app        			labJDTEST.labJDTEST_page.upfront_app%type;
v_upfront_mobile        		labJDTEST.labJDTEST_page.upfront_mobile%type;
v_is_wrapper        			labJDTEST.labJDTEST_page.is_wrapper%type;
v_page_parent_id        	    labJDTEST.labJDTEST_page.parent_id%type;
v_visible        				labJDTEST.labJDTEST_page.visible%type;
v_visible_app       	 		labJDTEST.labJDTEST_page.visible_app%type;
v_visible_mobile        		labJDTEST.labJDTEST_page.visible_mobile%type;
v_scheduled_publish        		labJDTEST.labJDTEST_page.scheduled_publish%type;
v_scheduled_unpublish        	labJDTEST.labJDTEST_page.scheduled_unpublish%type;
v_ordering        				labJDTEST.labJDTEST_page.ordering%type;
v_title_mobile        			labJDTEST.labJDTEST_page.title_mobile%type;
v_title_app        				labJDTEST.labJDTEST_page.title_app%type;
v_is_redirect        			labJDTEST.labJDTEST_page.is_redirect%type;
v_published_version_number      labJDTEST.labJDTEST_page.published_version_number%type;
v_created_date        			labJDTEST.labJDTEST_page.created_date%type;
v_updated_date        			labJDTEST.labJDTEST_page.updated_date%type;
v_created_by        			labJDTEST.labJDTEST_page.created_by%type;
v_updated_by        			labJDTEST.labJDTEST_page.updated_by%type;
v_is_active        				labJDTEST.labJDTEST_page.is_active%type;
v_is_deleted        			labJDTEST.labJDTEST_page.is_deleted%type;
v_status        			labJDTEST.labJDTEST_page.is_published%type;
v_page_guid        				labJDTEST.labJDTEST_page.page_guid%type;

v_template_id        			labJDTEST.labJDTEST_template.template_id%type;
v_template_name        			labJDTEST.labJDTEST_template.template_name%type;
v_template_desc        			labJDTEST.labJDTEST_template.template_desc%type;
v_layout_id        				labJDTEST.labJDTEST_template.layout_id%type;
v_is_inherited        			labJDTEST.labJDTEST_template.is_inherited%type;
v_template_parent_id            labJDTEST.labJDTEST_template.parent_id%type;
v_template_guid        			labJDTEST.labJDTEST_template.template_guid%type;
v_json							jsonb;
v_sysdate						timestamp;
v_is_responsive labJDTEST.labJDTEST_template.is_responsive%type;
v_mobile_html  labJDTEST.labJDTEST_template.mobile_html%type;
 
--  entity variables
v_entityjson json;
v_entity json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type numeric:=11;

-- template variables
v_templatejson jsonb;
v_img_ret numeric;
v_img_ret_data jsonb;
v_t_layout_id numeric;
v_t_template_name varchar(2000);
v_t_parent_id numeric;

v_page_template_json jsonb;
v_seojson 		  jsonb;
v_seodataid numeric;
v_seodataguid varchar(200);

v_asset_type_id numeric;
v_is_custom numeric;
-- v_custom_alias character varying ;
v_is_required numeric;
v_custom_alias character varying ;
v_ent_role_map_id  numeric;
v_is_amp numeric;
 
v_meta_info jsonb;
v_show_in_sitemap numeric;
v_is_update numeric;
v_page_alias     labJDTEST.labJDTEST_page.alias%TYPE;
v_page_data_json jsonb;
v_mob_flag numeric;
v_mob_page_data_json jsonb;
  V_page_template_name varchar(4000);
  V_template_html text;
  v_parent_template_id numeric;
		 
 
begin

      select current_timestamp at time zone 'utc'
      into   v_sysdate;  

      -------------------------------------------------------
      
      v_json := p_json;
      -------------------------------------------------------
      select    v_json->'data'->>'page_id',
                v_json->'data'->>'alias',
                v_json->'data'->>'title',
                v_json->'data'->>'page_level',
                v_json->'data'->>'upfront',
                v_json->'data'->>'upfront_app',
                v_json->'data'->>'upfront_mobile',
                v_json->'data'->>'is_wrapper',
                v_json->'data'->>'parent_id',
                v_json->'data'->>'visible',
                v_json->'data'->>'visible_app',
                v_json->'data'->>'visible_mobile',
                coalesce((v_json->'data'->>'scheduled_publish')::timestamp,v_sysdate)::timestamp,
                coalesce((v_json->'data'->>'scheduled_unpublish')::timestamp,v_sysdate)::timestamp, 
                v_json->'data'->>'ordering',
                v_json->'data'->>'title_mobile',
                v_json->'data'->>'title_app',
                v_json->'data'->>'is_redirect',
                v_json->'data'->>'published_version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'status',
                v_json->'data'->>'guid',
                v_json->'data'->>'asset_type_id',
                v_json->'data'->'seo',
                v_json->'data'->>'is_custom',
                v_json->'data'->>'is_amp',
                v_json->'data'->>'meta_info',
                v_json->'data'->>'show_in_sitemap'

     into       v_page_id,
                v_alias,
                v_title,
                v_page_level,
                v_upfront,
                v_upfront_app,
                v_upfront_mobile,
                v_is_wrapper,
                v_page_parent_id,
                v_visible,
                v_visible_app,
                v_visible_mobile,
                v_scheduled_publish,
                v_scheduled_unpublish,
                v_ordering,
                v_title_mobile,
                v_title_app,
                v_is_redirect,
                v_published_version_number,
                v_updated_by,
                v_status,
                v_page_guid,
                v_asset_type_id,
                v_seojson,
                v_is_custom,
				v_is_amp,
				v_meta_info,
                v_show_in_sitemap
                -- v_is_required
                ;
                
    select 'custom_'  
	into v_custom_alias;
			
			
			v_alias := case when v_alias='home' then '' else v_alias end ;
	-- raise notice '%',v_page_id;
   --  select 1/0;
    --------------------------------------------------------------------------------------------------------
    if (v_page_id  is null )
    then
		
        /***
        insert page information
        ***/
        
        v_page_guid    	 := uuid_generate_v4();	
        v_page_id        := nextval('labJDTEST.seq_labJDTEST_page_id');
        
        v_json 	         := jsonb_set(v_json, '{data,page_id}', v_page_id::text::jsonb, true);
        v_json 	         := jsonb_set(v_json, '{data,page_guid}', ('"'||v_page_guid||'"')::text::jsonb, true);
          
          
          
          v_custom_alias:=v_custom_alias||v_page_id::text;
		
		   
          insert into labJDTEST.labJDTEST_page
          (
          page_id,
          alias,
          title, 
          page_level, 
          upfront, 
          upfront_app, 
          upfront_mobile, 
          is_wrapper, 
          parent_id,
          visible, 
          visible_app, 
          visible_mobile, 
          scheduled_publish, 
          scheduled_unpublish, 
          ordering, 
          title_mobile, 
          title_app, 
          is_redirect, 
          published_version_number, 
          created_date, 
          updated_date, 
          created_by, 
          updated_by, 
          is_active, 
          is_deleted, 
          is_published, 
          page_guid,
          asset_type_id,
          is_custom_menu,
		  is_amp,
		  show_in_sitemap	,
		  meta_info	  
          )    
          values
          (
          v_page_id, 
          (case when v_is_custom = 1 then v_custom_alias else v_alias end),
          v_title, 
          v_page_level, 
          v_upfront, 
          v_upfront_app, 
          v_upfront_mobile, 
          v_is_wrapper, 
          v_page_parent_id, 
          v_visible, 
          v_visible_app, 
          v_visible_mobile, 
          v_scheduled_publish,
          v_scheduled_unpublish, 
          v_ordering, 
          v_title_mobile, 
          v_title_app, 
          v_is_redirect, 
          v_published_version_number,
          v_sysdate, 
          v_sysdate, 
          v_updated_by, 
          v_updated_by,
          1, 
          0, 
          v_status, 
          v_page_guid,
          v_asset_type_id,
          v_is_custom,
		  v_is_amp,
		  v_show_in_sitemap,
		  v_meta_info	  
        );    
         
        -- select v_json->'data'->'templatedata'
        -- into   v_templatejson;   
         -- select v_json->'data'->'templatedata'->'data'->>'layout_id',
            --   v_json->'data'->'templatedata'->'data'->>'template_name',
           --    v_json->'data'->'templatedata'->'data'->>'parent_id',
           --    v_json->'data'->'templatedata'->'data'->>'is_responsive',
           --    v_json->'data'->'templatedata'->'data'->>'mobile_html'
        -- into   v_t_layout_id,v_t_template_name,v_t_parent_id, v_is_responsive, v_mobile_html ;
        --- insert data into seo data ---
        
          
          select v_json->'data'->>'entitydata'
                         into   v_entityjson;
         -- select A from json_array_elements(v_entityjson)
         select aa->>'entity_role_map_id' into v_ent_role_map_id 
         from (select  json_array_elements(v_entityjson) as aa
        )b 
       where (aa->>'entity_role_map_id')::text::numeric in (select erm.entity_role_map_id
                                                        from   labJDTEST.labJDTEST_entity_category ec
                                                       join   labJDTEST.labJDTEST_entity_role_map erm
                                                      on     erm.entity_role_id = ec.entity_role_id
                                                      where  category_name = 'Language'
										);
       
     
	  -- select 1/0;
        
        
        ----insert data into asset_list ---
		insert into labJDTEST.labJDTEST_asset_list
					(
					asset_list_id,
					asset_id,
					asset_type_id,
					asset_title,
					title_alias,
					author_id,
					short_desc,
					tags,
					primary_entity_role_map_id,
					secondary_entity_role_map_id,
					total_assets,
					image_file_name,
					image_path,
					duration,
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
					asset_guid,
					show_copyright,
					order_number,
					short_title
					) 
					   values( 
					 nextval('labJDTEST.seq_labJDTEST_asset_list_id'),
					 v_page_id,
				     v_asset_type,
					 v_title,
					 (case when v_is_custom = 1 then v_custom_alias else v_alias end),
					 41,
					 null,
					 null,
					 v_ent_role_map_id,
					 v_ent_role_map_id,
					 null,
					 null,
					 null,
					 null,
					 0,
					 0,
					 0,
					 1,
					 0,       
					 current_timestamp at time zone 'utc',
					 current_timestamp at time zone 'utc',
					 1,
					 1,
					 1,
					 0,
					 1,
					current_timestamp at time zone 'utc',
					uuid_generate_v4(),
					null,
					null,
					null
					);
               
        else
        
        raise notice 'Meta Info:%',v_meta_info;
        
          update labJDTEST.labJDTEST_page
          set alias =(case when v_is_custom = 1 then v_custom_alias else v_alias end),
              title=v_title,
              page_level=v_page_level,
              upfront=v_upfront,
              ordering=v_ordering,
              updated_by=v_updated_by,
              updated_date=v_sysdate,
              visible= v_visible, 
             visible_app= v_visible_app, 
             visible_mobile=v_visible_mobile,
             title_mobile=v_title_mobile,
              title_app=v_title_app,
              is_published=v_status,
              asset_type_id=v_asset_type_id,
              is_custom_menu=v_is_custom,
              is_amp=v_is_amp,
			  meta_info=v_meta_info,
              show_in_sitemap=v_show_in_sitemap
          where page_id=v_page_id;
		  
		  -- update asset_id ----
		  update labJDTEST.labJDTEST_asset_list
		  set title_alias=(case when v_is_custom = 1 then v_custom_alias else v_alias end),
		      asset_title=v_title
		  where asset_id=v_page_id
		  and asset_type_id=v_asset_type

		  ;
       
         -- update seo data ----
         
          --raise notice '%',v_seojson;
         -- raise notice '%',v_page_id;
          ---raise notice '%',v_asset_type;
          
    select template_id ,parent_id
		 from labJDTEST.labJDTEST_template
		 where page_id=v_page_id
		into  V_template_id ,v_parent_template_id;
	 
	
--- raise notice '%,%',V_template_id,v_parent_template_id;
	 v_page_alias:= (case when v_is_custom = 1 then v_custom_alias else v_alias end);
	 --- if ((select length(replace(regexp_replace(v_page_alias, '[\w]+','','g'),'/','')))=0
	/* if V_template_id is not null  then		   
   select template_id, template_name, template_html,
		 mobile_html 
		 from labJDTEST.labJDTEST_template
		 where template_id=v_parent_template_id
        into  v_template_id,V_page_template_name,V_template_html,
		V_mobile_html;
		
		v_template_id:=v_parent_template_id;
	 
	  if    v_is_responsive=0 then
	execute 'select * from labJDTEST.labJDTEST_get_page_data_r
		  (	''{
  "inputs": {
    "p_url": "'||v_page_alias||'",
    "is_mobile":1,
    "is_amp":"'||v_is_amp||'",
	"listing_page_no":"1",
  "search_key": {
    "search_text": null,
    "entity_id": null,
    "page_number": null
  }
 }
}'')'  into v_mob_page_data_json;

end if;
 --raise notice '%', v_page_alias;
 ---select 1/0;
execute 'select * from labJDTEST.labJDTEST_get_page_data_r
		  (	''{
  "inputs": {
   "p_url": "'||v_page_alias||'",
    "is_mobile":null,
    "is_amp":"'||v_is_amp||'",
	"listing_page_no":"1",
  "search_key": {
    "search_text": null,
    "entity_id": null,
    "page_number": null
  }
 }
}'')'  into v_page_data_json;				 
					 */

 ---raise notice '%,%',v_page_alias,v_page_data_json;	
 
 --select 1/0;
					 
	/*	if  not exists(select 1 from labJDTEST.labJDTEST_page_template_detail
					 where page_id=v_page_id
					 ) then	
					 
	   insert into labJDTEST.labJDTEST_page_template_detail
	  select nextval('labJDTEST.seq_labJDTEST_page_template_detail_id'),v_page_id,v_page_alias,
	  V_template_id,V_page_template_name,V_template_html,v_page_data_json,1,current_timestamp,current_timestamp,
	  v_mobile_html,v_mob_page_data_json,v_is_responsive,v_is_amp,coalesce(v_is_deleted,0),v_status; 
					 
					 
	  else
	  update labJDTEST.labJDTEST_page_template_detail
	  set  page_alias=v_page_alias,
	  page_info_json=v_page_data_json,
	  updated_date=current_timestamp, 
	  mobile_page_json= v_mob_page_data_json,
	  is_responsive=v_is_responsive ,
	  is_amp=v_is_amp,
	  is_deleted=coalesce(v_is_deleted,0),
	  is_published=v_status
	  where page_id=v_page_id;
	  end if; */
						   
                     ---  END IF;
    end if;
    -----------
    delete from labJDTEST.labJDTEST_seo_data
    where asset_id=v_page_id
    and asset_type_id=v_asset_type ;
    v_seodataid := nextval('labJDTEST.seq_labJDTEST_seo_data_id');
	v_seodataguid := uuid_generate_v4();
    
    insert into labJDTEST.labJDTEST_seo_data(seo_data_id,
										   asset_id,
										   asset_type_id,
										   meta_info,
										   published_version_number,
										   created_date,
										   updated_date,
										   created_by,
										   updated_by,
										   is_active,
										   is_deleted,
										   is_published,
										   seo_data_guid)
			values(v_seodataid,
					 v_page_id,
					 v_asset_type,
					 v_seojson,
					 v_published_version_number,
					 v_sysdate,
					 v_sysdate,
					 v_updated_by,
					 v_updated_by,
					 1,
					 0,
					 v_status,
					 v_seodataguid);
    
    
    
    
    --  entity data---     
                     delete from labJDTEST.labJDTEST_asset_entity_map 
                     where asset_type_id=v_asset_type
                     and asset_id=v_page_id;
                     
                     select v_json->'data'->>'entitydata'
                         into   v_entityjson;

                        if v_entityjson is not null then
                      UPDATE labJDTEST.labJDTEST_page
		            set required_entities= null
		             where page_id=v_page_id;

                         for v_entity in select * from json_array_elements(v_entityjson)
                           loop
  
                           select v_entity->>'entity_role_map_id',
                                  v_entity->>'priority',
                                  v_entity->>'is_linkable',
                                  v_entity->>'is_visible',
                                  v_entity->>'is_required',
                                  v_entity->>'is_deleted'
                           into   v_entityrolemapid,
                                  v_priority,
                                  v_islinkable,
                                  v_isvisible,
                                  v_is_required,
                                  v_is_deleted
                                  ;

                      if (v_entityrolemapid is not null and v_priority is not null) then

                           v_assetentitymapid   := nextval('labJDTEST.seq_labJDTEST_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();
                           
                           insert into labJDTEST.labJDTEST_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required)
                          values(v_assetentitymapid, v_page_id, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, v_is_deleted, 
                          1, v_assetentitymapguid,v_is_required);
                          
                        UPDATE labJDTEST.labJDTEST_page
		            set required_entities= 
		           case when (coalesce(v_is_required,0)=1 and v_asset_type=11)
		           then array_append(required_entities,v_entityrolemapid) end 
		             where page_id=v_page_id;
                       end if;
                      end loop;
					  
					  UPDATE labJDTEST.labJDTEST_page
		     set required_entities= ARRAY(SELECT DISTINCT UNNEST(required_entities))   
		     where page_id=v_page_id;
					  
                    end if;
              -- entity data -- 
      p_result:=v_page_id;        
      p_data := v_json;

end;
$$;


--
