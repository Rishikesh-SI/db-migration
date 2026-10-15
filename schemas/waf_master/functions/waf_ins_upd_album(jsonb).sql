-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ins_upd_album(jsonb)
-- Type: FUNCTION

-- Name: waf_ins_upd_album(jsonb); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_ins_upd_album(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
      
  -- variables for album start ========
    	v_album_id        	 waf_master.waf_album.album_id%type;      
    	v_albumguid          varchar(256);      
      v_albumassettypeid     numeric;
    	v_albumcontentsourceid  	 numeric;  
    	v_albumversionnumber    	 numeric := 1;
    	v_albummeta       	 varchar(4000);
      v_albumtype       	 numeric;
    	v_albumtitle        	 varchar(4000);
    	v_albumtitlealias       	 varchar(4000);
    	v_albumshorttitle    	 varchar(4000);
    	v_albumdesc      varchar(4000);
      v_albumpartnerid            numeric;
      v_albumshowinweb            numeric;
      v_albumshowinmobile            numeric;
      v_albumshowinapp            numeric;
      v_albumscoveraimage    	 varchar(4000);
      v_albumtotalassets            numeric;
      v_albumstatus           	 numeric;
      v_albumistrashed           	 numeric;
      v_coverimage              varchar(4000);
      v_albumassetid          	  numeric;
  -- variables for album end ========
  
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
  -- variables for image album end ========
  
  -- variables for entity start
      v_albumentityjson 		 json;
      v_entitymasterid  numeric;
    	v_priority 	    	numeric;
      v_is_linkable     numeric;
      v_is_visible      numeric;
      
  -- variables for entity end 
  
      v_albumimagejson    json;
      v_sysdate           timestamp;
    	v_assetentitymapid   numeric;
    	
    	v_assetentitymapguid varchar(50);    	   
      v_seojson 		 jsonb;
    	v_seodataid 		 numeric;
    	v_seodataguid 		 varchar(50);
    	
    	v_entity 			 json;
      v_images       json;
      v_imageexists 	 numeric;
      v_seoexists 		 numeric;
    	v_entityexists 	 numeric;
     
      v_img_ret        numeric;
      v_img_ret_data   json;
      
begin
	
     v_json := p_json;
     v_sysdate:= current_timestamp;
     
	select    v_json->'data'->>'album_id', 
            v_json->'data'->>'asset_type',
            v_json->'data'->>'content_source_id',
            v_json->'data'->>'album_meta',
            v_json->'data'->>'album_type',
            v_json->'data'->>'title',
            v_json->'data'->>'title_alias',
            v_json->'data'->>'short_title',
            v_json->'data'->>'album_desc',
            v_json->'data'->>'partner_id',
            v_json->'data'->>'show_in_web',
            v_json->'data'->>'show_in_mobile',
            v_json->'data'->>'show_in_app',
            v_json->'data'->>'total_assets',
            v_json->'data'->>'is_trashed',
            v_json->'data'->>'status', 
            v_json->'data'->>'uploaded_by',
            v_json->'data'->>'cover_image',
            v_json->'data'->>'seo'
    	into  v_album_id,
            v_albumassettypeid,
            v_albumcontentsourceid,
            v_albummeta,
            v_albumtype,
            v_albumtitle,
            v_albumtitlealias,
            v_albumshorttitle,
            v_albumdesc,
            v_albumpartnerid,
            v_albumshowinweb,
            v_albumshowinmobile,
            v_albumshowinapp,
            v_albumtotalassets,
            v_albumistrashed,
            v_albumstatus, 
            v_updatedby,
            v_coverimage,
            v_seojson
            ;
     
	if v_album_id is null then
     	
          v_assetdraftid   := nextval('waf_master.seq_waf_asset_draft_id');
          v_assetdraftguid := uuid_generate_v4();
          v_albumassetid   := nextval('waf_master.seq_waf_album_id');
          v_albumguid      := uuid_generate_v4();
          v_seodataid      := nextval('waf_master.seq_waf_seo_data_id');
          v_seodataguid    := uuid_generate_v4();
          
          v_json 	       := jsonb_set(v_json, '{data,album_id}', v_albumassetid::text::jsonb, true);
          v_json 	       := jsonb_set(v_json, '{data,guid}', ('"'||v_albumguid||'"')::text::jsonb, true);
          
          insert into waf_master.waf_asset_draft
          (asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
          updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
          values
          (v_assetdraftid, v_albumassetid, v_albumassettypeid, v_albumversionnumber, v_json, v_sysdate, 
          v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid);
          
          insert into waf_master.waf_album
          ( album_id, content_source_id, album_meta, album_type, title, title_alias, 
          short_title, album_desc, partner_id, show_in_web, show_in_mobile, show_in_app,
          cover_image, total_assets, published_version_number, is_trashed, created_date, 
          updated_date, created_by, updated_by, is_active, is_deleted, is_published, album_guid)
          values 
          (v_albumassetid, v_albumcontentsourceid, v_albummeta, v_albumtype, v_albumtitle, v_albumtitlealias,
          v_albumshorttitle,v_albumdesc,v_albumpartnerid,v_albumshowinweb,v_albumshowinmobile,v_albumshowinapp,
          v_coverimage, v_albumtotalassets, v_albumversionnumber, v_albumistrashed, v_sysdate,
          v_sysdate, v_updatedby, v_updatedby, 1, 0, v_albumstatus, v_albumguid);
          
          insert into waf_master.waf_seo_data
          (seo_data_id, asset_id, asset_type_id, meta_info, version_number, created_date, 
          updated_date, created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
          values
          (v_seodataid, v_albumassetid, v_albumassettypeid, v_seojson, v_albumversionnumber, v_sysdate, 
           v_sysdate, v_updatedby, v_updatedby, 1, 0, v_albumstatus, v_seodataguid);
         	
     else
     	
          if v_albumstatus = 0 then
          	
               update waf_master.waf_asset_draft ad
               set    asset_data        = v_json,
                      updated_date      = v_sysdate
               where  asset_id      = v_album_id
               and    asset_type_id = v_albumassettypeid
               and    ad.version_number = (select max(ad1.version_number)
                                           from   waf_master.waf_asset_draft ad1
                                           where  ad1.asset_id = ad.asset_id
                                           and    ad1.asset_type_id = v_albumassettypeid);
               
          else
          	
               v_assetdraftid   := nextval('waf_master.seq_waf_asset_draft_id');
               v_assetdraftguid := uuid_generate_v4();
               
               select max(version_number)
               into   strict v_albumversionnumber
                      from   waf_master.waf_asset_draft
                      where  asset_type_id = v_albumassettypeid
                      and    asset_id      = v_album_id;
          	
               v_albumversionnumber := v_albumversionnumber + 1;
               
               insert into waf_master.waf_asset_draft
               (asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
               updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
               values
               (v_assetdraftid, v_album_id, v_albumassettypeid, v_albumversionnumber, v_json, v_sysdate, 
               v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid); 
               
              update waf_master.waf_album
              set content_source_id=v_albumcontentsourceid,
                  album_meta=v_albummeta,
                  album_type=v_albumtype,
                  title=v_albumtitle,
                  title_alias=v_albumtitlealias,
                  short_title=v_albumshorttitle,
                  album_desc=v_albumdesc,
                  partner_id=v_albumpartnerid,
                  show_in_web=v_albumshowinweb,
                  show_in_mobile=v_albumshowinmobile,
                  show_in_app=v_albumshowinapp,
                  cover_image=v_coverimage, 
                  total_assets=v_albumtotalassets, 
                  published_version_number=v_albumversionnumber, 
                  is_trashed=v_albumistrashed, 
                  updated_date=v_sysdate, 
                  updated_by=v_updatedby, 
                  is_published=v_albumstatus 
                  where  album_id        	  = v_album_id;
               
			update waf_master.waf_seo_data
			set    meta_info 	 = v_seojson,
               	  updated_date  = v_sysdate
			where  asset_type_id = v_albumassettypeid
			and    asset_id      = v_album_id;
               
      delete
			from   waf_master.waf_asset_entity_map
			where  asset_type_id = v_albumassettypeid
			and    asset_id      = v_album_id;
               
          end if;
          
	end if;
     
  select v_json->'data'->'entitydata'
	into   v_albumentityjson;
     
	if v_albumentityjson is not null then
     	
          for v_entity in select * from json_array_elements(v_albumentityjson)
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
                (v_assetentitymapid, coalesce(v_album_id, v_albumassetid), v_albumassettypeid,
                v_entitymasterid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
                           v_sysdate, v_updatedby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
            	
               end if;     
          
          end loop;
          
     end if;
     
  select v_json->'data'->'images'
	into   v_albumimagejson;   
  
  delete
  from   waf_master.waf_album_asset_map
  where  album_id      = coalesce(v_album_id, v_albumassetid);
                
	if v_albumimagejson is not null then
          
          for v_images in select * from json_array_elements(v_albumimagejson)
          loop
                

               select v_images->>'image_id', v_images->>'content_source_id',
                      v_images->>'img_caption', v_images->>'img_meta',
                      v_images->>'img_desc', v_images->>'img_path',
                      v_images->>'copyright_text', v_images->>'img_file_name',
                      v_images->>'status'
               into   v_image_id, v_imagecontentsourceid,v_imagecaption,v_imagemeta,
                      v_imagedesc,v_imagepath,v_imagecopyrighttext,v_imagefilename,v_imagestatus;
            	
              perform waf_master.waf_ins_upd_image
              (
              v_images,--<p_cf_user_tour_teamid numeric>, 
              coalesce(v_album_id, v_albumassetid),--<p_cf_userid numeric>, 
              v_img_ret,--<p_procedure_name character varying>, 
              v_img_ret_data
              );
      
               /*
               if v_entitymasterid is not null then
               
                  v_assetentitymapid   := nextval('waf_master.seq_waf_asset_entity_map_id');
                  v_assetentitymapguid := uuid_generate_v4();
				
                  insert into waf_master.waf_asset_entity_map
                  (asset_entity_map_id, asset_id, asset_type_id, entity_master_id, is_linkable, is_visible,
                   priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                   is_published, aemap_guid)
            		values
                (v_assetentitymapid, coalesce(v_album_id, v_albumassetid), v_albumassettypeid,
                v_entitymasterid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
                           v_sysdate, v_updatedby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
            	
               end if;     
          */
          end loop;
          
     end if;
     
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
