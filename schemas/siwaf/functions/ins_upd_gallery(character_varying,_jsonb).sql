-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_gallery(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_gallery(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_gallery(p_schema character varying, p_gallery_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$

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
	
    
begin
	
    select v_gallery_json->>'data',v_gallery_json->>'operation'
    into   v_gallery_data_json,v_operation;
    
	
	
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
                    v_data_json->>'entitydata',
					v_data_json->>'image_type',
					v_data_json->>'user_guid',
					v_data_json->>'is_gif_created',
					v_data_json->>'gif_frame_path',
					v_data_json->>'frame_id',
					v_data_json->>'reason_desc'
    		into   v_gallery_id,
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
					v_reason_desc;
            
            if v_gallery_id is null then
			
				execute 'select nextval('''||p_schema||'.seq_'||p_schema||'_gallery_id'')' 
				into v_gallery_id;
            	
        		v_gallery_guid := uuid_generate_v4();
        		
        		execute 'insert into '||p_schema||'.'||p_schema||'_gallery(gallery_id, gallery_name, gallery_path, gallery_type, thumbnail, season_id, status, gallery_guid, 
                                            is_active, is_deleted, created_by, updated_by, created_date,updated_date,user_guid,image_type,
											   is_gif_created, gif_frame_path, frame_id)
						values($1,$2,$3,$4,$5,$6,$7,$8,1, 0, 1, 1,$9,$10,$11,$12,$13,$14,$15)'
        		using v_gallery_id, v_gallery_name, v_gallery_path, v_gallery_type, v_thumbnail, v_season_id, v_status, v_gallery_guid, 
                		v_current_timestamp, v_current_timestamp,v_user_guid,v_image_type, v_is_gif_created, v_gif_frame_path, v_frame_id;
				
        		p_result := 1;
        		
			else
    			
				if v_operation = 1 then
				
					execute ' update '||p_schema||'.'||p_schema||'_gallery
							  set    is_gif_created = $1
							  where  thumbnail = $2'
					using   v_is_gif_created,v_thumbnail;
				end if;
				
				if v_operation = 2 then

				--  raise notice 'v_operation cms called: % ',  v_operation ;				
					
					execute ' update '||p_schema||'.'||p_schema||'_gallery
							set    status = $1,
								   reason_desc=$2
							where  thumbnail = $3'
					using   v_status,v_reason_desc,v_thumbnail;
				end if;  				
        		
        		p_result := 1;
        		
    		end if;
                     
        end loop;
        
    end if;
	
end;

$_$;


--
