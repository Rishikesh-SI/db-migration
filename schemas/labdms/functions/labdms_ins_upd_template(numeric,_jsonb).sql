-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_ins_upd_template(numeric, jsonb)
-- Type: FUNCTION

-- Name: labdms_ins_upd_template(numeric, jsonb); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_ins_upd_template(p_page_id numeric, p_json jsonb, OUT p_result numeric, OUT p_data jsonb, OUT p_draft_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare

v_json 								jsonb;
v_template_id        			   numeric;

v_template_name        				labdms.labdms_template.template_name%type;
v_template_desc        				labdms.labdms_template.template_desc%type;
v_page_id							labdms.labdms_template.page_id%type;
v_layout_id							labdms.labdms_template.layout_id%type;
v_parent_id							labdms.labdms_template.parent_id%type;
v_is_inherited							labdms.labdms_template.is_inherited%type;
v_published_version_number        	labdms.labdms_template.published_version_number%type:=1;
v_created_date        				labdms.labdms_template.created_date%type;
v_updated_date        				labdms.labdms_template.updated_date%type;
v_created_by        				labdms.labdms_template.created_by%type;
v_updated_by        				labdms.labdms_template.updated_by%type;
v_is_active        					labdms.labdms_template.is_active%type;
v_is_deleted        				labdms.labdms_template.is_deleted%type;
v_is_published        				labdms.labdms_template.is_published%type;
v_template_guid        				labdms.labdms_template.template_guid%type;
v_master_id						labdms.labdms_template.is_master%type;
v_use_default_bg_color  numeric;
v_use_default_bg_image  numeric;
v_bg_color             character varying;
v_bg_image_id              labdms.labdms_template.bg_image_id%type;

v_sysdate 							 timestamp;
v_is_master                             numeric;
v_master_template_id                    numeric;
v_template_html        				labdms.labdms_layout.layout_html%type;

v_version_number numeric;
v_status numeric;
v_guid varchar(256);

v_componentjson json;
v_componentdata json;
v_is_responsive labdms.labdms_template.is_responsive%type;
v_mobile_html  labdms.labdms_template.mobile_html%type;

-- template component variables
v_co_template_component_map_id numeric;
v_co_component_id numeric;
v_co_title varchar(500);
v_co_display_title varchar(500);
v_co_title_mobile varchar(500);
v_co_title_app varchar(500);
v_co_show_in_web numeric;
v_co_show_in_mobile numeric;
v_co_show_in_app numeric;
v_co_fetch_from numeric;
v_co_parent_container_id varchar(256); 
v_co_meta json;

-- child component variables
v_childcomponentjson json;
v_childcomponentdata json;

v_coc_template_component_map_id numeric;
v_coc_component_id numeric;
v_coc_title varchar(500);
v_coc_display_title varchar(500);
v_coc_title_mobile varchar(500);
v_coc_title_app varchar(500);
v_coc_show_in_web numeric;
v_coc_show_in_mobile numeric;
v_coc_show_in_app numeric;
v_coc_fetch_from numeric;
v_coc_parent_container_id varchar(256); 
v_c_template_component_map_id numeric;
v_c_asset_guid1 varchar(256);
v_coc_meta json;

v_template_component_map_id numeric;
v_asset_guid1 varchar(256);

--  entity variables
v_entityjson json;
v_entity json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type numeric:=13;

-- draft versioning tabless
v_assetdraftguid   	  varchar(50);
v_assetdraftid     	  numeric;
v_assettypeid numeric:=10; -- for template
v_versionnumber    	  numeric := 1;
v_cur_status          numeric;
v_cur_published_version_number numeric;
v_is_new numeric:=0;
v_max_version_number numeric:=0;

-- assign pages
v_pagejson json;
v_pages json;
v_page_template_id numeric;
v_page_old_template_id numeric;
v_page_template_guid        				labdms.labdms_template.template_guid%type;
v_page_template_name        				labdms.labdms_template.template_name%type;
v_page_template_desc        				labdms.labdms_template.template_desc%type;
v_page_title                        labdms.labdms_page.title%type;
begin

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/***
		get data from json
		***/
		-------------------------------------------------------------
      --  raise notice '%', v_json;
         
		select 	    v_json->'data'->>'template_id',
                v_json->'data'->>'template_name',
                v_json->'data'->>'template_desc',
                v_json->'data'->>'version_number',
                v_json->'data'->>'updated_by',
                v_json->'data'->>'status',
                v_json->'data'->>'guid',
                v_json->'data'->>'is_master',
                v_json->'data'->>'layout_id',
                v_json->'data'->>'is_inherited',
                v_json->'data'->>'parent_id',
                v_json->'data'->>'template_html',
                v_json->'data'->>'is_responsive',
                v_json->'data'->>'mobile_html',
                v_json->'data'->>'pagedata',
                v_json->'data'->>'use_default_bg_color',
                v_json->'data'->>'use_default_bg_image',
                v_json->'data'->>'bg_color',
                v_json->'data'->>'bg_image_id'

		into            
				        v_template_id,
                v_template_name,
                v_template_desc,
                v_version_number,
                v_updated_by,
                v_status,
                v_guid,
                v_is_master,
                v_layout_id,
                v_is_inherited,
                v_parent_id,
                v_template_html,
                v_is_responsive,
				        v_mobile_html,
                v_pagejson,
                v_use_default_bg_color,
                v_use_default_bg_image  ,
                v_bg_color            ,
                v_bg_image_id ;
		---------------------------------------------------------------        
--raise notice '%',v_is_inherited;

    if v_template_id is null then   
        v_is_new:= 1;
    end if;
    
    --raise notice '%',2;
    
		if (v_template_id is null and v_status = 0)
		then 
              v_template_guid    := uuid_generate_v4();	
              v_template_id      := nextval('labdms.seq_labdms_template_id');
                    v_json 	         := jsonb_set(v_json, '{data,template_id}', v_template_id::text::jsonb, true);
                    v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_template_guid||'"')::text::jsonb, true);
               raise notice '%',v_template_id;
              v_assetdraftid := nextval('labdms.seq_labdms_asset_draft_id');
              v_assetdraftguid := uuid_generate_v4();
              
              insert into labdms.labdms_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                            created_by, updated_by, is_active, is_deleted, asset_draft_guid)
              values(v_assetdraftid, v_template_id, v_assettypeid, v_versionnumber, v_json, v_sysdate, v_sysdate,
                     v_updated_by, v_updated_by, 1, 0, v_assetdraftguid);
              
              insert into labdms.labdms_template
              (
              template_id, 
                  page_id, 
                  template_name,
                  template_desc, 
                  layout_id, 
                  is_inherited,
                  parent_id,
                  published_version_number,
                  created_date, 
                  updated_date,
                  created_by, 
                  updated_by, 
                  is_active,
                  is_deleted, 
                  is_published, 
                  template_guid,
                  is_master, 
                  template_html, 
                  is_responsive, 
                  mobile_html,
                  use_default_bg_color,
                  use_default_bg_image  ,
                  bg_color            ,
                  bg_image_id 
              )    
              values
              (
              v_template_id,
                  p_page_id, 
                  v_template_name,
                  v_template_desc, 
                  v_layout_id, 
                  v_is_inherited, 
                  v_parent_id,
                  v_version_number, 
                  v_sysdate, 
                  v_sysdate, 
                  1, 
                  1, 
                  1, 
                  0, 
                  v_status, 
                  v_template_guid,
                  v_is_master, 
                  v_template_html, 
                  v_is_responsive, 
                  v_mobile_html,
                  v_use_default_bg_color,
                  v_use_default_bg_image  ,
                  v_bg_color            ,
                  v_bg_image_id 
              );   
		else
      
      select is_published,published_version_number into v_cur_status,v_cur_published_version_number
      from labdms.labdms_template where template_id = v_template_id;
      
   
      select max(version_number) into v_max_version_number
      from labdms.labdms_asset_draft where asset_id = v_template_id 
      and asset_type_id=v_assettypeid;
                
				 
       -- raise notice '%','testing'  ;
       -- raise notice '%',v_cur_status  ;
       -- raise notice '%',v_cur_published_version_number  ;       
       -- raise notice '%',v_max_version_number  ;  
     --  select 1/0;
      if v_status = 0 and v_cur_status = 1 and v_max_version_number = v_cur_published_version_number then
          v_assetdraftid := nextval('labdms.seq_labdms_asset_draft_id');
          v_assetdraftguid := uuid_generate_v4();
          v_json 	         := jsonb_set(v_json, '{data,version_number}', ('"'||(v_cur_published_version_number+1)||'"')::text::jsonb, true);
         
          insert into labdms.labdms_asset_draft
          (asset_draft_id, 
           asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
           created_by, updated_by, is_active, is_deleted, asset_draft_guid)
          values(v_assetdraftid, v_template_id, v_assettypeid, (v_cur_published_version_number+1),
                 v_json, v_sysdate,v_sysdate,v_updated_by, v_updated_by, 1, 0, v_assetdraftguid);
      
      elsif v_status in (0) and v_cur_status = 1 and v_max_version_number > v_cur_published_version_number  then 
          
          v_json 	         := jsonb_set(v_json, '{data,version_number}', ('"'||(v_max_version_number+1)||'"')::text::jsonb, true);
         -- raise notice '%', v_cur_published_version_number;
         -- raise notice '%',v_json;
           --  select 1/0;
            v_assetdraftid := nextval('labdms.seq_labdms_asset_draft_id');
          v_assetdraftguid := uuid_generate_v4();
          -- update labdms.labdms_asset_draft ad
				--		set    asset_data        = v_json,
						--       updated_date      = v_sysdate
					--	where  asset_id          = v_template_id
           --             and    asset_type_id     = v_assettypeid
					--	and    ad.version_number = v_max_version_number;
          
           insert into labdms.labdms_asset_draft
          (asset_draft_id, 
           asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
           created_by, updated_by, is_active, is_deleted, asset_draft_guid)
          values(v_assetdraftid, v_template_id, v_assettypeid, (v_max_version_number+1),
                 v_json, v_sysdate,v_sysdate,v_updated_by, v_updated_by, 1, 0, v_assetdraftguid);

                                                    
      elsif v_status in (0,1) and v_cur_status = 0 then  
      
    
           --  update labdms.labdms_asset_draft ad
						-- set    asset_data        = v_json,
						--        updated_date      = v_sysdate
					-- 	where  asset_id          = v_template_id
           --              and    asset_type_id     = v_assettypeid
					--	and    ad.version_number = (select max(ad1.version_number)
            --                                        from   labdms.labdms_asset_draft ad1
            --                                         where  ad1.asset_id = ad.asset_id
            --                                        and    ad1.asset_type_id = ad.asset_type_id);
     
          v_assetdraftid := nextval('labdms.seq_labdms_asset_draft_id');
          v_assetdraftguid := uuid_generate_v4();
          v_json 	         := jsonb_set(v_json, '{data,version_number}', ('"'||(v_max_version_number+1)||'"')::text::jsonb, true);
          
          insert into labdms.labdms_asset_draft
          (asset_draft_id, 
           asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
           created_by, updated_by, is_active, is_deleted, asset_draft_guid)
          values(v_assetdraftid, v_template_id, v_assettypeid, (v_max_version_number+1),
                 v_json, v_sysdate,v_sysdate,v_updated_by, v_updated_by, 1, 0, v_assetdraftguid);
     
     
     
            update labdms.labdms_template
                  set 	page_id = p_page_id,
                          template_name = v_template_name,
                          template_desc = v_template_desc,
                          layout_id = v_layout_id,
                          is_inherited = v_is_inherited,
                          parent_id = v_parent_id,
                          published_version_number = v_published_version_number,
                          updated_date = v_sysdate,
                          updated_by = v_updated_by,
                          is_active = 1,
                          is_deleted = 0,
                          is_published = v_status,
                          is_master = v_is_master,
                          template_html = v_template_html,
                          is_responsive = v_is_responsive,
                          mobile_html = v_mobile_html,
                          use_default_bg_color=v_use_default_bg_color,
                          use_default_bg_image = v_use_default_bg_image,
                          bg_color            =v_bg_color,
                          bg_image_id=v_bg_image_id
             where    template_id = v_template_id;
             
          
          
          
             
        elsif v_status in (1) and v_cur_status = 1 then  
        
           v_assetdraftid := nextval('labdms.seq_labdms_asset_draft_id');
           v_assetdraftguid := uuid_generate_v4();
           v_json 	         := jsonb_set(v_json, '{data,version_number}', ('"'||(v_max_version_number+1)||'"')::text::jsonb, true);
 
      
      
            insert into labdms.labdms_asset_draft
            (asset_draft_id, 
            asset_id, 
            asset_type_id, 
            version_number, 
            asset_data,
            created_date,
            updated_date,
            created_by, 
            updated_by, is_active, is_deleted, asset_draft_guid)
            values(v_assetdraftid, 
            v_template_id, 
            v_assettypeid, 
            (v_max_version_number+1),
            v_json,
            v_sysdate,v_sysdate,v_updated_by, v_updated_by, 1, 0, v_assetdraftguid);
      
          --  update labdms.labdms_asset_draft ad
					--	set    asset_data        = v_json,
						     --  updated_date      = v_sysdate
					--	where  asset_id          = v_template_id
                --        and    asset_type_id     = v_assettypeid
					--	and    ad.version_number = (select max(ad1.version_number)
                                              --      from   labdms.labdms_asset_draft ad1
                                                 --   where  ad1.asset_id = ad.asset_id
                                                --    and    ad1.asset_type_id = ad.asset_type_id);
												
												
     
            update labdms.labdms_template
                  set 	page_id = p_page_id,
                          template_name = v_template_name,
                          template_desc = v_template_desc,
                          layout_id = v_layout_id,
                          is_inherited = v_is_inherited,
                          parent_id = v_parent_id,
                          published_version_number = (v_cur_published_version_number+1),
                          updated_date = v_sysdate,
                          updated_by = v_updated_by,
                          is_active = 1,
                          is_deleted = 0,
                          is_published = v_status,
                          is_master = v_is_master,
                          template_html = v_template_html,
                          is_responsive = v_is_responsive,
                          mobile_html = v_mobile_html,
                          use_default_bg_color=v_use_default_bg_color,
                          use_default_bg_image = v_use_default_bg_image,
                          bg_color            =v_bg_color,
                          bg_image_id=v_bg_image_id
             where    template_id = v_template_id;
      end if;  
		end if;
    
	
    if (v_is_new = 1 or v_status = 1 or v_cur_status = 0) then
          --raise notice '%',v_template_id;
		 
          update labdms.labdms_template_component_map
          set is_deleted=1,is_active=0
          where template_id = v_template_id;
          
          -- ==============
      --          select v_json->'data'->>'componentdata'
      --               into   v_componentjson; 
      --        select v_json->>'data'->>'componentdata'
      --               into   v_componentjson; 
                      select v_json->>'data'
                     into   v_componentjson; 
              
            --  raise notice 'json : %' ,v_componentjson;
                
                if v_componentjson is not null then 
                    
      --            for v_componentdata in select * from json_array_elements(v_componentjson)
      --              loop
                                                    -- raise notice '% testing labdms 2d' ,8;
                                                    --raise notice '%' ,v_componentjson; 
                                                    
                                               --   select 1/0;
              
			  select s.p_result into p_result  
               from labdms.labdms_ins_upd_template_component_map(v_template_id,v_updated_by,v_status
             , null::numeric,v_componentjson::jsonb) s;
			 
			  
                   -- end loop;     
                end if;
          -- ==============
         
       end if;
       
                                                            
       if (v_is_new = 1 or v_status = 1 or v_cur_status = 0) then
            
          if v_pagejson is not null and v_pagejson::text not in ('null') then
              
              update  labdms.labdms_template 
              set is_active=0,is_published=0,updated_date=v_sysdate,updated_by=v_updated_by
              where  parent_id= v_template_id; 
              
			 
              for v_pages in select * from json_array_elements(v_pagejson)
                           loop
  
                           select v_pages->>'page_id' 
                           into   v_page_id;

                      if (v_page_id is not null ) then
                           
                          select title into v_page_title 
						  from labdms.labdms_page where page_id=v_page_id;
                          v_page_template_name:= v_page_title||'-' || v_template_name;
                         
                          begin
                          
                         
                           
                             select parent_id into strict v_page_old_template_id 
							 from labdms.labdms_template where page_id=v_page_id  
							 ; 
                             
						-- raise notice '% test',v_page_id;
						  --  select 1/0;
                             
                            if v_page_old_template_id = v_template_id then
                                  update  labdms.labdms_template 
                                  set is_active=1,is_published=1,updated_date=v_sysdate,updated_by=v_updated_by
                                  where   page_id=v_page_id and parent_id= v_template_id; 
                            else      
                                  update  labdms.labdms_template 
                                  set page_id=0,is_active=0,is_published=0,updated_date=v_sysdate,updated_by=v_updated_by
                                  where page_id=v_page_id and parent_id= v_page_old_template_id; 
                                  
                                  v_page_template_guid    := uuid_generate_v4();	
                                  v_page_template_id      := nextval('labdms.seq_labdms_template_id'); 

                                  insert into labdms.labdms_template
                                  (
                                  template_id, page_id, template_name, template_desc, layout_id, is_inherited, parent_id,
                                  published_version_number,created_date, updated_date, created_by, updated_by, is_active,
                                  is_deleted, is_published, template_guid, is_master, template_html, is_responsive, mobile_html,
                                  use_default_bg_color,use_default_bg_image , bg_color , bg_image_id 
                                  )    
                                  values
                                  (
                                  v_page_template_id,v_page_id, v_page_template_name, v_page_template_desc, null, 1, v_template_id,
                                  1, v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0,   1,  v_page_template_guid,
                                  0, null, 0, null, null, null, null, null
                                  ); 
                            end if;
                            
                          exception
                          when no_data_found then
                                v_page_template_guid    := uuid_generate_v4();	
                                v_page_template_id      := nextval('labdms.seq_labdms_template_id'); 
                                  
                                insert into labdms.labdms_template
                                  (
                                  template_id, page_id, template_name, template_desc, layout_id, is_inherited, parent_id,
                                  published_version_number,created_date, updated_date, created_by, updated_by, is_active,
                                  is_deleted, is_published, template_guid, is_master, template_html, is_responsive, mobile_html,
                                  use_default_bg_color,use_default_bg_image , bg_color , bg_image_id 
                                  )    
                                  values
                                  (
                                  v_page_template_id,v_page_id, v_page_template_name, v_page_template_desc, null, 1, v_template_id,
                                  1, v_sysdate, v_sysdate, v_updated_by, v_updated_by, 1, 0,   1,  v_page_template_guid,
                                  0, null, 0, null, null, null, null, null
                                  ); 
                          end;
                           
                       end if;
                       
                      end loop;
		  else 
                                                    
		  ---- added by purushottam on the request of bhushan sir on dated 20171207
			  update  labdms.labdms_template 
              set is_active=0,is_published=0,updated_date=v_sysdate,updated_by=v_updated_by
              where  parent_id= v_template_id; 
				
          end if;
           
       end if;
        p_result := v_template_id;
		-- p_data := v_json;
       --raise notice '%', 5;
   select s.p_json,s.v_asset_draft from labdms.labdms_get_template_detail(v_template_id) s
       into p_data,p_draft_data;
        
        
 -- raise notice '%', 6;
-- select 1/0; 
end;

 

  

 $$;


--
