-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_ins_upd_page_template_comp_menu_map(numeric[], numeric, numeric[], numeric, numeric[], numeric[])
-- Type: FUNCTION

-- Name: labal_nassr_ins_upd_page_template_comp_menu_map(numeric[], numeric, numeric[], numeric, numeric[], numeric[]); Type: FUNCTION; Schema: labal_nassr; Owner: -
--

CREATE FUNCTION labal_nassr.labal_nassr_ins_upd_page_template_comp_menu_map(p_page_id numeric[], p_menu_id numeric, p_template_id numeric[], p_updated_by numeric, p_temp_comp_map_id numeric[], p_is_check numeric[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_current_timestamp timestamp;
a numeric[] :=p_temp_comp_map_id;
v_cnt numeric:=0;
v_entrolemap_id numeric[] ;
v_menujson jsonb;
v_page_data jsonb;
v_widget_data jsonb;
v_required_entities numeric[];
v_is_amp numeric;
v_menuarray numeric[];
v_fetch_from numeric;
begin

 
	select fetch_from into v_fetch_from
	from labal_nassr.labal_nassr_template_component_map
	where template_component_map_id =any(p_temp_comp_map_id);
 
    v_current_timestamp:= current_timestamp at time zone 'utc';
    raise notice '%',v_fetch_from;
	
	if v_fetch_from=1 then

	update labal_nassr.labal_nassr_page_template_component_menu_map
	set is_active=0,is_deleted =1,is_published=0,
    updated_date=v_current_timestamp,
    updated_by=p_updated_by
	where menu_id=p_menu_id and
	template_component_map_id != any(p_temp_comp_map_id)
	and is_active=1 and is_deleted=0;
	
	else
	
	update labal_nassr.labal_nassr_page_template_component_menu_map
	set is_active=0,is_deleted =1,is_published=0,
    updated_date=v_current_timestamp,
    updated_by=p_updated_by
	where menu_id=p_menu_id and
	template_component_map_id != any(p_temp_comp_map_id);
	
    update labal_nassr.labal_nassr_page_template_component_menu_map
	set is_active=0,is_deleted =1,is_published=0,
    updated_date=v_current_timestamp,
    updated_by=p_updated_by
    where template_component_map_id =any(p_temp_comp_map_id); --menu_id=p_menu_id and

 end if;
  

    for t in array_lower(a, 1) .. array_upper(a, 1)
      loop
       
          select count(1) into v_cnt 
          from labal_nassr.labal_nassr_page_template_component_menu_map
          where template_component_map_id=p_temp_comp_map_id[t]
		  and is_active=1 and is_deleted=0 and menu_id=p_menu_id
        
		;
         
         if v_cnt > 0 then
           update labal_nassr.labal_nassr_page_template_component_menu_map
           set menu_id=(case when  p_is_check[t]=1 then  p_menu_id	else 	null end),
                     updated_by=p_updated_by,updated_date=v_current_timestamp,
                   is_deleted=1,is_active=0
           where template_component_map_id=p_temp_comp_map_id[t] 
            and page_id =p_page_id[t] and menu_id=(case when  v_fetch_from=0 then  p_menu_id else null end)
		;
         else
		 
		 
            insert into labal_nassr.labal_nassr_page_template_component_menu_map(
            page_template_component_menu_map_id, page_id, template_component_map_id, menu_id, is_trashed, created_date, 
            updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid,template_id)
            values (nextval('labal_nassr.seq_labal_nassr_page_template_component_menu_map_id'),
                    p_page_id[t], 
                    p_temp_comp_map_id[t], 
                    case when  p_is_check[t]=1 then  p_menu_id	else null end, 0, 
					v_current_timestamp,
					v_current_timestamp,
                    p_updated_by, p_updated_by, 1, 0, 1, 
					v_current_timestamp,
					uuid_generate_v4(),
                    p_template_id[t]
                   );
         end if;
      end loop;

		select array_agg(entity_role_map_id) into v_entrolemap_id
		from labal_nassr.labal_nassr_asset_entity_map
		where asset_id = p_menu_id and asset_type_id = 22;
		
		select array_agg(entity_role_map_id) into v_required_entities
		from labal_nassr.labal_nassr_asset_entity_map
		where asset_id = any(p_temp_comp_map_id) and asset_type_id = 13;
		
		select is_amp into v_is_amp from labal_nassr.labal_nassr_page
		where page_id in (select t2.page_id from labal_nassr.labal_nassr_template t
		join labal_nassr.labal_nassr_template_component_map tcm on t.template_id = tcm.template_id
		join labal_nassr.labal_nassr_template t1 on t.template_id = t1.layout_id
		join labal_nassr.labal_nassr_template t2 on t1.template_id = t2.parent_id
		where tcm.template_component_map_id = any(p_temp_comp_map_id) and t2.is_published = 1
		limit 1);
		
		if v_entrolemap_id is not null then
		
			select * into v_menujson from labal_nassr.labal_nassr_get_navigation_r(0,p_temp_comp_map_id,v_entrolemap_id);
			
			select ('['||string_agg((row_to_json(row))::text,',')||']')::json into v_page_data
			from(select p.title,p.alias,t.parent_id as template_id  from labal_nassr.labal_nassr_asset_entity_map a
	 			 join labal_nassr.labal_nassr_page p on a.asset_id = p.page_id
				 left join labal_nassr.labal_nassr_template t on p.page_id = t.page_id
	 			 where a.asset_type_id = 11 and entity_role_map_id = any(v_entrolemap_id))row;
		
		
		select string_agg((row_to_json(row))::text,',')::json into v_widget_data
			from(select *,v_required_entities as required_entities ,v_is_amp as is_amp from labal_nassr.labal_nassr_template_component_map
				 where template_component_map_id = any(p_temp_comp_map_id) )row;	 
				 
		    v_menujson:= jsonb_set(v_menujson,'{page}', coalesce(v_page_data,'[]'), true);		 
		    v_menujson:= jsonb_set(v_menujson,'{widget_data}', coalesce(v_widget_data,'{}'), true);
				 
				 
		  -- v_menujson:= jsonb_set(v_menujson,'{page}', coalesce(v_page_data,'[]'), true);		 
		    
			if v_menujson is not null then
			
				delete from labal_nassr.labal_nassr_navigation
				where template_comp_map_id = p_temp_comp_map_id;
			
				insert into labal_nassr.labal_nassr_navigation
				select nextval('labal_nassr.seq_labal_nassr_navigation_id'),p_temp_comp_map_id,v_entrolemap_id,v_menujson,v_current_timestamp,0,array[p_menu_id];
				
			end if;
		
		
		end if;
	  
			
p_result := 1;
/*
 exception when others 
 then p_result:= -1; */
end ;
$$;


--
