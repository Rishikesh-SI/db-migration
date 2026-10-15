-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_sync_entity_data(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_sync_entity_data(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_sync_entity_data(p_json jsonb, OUT p_result numeric, OUT p_output_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_ref_entity_master_id numeric;
v_entity_role_id numeric;
v_entity_group_id numeric;
v_entity_type_id numeric;
v_entity_name text;
v_entity_master_id numeric;
v_created_date timestamp without time zone;
v_updated_date timestamp without time zone;
v_entity_guid varchar(256);
v_entity_role_map_id numeric;
v_count numeric;
v_search_query text :=' ';
v_search_keyword text;
v_count1 numeric;
V_entity_display_name text;
v_source_object_id text;
v_queery text;
v_client_id numeric;
v_created_by numeric;
v_updated_by numeric;
v_is_active numeric;
v_is_deleted numeric;
v_canonical_url varchar(300);
v_player_image_path varchar(300);
v_entity_url varchar(300);
v_show_data numeric;
v_show_content numeric;
v_entity_role_map_id_1 numeric;
v_count_entity numeric:=0;
v_entity_master_id1 numeric;
v_currenttimestamp timestamp;
v_ref_id numeric;
v_canonical_url_old varchar(300);
v_entity_name_old character varying;
v_unique_code character varying;
begin

select   p_json->'data'->>'entity_name',
         p_json->'data'->>'entity_master_id', 
         p_json->'data'->>'entity_display_name',
         p_json->'data'->>'source_object_id',
		 p_json->'data'->>'entity_group_id', 
		 p_json->'data'->>'entity_type_id',
		 p_json->'data'->>'client_id', 
		 p_json->'data'->>'created_by', 
		 p_json->'data'->>'updated_by', 
		 p_json->'data'->>'is_active', 
		 p_json->'data'->>'is_deleted',
		 p_json->'data'->>'canonical_url',
		 p_json->'data'->>'player_image_path',
		 p_json->'data'->>'entity_url',
		 p_json->'data'->>'show_data',
		 p_json->'data'->>'show_content',
		 p_json->'data'->>'ref_entity_master_id',
		 p_json->'data'->>'unique_code'
         into
         v_entity_name,
         v_entity_master_id,
         V_entity_display_name,
         v_source_object_id,
		 v_entity_group_id,
		 v_entity_type_id,
		 v_client_id,
		 v_created_by,
		 v_updated_by,
		 v_is_active,
		 v_is_deleted,
		 v_canonical_url,
		 v_player_image_path,
		 v_entity_url,
		 v_show_data,
		 v_show_content,
		 v_ref_entity_master_id,
		 v_unique_code;

    select current_timestamp at time zone 'utc' into v_currenttimestamp;

	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'_ins_upd_del_entity_details',
	'{"exception":""}',uuid_generate_v4(),p_json,v_currenttimestamp,'labkc_v1','db-error');

v_created_date     := current_timestamp;
v_updated_date     := current_timestamp;

	select entity_role_id from labkc_v1.labkc_v1_entity_role 
    where entity_group_id=v_entity_group_id and entity_type_id=v_entity_type_id
    into v_entity_role_id;

	
  --v_queery:='select entity_role_id from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role 
     --      where entity_group_id='||v_entity_group_id||' and entity_type_id='||v_entity_type_id||'';
  
  --raise notice '% gourp ', v_entity_group_id;
  
  --raise notice '% type ', v_entity_type_id;
  
  --raise notice '% role ', v_entity_role_id;
  
 -- raise notice '% query ', v_queery;
  
-- raise notice 'v_entity_role_id %',v_entity_role_id;

--if exists (select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map
--			where ref_id = (p_schema_prefix||v_ref_entity_master_id)::text) then 

		
		if not exists (select 1 from labkc_v1.labkc_v1_entity_role_map where entity_code=v_unique_code) then
					
		v_entity_master_id:=nextval('labkc_v1.seq_labkc_v1_entity_master_id') ;
		
		v_entity_role_map_id:= nextval('labkc_v1.seq_labkc_v1_entity_role_map_id');
		
        --v_canonical_url :=CONCAT(v_canonical_url,'-', v_entity_role_map_id);
		--v_entity_url :=CONCAT(v_entity_url,'-', v_entity_role_map_id);
		v_entity_guid      := uuid_generate_v4();

 
		insert into labkc_v1.labkc_v1_entity_master (entity_master_id,waf_entity_master_id,
											 client_id,entity_name,entity_display_name,
											 canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,
											 is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,
											 waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name,player_image_path
											 ,entity_url,show_data,show_content)
			values (v_entity_master_id,0,v_client_id,v_entity_name,V_entity_display_name,v_canonical_url,1,v_created_date,v_updated_date,v_created_by,v_updated_by,1,0,null,null,null,v_entity_name,null,null,null,v_entity_guid,v_entity_name,V_entity_display_name,v_player_image_path,v_entity_url,v_show_data,v_show_content);

			Insert into labkc_v1.labkc_v1_entity_role_map (entity_role_map_id,entity_role_id,
											 entity_master_id,priority,is_active,source_object_id,created_date,
											 updated_date,hyperlink,entity_code)
				values(v_entity_role_map_id,v_entity_role_id,v_entity_master_id,1,1,v_source_object_id,v_created_date,v_updated_date,0,v_unique_code);

		p_result := v_entity_master_id; 
		
	  
    elsif exists (select 1 from labkc_v1.labkc_v1_entity_role_map where entity_code=v_unique_code)then
		raise notice'old';				

	 	--	if (v_entity_role_id is not null) and (v_source_object_id is not null) then
/*			
				select b.entity_master_id
				from labkc_v1.labkc_v1_entity_role_map  a
				join labkc_v1.labkc_v1_entity_master b
				on a.entity_master_id=b.entity_master_id
				where a.entity_role_id = v_entity_role_id
				and a.source_object_id = v_source_object_id
				and a.is_active=1 
				into v_entity_master_id1;

		 	end if;
*/
			select entity_master_id into v_entity_master_id
			from labkc_v1.labkc_v1_entity_role_map
			where entity_code = v_unique_code;
			
	--	   if (v_entity_master_id1 = v_entity_master_id) or (v_entity_master_id1 is null) then

		  		-- raise notice 'v_entity_name %',v_entity_name;
	
     		    select canonical_url,entity_name
         	    from labkc_v1.labkc_v1_entity_master a
           		where entity_master_id = v_entity_master_id 
		        and a.is_active=1 and a.is_deleted=0
			    into v_canonical_url_old,v_entity_name_old;
	
		--if v_ref_id > 0 then
 
			update labkc_v1.labkc_v1_entity_master
            set entity_name= v_entity_name,
            entity_display_name = V_entity_display_name,
            updated_date= v_updated_date,
			updated_by=v_updated_by,
			canonical_url=v_canonical_url,
			player_image_path=v_player_image_path,
			is_active=v_is_active,
			is_deleted=v_is_deleted,
			entity_url=v_entity_url,
			show_data=v_show_data,
			show_content=v_show_content
            where entity_master_id = v_entity_master_id; 
	  
	  --if v_source_object_id is not null then 
	  
			update labkc_v1.labkc_v1_entity_role_map
            set source_object_id=v_source_object_id,entity_role_id=v_entity_role_id,is_active=v_is_active
			where entity_master_id=v_entity_master_id;
	    
	    
	  	if (v_is_deleted = 1) and (v_is_active = 0) then
		
		  	update labkc_v1.labkc_v1_asset_entity_map
			set is_active=0,is_deleted=1,is_published=0
			where entity_role_map_id in (select entity_role_map_id 
									   	from labkc_v1.labkc_v1_entity_role_map
									   	where entity_master_id=v_entity_master_id);
	     end if;
	  
	   -- end if;
/*		
	 	else 
		
	  raise notice 'v_count_entity %',v_count_entity;
	   p_result := 0;
	   p_output_json:='{}';
 	--end if;  
*/	 
	end if;
	     
	
	
    p_result := v_entity_master_id; 
   
	p_output_json := p_json;

			
end;
$$;


--
