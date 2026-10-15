-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_ins_upd_gallery(jsonb)
-- Type: FUNCTION

-- Name: labkxip_ins_upd_gallery(jsonb); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_ins_upd_gallery(p_gallery_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_gallery_json jsonb := p_gallery_json;
    v_gallery_data_json json;
    v_data_json json;
    v_gallery_id numeric;
    v_gallery_name text;
    v_gallery_path text;
    v_gallery_type numeric;
    v_thumbnail text;
    v_season_id numeric;
    v_status numeric;
    v_gallery_resolution_map json;
    v_gallery_guid text;
    v_grm_json json;
    v_file_name text;
    v_file_size text;
    v_gallery_resolution_map_id numeric;
    v_grm_guid text;
    v_entities_json json;
    v_entity_json json;
    v_entityrolemapid numeric;
    v_priority numeric;
    v_is_linkable numeric;
    v_is_visible numeric;
	v_image_type numeric;
	v_user_guid text;
	v_is_gif_created numeric;
	v_gif_frame_path text;
	v_frame_id numeric;
	v_reason_desc text;
	v_operation numeric;
	v_process_id numeric;
	v_config_json json;
	v_img_time character varying;
	v_optype numeric;
	v_additional_info jsonb;
    v_user_info jsonb;
begin

-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- 	log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- 	values (nextval('siwaf.seq_siwaf_api_error_log_id'),'gtoutput-update_gallery','logs',uuid_generate_v4(),v_gallery_json,current_timestamp,'labkxip','logs');	
	
    select v_gallery_json->>'data',v_gallery_json->>'operation'
    into   v_gallery_data_json,v_operation;
    
	
	
	
    if v_gallery_data_json is not null then
		
    	
        for v_data_json in select * from json_array_elements(v_gallery_data_json)
        loop
        	
            select  v_data_json->>'gallery_id',
            		v_data_json->>'gallery_name',
            		v_data_json->>'gallery_path',
            		v_data_json->>'gallery_type',
            		v_data_json->>'thumbnail',
                    v_data_json->>'season_id',
            		v_data_json->>'status',
            		v_data_json->>'gallery_resolution',
                    v_data_json->>'entitydata',
					v_data_json->>'image_type',
					v_data_json->>'user_guid',
					v_data_json->>'is_gif_created',
					v_data_json->>'gif_frame_path',
					v_data_json->>'frame_id',
					v_data_json->>'reason_desc',
					v_data_json->>'configJSON',
					v_data_json->>'img_time',
					v_data_json->>'optype',
					v_data_json->>'additional_info',
					v_data_json->>'user_info'
    		into    v_gallery_id,
    				v_gallery_name,
            		v_gallery_path,
            		v_gallery_type,
           			v_thumbnail,
            		v_season_id,
                    v_status,
            		v_gallery_resolution_map,
                    v_entities_json,
					v_image_type,
					v_user_guid,
					v_is_gif_created,
					v_gif_frame_path,
					v_frame_id,
					v_reason_desc,
					v_config_json,
					v_img_time,
					v_optype,
					v_additional_info,
					v_user_info
					;
					
					--v_process_id;
					
	
            
            if v_gallery_id is null then
            	
                v_gallery_id := nextval('labkxip.seq_labkxip_gallery_id');
        		v_gallery_guid := uuid_generate_v4();
        		
        		insert into labkxip.labkxip_gallery(gallery_id, gallery_name, gallery_path, gallery_type, thumbnail, season_id, status, gallery_guid, 
                                            is_active, is_deleted, created_by, updated_by, created_date,updated_date,user_guid,image_type,
											   is_gif_created, gif_frame_path, frame_id,config_json,process_id,is_read,optype,additional_info,user_info)
        		select v_gallery_id, v_gallery_name, v_gallery_path, v_gallery_type, v_thumbnail, v_season_id, v_status, v_gallery_guid, 1, 0, 1, 1, 
                		v_current_timestamp, v_current_timestamp,v_user_guid,v_image_type, v_is_gif_created, v_gif_frame_path, v_frame_id,v_config_json,0,0,v_optype,v_additional_info,v_user_info;
				
        		p_result := 1;
        		
			else
    			
				if v_operation = 1 then
				
					update labkxip.labkxip_gallery
					set    is_gif_created = v_is_gif_created,
					img_time=v_img_time
					where  gallery_id = v_gallery_id;
				end if;
				if v_operation = 2 then

					
					update labkxip.labkxip_gallery
					set    status = v_status,
						   reason_desc=v_reason_desc,
						   img_time=v_img_time
					where  gallery_id = v_gallery_id;
					
				end if;  
				/* else 
				
        		   update labkxip.labkxip_gallery

        		    set    gallery_name = v_gallery_name,
                		gallery_path = v_gallery_path,
                        gallery_type = v_gallery_type,
                        thumbnail = v_thumbnail,
                        season_id = v_season_id,
                        status = v_status,
                        updated_date = v_current_timestamp,
						image_type=v_image_type,
						is_gif_created = v_is_gif_created,
						gif_frame_path = v_gif_frame_path,
						frame_id = v_frame_id,
						reason_desc=v_reason_desc
				     where  gallery_id = v_gallery_id;
				
				end if;*/
        		
        		/*delete from labkxip.labkxip_gallery_resolution_map
                where  
				gallery_id = v_gallery_id;*/
                
                /*if v_gallery_type = 2 and v_entities_json is null then
                	
                    delete from labkxip.labkxip_asset_entity_map
                	where  asset_id = v_gallery_id
                    and asset_type_id = 27;
                    
                end if;*/
        		
        		p_result := 1;
        		
    		end if;
            
            /*if v_gallery_resolution_map is not null then
        		
        		for v_grm_json in select * from json_array_elements(v_gallery_resolution_map)
        		loop
                	
            		select v_grm_json->>'file_name',
                    		v_grm_json->>'file_size'
    				into   v_file_name,
            				v_file_size;
            		
            		v_gallery_resolution_map_id := nextval('labkxip.labkxip_gallery_resolution_map_id');
            		v_grm_guid := uuid_generate_v4();
            		
            		insert into labkxip.labkxip_gallery_resolution_map(gallery_resolution_map_id, gallery_id, gallery_type, file_name, file_path, grm_guid, 
                                                               is_active, is_deleted, created_by, updated_by, created_date, updated_date)
					select v_gallery_resolution_map_id, v_gallery_id, v_gallery_type, v_file_name, v_file_size, v_grm_guid, 1, 0, 1, 1, 
                    		v_current_timestamp, v_current_timestamp;
            		
        		end loop;
        		
        		p_result := 1;
        		
    		end if;*/
            
            /*if v_gallery_type = 2 and v_entities_json is not null then
            	
                for v_entity_json in select * from json_array_elements(v_entities_json)
        		loop
                	
            		select v_entity->>'entity_role_map_id', 
                    		v_entity->>'priority', 
                            v_entity->>'is_linkable', 
                            v_entity->>'is_visible'
					into   v_entityrolemapid, v_priority, v_is_linkable, v_is_visible;
            		
                    if exists(select 1 from labkxip.labkxip_entity_role_map where entity_role_map_id = v_entityrolemapid and entity_role_id = 7) then
                    	
                        update labkxip.labkxip_gallery
        				set season_id = v_season_id,
                        	updated_date = v_current_timestamp
						where  gallery_id = v_gallery_id;
                        
                    end if;
                    
            		insert into labkxip.labkxip_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible, 
                                                         priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
                                                         is_published, aemap_guid)
					values(nextval('labkxip.seq_labkxip_asset_entity_map_id'), v_gallery_id, 27, v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, 
                           v_current_timestamp, v_current_timestamp, 1, 1, 1, 0, 1, uuid_generate_v4());
            		
        		end loop;
        		
        		p_result := 1;
                
            end if;
            */
        end loop;
        
    end if;
	
end;
$$;


--
