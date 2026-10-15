-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_ins_upd_ad(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_ins_upd_ad(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_ins_upd_ad(p_ad_json jsonb, OUT p_result numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_json jsonb := p_ad_json;
	v_ad_id numeric;
	v_title text;
	v_html text;
	v_ad_position numeric;
	v_status numeric;
	v_is_trashed numeric;
	v_published_date timestamp;
	v_created_date timestamp;
	v_modified_date timestamp;
	v_created_by numeric;
	v_edited_by numeric;
	v_guid varchar(256);
	v_is_default numeric;
	v_entity_data jsonb;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_asset_draft_id numeric;
	v_ad_asset_type_id numeric := 16;
	v_version_number numeric;
	v_asset_draft_guid varchar(256);
	v_asset_guid varchar(256);
	v_first_time numeric := 0;
	v_published_version_number numeric;
	v_draft_version_number numeric;
	v_entity json;
	v_entity_role_map_id numeric;
	v_priority numeric;
	v_is_linkable numeric;
	v_is_visible numeric;
	v_asset_entity_map_id numeric;
	v_asset_entity_map_guid varchar(256);
	v_entity_role_map_id_arr numeric[];
	v_entity_count numeric;
	v_asset_count numeric;
	v_ad_client text;
	v_ad_client_arr numeric[];
	v_continue numeric := 1;
	v_i numeric := 1;
	v_is_detail numeric;
	v_asset_draft_id_arr numeric[];
	v_ad_asset_draft_id numeric;
	v_ad_entity_data jsonb;
	v_ad_entity_role_map_id_arr numeric[];
    v_ad_id_1 numeric;
	
begin
	
	select v_json->'data'->>'ad_id',
			v_json->'data'->>'title',
			v_json->'data'->>'html',
			v_json->'data'->>'ad_position',
			v_json->'data'->>'status',
			v_json->'data'->>'is_trashed',
			v_json->'data'->>'published_date',
			v_json->'data'->>'created_date',
			v_json->'data'->>'modified_date',
			v_json->'data'->>'created_by',
			v_json->'data'->>'edited_by',
			v_json->'data'->>'guid',
			v_json->'data'->>'is_default',
			v_json->'data'->>'ad_client',
			v_json->'data'->>'is_detail',
			v_json->'data'->>'entitydata'
	into v_ad_id,
			v_title,
			v_html,
			v_ad_position,
			v_status,
			v_is_trashed,
			v_published_date,
			v_created_date,
			v_modified_date,
			v_created_by,
			v_edited_by,
			v_guid,
			v_is_default,
			v_ad_client,
			v_is_detail,
			v_entity_data;
               
               
	 
	
	select ('{'||replace(v_ad_client,'/',',')||'}')::numeric[] into v_ad_client_arr;
	
	if v_status = 0 and v_is_trashed = 0 then
	
		select array(select c->>'entity_role_map_id' from (select json_array_elements(a::json) c from (select v_entity_data a) b) d)::numeric[]
		into v_entity_role_map_id_arr;
		
		select array(select ad.asset_draft_id
						from labdd_v1.labdd_v1_asset_draft as ad
						where ad.asset_type_id = v_ad_asset_type_id
						and ad.version_number = (select max(ad1.version_number) from labdd_v1.labdd_v1_asset_draft as ad1
													where  ad1.asset_id = ad.asset_id
													and ad1.asset_type_id = ad.asset_type_id)
						and ((exists (select ad_id from labdd_v1.labdd_v1_advertisement a
										where a.ad_id = ad.asset_id
										and a.is_published = 0
										and a.is_trashed = 0))
							or (ad.version_number > (select max(published_version_number) from labdd_v1.labdd_v1_advertisement a
														where a.ad_id = ad.asset_id)))
						and (ad.asset_data->'data'->>'ad_position')::numeric = v_ad_position
						and (ad.asset_data->'data'->>'ad_client') = v_ad_client
						and (ad.asset_data->'data'->>'is_detail')::numeric = v_is_detail
						and (ad.asset_data->'data'->>'is_default')::numeric = v_is_default)
		into v_asset_draft_id_arr;
		
		foreach v_ad_asset_draft_id in array v_asset_draft_id_arr
		loop
			
			select asset_data->'data'->>'entitydata' into v_ad_entity_data from labdd_v1.labdd_v1_asset_draft where asset_draft_id = v_ad_asset_draft_id;
			
			select array(select c->>'entity_role_map_id' from (select json_array_elements(a::json) c from (select v_ad_entity_data a) b) d)::numeric[]
			into v_ad_entity_role_map_id_arr;
			
			if v_entity_role_map_id_arr <@ v_ad_entity_role_map_id_arr then
				v_continue := -1;
				exit;
			else
				v_continue := 1;
			end if;
			
		end loop;
		
	elsif v_status = 1 then
     
		if (( v_entity_data != '[]'::jsonb) or ( v_entity_data is not null ) ) then
			
              
               
			select array(select c->>'entity_role_map_id' from (select json_array_elements(a::json) c from (select v_entity_data a) b) d)::numeric[]
			into v_entity_role_map_id_arr;
			
			select count(1) into v_entity_count from (select entity_id from unnest(v_entity_role_map_id_arr::numeric[]) u(entity_id)) a;
			
			select count(1) into v_asset_count
			from labdd_v1.labdd_v1_asset_entity_map aem
			where asset_type_id = v_ad_asset_type_id
			and exists(select 1
						from labdd_v1.labdd_v1_asset_entity_map aem1
						where aem1.asset_id = aem.asset_id
						and aem1.asset_type_id = aem.asset_type_id
						and aem1.entity_role_map_id in(select entity_id from unnest(v_entity_role_map_id_arr::numeric[]) u(entity_id))
						and aem1.asset_id in(select ad_id from labdd_v1.labdd_v1_advertisement
												where ad_position = v_ad_position
												and v_ad_client_arr[v_i] = any(ad_client)
												and is_published = 1
												and is_detail = v_is_detail
												and is_default = v_is_default)
						and aem1.asset_id <> coalesce(v_ad_id, 0)
						group by aem1.asset_id,aem1.asset_type_id
						having count(1) = v_entity_count)
			group by aem.asset_id,aem.asset_type_id
			having count(1) = v_entity_count;
      

                          
          
            if v_asset_count > 0 then
                v_continue := -1;
            end if;
			
          
		else
          
    
          
            select count(1) into v_asset_count
            from labdd_v1.labdd_v1_advertisement
            where ad_position = v_ad_position
            and v_ad_client_arr[v_i] = any(ad_client)
            and is_published = 1
            and is_detail = v_is_detail
            and is_default = v_is_default;
            
            select ad_id into v_ad_id_1
            from labdd_v1.labdd_v1_advertisement
            where ad_position = v_ad_position
            and v_ad_client_arr[v_i] = any(ad_client)
            and is_published = 1
            and is_detail = v_is_detail
            and is_default = v_is_default;
            
            
           
            if v_asset_count > 0 then
                v_continue := -1;
            end if;
			
		end if;
		  
	end if;
	
	
	
	
	if ((v_asset_count = 0 or v_asset_count is null) and v_continue = 1) then

		
		if v_ad_id is null then
			
			v_asset_draft_id := nextval('labdd_v1.seq_labdd_v1_asset_draft_id');
			v_ad_id := nextval('labdd_v1.seq_labdd_v1_ad_id');
			v_version_number := 1;
			v_asset_draft_guid := uuid_generate_v4();
			v_asset_guid := uuid_generate_v4();
			v_json := jsonb_set(v_json,'{data,ad_id}',v_ad_id::text::jsonb,true);
			v_json := jsonb_set(v_json,'{data,guid}',('"'||v_asset_guid||'"')::text::jsonb,true);
			v_json := jsonb_set(v_json,'{data,created_date}',('"'||v_current_timestamp||'"')::text::jsonb,true);
			v_json := jsonb_set(v_json,'{data,modified_date}',('"'||v_current_timestamp||'"')::text::jsonb,true);
			v_json := jsonb_set(v_json,'{data,version_number}',v_version_number::text::jsonb,true);
			v_first_time := 1;
			
			insert into labdd_v1.labdd_v1_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,created_by,
											updated_by,is_active,is_deleted,asset_draft_guid)
			select v_asset_draft_id,v_ad_id,v_ad_asset_type_id,v_version_number,v_json,v_current_timestamp,v_current_timestamp,v_created_by,
					v_edited_by,1,0,v_asset_draft_guid;
			
			insert into labdd_v1.labdd_v1_advertisement(ad_id,ad_title,ad_code,ad_position,is_published,is_trashed,published_version_number,published_date,is_active,
									is_deleted,created_by,updated_by,created_date,updated_date,ad_guid,is_default,ad_client,is_detail)
			select v_ad_id,v_title,v_html,v_ad_position,v_status,v_is_trashed,v_version_number,v_published_date,1,0,v_created_by,v_edited_by,
					v_current_timestamp,v_current_timestamp,v_asset_guid,v_is_default,v_ad_client_arr,v_is_detail;
			
			p_result := 1;
			p_json := v_json;
            
    else
				
                    
				v_asset_draft_id := nextval('labdd_v1.seq_labdd_v1_asset_draft_id');
				v_asset_draft_guid := uuid_generate_v4();
				
                   
                    
				select coalesce(max(version_number),0) into strict v_draft_version_number
				from labdd_v1.labdd_v1_asset_draft where asset_id = v_ad_id and asset_type_id = v_ad_asset_type_id;
				
				v_draft_version_number := v_draft_version_number + 1;
                   
		
				v_json := jsonb_set(v_json,'{data,modified_date}',('"'||v_current_timestamp||'"')::text::jsonb,true);
				
				v_json := jsonb_set(v_json,'{data,version_number}',v_draft_version_number::text::jsonb,true);
				
			
				insert into labdd_v1.labdd_v1_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,created_by,
												updated_by,is_active,is_deleted,asset_draft_guid)
				select v_asset_draft_id,v_ad_id,v_ad_asset_type_id,v_draft_version_number,v_json,v_current_timestamp,v_current_timestamp,v_created_by,
						v_edited_by,1,0,v_asset_draft_guid;
				 
				update labdd_v1.labdd_v1_advertisement
				set ad_title = v_title, ad_code = v_html, is_published = v_status, is_trashed = v_is_trashed, published_date = v_published_date,
					updated_date = v_current_timestamp, updated_by = v_edited_by, is_default = v_is_default, ad_client = v_ad_client_arr,
					published_version_number = v_draft_version_number, ad_position = v_ad_position, is_detail = v_is_detail
				where ad_id = v_ad_id;
                
             p_result := 1;
			p_json := v_json;

            end if;
			
	else
		  
			if v_status = 0 then 
               
				if v_is_trashed = 0 then
					
					select coalesce(max(published_version_number),1) into strict v_published_version_number from labdd_v1.labdd_v1_advertisement where ad_id = v_ad_id;
					
					select max(version_number) into strict v_draft_version_number
					from labdd_v1.labdd_v1_asset_draft
					where asset_type_id = v_ad_asset_type_id and asset_id = v_ad_id;
					
					if v_draft_version_number > v_published_version_number then
					
						update labdd_v1.labdd_v1_asset_draft ad
						set asset_data = v_json, updated_date = v_current_timestamp
						where asset_id = v_ad_id and asset_type_id = v_ad_asset_type_id
						and ad.version_number = (select max(ad1.version_number)
													from labdd_v1.labdd_v1_asset_draft ad1
													where ad1.asset_id = ad.asset_id
													and ad1.asset_type_id = v_ad_asset_type_id);
						p_result := 1;
			            p_json := v_json;
					else
						
						v_draft_version_number := v_draft_version_number + 1;
						v_asset_draft_id := nextval('labdd_v1.seq_labdd_v1_asset_draft_id');
						v_asset_draft_guid := uuid_generate_v4();
						v_json := jsonb_set(v_json,'{data,modified_date}',('"'||v_current_timestamp||'"')::text::jsonb,true);
						v_json := jsonb_set(v_json,'{data,version_number}',v_draft_version_number::text::jsonb,true);
						
						insert into labdd_v1.labdd_v1_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,
														created_by,updated_by,is_active,is_deleted,asset_draft_guid)
						select v_asset_draft_id,v_ad_id,v_ad_asset_type_id,v_draft_version_number,v_json,v_current_timestamp,v_current_timestamp,
								v_created_by,v_edited_by,1,0,v_asset_draft_guid;
						p_result := 1;
			            p_json := v_json;
					end if;
					
				else
					
					update labdd_v1.labdd_v1_advertisement
                    set is_trashed = v_is_trashed, is_published = v_status, updated_date = v_current_timestamp, ad_position = v_ad_position,
						is_detail = v_is_detail
                    where ad_id = v_ad_id;
					
					update labdd_v1.labdd_v1_asset_draft ad
					set asset_data = v_json, updated_date = v_current_timestamp
					where asset_id = v_ad_id
					and asset_type_id = v_ad_asset_type_id
					and ad.version_number = (select max(ad1.version_number) from labdd_v1.labdd_v1_asset_draft ad1
												where ad1.asset_id = ad.asset_id and ad1.asset_type_id = v_ad_asset_type_id);
					p_result := 1;
			        p_json := v_json;
				end if;
				
			else
       
            
				if (v_ad_id = v_ad_id_1) then
                    
				v_asset_draft_id := nextval('labdd_v1.seq_labdd_v1_asset_draft_id');
				v_asset_draft_guid := uuid_generate_v4();
				
                   
                    
				select coalesce(max(version_number),0) into strict v_draft_version_number
				from labdd_v1.labdd_v1_asset_draft where asset_id = v_ad_id and asset_type_id = v_ad_asset_type_id;
				
				v_draft_version_number := v_draft_version_number + 1;
                   
		
				v_json := jsonb_set(v_json,'{data,modified_date}',('"'||v_current_timestamp||'"')::text::jsonb,true);
				
				v_json := jsonb_set(v_json,'{data,version_number}',v_draft_version_number::text::jsonb,true);
				
			
				insert into labdd_v1.labdd_v1_asset_draft(asset_draft_id,asset_id,asset_type_id,version_number,asset_data,created_date,updated_date,created_by,
												updated_by,is_active,is_deleted,asset_draft_guid)
				select v_asset_draft_id,v_ad_id,v_ad_asset_type_id,v_draft_version_number,v_json,v_current_timestamp,v_current_timestamp,v_created_by,
						v_edited_by,1,0,v_asset_draft_guid;
				 
				update labdd_v1.labdd_v1_advertisement
				set ad_title = v_title, ad_code = v_html, is_published = v_status, is_trashed = v_is_trashed, published_date = v_published_date,
					updated_date = v_current_timestamp, updated_by = v_edited_by, is_default = v_is_default, ad_client = v_ad_client_arr,
					published_version_number = v_draft_version_number, ad_position = v_ad_position, is_detail = v_is_detail
				where ad_id = v_ad_id;
                p_result := 1;
			    p_json := v_json;
            else 
          
                p_result := -2;
			    p_json := v_json;
				
				end if;
				
			end if;
	
		end if;
		
		

		
		/*p_result := 1;
		p_json := v_json;*/
          
          
		
		if (v_first_time = 1 or (v_ad_id is not null and v_status = 1)) then
			
            delete from labdd_v1.labdd_v1_asset_entity_map where asset_id = v_ad_id and asset_type_id = v_ad_asset_type_id;
            
			if v_entity_data is not null then
				
				-- delete from labdd_v1.labdd_v1_asset_entity_map where asset_id = v_ad_id and asset_type_id = v_ad_asset_type_id;
				
				for v_entity in select * from json_array_elements(v_entity_data::json)
				loop
					
					select v_entity->>'entity_role_map_id',v_entity->>'priority',v_entity->>'is_linkable',v_entity->>'is_visible'
					into v_entity_role_map_id,v_priority,v_is_linkable,v_is_visible;
					
					if v_entity_role_map_id is not null then
						
						v_asset_entity_map_id := nextval('labdd_v1.seq_labdd_v1_asset_entity_map_id');
						v_asset_entity_map_guid := uuid_generate_v4();
						
						insert into labdd_v1.labdd_v1_asset_entity_map(asset_entity_map_id,asset_id,asset_type_id,entity_role_map_id,is_linkable,is_visible,
																priority,created_date,updated_date,created_by,updated_by,is_active,is_deleted,
																is_published,aemap_guid)
						select v_asset_entity_map_id,v_ad_id,v_ad_asset_type_id,v_entity_role_map_id,v_is_linkable,v_is_visible,v_priority,
								v_current_timestamp,v_current_timestamp,v_edited_by,v_edited_by,1,0,1,v_asset_entity_map_guid;
						
					end if;     
					
				end loop;
				
			end if;
			
		end if;
	
	/*else
		
		p_result := -2;
		p_json := v_json;
		
	end if;*/
	
/*exception
	when others then
		p_result := -1;
		p_json := '{"data": {}}'::jsonb;*/
	
end;

$$;


--
