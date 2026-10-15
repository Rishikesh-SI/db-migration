-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_gen_onthisday_article(numeric)
-- Type: FUNCTION

-- Name: labdv_gen_onthisday_article(numeric); Type: FUNCTION; Schema: labdv; Owner: -
--

CREATE FUNCTION labdv.labdv_gen_onthisday_article(p_languge_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

    declare
      
       v_date varchar;
        v_cnt numeric;
        v_date_entity_role_map_id numeric;
        v_name varchar :='on this day';
        v_name_entity_role_map_id numeric;
        v_template_component_map_id numeric :=15;
        
        v_asset_type_id numeric :=1;
        v_asset_id numeric ; 
        v_asset_type_id1 numeric ;
        v_max_asset_order numeric ;
        v_template_asset_component_map_id numeric;
        v_asset_guid1 varchar ;
        v_updated_by numeric:=41;
        v_currenttimestamp timestamp;
        v_count numeric;
        v_asser_map_id_arr numeric[];
    begin
           v_currenttimestamp:=current_timestamp at time zone 'utc';
           select to_char(current_timestamp at time zone 'utc' + ('5.30 hours')::interval, 'ddmar') into v_date;
           
           select entity_role_map_id into v_date_entity_role_map_id 
           from labdv.labdv_entity_role_map
           where entity_master_id in (select entity_master_id from labdv.labdv_entity_master
                                      where entity_name = v_date 
                                      ) 
                                      limit 1;
           
           select entity_role_map_id into v_name_entity_role_map_id  
           from labdv.labdv_entity_role_map
           where entity_master_id in (select entity_master_id from labdv.labdv_entity_master
                                      where entity_name = v_name 
                                      )
                                      limit 1;
                                      
                                      
                                      
               select count(*) into  v_count  from labdv.labdv_asset_entity_map
                              where 
                              asset_type_id=v_asset_type_id
                              and (asset_id,asset_type_id) in (select asset_id,asset_type_id from labdv.labdv_template_component_asset_map
                                                               where template_component_map_id=v_template_component_map_id
                                                               and asset_order=1)
                              and entity_role_map_id in (v_date_entity_role_map_id,v_name_entity_role_map_id,p_languge_id)
                              group by asset_id,asset_type_id
                              having count(entity_role_map_id)=3 ;
                                                     
                                                               
               if v_count is null then 
               v_count:=0;
               end if;
               
               
                if v_count =0
                                then       
             --  open p_article_cur for 
                              select asset_id,asset_type_id
                              into v_asset_id,v_asset_type_id1
                              from labdv.labdv_asset_entity_map
                              where 
                              asset_type_id=v_asset_type_id
                              and entity_role_map_id in (v_date_entity_role_map_id,v_name_entity_role_map_id,p_languge_id)
                              group by asset_id,asset_type_id
                              having count(entity_role_map_id)=3
                                ;
                                
                                v_max_asset_order :=1;
                                v_template_asset_component_map_id := nextval('labdv.seq_labdv_template_component_asset_map_id');
                                v_asset_guid1                     := uuid_generate_v4();
                                
                                
                                
                                
                                
                                update labdv.labdv_template_component_asset_map
                                set asset_order =0
                                where template_component_asset_map_id in (
                                                                    select temp_map_id
                               
                                    from   unnest(v_asser_map_id_arr) u(temp_map_id));
                                if (v_asset_id is not null and  v_asset_type_id1 is not null) then 
                         insert into labdv.labdv_template_component_asset_map(
                                               template_component_asset_map_id, 
						                                   template_component_map_id,
                                               asset_order,
                                               asset_id,
                                               asset_type_id, 
                                               asset_meta,
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
                                               asset_guid)
					   values(v_template_asset_component_map_id,  
                   v_template_component_map_id, 
					         v_max_asset_order, 
                   v_asset_id, 
                   v_asset_type_id1, 
                   null, 
                   1, 
                   1, 
                   1, 
					         1, 
                   0,
						       v_currenttimestamp, 
                   v_currenttimestamp,
                   v_updated_by, 
                   v_updated_by, 
						        1,
                    0, 
                    1, 
                    v_currenttimestamp,
                    v_asset_guid1
                    );
                    end if;
                      
                      end if;     
                      
                      
                      
    p_result:=1;
   -- exception
	
	-- when others then
	-- 	p_result := -1;
         
end; 

 $$;


--
