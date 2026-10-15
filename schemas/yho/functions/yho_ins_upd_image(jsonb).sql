-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_ins_upd_image(jsonb)
-- Type: FUNCTION

-- Name: yho_ins_upd_image(jsonb); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_ins_upd_image(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

	
declare
	
	v_json             	 jsonb;
      
    	v_assetdraftid     	yho.yho_asset_draft.asset_draft_id%type;
    	v_assetdraftguid   	 varchar(50);
    	v_imageassettypeid   numeric; 
    	v_createdby        	 yho.yho_asset_draft.created_by%type;
    	v_updatedby        	 numeric;      
      v_albstatus          numeric;  
  
  -- variables for image start ========
    	v_image_id        	 numeric;      
    	v_imageguid          varchar(256);
    	v_imagecontentsourceid  	 yho.yho_image.content_source_id%type;  
    	v_imageversionnumber    	 numeric := 1;
    	v_imagecaption     	 text;
    	v_imagemeta       	 jsonb;
    	v_imagedesc        	 text;
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
      v_entityrolemapid  numeric;
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
        v_show_copyright  numeric;
     v_content_source_link varchar(4000);
     v_order_number numeric;
     v_asset_list_id numeric;
     v_title_alias varchar(4000);
          v_name varchar(1000);
          v_status numeric;
begin
	
     v_json := p_json;
     
     v_sysdate:=  current_timestamp at time zone 'utc';
    v_imageassettypeid:=3;
                      
    select  v_json->'data'->>'image_id' ,
         v_json->'data'->>'content_source_id',
            v_json->'data'->>'img_caption',
            v_json->'data'->>'img_meta',
            v_json->'data'->>'img_desc',
            v_json->'data'->>'img_path',
            v_json->'data'->>'copyright_text',
            v_json->'data'->>'img_file_name',
           v_json->'data'->>'status',
            v_json->'data'->>'uploaded_by',
            v_json->'data'->>'show_copyright',
           v_json->'data'->>'content_source_link',
           -- v_json->'data'->>'order_number',
             v_json->'data'->>'img_title',
              v_json->'data'->>'uploaded_by'
          
    	into  v_image_id,
         v_imagecontentsourceid,
            v_imagecaption,
            v_imagemeta,
            v_imagedesc,
            v_imagepath,
            v_imagecopyrighttext,
            v_imagefilename,
            v_imagestatus,
            v_updatedby,
            v_show_copyright,
            v_content_source_link,
            -- v_order_number,
           v_title_alias,
           v_createdby
           
            ;
     
        

 v_updatedby:=12;
 
 
     -- v_imagecontentsourceid:=1;
   v_imagestatus:=1;
  
	-- if v_image_id is null then
     
          v_imageassetid   := nextval('yho.seq_yho_image_id');
          v_imageguid   	 := uuid_generate_v4();
          v_json 	       := jsonb_set(v_json, '{data,image_id}', v_imageassetid::text::jsonb, true);
          v_json 	       := jsonb_set(v_json, '{data,guid}', ('"'||v_imageguid||'"')::text::jsonb, true);
          
          insert into yho.yho_image(
          image_id, content_source_id, image_caption, image_meta, image_desc, image_path, 
          copyright_text, image_file_name, published_version_number, created_date, updated_date, 
          created_by, updated_by, is_active, is_deleted, is_published, image_guid,show_copyright,content_source_link, title_alias
          ) 
          values 
          (v_imageassetid, v_imagecontentsourceid,v_imagecaption, v_imagemeta, v_imagedesc, v_imagepath, 
           v_imagecopyrighttext, v_imagefilename, v_imageversionnumber, v_sysdate, v_sysdate, 
           v_updatedby, v_updatedby, 1, 0, v_imagestatus, v_imageguid,v_show_copyright,v_content_source_link, coalesce(v_title_alias,'')
          ); 
       
          
         
     /*else
     	
          if v_status = 0 then
          	
               update yho.yho_asset_draft ad
               set    asset_data        = v_json,
                      updated_date      = v_sysdate
               where  asset_id      = v_image_id
               and    asset_type_id = v_imageassettypeid
               and    ad.version_number = (select max(ad1.version_number)
                                           from   yho.yho_asset_draft ad1
                                           where  ad1.asset_id = ad.asset_id
                                           and    ad1.asset_type_id = v_imageassettypeid);
               
          else
          	
               v_assetdraftid   := nextval('yho.seq_yho_asset_draft_id');
               v_assetdraftguid := uuid_generate_v4();
               
               select max(version_number)
               into   strict v_imageversionnumber
                      from   yho.yho_asset_draft
                      where  asset_type_id = v_imageassettypeid
                      and    asset_id      = v_image_id;
          	
               v_imageversionnumber := v_imageversionnumber + 1;
               
               insert into yho.yho_asset_draft
               (asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
               updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
               values
               (v_assetdraftid, v_image_id, v_imageassettypeid, v_imageversionnumber, v_json, v_sysdate, 
               v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid); 
               
              update yho.yho_image
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
                      is_published=v_imagestatus,
                      show_copyright = v_show_copyright,
                      content_source_link = v_content_source_link,
                      -- order_number= v_order_number
                     title_alias = v_title_alias
                  where  image_id = v_image_id;
               
               
      delete
			from   yho.yho_asset_entity_map
			where  asset_type_id = v_imageassettypeid
			and    asset_id      = v_image_id;
               
          end if;
          
	end if;

  select v_json->'data'->>'entitydata'
	into   v_imageentityjson;
     
	if v_imageentityjson is not null then
     	
          for v_entity in select * from json_array_elements(v_imageentityjson)
          loop
          	
               select v_entity->>'entity_role_map_id', v_entity->>'priority', v_entity->>'name',
                      v_entity->>'is_linkable', v_entity->>'is_visible'
               into   v_entityrolemapid, v_priority,v_name,v_is_linkable,v_is_visible;
            	
               if v_entityrolemapid is not null then
               
                  v_assetentitymapid   := nextval('yho.seq_yho_asset_entity_map_id');
                  v_assetentitymapguid := uuid_generate_v4();
				
                  insert into yho.yho_asset_entity_map
                  (asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
                   priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                   is_published, aemap_guid)
            		values
                (v_assetentitymapid, coalesce(v_image_id, v_imageassetid), v_imageassettypeid,
                v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
                           v_sysdate, v_updatedby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
            	
                           
               end if;     
          
          end loop;
          
     end if; */
   
  
       p_result := 1;
     
    	if p_result = 1 then
    		
          p_data := v_json;
          
    	end if;
     
  
     
   
     

	
end;

 

$$;


--
