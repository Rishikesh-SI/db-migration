-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_ins_upd_menu_bk(numeric, character varying, character varying, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric[], numeric[], character varying[], numeric[], numeric[], numeric[], numeric[], numeric[], character varying[], text[], character varying[], numeric[], numeric, jsonb, numeric[])
-- Type: FUNCTION

-- Name: lablsg_v1_ins_upd_menu_bk(numeric, character varying, character varying, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric[], numeric[], character varying[], numeric[], numeric[], numeric[], numeric[], numeric[], character varying[], text[], character varying[], numeric[], numeric, jsonb, numeric[]); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_ins_upd_menu_bk(p_menu_id numeric, p_menu_name character varying, p_disp_name character varying, p_menu_type numeric, p_updated_by numeric, p_is_active numeric, p_is_deleted numeric, p_is_published numeric, p_is_dynamic numeric, p_max_level numeric, p_include_child_pages numeric, p_menu_page_map_id numeric[], p_page_id numeric[], p_title character varying[], p_page_level numeric[], p_upfront numeric[], p_parent_page_id numeric[], p_order_number numeric[], p_no_action numeric[], p_external_url character varying[], p_function_info text[], p_meta_info character varying[], p_is_del_menu_map numeric[], p_language_id numeric, p_entity_json jsonb, p_openin_new_tab numeric[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
-- working sp--

declare 
v_sysdate timestamp;
v_menu_id numeric;
v_menu_guid varchar(200);

v_menu_page_map_id numeric;
v_mpmap_guid varchar(200);
a numeric[] :=p_menu_page_map_id;

v_json json;

 
 --  entity variables
v_entityjson json;
v_entity json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type numeric:=22;
v_is_required numeric;
v_entrolemap_id numeric[] ;
v_template_component_map_id numeric[];
v_menujson jsonb;
v_menu_id_1 numeric := p_menu_id ;
v_page_data jsonb;
v_widget_data jsonb;
v_required_entities numeric[];
v_is_amp numeric;
v_menu_required_entities numeric[];
begin
v_sysdate := current_timestamp at time zone 'utc';

  v_entityjson :=  p_entity_json;
  
               
if (p_menu_id is  null ) then 	
    
    if exists (select 1 from lablsg_v1.lablsg_v1_menu
               where menu_name = p_menu_name
               and is_active = 1 
               and is_deleted = 0) 
    then 
            p_result := -2 ;
            return;

    end if ;
    
     v_menu_guid:=uuid_generate_v4();
     v_menu_id := nextval('lablsg_v1.seq_lablsg_v1_menu_id');
      
     insert into lablsg_v1.lablsg_v1_menu(
        menu_id, menu_name, display_name, menu_type, created_date, updated_date, created_by, 
        updated_by, is_active, is_deleted, is_published, published_date, menu_guid, is_dynamic,
        max_level, include_child_pages, language_id)

      values
         (
             v_menu_id,
             p_menu_name, 
             p_disp_name, 
             p_menu_type, v_sysdate, v_sysdate, p_updated_by,p_updated_by,
         1,0, p_is_published, v_sysdate, v_menu_guid ,p_is_dynamic,p_max_level,p_include_child_pages,
           p_language_id 
        );
                
        insert into  lablsg_v1.lablsg_v1_menu_page_map
            (
            menu_page_map_id,
            menu_id, 
            page_id, 
                title, page_level, upfront,
            parent_page_id,order_number, no_action, external_url, function_info, meta_info, created_date,
            updated_date,created_by, updated_by, is_active, is_deleted, is_published,
            published_date,mpmap_guid,is_opennewtab
             )
        values 
               ( 
                   nextval('lablsg_v1.seq_lablsg_v1_menu_page_map_id'),
                  -- v_menu_id, 
                   v_menu_id,
                   unnest(p_page_id), 
                   unnest(p_title),
                   unnest(p_page_level),
                   unnest(p_upfront), 
                   unnest(p_parent_page_id), 
                   unnest(p_order_number),
                   unnest(p_no_action),
                   unnest(p_external_url), 
                   unnest(p_function_info), 
                   unnest(p_meta_info)::json,
                   v_sysdate,v_sysdate, 
                   p_updated_by, 
                   p_updated_by, 
                   p_is_active,
                   unnest(p_is_del_menu_map),
                   p_is_published, 
                   v_sysdate, 
                   uuid_generate_v4(),
				   unnest(p_openin_new_tab)
               ); 
               
               p_result:= v_menu_id;
               
else 

    if exists (select 1 from lablsg_v1.lablsg_v1_menu
               where menu_name = p_menu_name
               and menu_id != p_menu_id
               and is_active = 1 
               and is_deleted = 0) 
    then 
            p_result := -2 ;
            return;

    end if ;
    
    
       update lablsg_v1.lablsg_v1_menu
       set 
          menu_name=p_menu_name,
          display_name=p_disp_name,
          menu_type=p_menu_type,
          updated_by=p_updated_by,
          is_active=p_is_active,
          is_deleted=p_is_deleted,
          is_published=p_is_published,
          updated_date=v_sysdate,
          is_dynamic=p_is_dynamic,
          max_level=p_max_level, 
          include_child_pages=p_include_child_pages,
          language_id = p_language_id
       where menu_id=p_menu_id
       ;
       
update lablsg_v1.lablsg_v1_menu_page_map set is_active = 0
where menu_id= p_menu_id;
---raise notice '%',p_is_del_menu_map;
--select 1/0;

insert into  lablsg_v1.lablsg_v1_menu_page_map
          (
          menu_page_map_id, menu_id, page_id, title, page_level, upfront,
          parent_page_id,order_number, no_action, external_url, function_info, meta_info,
          created_date,updated_date, created_by, updated_by, is_active,
          is_deleted,is_published, published_date, mpmap_guid,is_opennewtab
           )
  values 
         ( 
          nextval('lablsg_v1.seq_lablsg_v1_menu_page_map_id'),p_menu_id, unnest(p_page_id), unnest(p_title),
           unnest(p_page_level), unnest(p_upfront), unnest(p_parent_page_id), unnest(p_order_number),
           unnest(p_no_action),unnest(p_external_url), unnest(p_function_info), unnest(p_meta_info)::json,
           v_sysdate,v_sysdate, p_updated_by, p_updated_by, p_is_active,
           unnest(p_is_del_menu_map),p_is_published, v_sysdate, uuid_generate_v4(),unnest(p_openin_new_tab)
         );
         
         p_result:= p_menu_id;
		 
		 
		      
update lablsg_v1.lablsg_v1_menu_page_map
set is_deleted= coalesce(is_deleted,0)
where menu_id= p_menu_id;
    end if;
	  
        
        --  entity data---     
                     delete from lablsg_v1.lablsg_v1_asset_entity_map 
                     where asset_type_id=v_asset_type
                     and asset_id=p_result;
                     
                    select p_entity_json->>'data'
					 into   v_entityjson;
                    
                     
                    -- select 1/0;
                    
                    -- select v_json->'data' into   v_entityjson;
                     -- ->>'entitydata'
                     

                       if v_entityjson is not null then
 
                         for v_entity in select * from json_array_elements(v_entityjson)
                           loop
  
                           select v_entity->>'entity_role_map_id',
                                  v_entity->>'priority',
                                  v_entity->>'is_linkable',
                                  v_entity->>'is_visible',
                                  v_entity->>'is_required'
                           into   v_entityrolemapid,
                                  v_priority,
                                  v_islinkable,
                                  v_isvisible,
                                  v_is_required
                                  ;

                      if (v_entityrolemapid is not null and v_priority is not null) then

                           v_assetentitymapid   := nextval('lablsg_v1.seq_lablsg_v1_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();

                           insert into lablsg_v1.lablsg_v1_asset_entity_map
                           (asset_entity_map_id, asset_id, asset_type_id,  entity_role_map_id, is_linkable,
                            is_visible, priority, created_date, updated_date, created_by, updated_by, is_active,
                            is_deleted, is_published, aemap_guid,is_required)
                          values(v_assetentitymapid, p_result, v_asset_type, 
                          v_entityrolemapid, coalesce(v_islinkable,0), v_isvisible, v_priority,
                          v_sysdate, v_sysdate, p_updated_by, p_updated_by, 1, 0, 
                          1, v_assetentitymapguid,v_is_required);
                       end if;
                      end loop;
					  update lablsg_v1.lablsg_v1_menu
       set required_entities= null
	   where menu_id=p_menu_id;
					  
                    end if;
					
---raise notice '%',v_asset_type;
		
        select array_agg(template_component_map_id) into v_template_component_map_id 
		from lablsg_v1.lablsg_v1_page_template_component_menu_map	
		where menu_id = p_menu_id and is_active=1 and is_deleted=0;
		
		select array_agg(entity_role_map_id) into v_entrolemap_id
		from lablsg_v1.lablsg_v1_asset_entity_map
		where asset_id = p_menu_id and asset_type_id = 22;
		
		select array_agg(entity_role_map_id) into v_menu_required_entities
		from lablsg_v1.lablsg_v1_asset_entity_map
		where asset_id = p_menu_id and asset_type_id = 22
		and is_required=1;
		
		
		select array_agg(entity_role_map_id) into v_required_entities
		from lablsg_v1.lablsg_v1_asset_entity_map
		where asset_id = any(v_template_component_map_id) and asset_type_id = 13;
		
		  update lablsg_v1.lablsg_v1_menu
       set required_entities=v_menu_required_entities
	   where menu_id=p_menu_id;
		
		select is_amp into v_is_amp from lablsg_v1.lablsg_v1_page
		where page_id in (select t2.page_id from lablsg_v1.lablsg_v1_template t
		join lablsg_v1.lablsg_v1_template_component_map tcm on t.template_id = tcm.template_id
		join lablsg_v1.lablsg_v1_template t1 on t.template_id = t1.layout_id
		join lablsg_v1.lablsg_v1_template t2 on t1.template_id = t2.parent_id
		where tcm.template_component_map_id = any(v_template_component_map_id) and t2.is_published = 1
		limit 1);
	
		if v_template_component_map_id is not null then
			---raise notice '%,%',v_template_component_map_id,v_entrolemap_id;
			--select 1/0;
			select * into v_menujson from lablsg_v1.lablsg_v1_get_navigation_r(0,v_template_component_map_id,v_entrolemap_id);
		  
		  --- v_menujson:= jsonb_set(v_menujson,'{required_entities}', coalesce(v_entrolemap_id,'[]'), true);
		
			select ('['||string_agg((row_to_json(row))::text,',')||']')::json into v_page_data
			from(select p.title,p.alias,
				 p.required_entities as page_required_entities
				 from lablsg_v1.lablsg_v1_asset_entity_map a
	 			 join lablsg_v1.lablsg_v1_page p on a.asset_id = p.page_id
	 			 where a.asset_type_id = 11 and entity_role_map_id = any(v_entrolemap_id))row;
			 
			select ('['||string_agg((row_to_json(row))::text,',')||']')::json into v_widget_data
			from(select *,v_required_entities as required_entities,v_is_amp as is_amp from lablsg_v1.lablsg_v1_template_component_map
				 where template_component_map_id = any(v_template_component_map_id) )row;	 
				 
		    v_menujson:= jsonb_set(v_menujson,'{page}', coalesce(v_page_data,'[]'), true);	
			
			
		    v_menujson:= jsonb_set(v_menujson,'{widget_data}', coalesce(v_widget_data,'{}'), true);
		    ---v_menujson:= jsonb_set(v_menujson,'{menu_required_entities}',coalesce(v_entrolemap_id,'[]'), true);
			 
			if v_menujson is not null then
			--- raise notice '%,%',v_template_component_map_id,v_entrolemap_id;
		 -- select 1/0;
			
				delete from lablsg_v1.lablsg_v1_navigation
				where template_comp_map_id = v_template_component_map_id and entity_role_map_id = v_entrolemap_id ;
			
				insert into lablsg_v1.lablsg_v1_navigation
				select nextval('lablsg_v1.seq_lablsg_v1_navigation_id'),v_template_component_map_id,v_entrolemap_id,v_menujson,v_sysdate,0,array[p_menu_id];
				
			end if;
			
		end if;	 
			
	
					
              -- entity data -- 

-- if p_menu_id is  not null  and  p_menu_page_map_id is null then
-- p_result:= 2;
 
                                         
-- end if;
/*
exception 
when others then 
p_result:= -1;
*/
end
$$;


--
