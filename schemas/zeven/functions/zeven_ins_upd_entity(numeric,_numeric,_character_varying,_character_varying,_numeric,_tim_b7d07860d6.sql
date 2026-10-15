-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_ins_upd_entity(numeric, numeric, character varying, character varying, numeric, timestamp without time zone, character varying, numeric, character varying, numeric, numeric[], numeric[], numeric[], numeric[])
-- Type: FUNCTION

-- Name: zeven_ins_upd_entity(numeric, numeric, character varying, character varying, numeric, timestamp without time zone, character varying, numeric, character varying, numeric, numeric[], numeric[], numeric[], numeric[]); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_ins_upd_entity(p_opt_type numeric, p_entity_master_id numeric, p_entity_name character varying, p_entity_display_name character varying, p_priority numeric, p_date_info timestamp without time zone, p_city character varying, p_country numeric, p_known_as character varying, p_updated_by numeric, p_entity_role_id_arr numeric[], p_hyperlink_arr numeric[], p_erm_priority_arr numeric[], p_source_object_id_arr numeric[], OUT p_ret numeric, OUT p_entityjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
    v_entity_role_id_count numeric;
    v_hyperlink_count numeric;
    v_erm_priority_count numeric;
    v_source_object_id_count numeric;
    v_entity_master_id numeric;
    v_entity_guid varchar(50);
    v_entity_role_map_id numeric;
    v_entity_role_id numeric;
    v_tagexists numeric;
    v_entityjsonarr jsonb[];
    v_entity_count numeric;
    v_entityjson jsonb;
    v_json text := '{"data":[';
    v_entity_role_id_to_delete_arr numeric[];
    v_entity_role_id_to_insert_arr numeric[];
    v_continue_delete numeric;
    v_entity_role_id_to_insert_count numeric;
    x numeric;
    
begin
	
    if p_opt_type = 1 then
    	
        if p_entity_master_id is null then
        	
            select count(1)
            into   v_entity_role_id_count
            from   unnest(p_entity_role_id_arr) u(entity_role_id);
            
        	select count(1)
        	into   v_hyperlink_count
        	from   unnest(p_hyperlink_arr) u(hyperlink);
        	
        	select count(1)
        	into   v_erm_priority_count
        	from   unnest(p_erm_priority_arr) u(erm_priority);
            
            select count(1)
        	into   v_source_object_id_count
        	from   unnest(p_source_object_id_arr) u(erm_priority);
            
        	if ((v_entity_role_id_count = v_hyperlink_count)
                and (v_hyperlink_count = v_erm_priority_count)
                and (v_erm_priority_count = v_source_object_id_count)) then
        		
            	v_entity_master_id := nextval('zeven.seq_zeven_entity_master_id');
            
        		v_entity_guid := uuid_generate_v4();
        		
            	insert into zeven.zeven_entity_master(entity_master_id, waf_entity_master_id, client_id, entity_name, entity_display_name, canonical_url,
                	                              priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted, date_info, city,
                    	                          country, known_as, comp_type, waf_series_master_id, waf_tour_master_id, entity_guid,
                                                  wafc_entity_name, wafc_entity_display_name)
				values(v_entity_master_id, v_entity_master_id, 1, p_entity_name, p_entity_display_name, null, p_priority, v_currenttimestamp,
                       v_currenttimestamp, p_updated_by, p_updated_by, 1, 0, p_date_info, p_city, p_country, p_known_as, null, null, null,
                       v_entity_guid, p_entity_name, p_entity_display_name);
				
            	for i in 1..v_entity_role_id_count
            	loop
                	
                	v_entity_role_map_id := nextval('zeven.seq_zeven_entity_role_map_id');
                	
                	insert into zeven.zeven_entity_role_map(entity_role_map_id, entity_role_id, entity_master_id, priority, is_active, source_object_id,
                    	                                created_date, updated_date, hyperlink)
					values(v_entity_role_map_id, p_entity_role_id_arr[i], v_entity_master_id, p_erm_priority_arr[i], 1, p_source_object_id_arr[i],
                    	   v_currenttimestamp, v_currenttimestamp, p_hyperlink_arr[i]);
                	
            	end loop;
            	
                p_ret := 1;
                
			else
                
                p_ret := 0;
                
        	end if;
            
        else
        	
            v_entity_master_id := p_entity_master_id;
            
            select array(select entity_role_id
                         from   zeven.zeven_entity_role_map
                         where  entity_master_id = v_entity_master_id
                         and    entity_role_id not in(select entity_role_id
                                                      from   unnest(p_entity_role_id_arr) u(entity_role_id))
                        )
			into   v_entity_role_id_to_delete_arr;
            
            select array(select entity_role_id
                         from   unnest(p_entity_role_id_arr) u(entity_role_id)
                         where  entity_role_id not in(select entity_role_id
                                                      from   zeven.zeven_entity_role_map
                                                      where  entity_master_id = v_entity_master_id)
                        )
			into   v_entity_role_id_to_insert_arr;
			
            select count(1)
            from   zeven.zeven_asset_entity_map
            where  entity_role_map_id in(select entity_role_map_id
                                         from   zeven.zeven_entity_role_map
                                         where  entity_master_id = v_entity_master_id
                                         and    entity_role_id in (select entity_role_id
                                                                   from   unnest(v_entity_role_id_to_delete_arr) u(entity_role_id))
                                        )
            into   v_continue_delete;
            
            if v_continue_delete = 0 then
            	
                update zeven.zeven_entity_master
            	set    entity_name = p_entity_name,
                	   entity_display_name = p_entity_display_name,
                       priority = p_priority,
                       date_info = p_date_info,
                       city = p_city,
                       country = p_country,
                       known_as = p_entity_name,
                       wafc_entity_name = p_entity_name,
                       wafc_entity_display_name = p_entity_display_name,
                       updated_by = p_updated_by,
                       updated_date = v_currenttimestamp
				where  entity_master_id = v_entity_master_id;
                
                update zeven.zeven_entity_role_map
                set    is_active = 0
                where  entity_master_id = v_entity_master_id
                and    entity_role_id in(select entity_role_id
                                         from   unnest(v_entity_role_id_to_delete_arr) u(entity_role_id));
				
                select count(1)
            	into   v_entity_role_id_to_insert_count
            	from   unnest(v_entity_role_id_to_insert_arr) u(entity_role_id);
                
                for i in 1..v_entity_role_id_to_insert_count
            	loop
                	
                    select array_position(p_entity_role_id_arr, v_entity_role_id_to_insert_arr[i])
                    into   x;
                    
                	v_entity_role_map_id := nextval('zeven.seq_zeven_entity_role_map_id');
                	
                	insert into zeven.zeven_entity_role_map(entity_role_map_id, entity_role_id, entity_master_id, priority, is_active, source_object_id,
                    	                                created_date, updated_date, hyperlink)
					values(v_entity_role_map_id, v_entity_role_id_to_insert_arr[i], v_entity_master_id, p_erm_priority_arr[x], 1,
                           p_source_object_id_arr[x], v_currenttimestamp, v_currenttimestamp, p_hyperlink_arr[x]);
                	
            	end loop;
                
                p_ret := 1;
                
			else
            	
                p_ret := 0;
                
            end if;
            
        end if;
        
	else
        
        v_entity_role_id := 55;
        
        select count(1)
        into   v_tagexists
        from   zeven.zeven_entity_role_map erm
        join   zeven.zeven_entity_master em
        on     em.entity_master_id = erm.entity_master_id
        where  entity_role_id = v_entity_role_id
        and    upper(em.entity_name) = upper(p_entity_name);
        
        if v_tagexists = 0 then
        	
            select entity_master_id
            into   v_entity_master_id
            from   zeven.zeven_entity_master
            where  upper(em.entity_name) = upper(p_entity_name);
            
            if v_entity_master_id is null then
            	
                v_entity_master_id := nextval('zeven.seq_zeven_entity_master_id');
                
                v_entity_guid := uuid_generate_v4();
                
                insert into zeven.zeven_entity_master(entity_master_id, waf_entity_master_id, client_id, entity_name, entity_display_name, canonical_url,
                                                  priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted, date_info, city,
                                                  country, known_as, comp_type, waf_series_master_id, waf_tour_master_id, entity_guid, wafc_entity_name,
                                                  wafc_entity_display_name)
				values(v_entity_master_id, v_entity_master_id, 1, p_entity_name, p_entity_display_name, null, p_priority, v_currenttimestamp,
                       v_currenttimestamp, p_updated_by, p_updated_by, 1, 0, p_date_info, p_city, p_country, p_known_as, null, null, null,
                       v_entity_guid, p_entity_name, p_entity_display_name);
                
            end if;
            
            v_entity_role_map_id := nextval('zeven.seq_zeven_entity_role_map_id');
            
            insert into zeven.zeven_entity_role_map(entity_role_map_id, entity_role_id, entity_master_id, priority, is_active, source_object_id,
                                                created_date, updated_date, hyperlink)
			values(v_entity_role_map_id, v_entity_role_id, v_entity_master_id, p_erm_priority_arr[i], 1, p_source_object_id_arr[i], v_currenttimestamp,
                   v_currenttimestamp, p_hyperlink_arr[i]);
			
		end if;
        
        p_ret := 1;
        
    end if;
    
    if p_ret = 1 then
        
        select '{"data":'||row_to_json(row)||'}'
        from
        (
            select em.*,
            	   (select array_to_json(array_agg(a))
                    from(select erm.*
                         from   zeven.zeven_entity_role_map erm
                         where  erm.entity_master_id = em.entity_master_id
                        )a
                   )entity_role_map
            from   zeven.zeven_entity_master em
            where  em.entity_master_id = v_entity_master_id
        ) as row
        into p_entityjson;
        
    end if;
    
/*EXCEPTION
	
    when others then
    	p_ret := -1;
        p_entityjson := '{"content":{"entities":[]}}';*/
	
end;

$$;


--
