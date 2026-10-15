-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_ins_upd_template_niu(numeric, jsonb)
-- Type: FUNCTION

-- Name: dd_ins_upd_template_niu(numeric, jsonb); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_ins_upd_template_niu(p_page_id numeric, p_json jsonb, OUT p_result numeric, OUT p_data jsonb, OUT p_draft_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
V_template_id        			    dd.dd_template.template_id%TYPE;

V_template_name        				dd.dd_template.template_name%TYPE;
V_template_desc        				dd.dd_template.template_desc%TYPE;
v_page_id							dd.dd_template.page_id%type;
v_layout_id							dd.dd_template.layout_id%type;
v_parent_id							dd.dd_template.parent_id%type;
v_is_inherited							dd.dd_template.is_inherited%type;
V_published_version_number        	dd.dd_template.published_version_number%TYPE:=1;
V_created_date        				dd.dd_template.created_date%TYPE;
V_updated_date        				dd.dd_template.updated_date%TYPE;
V_created_by        				dd.dd_template.created_by%TYPE;
V_updated_by        				dd.dd_template.updated_by%TYPE;
V_is_active        					dd.dd_template.is_active%TYPE;
V_is_deleted        				dd.dd_template.is_deleted%TYPE;
V_is_published        				dd.dd_template.is_published%TYPE;
V_template_guid        				dd.dd_template.template_guid%TYPE;
v_master_id						dd.dd_template.is_master%type;
v_use_default_bg_color  dd.dd_template.use_default_bg_color%type;
v_use_default_bg_image  dd.dd_template.use_default_bg_image%type;
v_bg_color              dd.dd_template.bg_color%type;
v_bg_image_id              dd.dd_template.bg_image_id%type;

v_sysdate 							 timestamp;
V_is_master                             numeric;
V_master_template_id                    numeric;
V_template_html        				dd.dd_layout.layout_html%TYPE;

V_version_number numeric;
v_status numeric;
v_guid varchar(256);

v_componentjson json;
v_componentdata json;
v_is_responsive dd.dd_template.is_responsive%type;
v_mobile_html  dd.dd_template.mobile_html%type;

-- template component variables
v_co_template_component_map_id numeric;
v_co_component_id numeric;
v_co_title VARCHAR(500);
v_co_display_title VARCHAR(500);
v_co_title_mobile VARCHAR(500);
v_co_title_app VARCHAR(500);
v_co_show_in_web NUMERIC;
v_co_show_in_mobile NUMERIC;
v_co_show_in_app NUMERIC;
v_co_fetch_from NUMERIC;
v_co_parent_container_id VARCHAR(256); 
v_co_meta json;

-- child component variables
v_childcomponentjson json;
v_childcomponentdata json;

v_coc_template_component_map_id numeric;
v_coc_component_id numeric;
v_coc_title VARCHAR(500);
v_coc_display_title VARCHAR(500);
v_coc_title_mobile VARCHAR(500);
v_coc_title_app VARCHAR(500);
v_coc_show_in_web NUMERIC;
v_coc_show_in_mobile NUMERIC;
v_coc_show_in_app NUMERIC;
v_coc_fetch_from NUMERIC;
v_coc_parent_container_id VARCHAR(256); 
v_c_template_component_map_id NUMERIC;
v_c_asset_guid1 VARCHAR(256);
v_coc_meta json;

V_template_component_map_id NUMERIC;
v_asset_guid1 VARCHAR(256);

--  ENTITY VARIABLES
v_entityjson json;
v_entity json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type NUMERIC:=13;

-- DRAFT versioning tabless
v_assetdraftguid   	  varchar(50);
v_assetdraftid     	  numeric;
v_assettypeid numeric:=10; -- for template
v_versionnumber    	  numeric := 1;
V_cur_status          numeric;
V_cur_published_version_number numeric;
V_is_new numeric:=0;
V_max_version_number numeric:=0;

-- Assign Pages
v_pagejson json;
v_pages json;
v_page_template_id numeric;
v_page_old_template_id numeric;
V_page_template_guid        				dd.dd_template.template_guid%TYPE;
V_page_template_name        				dd.dd_template.template_name%TYPE;
V_page_template_desc        				dd.dd_template.template_desc%TYPE;
V_page_title                        dd.dd_page.title%TYPE;
BEGIN

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/***
		Get data from JSON
		***/
		-------------------------------------------------------------
      --  raise notice '%', v_json;
         
		SELECT 	    v_json->'data'->>'template_id',
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

		INTO            
				        V_template_id,
                V_template_name,
                V_template_desc,
                V_version_number,
                V_updated_by,
                v_status,
                v_guid,
                V_is_master,
                V_layout_id,
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
raise notice '%',v_is_inherited;
    if V_template_id is null then
        V_is_new:= 1;
    end if;
    raise notice '%',2;
    
		if (V_template_id is null and v_status = 0)
		then 
              V_template_guid    := uuid_generate_v4();	
              V_template_id      := nextval('dd.seq_dd_template_id');
                    v_json 	         := jsonb_set(v_json, '{data,template_id}', V_template_id::text::jsonb, true);
                    v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||V_template_guid||'"')::text::jsonb, true);
               raise notice '%',V_template_id;
              v_assetdraftid := nextval('dd.seq_dd_asset_draft_id');
              v_assetdraftguid := uuid_generate_v4();
              
              insert into dd.dd_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                            created_by, updated_by, is_active, is_deleted, asset_draft_guid)
              values(v_assetdraftid, V_template_id, v_assettypeid, v_versionnumber, v_json, v_sysdate, v_sysdate,
                     V_updated_by, V_updated_by, 1, 0, v_assetdraftguid);
              
              insert into dd.dd_template
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
              V_template_id,
                  p_page_id, 
                  v_template_name,
                  V_template_desc, 
                  v_layout_id, 
                  v_is_inherited, 
                  v_parent_id,
                  V_version_number, 
                  v_sysdate, 
                  v_sysdate, 
                  1, 
                  1, 
                  1, 
                  0, 
                  v_status, 
                  V_template_guid,
                  V_is_master, 
                  V_template_html, 
                  v_is_responsive, 
                  v_mobile_html,
                  v_use_default_bg_color,
                  v_use_default_bg_image  ,
                  v_bg_color            ,
                  v_bg_image_id 
              );   
		else
      
      select is_published,published_version_number into V_cur_status,V_cur_published_version_number
      from dd.dd_template where template_id = V_template_id;
      
    
      select max(version_number) into V_max_version_number
      from dd.dd_asset_draft where asset_id = V_template_id 
      and asset_type_id=v_assettypeid;
                
        raise notice '%','testing'  ;
        raise notice '%',V_cur_status  ;
        raise notice '%',V_cur_published_version_number  ;       
        raise notice '%',V_max_version_number  ;  
     --  select 1/0;
      if V_status = 0 and V_cur_status = 1 and V_max_version_number = V_cur_published_version_number then
          v_assetdraftid := nextval('dd.seq_dd_asset_draft_id');
          v_assetdraftguid := uuid_generate_v4();
          v_json 	         := jsonb_set(v_json, '{data,version_number}', ('"'||(V_cur_published_version_number+1)||'"')::text::jsonb, true);
          
          insert into dd.dd_asset_draft
          (asset_draft_id, 
           asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
           created_by, updated_by, is_active, is_deleted, asset_draft_guid)
          values(v_assetdraftid, V_template_id, v_assettypeid, (V_cur_published_version_number+1),
                 v_json, v_sysdate,v_sysdate,V_updated_by, V_updated_by, 1, 0, v_assetdraftguid);
      
      elsif V_status IN (0) and V_cur_status = 1 and V_max_version_number > V_cur_published_version_number  then 
         
          v_json 	         := jsonb_set(v_json, '{data,version_number}', ('"'||(V_max_version_number+1)||'"')::text::jsonb, true);
         -- raise notice '%', V_cur_published_version_number;
          raise notice '%',v_json;
           --  select 1/0;
            v_assetdraftid := nextval('dd.seq_dd_asset_draft_id');
          v_assetdraftguid := uuid_generate_v4();
          -- update dd.dd_asset_draft ad
				--		set    asset_data        = v_json,
						--       updated_date      = v_sysdate
					--	where  asset_id          = V_template_id
           --             and    asset_type_id     = v_assettypeid
					--	and    ad.version_number = V_max_version_number;
          
           insert into dd.dd_asset_draft
          (asset_draft_id, 
           asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
           created_by, updated_by, is_active, is_deleted, asset_draft_guid)
          values(v_assetdraftid, V_template_id, v_assettypeid, (V_max_version_number+1),
                 v_json, v_sysdate,v_sysdate,V_updated_by, V_updated_by, 1, 0, v_assetdraftguid);

                                                    
      elsif V_status IN (0,1) and V_cur_status = 0 then  
      
      
           --  update dd.dd_asset_draft ad
						-- set    asset_data        = v_json,
						--        updated_date      = v_sysdate
					-- 	where  asset_id          = V_template_id
           --              and    asset_type_id     = v_assettypeid
					--	and    ad.version_number = (select max(ad1.version_number)
            --                                        from   dd.dd_asset_draft ad1
            --                                         where  ad1.asset_id = ad.asset_id
            --                                        and    ad1.asset_type_id = ad.asset_type_id);
     
          v_assetdraftid := nextval('dd.seq_dd_asset_draft_id');
          v_assetdraftguid := uuid_generate_v4();
          v_json 	         := jsonb_set(v_json, '{data,version_number}', ('"'||(V_max_version_number+1)||'"')::text::jsonb, true);
          
          insert into dd.dd_asset_draft
          (asset_draft_id, 
           asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
           created_by, updated_by, is_active, is_deleted, asset_draft_guid)
          values(v_assetdraftid, V_template_id, v_assettypeid, (V_max_version_number+1),
                 v_json, v_sysdate,v_sysdate,V_updated_by, V_updated_by, 1, 0, v_assetdraftguid);
     
     
     
            update dd.dd_template
                  set 	page_id = p_page_id,
                          template_name = V_template_name,
                          template_desc = V_template_desc,
                          layout_id = v_layout_id,
                          is_inherited = v_is_inherited,
                          parent_id = v_parent_id,
                          published_version_number = V_published_version_number,
                          updated_date = v_sysdate,
                          updated_by = V_updated_by,
                          is_active = 1,
                          is_deleted = 0,
                          is_published = V_status,
                          is_master = V_is_master,
                          template_html = V_template_html,
                          is_responsive = v_is_responsive,
                          mobile_html = v_mobile_html,
                          use_default_bg_color=v_use_default_bg_color,
                          use_default_bg_image = v_use_default_bg_image,
                          bg_color            =v_bg_color,
                          bg_image_id=v_bg_image_id
             where    template_id = V_template_id;
             
          
          
          
             
        elsif V_status IN (1) and V_cur_status = 1 then  
      
           v_assetdraftid := nextval('dd.seq_dd_asset_draft_id');
           v_assetdraftguid := uuid_generate_v4();
           v_json 	         := jsonb_set(v_json, '{data,version_number}', ('"'||(V_max_version_number+1)||'"')::text::jsonb, true);
 
      
      
            insert into dd.dd_asset_draft
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
            V_template_id, 
            v_assettypeid, 
            (V_max_version_number+1),
            v_json,
            v_sysdate,v_sysdate,V_updated_by, V_updated_by, 1, 0, v_assetdraftguid);
      
          --  update dd.dd_asset_draft ad
					--	set    asset_data        = v_json,
						     --  updated_date      = v_sysdate
					--	where  asset_id          = V_template_id
                --        and    asset_type_id     = v_assettypeid
					--	and    ad.version_number = (select max(ad1.version_number)
                                              --      from   dd.dd_asset_draft ad1
                                                 --   where  ad1.asset_id = ad.asset_id
                                                --    and    ad1.asset_type_id = ad.asset_type_id);
     
            update dd.dd_template
                  set 	page_id = p_page_id,
                          template_name = V_template_name,
                          template_desc = V_template_desc,
                          layout_id = v_layout_id,
                          is_inherited = v_is_inherited,
                          parent_id = v_parent_id,
                          published_version_number = (V_cur_published_version_number+1),
                          updated_date = v_sysdate,
                          updated_by = V_updated_by,
                          is_active = 1,
                          is_deleted = 0,
                          is_published = V_status,
                          is_master = V_is_master,
                          template_html = V_template_html,
                          is_responsive = v_is_responsive,
                          mobile_html = v_mobile_html,
                          use_default_bg_color=v_use_default_bg_color,
                          use_default_bg_image = v_use_default_bg_image,
                          bg_color            =v_bg_color,
                          bg_image_id=v_bg_image_id
             where    template_id = V_template_id;
      end if;  
		end if;
    
    if (V_is_new = 1 or v_status = 1 or V_cur_status = 0) then
          raise notice '%',V_template_id;
          UPDATE dd.dd_TEMPLATE_COMPONENT_MAP
          SET IS_DELETED=1,IS_ACTIVE=0
          WHERE template_id = V_template_id;
          
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
                                                     raise notice '% testing dd 2d' ,8;
                                                    raise notice '%' ,v_componentjson; 
                                                    
                                               --   select 1/0;
              SELECT S.p_result INTO p_result  
               from dd.dd_ins_upd_template_component_map(V_template_id,V_updated_by,v_status
             , null::numeric,v_componentjson::jsonb) s;
                   -- end loop;     
                end if;
          -- ==============
         
       end if;
       
       if (V_is_new = 1 or v_status = 1 or V_cur_status = 0) then
                   
          if v_pagejson is not null and v_pagejson::text not in ('null') then
              
              update  dd.dd_template 
              set is_active=0,is_published=0,updated_date=v_sysdate,updated_by=V_updated_by
              where  parent_id= V_template_id; 
              
              for v_pages in select * from json_array_elements(v_pagejson)
                           loop
  
                           select v_pages->>'page_id' 
                           into   v_page_id;

                      if (v_page_id is not null ) then
                          
                          select title into V_page_title from dd.dd_page where page_id=v_page_id;
                          V_page_template_name:= V_page_title||'-' || V_template_name;
                          
                          begin
                          
                         	-- raise notice 'page_id : %' , v_page_id ;
                             select parent_id into strict v_page_old_template_id from dd.dd_template where page_id=v_page_id; 
                             
                           
                             
                            if v_page_old_template_id = V_template_id then
                                  update  dd.dd_template 
                                  set is_active=1,is_published=1,updated_date=v_sysdate,updated_by=V_updated_by
                                  where   page_id=v_page_id and parent_id= V_template_id; 
                            else      
                                  update  dd.dd_template 
                                  set page_id=0,is_active=0,is_published=0,updated_date=v_sysdate,updated_by=V_updated_by
                                  where page_id=v_page_id and parent_id= v_page_old_template_id; 
                                  
                                  V_page_template_guid    := uuid_generate_v4();	
                                  v_page_template_id      := nextval('dd.seq_dd_template_id'); 

                                  insert into dd.dd_template
                                  (
                                  template_id, page_id, template_name, template_desc, layout_id, is_inherited, parent_id,
                                  published_version_number,created_date, updated_date, created_by, updated_by, is_active,
                                  is_deleted, is_published, template_guid, is_master, template_html, is_responsive, mobile_html,
                                  use_default_bg_color,use_default_bg_image , bg_color , bg_image_id 
                                  )    
                                  values
                                  (
                                  v_page_template_id,v_page_id, V_page_template_name, V_page_template_desc, null, 1, V_template_id,
                                  1, v_sysdate, v_sysdate, V_updated_by, V_updated_by, 1, 0,   1,  V_page_template_guid,
                                  0, null, 0, null, null, null, null, null
                                  ); 
                            end if;
                            
                          exception
                          when no_data_found then
                                V_page_template_guid    := uuid_generate_v4();	
                                v_page_template_id      := nextval('dd.seq_dd_template_id'); 
                                  
                                insert into dd.dd_template
                                  (
                                  template_id, page_id, template_name, template_desc, layout_id, is_inherited, parent_id,
                                  published_version_number,created_date, updated_date, created_by, updated_by, is_active,
                                  is_deleted, is_published, template_guid, is_master, template_html, is_responsive, mobile_html,
                                  use_default_bg_color,use_default_bg_image , bg_color , bg_image_id 
                                  )    
                                  values
                                  (
                                  v_page_template_id,v_page_id, V_page_template_name, V_page_template_desc, null, 1, V_template_id,
                                  1, v_sysdate, v_sysdate, V_updated_by, V_updated_by, 1, 0,   1,  V_page_template_guid,
                                  0, null, 0, null, null, null, null, null
                                  ); 
                          end;
                           
                       END IF;
                       
                      END LOOP;
          end if;
           
       end if;
        p_result := V_template_id;
		-- p_data := v_json;
       raise notice '%', 5;
   select s.p_json,s.v_asset_draft from dd.dd_get_template_detail(V_template_id) s
       into p_data,p_draft_data;
        
        
 raise notice '%', 6;
END;

 

  

$$;


--
