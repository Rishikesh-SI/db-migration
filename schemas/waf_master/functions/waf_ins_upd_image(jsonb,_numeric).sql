-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ins_upd_image(jsonb, numeric)
-- Type: FUNCTION

-- Name: waf_ins_upd_image(jsonb, numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_ins_upd_image(p_json jsonb, p_album_id numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_json             	 jsonb;
      
    	v_assetdraftid     	 waf_master.waf_asset_draft.asset_draft_id%type;
    	v_assetdraftguid   	 varchar(50);
    	v_imageassettypeid   numeric; 
    	v_createdby        	 numeric;
    	v_updatedby        	 numeric;      
      v_albstatus          numeric;  
  
  -- variables for image start ========
    	v_image_id        	 waf_master.waf_image.image_id%type;      
    	v_imageguid          varchar(256);
    	v_imagecontentsourceid  	 numeric;  
    	v_imageversionnumber    	 numeric := 1;
    	v_imagecaption     	 varchar(4000);
    	v_imagemeta       	 varchar(4000);
    	v_imagedesc        	 varchar(4000);
    	v_imagepath       	 varchar(4000);
    	v_imagecopyrighttext    	 varchar(4000);
    	v_imagefilename      varchar(4000);
      v_imagestatus           	 numeric;
      
      v_imageassetid          	  numeric;
  -- variables for image end ========
  
  -- variables for image album start ========
    	v_image_order        	 numeric; 
    	v_imagealbstatus       numeric;
      
      v_albumassetmapid   numeric;
      v_albumassetmapguid varchar(256); 
  -- variables for image album end ========
  
  -- variables for entity start
      v_imageentityjson 		 json;
      v_entitymasterid  numeric;
    	v_priority 	    	numeric;
      v_is_linkable     numeric;
      v_is_visible      numeric;
      
  -- variables for entity end 
  
      v_albumimagejson    json;
      v_sysdate           timestamp;
    	v_assetentitymapid   numeric;
    	
    	v_assetentitymapguid varchar(256);    	   
      v_seojson 		 jsonb;
    	v_seodataid 		 numeric;
    	v_seodataguid 		 varchar(256);
    	
    	v_entity 			 json;
      v_images       json;
      v_imageexists 	 numeric;
      v_seoexists 		 numeric;
    	v_entityexists 	 numeric;
     
begin
	
     v_json := p_json;
     v_sysdate:= current_timestamp;
     
      
	select v_json->'data'->>'image_id', v_json->'data'->>'content_source_id',
                      v_json->'data'->>'img_caption', v_json->'data'->>'img_meta',
                      v_json->'data'->>'img_desc', v_json->'data'->>'img_path',
                      v_json->'data'->>'copyright_text', v_json->'data'->>'img_file_name',
                      v_json->'data'->>'status',v_json->'data'->>'uploaded_by'
               into   v_image_id, v_imagecontentsourceid,v_imagecaption,v_imagemeta,
                      v_imagedesc,v_imagepath,v_imagecopyrighttext,v_imagefilename,v_imagestatus,v_updatedby;
                      
  
	if v_image_id is null then
     	 
          v_assetdraftid   := nextval('waf_master.seq_waf_asset_draft_id');
          v_assetdraftguid := uuid_generate_v4();
          v_imageassetid   := nextval('waf_master.seq_waf_album_id');
          v_imageguid   	 := uuid_generate_v4();
         
          
          v_json 	       := jsonb_set(v_json, '{data,image_id}', v_imageassetid::text::jsonb, true);
          v_json 	       := jsonb_set(v_json, '{data,guid}', ('"'||v_imageguid||'"')::text::jsonb, true);
          
          insert into waf_master.waf_asset_draft
          (asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
          updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
          values
          (v_assetdraftid, v_imageassetid, v_imageassettypeid, v_imageversionnumber, v_json, v_sysdate, 
          v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid);
          
          insert into waf_master.waf_image(
          image_id, content_source_id, image_caption, image_meta, image_desc, image_path, 
          copyright_text, image_file_name, published_version_number, created_date, updated_date, 
          created_by, updated_by, is_active, is_deleted, is_published, image_guid) 
          values 
          (v_imageassetid, v_imagecontentsourceid,v_imagecaption, v_imagemeta, v_imagedesc, v_imagepath, 
           v_imagecopyrighttext, v_imagefilename, v_imageversionnumber, v_sysdate, v_sysdate, 
           v_updatedby, v_updatedby, 1, 0, v_imagestatus, v_imageguid); 
          
         
     else
     	
          if v_albumstatus = 0 then
          	
               update waf_master.waf_asset_draft ad
               set    asset_data        = v_json,
                      updated_date      = v_sysdate
               where  asset_id      = v_image_id
               and    asset_type_id = v_imageassettypeid
               and    ad.version_number = (select max(ad1.version_number)
                                           from   waf_master.waf_asset_draft ad1
                                           where  ad1.asset_id = ad.asset_id
                                           and    ad1.asset_type_id = v_imageassettypeid);
               
          else
          	
               v_assetdraftid   := nextval('waf_master.seq_waf_asset_draft_id');
               v_assetdraftguid := uuid_generate_v4();
               
               select max(version_number)
               into   strict v_imageversionnumber
                      from   waf_master.waf_asset_draft
                      where  asset_type_id = v_imageassettypeid
                      and    asset_id      = v_image_id;
          	
               v_imageversionnumber := v_imageversionnumber + 1;
               
               insert into waf_master.waf_asset_draft
               (asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
               updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
               values
               (v_assetdraftid, v_image_id, v_imageassettypeid, v_imageversionnumber, v_json, v_sysdate, 
               v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid); 
               
              update waf_master.waf_image
              set     content_source_id=v_imagecontentsourceid, 
                      image_caption=v_imagecaption, 
                      image_meta=v_imagemeta, 
                      image_desc=v_imagedesc, 
                      image_path=v_imagepath, 
                      copyright_text=v_imagecopyrighttext, 
                      image_file_name=v_imagefilename, 
                      published_version_number=v_imageversionnumber, 
                      updated_date=v_sysdate, 
                      updated_by=v_updatedby, 
                      is_published=v_imagestatus
                  where  image_id = v_image_id;
               
               
      delete
			from   waf_master.waf_asset_entity_map
			where  asset_type_id = v_imageassettypeid
			and    asset_id      = v_image_id;
               
          end if;
          
	end if;
     
  select v_json->'data'->'entitydata'
	into   v_imageentityjson;
     
	if v_imageentityjson is not null then
     	
          for v_entity in select * from json_array_elements(v_imageentityjson)
          loop
          	
               select v_entity->>'entity_master_id', v_entity->>'priority',
                      v_entity->>'is_linkable', v_entity->>'is_visible'
               into   v_entitymasterid, v_priority,v_is_linkable,v_is_visible;
            	
               if v_entitymasterid is not null then
               
                  v_assetentitymapid   := nextval('waf_master.seq_waf_asset_entity_map_id');
                  v_assetentitymapguid := uuid_generate_v4();
				
                  insert into waf_master.waf_asset_entity_map
                  (asset_entity_map_id, asset_id, asset_type_id, entity_master_id, is_linkable, is_visible,
                   priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                   is_published, aemap_guid)
            		values
                (v_assetentitymapid, coalesce(v_image_id, v_imageassetid), v_imageassettypeid,
                v_entitymasterid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
                           v_sysdate, v_updatedby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
            	
               end if;     
          
          end loop;
          
     end if; 
   
  
  select v_json->'data'->'imgalbum'->>'img_order', v_json->'data'->'imgalbum'->>'status'
               into   v_image_order,v_imagealbstatus ;
   
  v_albumassetmapid   := nextval('waf_master.seq_waf_asset_draft_id');
  v_albumassetmapguid := uuid_generate_v4();
  
  insert into waf_master.waf_album_asset_map
              ( album_asset_map_id, album_id, asset_order, asset_id, asset_type_id, created_date, 
              updated_date, created_by, updated_by, is_active, is_deleted, is_published)
  values 
              (v_albumassetmapid, p_album_id, v_image_order, coalesce(v_image_id, v_imageassetid), 
               v_imageassettypeid, v_sysdate, v_sysdate, v_updatedby, v_updatedby, 1, 0, v_imagealbstatus);
              
     p_result := 1;
     
    	if p_result = 1 then
    		
          p_data := v_json;
          
    	end if;
     
exception
	
     when others then
    		p_result := -1;
	
end;

$$;


--
