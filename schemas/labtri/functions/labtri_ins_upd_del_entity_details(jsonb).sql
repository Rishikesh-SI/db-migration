-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_ins_upd_del_entity_details(jsonb)
-- Type: FUNCTION

-- Name: labtri_ins_upd_del_entity_details(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_ins_upd_del_entity_details(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
v_entity_url varchar;
v_show_data numeric;
v_show_content numeric;
v_canonical_url_old varchar(300);
-- i record ;
v_json jsonb;
v_entity_role_map_id_1 numeric;
v_tour_id numeric;
v_asset_type_id numeric;
v_ref_guid varchar;
v_ref_id numeric;
v_city varchar(300);
v_country varchar(300);
v_add_info jsonb;
v_langcode character varying;
--v_source_object_id CHARACTER VARYING;
v_previous_featured_homepage numeric;
v_featured_homepage numeric;
begin

select   p_json->'data'->>'ref_id',
         p_json->'data'->>'langcode', 
         p_json->'data'->>'canonical_url',
         p_json->'data'->>'entity_name',
		 p_json->'data'->>'entity_url',
		 p_json->'data'->>'ref_guid',
		 p_json->'data'->>'add_info',
		 p_json->'data'->>'asset_type_id',
		 p_json->'data'->>'is_active',
		 p_json->'data'->>'is_deleted',
		 p_json->'data'->>'source_object_id',
		 p_json->'data'->'add_info'->>'featured_homepage'
         into
         v_ref_id,
         v_langcode,
         v_canonical_url,
         v_entity_name,
		 v_entity_url,
		 v_ref_guid,
		 v_add_info,
		 v_asset_type_id,
		 v_is_active,
		 v_is_deleted,
		 v_source_object_id,
		 v_featured_homepage
		 ;
       
	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'_ins_upd_del_entity_details',
	'{"exception":""}',uuid_generate_v4(),p_json,current_timestamp,'labtri','db-error');

   
			v_created_date     := current_timestamp;
			v_updated_date     := current_timestamp;

         --  select entity_role_id from labtri.labtri_entity_role 
         --  where entity_group_id= v_entity_group_id and entity_type_id = v_entity_type_id
        --   into v_entity_role_id;
         
		select entity_role_id from labtri.labtri_asset_type
		where asset_type_id = v_asset_type_id  
		into v_entity_role_id; 
		
		-- raise notice '%',v_entity_role_id;
		-- select 1/0;

		   if not exists  ( select 1 from labtri.labtri_entity_master a
					  join labtri.labtri_entity_role_map b on a.entity_master_id=b.entity_master_id
					  join labtri.labtri_asset_type c on c.entity_role_id = b.entity_role_id 	   
					  where b.ref_id = v_ref_id
					  and asset_type_id = v_asset_type_id
					  and a.is_active=1 and a.is_deleted=0
					  -- and b.entity_role_id= v_entity_role_id 
						  ) then

	     
	     v_entity_master_id :=  nextval('labtri.seq_labtri_entity_master_id') ;
		 v_entity_role_map_id := nextval('labtri.seq_labtri_entity_role_map_id');
	     v_entity_guid      := uuid_generate_v4();
		  
		  
		  		
			select previous_featured_homepage
			into v_previous_featured_homepage
			from labtri.labtri_entity_master
			where entity_master_id=v_entity_master_id;
		  
		-- execute 'select nextval(''labtri.seq_labtri_entity_master_id'')' into v_entity_master_id;
		-- execute 'select nextval(''labtri.seq_labtri_entity_role_map_id'')' into v_entity_role_map_id;
         
		 if v_canonical_url is null or v_canonical_url = '' then
		 
		 	v_canonical_url := lower(replace(v_entity_name,' ','-'));
		
		end if;
		-- v_entity_url :=CONCAT(v_entity_url,'-', v_entity_role_map_id);
		
	   
		insert into labtri.labtri_entity_master (entity_master_id,waf_entity_master_id,
											 client_id,entity_name,entity_display_name,
											 canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,
											 is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,
											 waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name,player_image_path
											 ,entity_url,show_data,show_content,country_name,add_info,previous_featured_homepage)
	     values (v_entity_master_id,0,1,v_entity_name,v_entity_name,v_canonical_url,1,v_created_date,v_updated_date,
				 0,0,1,0,null,v_city,null,v_entity_name,null,null,null,v_entity_guid,v_entity_name,v_entity_name,
				 v_player_image_path,v_entity_url,v_show_data,v_show_content,v_country,v_add_info,v_featured_homepage);

		 Insert into labtri.labtri_entity_role_map (entity_role_map_id,entity_role_id,
											 entity_master_id,priority,is_active,source_object_id,created_date,
											 updated_date,hyperlink,tour_id,ref_id,ref_guid)
				values(v_entity_role_map_id,v_entity_role_id,v_entity_master_id,1,1,v_source_object_id,v_created_date,v_updated_date,0,v_tour_id,
				v_ref_id,v_ref_guid);
		 
		 p_result := 1; 
		 
		 
		-- raise notice '%',p_data;
		 
		else
		
					select a.entity_master_id
					into v_entity_master_id
					from labtri.labtri_entity_master a
					join labtri.labtri_entity_role_map b on a.entity_master_id=b.entity_master_id
					where b.ref_id = v_ref_id
					and a.is_active=1 and a.is_deleted=0
					and b.entity_role_id= v_entity_role_id;
		
		
					select entity_role_map_id into v_entity_role_map_id
					from labtri.labtri_entity_role_map b
					where b.ref_id = v_ref_id;
		
		
				
			select previous_featured_homepage
			into v_previous_featured_homepage
			from labtri.labtri_entity_master
			where entity_master_id=v_entity_master_id;
		
		       --     v_canonical_url := lower(replace(v_entity_name,' ','-'));
		
		            --select canonical_url into v_canonical_url_old
         	        -- from labtri.labtri_entity_master a
           		    -- where entity_master_id = v_entity_master_id 
		           --  and a.is_active=1 and a.is_deleted=0 ;
       
	  -- v_canonical_url := lower(replace(v_entity_name,' ','-'));
	   
		 if v_is_deleted = 1 then
 
 		update labtri.labtri_entity_master
         set   is_active= v_is_active,
			   is_deleted= v_is_deleted
        where  entity_master_id = v_entity_master_id ;
		
		update labtri.labtri_entity_role_map
     	set    is_active= v_is_active
       where entity_master_id = v_entity_master_id ;
 
 else
 raise notice 'v_add_info %',v_add_info;
         update labtri.labtri_entity_master
         set   entity_name= v_entity_name,
               entity_display_name = v_entity_name,
               updated_date= v_updated_date,
			   updated_by=v_updated_by,
			   canonical_url=v_canonical_url,
			   entity_url=v_entity_url,
			   player_image_path=v_player_image_path,
			   is_active=v_is_active,
			   is_deleted=v_is_deleted,
			   show_data=v_show_data,
			   show_content=v_show_content,
			   city = v_city,
			   country_name = v_country,
			   add_info=v_add_info,
			   previous_featured_homepage=v_featured_homepage
        where  entity_master_id = v_entity_master_id ;
		
	  
	 update labtri.labtri_entity_role_map
     set source_object_id = v_source_object_id
     where entity_master_id = v_entity_master_id ;
	 
 end if;
		   
		  
		   
		   p_result := 1; 

	  		end if ;
		   
	
		 p_data:= p_json;
		 p_data := jsonb_set(p_data,'{data,entity_master_id}', v_entity_master_id::text::jsonb, true);
		 p_data := jsonb_set(p_data,'{data,entity_role_map_id}', v_entity_role_map_id::text::jsonb, true);	
 		 p_data := jsonb_set(p_data,'{data,previous_featured_homepage}', coalesce(v_previous_featured_homepage::text,'null')::text::jsonb, true);

	
	
--     p_result := v_entity_master_id; 
	

   

		 
end;
$$;


--
