-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_ins_upd_template_comp_cont_map(jsonb)
-- Type: FUNCTION

-- Name: labmao_ins_upd_template_comp_cont_map(jsonb); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_ins_upd_template_comp_cont_map(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

 

 

declare

v_json 								jsonb;

v_sysdate timestamp ;
v_template_component_content_map_id numeric;

v_template_component_map_id numeric;

v_tccmap_name varchar(200000);
 v_template_desc text;
 v_tccmap_display_name varchar(200000);
 v_updated_by numeric;
 
 v_asset_type_id numeric;
 v_tcmi_guid varchar(200);
 v_asset_type numeric :=15;
 
 v_asset_meta jsonb ;
 
 v_version_number numeric :=1;
 
 
 v_entityrolemapid numeric;
 v_priority numeric;
 v_islinkable numeric;
 v_isvisible numeric;     
 v_is_active numeric;
 v_is_published_date timestamp;
 
v_entityjson json;
v_entity jsonb; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_custom_id numeric;
v_status numeric;
-- draft --
v_assetdraftid numeric;

v_assetdraftguid  varchar(256);

v_temppublishedstatus numeric ;
                                  
                                  
                                  
v_pubversionnumber numeric;                                  
v_is_trashed numeric;    

v_is_default numeric;
begin

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/***
		get data from json
		***/
		-------------------------------------------------------------
     --  raise notice 'v_json = %', v_json;
         
		select 	    v_json->'data'->>'template_component_content_map_id',
                v_json->'data'->>'template_component_map_id',
                v_json->'data'->>'tccmap_name',
                v_json->'data'->>'tccmap_display_name',
                v_json->'data'->>'tccmap_desc' ,
                v_json->'data'->>'updated_by' ,
                v_json->'data'->>'is_active' ,
                v_json->'data'->>'published_date' ,
                v_json->'data'->>'asset_type_id' ,
                v_json->'data'->>'custom_id' ,
                v_json->'data'->>'asset_meta' ,
                v_json->'data'->>'status',
                v_json->'data'->>'entitydata',
                v_json->'data'->>'is_trashed',
                v_json->'data'->>'is_default'
                

		into        v_template_component_content_map_id,    
                v_template_component_map_id,
                v_tccmap_name,
                v_tccmap_display_name,
                v_template_desc,
                
                v_updated_by,
                v_is_active,
                v_is_published_date,
                 v_asset_type_id,
                 v_custom_id,
                v_asset_meta,
                 v_status,             
                v_entityjson,
                v_is_trashed,
                v_is_default
              
                ;
		---------------------------------------------------------------        
---  raise notice 'is_inherited = %',v_is_inherited;

   v_is_published_date:= coalesce(v_is_published_date,v_sysdate);
	  v_assetdraftid   := nextval('labmao.seq_labmao_asset_draft_id');
	  v_assetdraftguid := uuid_generate_v4();

		if (v_template_component_content_map_id is null)
		then
    
          v_tcmi_guid    := uuid_generate_v4();	
          v_template_component_content_map_id     := nextval('labmao.seq_labmao_template_component_content_map_id');
          v_json 	         := jsonb_set(v_json, '{data,template_component_content_map_id}', v_template_component_content_map_id::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_tcmi_guid||'"')::text::jsonb, true);
          v_json 	         := jsonb_set(v_json, '{data,custom_id}', v_template_component_content_map_id::text::jsonb, true);
          
          insert into labmao.labmao_template_component_content_map
          (
            template_component_content_map_id,
            template_component_map_id,
            tccmap_name,
            tccmap_display_name,
            tccmap_desc,
            order_number,
            asset_id,
            asset_type_id,
            asset_meta,
            show_in_web,
            show_in_mobile,
            show_in_app,
            is_default,
            published_version_number,
            is_trashed,
            created_date,
            updated_date,
            created_by,
            updated_by,
            is_active,
            is_deleted,
            is_published,
            published_date,
            asset_guid
          )    
          values
          (
           v_template_component_content_map_id,
           v_template_component_map_id,
           v_tccmap_name,
           v_tccmap_display_name,
           v_template_desc,
           1,
           v_template_component_content_map_id,
           v_asset_type_id,
           v_asset_meta,
           1,
           1,
           1,
           1,
           1,
           0,
           v_sysdate,
           v_sysdate,
           v_updated_by,
           v_updated_by,
           v_is_active,
              0,
             v_status,
           v_is_published_date,
           v_tcmi_guid
           
           
          );    
          
          insert into labmao.labmao_asset_draft
		           (asset_draft_id, 
               asset_id, 
               asset_type_id, 
               version_number, 
               asset_data, 
               created_date, 
               updated_date, 
               created_by,
               updated_by, 
               is_active, 
               is_deleted, 
               asset_draft_guid)
		 values
		 (v_assetdraftid,
     v_template_component_content_map_id,
     v_asset_type_id, 
     v_version_number,
     v_json, 
     v_sysdate, 
     v_sysdate, 
     v_updated_by, 
     v_updated_by, 
     1, 
     0, 
     v_assetdraftguid);
          
          
          else 
          
          
            select is_published
            into v_temppublishedstatus
            from labmao.labmao_template_component_content_map
            where template_component_content_map_id= v_template_component_content_map_id;
            
            if v_status = 0 then
              
                if v_is_trashed = 0 then
               
                select coalesce(published_version_number,1)
					      into   strict v_pubversionnumber
					      from  labmao.labmao_template_component_content_map
					      where  template_component_content_map_id = v_template_component_content_map_id;
                
                
               
                 
                 select max(version_number)
				      	 into   strict v_version_number
                 from   labmao.labmao_asset_draft
					       where  asset_type_id = v_asset_type_id
					       and    asset_id      = v_template_component_content_map_id;
                 
                --  raise notice 'vaersion 1 :  %' ,v_pubversionnumber;
                 -- raise notice 'vaersion 12 :  %' ,v_version_number;
                  
                       if ((v_version_number = v_pubversionnumber ) or (v_version_number > v_pubversionnumber)) then
                    
                       update labmao.labmao_asset_draft ad
						           set    asset_data        = v_json,
                      updated_date      = v_sysdate
						          where  asset_id          = v_template_component_content_map_id
                      and    asset_type_id     = v_asset_type_id
                      and    ad.version_number = (select max(ad1.version_number)
                                                    from   labmao.labmao_asset_draft ad1
                                                    where  ad1.asset_id = ad.asset_id
                                                    and    ad1.asset_type_id = ad.asset_type_id);
                                                    
                                                    
                                                    --------new --
                     update    labmao.labmao_template_component_content_map
                    
                    set   template_component_map_id=v_template_component_map_id,
                          tccmap_name=v_tccmap_name,
                          tccmap_display_name=v_tccmap_display_name,
                          tccmap_desc=v_template_desc ,
                          -- 
                        --  asset_meta=v_asset_meta,
                         -- is_default=v_is_default,     
                          -- is_trashed=v_is_trashed,
                         -- created_date=v_sysdate,
                        updated_date=v_sysdate, -- change by purushottam on dated 2017/08/02
                         created_by=v_updated_by, -- change by purushottam on dated 2017/08/02
                         updated_by=v_updated_by, -- change by purushottam on dated 2017/08/02                  
                          is_published=v_status,  -- change by purushottam on dated 2017/08/02
                          published_date=v_sysdate -- change by purushottam on dated 2017/08/02
                         -- published_version_number=v_version_number
                    where  template_component_content_map_id = v_template_component_content_map_id;
                    
                    -----new----
                                                    
                                                    
                                                    
                                                    
                     else
                 
                     
                     
                          v_version_number := v_version_number + 1;  
                          
                          insert into labmao.labmao_asset_draft(
                          asset_draft_id, 
                          asset_id, 
                          asset_type_id, 
                          version_number, 
                          asset_data, 
                          created_date, 
                          updated_date,
                          created_by, 
                          updated_by, 
                          is_active, 
                          is_deleted, 
                          asset_draft_guid
                          )
						         values(v_assetdraftid, 
                            v_template_component_content_map_id, 
                            v_asset_type_id, 
                            v_version_number, 
                            v_json, 
                            v_sysdate, 
                            v_sysdate, 
                            v_updated_by,
                            v_updated_by,
                            1, 
                            0, 
                            v_assetdraftguid);
						
                    end if;
                  
                  
                else 
               
                
                update labmao.labmao_template_component_content_map
					       set    is_published = v_status,
                                   is_trashed   = 1,
						            updated_date = v_sysdate
					       where  template_component_content_map_id = v_template_component_content_map_id;
                 
                         update labmao.labmao_asset_draft ad
                          set    asset_data        = v_json,
                    	           updated_date      = v_sysdate
					              where  asset_id          = v_template_component_content_map_id
					              and    asset_type_id     = v_asset_type_id
                        and    ad.version_number = (select max(ad1.version_number)
                                                from   labmao.labmao_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
                 
                 
                 end if;
                 
            else 
            
           -- raise notice 'v_template_component_content_map_id %' , v_template_component_content_map_id ;
             select max(version_number)
			    	 into   strict v_version_number
				     from   labmao.labmao_asset_draft
				     where  asset_type_id = v_asset_type_id
             and    asset_id      = v_template_component_content_map_id;
             
             
--             select max(version_number)
--			    	 --into   strict v_version_number
--				     from   labmao.labmao_asset_draft
--				     where  asset_type_id = 17
--             and    asset_id      = 70;
             
              v_version_number := v_version_number + 1;
              
          
              
              insert into labmao.labmao_asset_draft( 
              asset_draft_id, 
              asset_id, 
              asset_type_id, 
              version_number, 
              asset_data, 
              created_date, 
              updated_date,
              created_by, 
              updated_by, 
              is_active, 
              is_deleted, 
              asset_draft_guid)
				      values(
                            v_assetdraftid, 
                            v_template_component_content_map_id, 
                            v_asset_type_id, 
                            v_version_number, 
                            v_json, 
                            v_sysdate, 
                            v_sysdate, 
                            v_updated_by,
                            v_updated_by,
                            1, 
                            0, 
                            v_assetdraftguid);
                            
                            
                    update    labmao.labmao_template_component_content_map
                    
                    set   template_component_map_id=v_template_component_map_id,
                          tccmap_name=v_tccmap_name,
                          tccmap_display_name=v_tccmap_display_name,
                          tccmap_desc=v_template_desc,
                          asset_meta=v_asset_meta,
                          is_default=v_is_default,     
                          is_trashed=v_is_trashed,
                          created_date=v_sysdate,
                          updated_date=v_sysdate,
                          created_by=v_updated_by,
                          updated_by=v_updated_by,                  
                          is_published=v_status,
                          published_date=v_sysdate,
                          published_version_number=v_version_number
                    where  template_component_content_map_id = v_template_component_content_map_id;
                 
     end if;
            
            
            
            
            
            
-- */  
          
          
--		-- else
--        
--		--	update labmao.labmao_template
--     --       set 	page_id = v_page_id,
--                    template_name = v_template_name,
--                    template_desc = v_template_desc,
--                    layout_id = v_layout_id,
--                    is_inherited = 1,
--                    parent_id = v_parent_id,
--                    published_version_number = v_published_version_number,
--                    updated_date = v_sysdate,
--                    updated_by = v_updated_by,
--                    is_active = 1,
--                    is_deleted = 0,
--                    is_published = v_status,
--                    is_master = v_is_master,
--                    template_html = v_template_html,
--                    is_responsive = v_is_responsive,
--                    mobile_html = v_mobile_html
--		   where    template_id = v_template_id;

		end if;
    

                  
                     --select v_json->'data'->'entitydata'
                      --   into   v_entityjson;

                        if v_entityjson is not null then
                          
                          delete
				                 from   labmao.labmao_asset_entity_map
				                 where  asset_type_id = v_asset_type_id
				                  and    asset_id      = v_template_component_content_map_id;
                          
                         for v_entity in select * from json_array_elements(v_entityjson)
                           loop
  
                           select v_entity->>'entity_role_map_id',
                                  v_entity->>'priority',
                                  v_entity->>'is_linkable',
                                  v_entity->>'is_visible'
                           into   v_entityrolemapid,
                                  v_priority,
                                  v_islinkable,
                                  v_isvisible;

                      if (v_entityrolemapid is not null and v_priority is not null) then

                           v_assetentitymapid   := nextval('labmao.seq_labmao_asset_entity_map_id');
                          v_assetentitymapguid := uuid_generate_v4();

                           insert into labmao.labmao_asset_entity_map
                           (
                           asset_entity_map_id, 
                            asset_id, 
                            asset_type_id,  
                            entity_role_map_id, 
                            is_linkable,
                            is_visible,
                            priority,
                            created_date,
                            updated_date,
                            created_by, 
                            updated_by, 
                            is_active,
                            is_deleted, 
                            is_published,
                            aemap_guid
                            )
                          values(v_assetentitymapid,
                                 v_template_component_content_map_id, 
                                 v_asset_type_id, 
                                 v_entityrolemapid, 
                                 coalesce(v_islinkable,0), 
                                 v_isvisible, 
                                 v_priority,
                                 v_sysdate, 
                                 v_sysdate, 
                                 v_updated_by, 
                                 v_updated_by, 
                                 1, 
                                 0, 
                                 1, 
                                 v_assetentitymapguid);
                       end if;
                      end loop;
                    end if;
                   
              
    -- ==============
     v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_version_number||'"')::text::jsonb, true);
		p_result :=v_template_component_content_map_id; -- v_template_component_content_map_id;

		p_data := v_json;

end;

 

 

 
$$;


--
