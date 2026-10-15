-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ins_upd_comp_layout(numeric, character varying, character varying, character varying, character varying, numeric, numeric, character varying, character varying, numeric, numeric, numeric, character varying, character varying, numeric[], numeric[], numeric[], text[], text[], numeric[], numeric)
-- Type: FUNCTION

-- Name: waf_ins_upd_comp_layout(numeric, character varying, character varying, character varying, character varying, numeric, numeric, character varying, character varying, numeric, numeric, numeric, character varying, character varying, numeric[], numeric[], numeric[], text[], text[], numeric[], numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_ins_upd_comp_layout(p_component_layout_id numeric, p_ref_number character varying, p_layout_name character varying, p_layout_desp_name character varying, p_layout_desc character varying, p_comp_id numeric, p_comp_type_id numeric, p_image_file_name character varying, p_image_path character varying, p_updated_by numeric, p_is_published numeric, p_is_responsive numeric, p_mobile_image_file_name character varying, p_mobile_image_path character varying, p_arr_client_id numeric[], p_child_comp_lay_id numeric[], p_child_comp numeric[], p_child_guid text[], p_child_position text[], p_child_responsive numeric[], p_widget_group_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_sysdate 							 timestamp;

v_component_guid character varying;

v_cclmap_guid character varying;
v_component_layout_id numeric;
v_order_number numeric;

v_component_layout_dependency_map_id numeric;
v_cldmap_guid varchar(500);
v_order_number2 numeric;
v_cnt numeric;
v_cnt1 numeric;
BEGIN

		select current_timestamp  at time zone 'utc'
		into   v_sysdate;
          v_cldmap_guid := uuid_generate_v4();
		  
          
      -- select coalesce(max(order_number),0) into v_order_number2
      -- from waf_master.waf_component_layout_dependency_map;
       
    	-- select max(order_number)into v_order_number  from waf_master.waf_component_layout;
		select count(1) into v_cnt1  from waf_master.waf_component_layout_dependency_map;
	   if 
	   v_cnt1 =0
	   then  v_order_number2:=1 ;
       else
    	select max(order_number) into v_order_number2
       from waf_master.waf_component_layout_dependency_map;
		end if;
		
		
	   select count(1) into v_cnt  from waf_master.waf_component_layout;
	   if 
	   v_cnt =0
	   then  v_order_number:=1 ;
       else
    	select max(order_number)into v_order_number  from waf_master.waf_component_layout;
		end if;
		
		
		
		if (p_component_layout_id is null)
		then
			v_component_guid := uuid_generate_v4();	
			v_component_layout_id   := nextval('waf_master.seq_waf_component_layout_id');
            
     -- insert data into pkl_component_layout --
     
     insert into waf_master.waf_component_layout ( component_layout_id,
                                            ref_number,
                                            layout_name,
                                            layout_display_name,
                                            layout_desc,
                                            component_type_id,
                                            component_id,
                                            image_file_name,
                                            image_path,
                                            created_date,
                                            updated_date,
                                            created_by,
                                            updated_by,
                                            is_active,
                                            is_deleted,
                                            is_published,
                                            published_date,
                                            component_layout_guid,
                                            order_number,
                                            is_responsive,
                                            waf_component_layout_id,
                                            client_id,
                                            mobile_image_file_name,
                                            mobile_image_path,
                                            widget_group_id
                                            )
                        values(
                               v_component_layout_id,
                               p_ref_number,
                               p_layout_name,
                               p_layout_desp_name,
                               p_layout_desc,
                               p_comp_type_id,
                               p_comp_id,
                               p_image_file_name,
                               p_image_path,
                               v_sysdate,
                               v_sysdate,
                               p_updated_by,
                               p_updated_by,
                               1,
                               0,
                               p_is_published,
                               v_sysdate,
                               v_component_guid,
                               (v_order_number+1),
                               p_is_responsive,
                               1,
                               
                               0,
                               p_mobile_image_file_name,
                               p_mobile_image_path,
                               p_widget_group_id
                               );
     
     
     	p_result := v_component_layout_id;
      
                  ----------insert data into waf_master.waf_client_component_layout_map master -------------------
             --     v_cclmap_guid:=uuid_generate_v4();
--                  
                  insert into waf_master.waf_client_component_layout_map (
                                                                            client_component_layout_map_id,
                                                                            client_id,
                                                                            component_layout_id,
                                                                            created_date,
                                                                            updated_date,
                                                                            created_by,
                                                                            updated_by,
                                                                            is_active,
                                                                            is_deleted,
                                                                            is_published,
                                                                            published_date,
                                                                            cclmap_guid
                                                                          )
                                                    values       (
                                                                  nextval('waf_master.seq_waf_client_component_layout_map_id'),
                                                                  unnest(p_arr_client_id),
                                                                  v_component_layout_id,
                                                                  v_sysdate,
                                                                  v_sysdate,
                                                                  p_updated_by,
                                                                  p_updated_by,
                                                                  1,
                                                                  0,
                                                                  1,
                                                                  v_sysdate,
                                                                  uuid_generate_v4()
                                                    
                                                               );
--                  ----------insert data into waf_master.waf_client_component_layout_map master -------------------
      
      
        ---------------
          
          insert into waf_master.waf_component_layout_dependency_map(
          component_layout_dependency_map_id,
          component_layout_id,
          child_component_layout_id,
          order_number,
          created_date,
          updated_date,
          created_by,
          updated_by,
          is_active,
          is_deleted,
          is_published,
          published_date,
          cldmap_guid,
		  child_comp,
		  child_position,
          child_responsive    
          )
          values
          (
          nextval('waf_master.seq_waf_component_layout_dependency_map_id'),
          v_component_layout_id,
          unnest(p_child_comp_lay_id),
          (v_order_number2+1),
          v_sysdate,
          v_sysdate,
          p_updated_by,
          p_updated_by,
          1,
          0,
          1,
          v_sysdate,
          unnest(p_child_guid),
		  unnest(p_child_comp),
		  unnest(p_child_position),
          unnest(p_child_responsive)
		   
              );
          ---------------------
      
                
     
		else
    
    update waf_master.waf_component_layout
    set 
     layout_name=p_layout_name ,
     ref_number=p_ref_number,
     layout_display_name=p_layout_desp_name,
     layout_desc=p_layout_desc ,
     component_type_id= p_comp_type_id,
     component_id=p_comp_id , 
     image_file_name=p_image_file_name,
     image_path=p_image_path,
     updated_by=p_updated_by,
     updated_date=v_sysdate,
     is_responsive=p_is_responsive,
	 is_published = p_is_published,
     mobile_image_file_name=p_mobile_image_file_name,
     mobile_image_path=p_mobile_image_path,
     widget_group_id = p_widget_group_id
    where component_layout_id= p_component_layout_id;
			
p_result := p_component_layout_id;
------------------
delete from waf_master.waf_client_component_layout_map
    where component_layout_id=p_component_layout_id;
    
    insert into waf_master.waf_client_component_layout_map (
                                                                            client_component_layout_map_id,
                                                                            client_id,
                                                                            component_layout_id,
                                                                            created_date,
                                                                            updated_date,
                                                                            created_by,
                                                                            updated_by,
                                                                            is_active,
                                                                            is_deleted,
                                                                            is_published,
                                                                            published_date,
                                                                            cclmap_guid
                                                                          )
                                                    values       (
                                                                  nextval('waf_master.seq_waf_client_component_layout_map_id'),
                                                                  unnest(p_arr_client_id),
                                                                  p_component_layout_id,
                                                                  v_sysdate,
                                                                  v_sysdate,
                                                                  p_updated_by,
                                                                  p_updated_by,
                                                                  1,
                                                                  0,
                                                                  1,
                                                                  v_sysdate,
                                                                  uuid_generate_v4()
                                                    
                                                               );
    

-------------------------------
   delete from waf_master.waf_component_layout_dependency_map
    where component_layout_id=p_component_layout_id;
    ------------
          insert into waf_master.waf_component_layout_dependency_map(
          component_layout_dependency_map_id,
          component_layout_id,
          child_component_layout_id,
          order_number,
          created_date,
          updated_date,
          created_by,
          updated_by,
          is_active,
          is_deleted,
          is_published,
          published_date,
          cldmap_guid,
		  child_comp,
		  child_position,
          child_responsive
          )
          values
          (
          nextval('waf_master.seq_waf_component_layout_dependency_map_id'),
          p_component_layout_id,
          unnest(p_child_comp_lay_id),
          v_order_number2+1,
          v_sysdate,
          v_sysdate,
          p_updated_by,
          p_updated_by,
          1,
          0,
          1,
          v_sysdate,
          unnest(p_child_guid),
		  unnest(p_child_comp),
		  unnest(p_child_position),
          unnest(p_child_responsive)
              );
    --------------------

		end if;

	
    -- exception 
    -- when others then p_result := -1;

END;

$$;


--
