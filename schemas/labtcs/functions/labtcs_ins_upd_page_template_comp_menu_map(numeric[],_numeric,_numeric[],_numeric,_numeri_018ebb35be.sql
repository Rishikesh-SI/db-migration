-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ins_upd_page_template_comp_menu_map(numeric[], numeric, numeric[], numeric, numeric[], numeric[])
-- Type: FUNCTION

-- Name: labtcs_ins_upd_page_template_comp_menu_map(numeric[], numeric, numeric[], numeric, numeric[], numeric[]); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_ins_upd_page_template_comp_menu_map(p_page_id numeric[], p_menu_id numeric, p_template_id numeric[], p_updated_by numeric, p_temp_comp_map_id numeric[], p_is_check numeric[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
 

 
 

declare
v_current_timestamp timestamp;
a numeric[] :=p_temp_comp_map_id;
v_cnt numeric:=0;

begin

    v_current_timestamp:= current_timestamp at time zone 'utc';
    
    update labtcs.labtcs_page_template_component_menu_map
    set is_active=0,is_deleted =1,is_published=0,
    updated_date=v_current_timestamp,
    updated_by=p_updated_by
    where menu_id=p_menu_id;
        
    for t in array_lower(a, 1) .. array_upper(a, 1)
      loop
       
          select count(1) into v_cnt 
          from labtcs.labtcs_page_template_component_menu_map
          where template_component_map_id=p_temp_comp_map_id[t]
		  and is_active=1 and is_deleted=0
        
		;
         
         if v_cnt > 0 then
           update labtcs.labtcs_page_template_component_menu_map
           set menu_id=(case when  p_is_check[t]=1 then  p_menu_id	else 	null end),
                     updated_by=p_updated_by,updated_date=v_current_timestamp,
                   is_deleted=0,is_active=1
           where template_component_map_id=p_temp_comp_map_id[t] 
            and page_id =p_page_id[t]
		;
         else
            insert into labtcs.labtcs_page_template_component_menu_map(
            page_template_component_menu_map_id, page_id, template_component_map_id, menu_id, is_trashed, created_date, 
            updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid,template_id)
            values (nextval('labtcs.seq_labtcs_page_template_component_menu_map_id'),
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
			
p_result := 1;

 exception when others 
 then p_result:= -1;
end ;

$$;


--
