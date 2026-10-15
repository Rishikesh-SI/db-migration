-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_ins_upd_del_entity_details_backup_17june2026(jsonb)
-- Type: FUNCTION

-- Name: labfih_ins_upd_del_entity_details_backup_17june2026(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_ins_upd_del_entity_details_backup_17june2026(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
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
v_canonical_url_old varchar(300);
-- i record ;
v_json jsonb;
v_entity_role_map_id_1 numeric;
v_tour_id numeric;
v_asset_type_id numeric;

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
		 p_json->'data'->>'tour_id',
		 p_json->'data'->>'asset_type_id'
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
		 v_tour_id,
		 v_asset_type_id;
       

   
			v_created_date     := current_timestamp;
			v_updated_date     := current_timestamp;

         --  select entity_role_id from labfih.labfih_entity_role 
         --  where entity_group_id= v_entity_group_id and entity_type_id = v_entity_type_id
        --   into v_entity_role_id;
         
		select entity_role_id from labfih.labfih_asset_type
		where asset_type_id = v_asset_type_id  
		into v_entity_role_id; 
		
  if v_source_object_id is null then		

  if v_entity_master_id is null or v_entity_master_id=0 then
  
      v_entity_role_id := 22 ;
  
      if not exists  ( select 1 from labfih.labfih_entity_master a
					  join labfih.labfih_entity_role_map b on a.entity_master_id=b.entity_master_id
					  where upper(a.entity_name) = upper(v_entity_name)
					  and a.is_active=1 and a.is_deleted=0
					  and b.entity_role_id= v_entity_role_id ) then

	     
	     v_entity_master_id :=  nextval('labfih.seq_labfih_entity_master_id') ;
		 v_entity_role_map_id := nextval('labfih.seq_labfih_entity_role_map_id');
	     v_entity_guid      := uuid_generate_v4();
		  
		-- execute 'select nextval(''labfih.seq_labfih_entity_master_id'')' into v_entity_master_id;
		-- execute 'select nextval(''labfih.seq_labfih_entity_role_map_id'')' into v_entity_role_map_id;
         v_canonical_url := lower(replace(v_entity_name,' ','-'));
		-- v_entity_url :=CONCAT(v_entity_url,'-', v_entity_role_map_id);
		
	   
		insert into labfih.labfih_entity_master (entity_master_id,waf_entity_master_id,
											 client_id,entity_name,entity_display_name,
											 canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,
											 is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,
											 waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name,player_image_path
											 ,entity_url,show_data,show_content)
	     values (v_entity_master_id,0,v_client_id,v_entity_name,V_entity_display_name,v_canonical_url,1,v_created_date,v_updated_date,
				 v_created_by,v_updated_by,1,0,null,null,null,v_entity_name,null,null,null,v_entity_guid,v_entity_name,V_entity_display_name,
				 v_player_image_path,v_entity_url,v_show_data,v_show_content);

		 Insert into labfih.labfih_entity_role_map (entity_role_map_id,entity_role_id,
											 entity_master_id,priority,is_active,source_object_id,created_date,
											 updated_date,hyperlink,tour_id)
				values(v_entity_role_map_id,v_entity_role_id,v_entity_master_id,1,1,v_source_object_id,v_created_date,v_updated_date,0,v_tour_id);
		 
		 p_result := v_entity_master_id; 
		 
		 p_data := jsonb_set(p_json,'{data,entity_master_id}', v_entity_master_id::text::jsonb, true);
		 p_data := jsonb_set(p_data,'{data,entity_role_map_id}', v_entity_role_map_id::text::jsonb, true);
		 
		else
		
		p_result := -2 ;
		
	  end if ;
	  
    else
     		         select canonical_url into v_canonical_url_old
         	         from labfih.labfih_entity_master a
           		     where entity_master_id = v_entity_master_id 
		             and a.is_active=1 and a.is_deleted=0 ;
       
	   v_canonical_url := lower(replace(v_entity_name,' ','-'));
	   
 
         update labfih.labfih_entity_master
         set   entity_name= v_entity_name,
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
        where  entity_master_id = v_entity_master_id ;
	  
	  --if v_source_object_id is not null then 
	  
	 update labfih.labfih_entity_role_map
     set source_object_id=v_source_object_id,entity_role_id=v_entity_role_id
     where entity_master_id = v_entity_master_id ;
	  
	  
	
		   
		   if v_canonical_url <> v_canonical_url_old then
		   
		   	  select entity_role_map_id
         	  from labfih.labfih_entity_role_map a
           	   where entity_master_id = v_entity_master_id
               into v_entity_role_map_id_1 ;
		   
		   -- v_json := '{"entity_role_map_id" : "'||coalesce(v_entity_role_map_id_1::varchar,'')||'"}';
		  --  v_json := '{ "entity_role_map_id": "'||coalesce(v_entity_role_map_id_1::text::jsonb,'') ||'"}';
			
			 v_json := '{"entity_role_map_id" : '||v_entity_role_map_id_1::text::json||'}' ;
			
		   perform labfih.labfih_update_asset_list_json(null,v_json);
		   -- using v_json;
		   
		   end if ;
		 
		end if;
		
		else 
	       
		   if not exists  ( select 1 from labfih.labfih_entity_master a
					  join labfih.labfih_entity_role_map b on a.entity_master_id=b.entity_master_id
					  where b.source_object_id = v_source_object_id
					  and a.is_active=1 and a.is_deleted=0
					  and b.entity_role_id= v_entity_role_id ) then

	     
	     v_entity_master_id :=  nextval('labfih.seq_labfih_entity_master_id') ;
		 v_entity_role_map_id := nextval('labfih.seq_labfih_entity_role_map_id');
	     v_entity_guid      := uuid_generate_v4();
		  
		-- execute 'select nextval(''labfih.seq_labfih_entity_master_id'')' into v_entity_master_id;
		-- execute 'select nextval(''labfih.seq_labfih_entity_role_map_id'')' into v_entity_role_map_id;
         v_canonical_url := lower(replace(v_entity_name,' ','-'));
		-- v_entity_url :=CONCAT(v_entity_url,'-', v_entity_role_map_id);
		
	   
		insert into labfih.labfih_entity_master (entity_master_id,waf_entity_master_id,
											 client_id,entity_name,entity_display_name,
											 canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,
											 is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,
											 waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name,player_image_path
											 ,entity_url,show_data,show_content)
	     values (v_entity_master_id,0,v_client_id,v_entity_name,V_entity_display_name,v_canonical_url,1,v_created_date,v_updated_date,
				 v_created_by,v_updated_by,1,0,null,null,null,v_entity_name,null,null,null,v_entity_guid,v_entity_name,V_entity_display_name,
				 v_player_image_path,v_entity_url,v_show_data,v_show_content);

		 Insert into labfih.labfih_entity_role_map (entity_role_map_id,entity_role_id,
											 entity_master_id,priority,is_active,source_object_id,created_date,
											 updated_date,hyperlink,tour_id)
				values(v_entity_role_map_id,v_entity_role_id,v_entity_master_id,1,1,v_source_object_id,v_created_date,v_updated_date,0,v_tour_id);
		 
		 p_result := v_entity_master_id; 
		 
		 p_data := jsonb_set(p_json,'{data,entity_master_id}', v_entity_master_id::text::jsonb, true);
		 p_data := jsonb_set(p_data,'{data,entity_role_map_id}', v_entity_role_map_id::text::jsonb, true);
		 
		-- raise notice '%',p_data;
		 
		else
		
					select a.entity_master_id,canonical_url ,entity_role_map_id
					into v_entity_master_id,v_canonical_url_old,v_entity_role_map_id 
					from labfih.labfih_entity_master a
					join labfih.labfih_entity_role_map b on a.entity_master_id=b.entity_master_id
					where b.source_object_id = v_source_object_id
					and a.is_active=1 and a.is_deleted=0
					and b.entity_role_id= v_entity_role_id;
		
		            v_canonical_url := lower(replace(v_entity_name,' ','-'));
		
		            --select canonical_url into v_canonical_url_old
         	        -- from labfih.labfih_entity_master a
           		    -- where entity_master_id = v_entity_master_id 
		           --  and a.is_active=1 and a.is_deleted=0 ;
       
	   v_canonical_url := lower(replace(v_entity_name,' ','-'));
	   
 
         update labfih.labfih_entity_master
         set   entity_name= v_entity_name,
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
        where  entity_master_id = v_entity_master_id ;
		
		
	  
	  --if v_source_object_id is not null then 
	  
	 update labfih.labfih_entity_role_map
     set source_object_id=v_source_object_id,entity_role_id=v_entity_role_id
     where entity_master_id = v_entity_master_id ;
	  
	
	--     p_data := jsonb_set(p_json,'{data,entity_master_id}', v_entity_master_id::text::jsonb, true);
	--	 p_data := jsonb_set(p_data,'{data,entity_role_map_id}', v_entity_role_map_id::text::jsonb, true);
		   
		   if v_canonical_url <> v_canonical_url_old then
		   
		   	  select entity_role_map_id
         	  from labfih.labfih_entity_role_map a
           	   where entity_master_id = v_entity_master_id
               into v_entity_role_map_id_1 ;
		   
		   -- v_json := '{"entity_role_map_id" : "'||coalesce(v_entity_role_map_id_1::varchar,'')||'"}';
		  --  v_json := '{ "entity_role_map_id": "'||coalesce(v_entity_role_map_id_1::text::jsonb,'') ||'"}';
			
			 v_json := '{"entity_role_map_id" : '||v_entity_role_map_id_1::text::json||'}' ;
			
		   perform labfih.labfih_update_asset_list_json(null,v_json);
		   -- using v_json;
		   
		   end if ;
		   
		   p_result := v_entity_master_id; 
		
	  		end if ;
		   
	
	
	        
	  
	    end if;
	     
	
	
    p_result := v_entity_master_id; 
	
	p_data := p_json;
   

		 
end;
$$;


--
