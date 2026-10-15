-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp07062024
-- Object: labecn_upload_excel(jsonb)
-- Type: FUNCTION

-- Name: labecn_upload_excel(jsonb); Type: FUNCTION; Schema: labecn_bkp07062024; Owner: -
--

CREATE FUNCTION labecn_bkp07062024.labecn_upload_excel(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	declare
	
	v_opt_type numeric;
	v_json jsonb;
	v_data jsonb;
	v_affliate_data_id numeric;
	v_is_approved numeric;
    

v_name character varying;
v_source_object_id character varying;
v_entity_master_id numeric;
	begin 
	
	select p_json->>'opt_type',
		   p_json->'data'
	into   v_opt_type,
	       v_json ;
		   
	if v_opt_type = 1 then
	
		for v_data in select * from json_array_elements(v_json)
		loop
		
		  select v_data->>'affliate_data_id',
		  		 v_data->>'is_approved'
		  into 	v_affliate_data_id,
		        v_is_approved;
				
		update labecn.labecn_affliate_data
		set is_approved = v_is_approved
		where affliate_data_id = v_affliate_data_id;
		
		
		
		end loop;
	
		p_data :=  '{
	 				"status" : 1
	 				}';
	
	
	elsif v_opt_type = 2 then

	for v_data in select * from jsonb_array_elements(v_json)
		loop
			select v_data->>'name',
			v_data->>'source_object_id'
			into 
			v_name,
			v_source_object_id;
		raise notice 'v_opt_type %',v_opt_type;
        
    if v_source_object_id not in ('null','') and v_name not in ('null','') and
    v_source_object_id is not null and v_name is not null then
		
		 if not exists(select 1 from labecn.labecn_entity_role_map
					  where entity_role_id = 11 and source_object_id = v_source_object_id)then
					  raise notice '%', v_source_object_id;

		
			Insert into labecn.labecn_entity_master (entity_master_id,waf_entity_master_id,client_id,entity_name,entity_display_name,canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name,player_image_path)
			values (nextval('labecn.seq_labecn_entity_master_id'),0,1,v_name,v_name,lower('/players/'||replace(TRIM(v_name),' ','-')||'-'||v_source_object_id),1,current_timestamp,current_timestamp,1,1,1,0,null,null,null,v_name,null,null,null,uuid_generate_v4(),v_name,v_name,v_source_object_id||'.png');
			Insert into labecn.labecn_entity_role_map (entity_role_map_id,entity_role_id,entity_master_id,priority,is_active,source_object_id,created_date,updated_date,hyperlink)
			values(nextval('labecn.seq_labecn_entity_role_map_id'),11,currval('labecn.seq_labecn_entity_master_id'),1,1,v_source_object_id,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0);
            
         elsif exists(select 1 from labecn.labecn_entity_role_map
					  where entity_role_id = 11 and source_object_id = v_source_object_id ) then
                      
          select entity_master_id into v_entity_master_id from labecn.labecn_entity_role_map
					  where entity_role_id = 11 and source_object_id = v_source_object_id;                        
                      
          update labecn.labecn_entity_master
          set entity_name=v_name,
          entity_display_name=v_name,
          canonical_url=lower('/players/'||replace(TRIM(v_name),' ','-')||'-'||v_source_object_id),
          updated_date=current_timestamp,
          is_active=1,
          is_deleted=0,
          known_as=v_name,
          wafc_entity_name=v_name,
          wafc_entity_display_name=v_name
          where entity_master_id = v_entity_master_id;
		
        update labecn.labecn_entity_role_map
        set updated_date=current_timestamp
        where entity_master_id = v_entity_master_id;
        
		 end if;
         
    end if;
    
    end loop ;
    
    
		p_data :=  '{
	 				"status" : 1
	 				}';
   
	
	end if;
	
	
	 
   
     exception
     when others then
     p_data := '{ "status" : -1}';

	end;

	
$$;


--
