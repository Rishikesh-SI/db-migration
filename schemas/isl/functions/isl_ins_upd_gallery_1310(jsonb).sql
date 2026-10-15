-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_upd_gallery_1310(jsonb)
-- Type: FUNCTION

-- Name: isl_ins_upd_gallery_1310(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_upd_gallery_1310(p_gallery_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_gallery_json jsonb := p_gallery_json;
    v_gallery_data_json json;
    v_data_json json;
    v_gallery_id numeric;
    v_gallery_name varchar(100);
    v_gallery_path varchar(500);
    v_gallery_type numeric;
    v_thumbnail varchar(100);
    v_season_id numeric;
    v_status numeric;
    v_gallery_resolution_map json;
    v_gallery_guid varchar(256);
    v_grm_json json;
    v_file_name varchar(100);
    v_file_size varchar(100);
    v_gallery_resolution_map_id numeric;
    v_grm_guid varchar(256);
    v_entities_json json;
    v_entity_json json;
    v_entityrolemapid numeric;
    v_priority numeric;
    v_is_linkable numeric;
    v_is_visible numeric;
    
begin
	
    select v_gallery_json->>'data'
    into   v_gallery_data_json;
    
    if v_gallery_data_json is not null then
    	
        for v_data_json in select * from json_array_elements(v_gallery_data_json)
        loop
        	
            select v_data_json->>'gallery_id',
            		v_data_json->>'gallery_name',
            		v_data_json->>'gallery_path',
            		v_data_json->>'gallery_type',
            		v_data_json->>'thumbnail',
            		v_data_json->>'season_id',
            		v_data_json->>'status',
            		v_data_json->>'gallery_resolution',
                    v_data_json->>'entitydata'
    		into   v_gallery_id,
    				v_gallery_name,
            		v_gallery_path,
            		v_gallery_type,
           			v_thumbnail,
            		v_season_id,
            		v_status,
            		v_gallery_resolution_map,
                    v_entities_json;
            
            if v_gallery_id is null then
            	
                v_gallery_id := nextval('isl.seq_isl_gallery_id');
        		v_gallery_guid := uuid_generate_v4();
        		
        		insert into isl.isl_gallery(gallery_id, gallery_name, gallery_path, gallery_type, thumbnail, season_id, status, gallery_guid, 
                                            is_active, is_deleted, created_by, updated_by, created_date, updated_date)
        		select v_gallery_id, v_gallery_name, v_gallery_path, v_gallery_type, v_thumbnail, v_season_id, v_status, v_gallery_guid, 1, 0, 1, 1, 
                		v_current_timestamp, v_current_timestamp;
				
        		p_result := 1;
        		
			else
    			
        		update isl.isl_gallery
        		set    gallery_name = v_gallery_name,
                		gallery_path = v_gallery_path,
                        gallery_type = v_gallery_type,
                        thumbnail = v_thumbnail,
                        season_id = v_season_id,
                        status = v_status,
                        updated_date = v_current_timestamp
				where  gallery_id = v_gallery_id;
        		
        		delete from isl.isl_gallery_resolution_map
                where  gallery_id = v_gallery_id;
                
                if v_gallery_type = 2 and v_entities_json is null then
                	
                    delete from isl.isl_asset_entity_map
                	where  asset_id = v_gallery_id
                    and asset_type_id = 27;
                    
                end if;
        		
        		p_result := 1;
        		
    		end if;
            
            if v_gallery_resolution_map is not null then
        		
        		for v_grm_json in select * from json_array_elements(v_gallery_resolution_map)
        		loop
                	
            		select v_grm_json->>'file_name',
                    		v_grm_json->>'file_size'
    				into   v_file_name,
            				v_file_size;
            		
            		v_gallery_resolution_map_id := nextval('isl.isl_gallery_resolution_map_id');
            		v_grm_guid := uuid_generate_v4();
            		
            		insert into isl.isl_gallery_resolution_map(gallery_resolution_map_id, gallery_id, gallery_type, file_name, file_path, grm_guid, 
                                                               is_active, is_deleted, created_by, updated_by, created_date, updated_date)
					select v_gallery_resolution_map_id, v_gallery_id, v_gallery_type, v_file_name, v_file_size, v_grm_guid, 1, 0, 1, 1, 
                    		v_current_timestamp, v_current_timestamp;
            		
        		end loop;
        		
        		p_result := 1;
        		
    		end if;
            
            if v_gallery_type = 2 and v_entities_json is not null then
            	
                for v_entity_json in select * from json_array_elements(v_entities_json)
        		loop
                	
            		select v_entity->>'entity_role_map_id', 
                    		v_entity->>'priority', 
                            v_entity->>'is_linkable', 
                            v_entity->>'is_visible'
					into   v_entityrolemapid, v_priority, v_is_linkable, v_is_visible;
            		
                    if exists(select 1 from isl.isl_entity_role_map where entity_role_map_id = v_entityrolemapid and entity_role_id = 7) then
                    	
                        update isl.isl_gallery
        				set season_id = v_season_id,
                        	updated_date = v_current_timestamp
						where  gallery_id = v_gallery_id;
                        
                    end if;
                    
            		insert into isl.isl_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible, 
                                                         priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
                                                         is_published, aemap_guid)
					values(nextval('isl.seq_isl_asset_entity_map_id'), v_gallery_id, 27, v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, 
                           v_current_timestamp, v_current_timestamp, 1, 1, 1, 0, 1, uuid_generate_v4());
            		
        		end loop;
        		
        		p_result := 1;
                
            end if;
            
        end loop;
        
    end if;
	
end;

$$;


--
