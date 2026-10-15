-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_ins_upd_gallery(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_gallery(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_ins_upd_gallery(p_gallery_json jsonb, OUT p_result numeric) RETURNS numeric
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
	v_user_info jsonb;
	v_comment character varying;
	v_is_fav_comment numeric;
	
    
begin

	
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
					v_data_json->'user_info',
					v_data_json->>'comment',
					v_data_json->>'is_fav_comment'
					--v_data_json->>'process_id'
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
					v_user_info,
					v_comment,
					v_is_fav_comment ;
					
					--v_process_id;
					
	
            
            if v_gallery_id is null then
            	
                v_gallery_id := nextval('labrr.seq_labrr_gallery_id');
        		v_gallery_guid := uuid_generate_v4();
        		
        		insert into labrr.labrr_gallery(gallery_id, gallery_name, gallery_path, gallery_type, thumbnail, season_id, status, gallery_guid, 
                                            is_active, is_deleted, created_by, updated_by, created_date,updated_date,user_guid,image_type,
											   is_gif_created, gif_frame_path, frame_id,config_json,process_id,is_read,optype,
												user_info,comment,is_fav_comment)
        		select v_gallery_id, v_gallery_name, v_gallery_path, v_gallery_type, v_thumbnail, v_season_id, v_status, v_gallery_guid, 1, 0, 1, 1, 
                		v_current_timestamp, v_current_timestamp,v_user_guid,v_image_type, v_is_gif_created, v_gif_frame_path, v_frame_id,v_config_json,0,0,v_optype,
						v_user_info,v_comment, coalesce(v_is_fav_comment,0);
				
        		p_result := 1;
        		
			else  			
				
				update labrr.labrr_gallery
				set status = coalesce(v_status,status),
				    is_fav_comment = coalesce(v_is_fav_comment,0),
					updated_date = v_current_timestamp
				where gallery_id = v_gallery_id ;	
				
        		p_result := 1;
        		
    		end if;
            
        end loop;
        
    end if;
	
end;
$$;


--
