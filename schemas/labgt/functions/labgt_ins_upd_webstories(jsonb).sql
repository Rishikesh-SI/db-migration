-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ins_upd_webstories(jsonb)
-- Type: FUNCTION

-- Name: labgt_ins_upd_webstories(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_ins_upd_webstories(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare

v_json             	   jsonb;
v_assetdraftid     	   labgt.labgt_asset_draft.asset_draft_id%type;
v_assetdraftguid   	   varchar;
v_imageassettypeid     numeric; 
v_createdby        	   numeric;
v_updatedby        	   numeric;      
v_albstatus            numeric; 
v_webstory_id        	   labgt.labgt_webstory.webstory_id%type;      
v_webstory_guid            varchar;      
v_webstory_assettypeid     numeric:=142;
v_webstory_contentsourceid numeric;  
v_webstory_versionnumber   numeric := 1 ;
v_webstory_meta       	   jsonb;
v_webstory_type       	   numeric;
v_webstory_title           varchar;
v_webstory_titlalias      varchar;
v_webstory_shorttitle      varchar;
v_webstory_desc            text;
v_webstory_partnerid       numeric;
v_webstory_showinweb       numeric;
v_webstory_showinmobile    numeric;
v_webstory_showinapp       numeric;
v_albumscoveraimage    varchar;
v_webstory_totalassets     numeric;
v_webstory_status          numeric;
v_webstory_istrashed       numeric;
v_coverimage           varchar;
v_webstory_assetid         numeric;
v_published_date       timestamp;
v_webstory_assetmapid      numeric;
v_albumassetmapguid    numeric;
v_image_id        	   labgt.labgt_image.image_id%type;       
v_imageguid            varchar;
v_imagecontentsourceid numeric;  
v_imageversionnumber   numeric := 1;
v_imagecaption     	   varchar;
v_imagemeta       	   varchar;
v_imagedesc        	   varchar;
v_imagecopyrighttext   varchar;
v_imagefilename        varchar;
v_imagestatus          numeric;
v_imageassetid         numeric;
v_image_order          numeric; 
v_imagealbstatus       numeric;
v_albumentityjson 	   json;
v_entityrolemapid      numeric;
v_priority 	    	   numeric;
v_is_linkable          numeric;
v_is_visible           numeric;
v_webstory_slidejson       json;
v_sysdate              timestamp;
v_assetentitymapid     numeric;
v_assetentitymapguid   varchar;    	   
v_seojson 		       jsonb;
v_seodataid 		   numeric;
v_seodataguid 		   varchar;
v_entity 			   json;
v_images               json;
v_imageexists 	       numeric;
v_seoexists 		   numeric;
v_entityexists 	       numeric;
v_img_ret              numeric;
v_img_ret_data         json;
v_show_copyright 	   numeric;
v_content_source_link  varchar;
v_order_number         numeric;
v_asset_list_id        numeric; 
v_image_file_name      varchar;
v_image_path           varchar;
v_pubversionnumber     numeric;
v_is_cover             numeric;
v_isdeleted		   numeric;
v_isactive numeric;

v_authordatajson      json;
	v_authordata          jsonb;
  v_author_id           numeric;        
	v_action_id           numeric;
	v_authoractionid      numeric;
     v_albumexists     numeric;
     v_continue  numeric;
     p_result1 numeric;
	 v_titlealias_exist numeric := 0;
     
     v_imagealt labgt.labgt_image.image_caption%type;
     v_imagecopyright labgt.labgt_image.copyright_text%type;
     v_imagetitle labgt.labgt_image.title_alias%type;
     v_imagedescription  labgt.labgt_image.image_desc%type;
     v_photo_type_id numeric;
	 v_position_id numeric ;
	 
	 v_entity_lang_id numeric;
	 v_web_listing_json jsonb;
	  v_array numeric[];
	  v_entity_count NUMERIC;
	  v_webstory_slide_id numeric; 
	  v_slide_title character varying;
	  v_slide_desc character varying;
	  v_mediatype character varying;
	  v_vedio_url character varying;
	  v_thumbnail_url character varying;
	  v_cta_text character varying;
	  v_cta_link character varying;
	  v_tooltip_text character varying;
	  v_tooltip_link character varying;
	  v_is_slide_delete numeric;
	  v_photoimagdata jsonb;
	  v_imageName text;
	  v_imagePath text;
	  v_full_img_path text;
	  v_counter numeric;
	  v_counter1 numeric;
	  v_cover_imageid numeric;
	  v_cover_imagename character varying;
	 v_cover_imagepath character varying;
	 v_image_selected jsonb;
	 v_image jsonb;
	 
	 v_author_slug character varying;
	 v_author_name character varying;
	  
begin
	
	v_json := p_json;
	v_sysdate:=  current_timestamp at time zone 'utc';
	select v_json->'data'->>'webstory_id', 
			v_json->'data'->>'asset_type',
			v_json->'data'->>'content_source_id',
			v_json->'data'->>'webstories_meta',
			v_json->'data'->>'webstories_type',
			v_json->'data'->>'title',
			v_json->'data'->>'title_alias',
			v_json->'data'->>'short_title',
			v_json->'data'->>'webstories_desc',
			v_json->'data'->>'partner_id',
			v_json->'data'->>'show_in_web',
			v_json->'data'->>'show_in_mobile',
			v_json->'data'->>'show_in_app',
			v_json->'data'->>'total_assets',
			v_json->'data'->>'is_trashed',
			v_json->'data'->>'status', 
			v_json->'data'->>'updated_by',
			--v_json->'data'->>'cover_image',
			v_json->'data'->>'seo',
			v_json->'data'->>'show_copyright',
			v_json->'data'->>'content_source_link',
			v_json->'data'->>'published_date',
			v_json->'data'->>'order_number',
               v_json->'data'->>'slug_url'

	into  v_webstory_id,
			v_webstory_assettypeid,
			v_webstory_contentsourceid,
			v_webstory_meta,
			v_webstory_type,
			v_webstory_title,
			v_webstory_titlalias,
			v_webstory_shorttitle,
			v_webstory_desc,
			v_webstory_partnerid,
			v_webstory_showinweb,
			v_webstory_showinmobile,
			v_webstory_showinapp,
			v_webstory_totalassets,
			v_webstory_istrashed,
			v_webstory_status, 
			v_updatedby,
			--v_coverimage,
			v_seojson,
			v_show_copyright,
			v_content_source_link,
			v_published_date,
			v_order_number,
               v_webstory_titlalias;
	   
		v_webstory_assettypeid := 142;
           -- insert entry in labgt_redirect table :- changes done by rakesh bhatkar --    
	      select labgt.labgt_ins_up_redirect(v_webstory_id,v_webstory_titlalias,v_webstory_status,v_webstory_assettypeid) into p_result1; 
           -- insert entry in labgt_redirect table :- changes done by rakesh bhatkar --

		insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-webstory','logs',uuid_generate_v4(),p_json,current_timestamp,'labgt','logs');
  
  
     begin

          select webstory_id
     	into strict v_albumexists
     	from   labgt.labgt_webstory
     	where  upper(title_alias) = upper(v_titlealias) ;
          
          if v_webstory_id is null then
          	v_continue := -1;
          else
          	if v_albumexists = v_webstory_id then
          		v_continue := 1;
          	else
           		v_continue := -1;
          	end if;
          end if;
          
     exception
     	when others then
          	v_continue := 1;
	end;
     
     -- if v_continue = 1 then
     	
          with coverimage(t_json)
     as(
         values ((v_json->'data'->>'images')::json)
     )
     select (obj->'data'->>'image_id')
     into   v_coverimage
	from   coverimage ci, json_array_elements(ci.t_json#>'{}') obj
	where  (obj->'data'->>'is_cover')::numeric = 1;
                                               
	v_published_date:= coalesce(v_published_date,v_sysdate);
	v_assetdraftid   := nextval('labgt.seq_labgt_asset_draft_id');
	v_assetdraftguid := uuid_generate_v4();
	

	if (v_webstory_id is null) then
		
		if not exists (select 1 from labgt.labgt_webstory where upper(title_alias) =  upper(v_webstory_titlalias))  --- condition added by purushottam on dated 20170924 
		then 
				v_webstory_assetid   := nextval('labgt.seq_labgt_webstory_id');
				v_webstory_guid      := uuid_generate_v4();
				v_seodataid      := nextval('labgt.seq_labgt_seo_data_id');
				v_seodataguid    := uuid_generate_v4();
				v_asset_list_id  := nextval ('labgt.seq_labgt_asset_list_id');
				v_json 	       := jsonb_set(v_json, '{data,webstory_id}', v_webstory_assetid::text::jsonb, true);
				v_json 	       := jsonb_set(v_json, '{data,guid}', ('"'||v_webstory_guid||'"')::text::jsonb, true);
				-- v_webstory_titlalias := v_webstory_titlalias||'-'||v_webstory_assetid;
				v_json 	       := jsonb_set(v_json, '{data,slug_url}', ('"'||v_webstory_titlalias||'"')::text::jsonb, true);
				
				insert into labgt.labgt_asset_draft
				(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
				updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
				values
				(v_assetdraftid, v_webstory_assetid, v_webstory_assettypeid, v_webstory_versionnumber, v_json, v_sysdate, 
				v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid);
				
				insert into labgt.labgt_webstory
				( webstory_id, content_source_id, webstory_meta, webstory_type, title, title_alias, 
				short_title, webstory_desc, partner_id, show_in_web, show_in_mobile, show_in_app,
				cover_image, total_assets, published_version_number, is_trashed, created_date, 
				updated_date, created_by, updated_by, is_active, is_deleted, is_published, webstory_guid,published_date,show_copyright,content_source_link,
				order_number)
				values 
				(v_webstory_assetid, v_webstory_contentsourceid, v_webstory_meta, v_webstory_type, v_webstory_title, v_webstory_titlalias,
				v_webstory_shorttitle,v_webstory_desc,v_webstory_partnerid,v_webstory_showinweb,v_webstory_showinmobile,v_webstory_showinapp,
				v_coverimage, v_webstory_totalassets, v_webstory_versionnumber, v_webstory_istrashed, v_sysdate,
				v_sysdate, v_updatedby, v_updatedby, 1, 0, v_webstory_status, v_webstory_guid,v_published_date,v_show_copyright,v_content_source_link,
				v_order_number);
				
				insert
				into labgt.labgt_asset_list
				(
				asset_list_id,
				asset_id,
				asset_type_id,
				asset_title,
				title_alias,
				author_id,
				short_desc,
				tags,
				primary_entity_role_map_id,
				secondary_entity_role_map_id,
				total_assets,
				image_file_name,
				image_path,
				duration,
				show_in_web,
				show_in_mobile,
				show_in_app,
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
				asset_guid,
				show_copyright,
				order_number
				)
				values
				(
				v_asset_list_id,
				v_webstory_assetid,
				v_webstory_assettypeid,
				v_webstory_title,
				v_webstory_titlalias,
				null,
				v_webstory_desc,
				null,
				null,
				null,
				v_webstory_totalassets,
				v_image_file_name,
				v_image_path,
				null,
				v_webstory_showinweb,
				v_webstory_showinmobile,
				v_webstory_showinapp,
				v_webstory_versionnumber,
				v_webstory_istrashed,
				v_sysdate,
				v_sysdate,
				v_updatedby,
				v_updatedby,
				1,
				0,
				v_webstory_status,
				v_published_date,
				v_webstory_guid,
				v_show_copyright,
				v_order_number
				);
				
				insert into labgt.labgt_seo_data
				(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, 
				updated_date, created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
				values
				(v_seodataid, v_webstory_assetid, v_webstory_assettypeid, v_seojson,v_webstory_versionnumber,  v_sysdate, 
				v_sysdate, v_updatedby, v_updatedby, 1, 0, v_webstory_status, v_seodataguid);
		else 
			v_titlealias_exist := 1 ;
           	p_data := '{ "data": { }}' ; 
            p_result := 0 ;                                  
			return ;
		end if ; 
		
	else

		
		if v_webstory_status = 0 then
		
			if v_webstory_istrashed = 0 then
				select coalesce(max(published_version_number),1)
				into   strict v_pubversionnumber
				from   labgt.labgt_webstory
				where  webstory_id      = v_webstory_id; 
				
				select max(version_number)
				into   strict v_webstory_versionnumber
				from   labgt.labgt_asset_draft
				where  asset_type_id = v_webstory_assettypeid
				and    asset_id      = v_webstory_id;
				
				if v_webstory_versionnumber > v_pubversionnumber then
					raise notice 'ffjifej';
					update labgt.labgt_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_sysdate
					where  asset_id      = v_webstory_id
					and    asset_type_id = v_webstory_assettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   labgt.labgt_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_webstory_assettypeid);
					
				else                           
					--raise notice 'vvvv';
					v_webstory_versionnumber := v_webstory_versionnumber + 1;
					
					insert into labgt.labgt_asset_draft
					(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
					updated_date,created_by, updated_by, is_active, is_deleted, asset_draft_guid)
					values
					( v_assetdraftid, v_webstory_id, v_webstory_assettypeid, v_webstory_versionnumber, v_json, 
					v_sysdate, v_sysdate, v_updatedby, v_updatedby,
					1, 0, v_assetdraftguid);
					
				end if;
				
			else
				update labgt.labgt_asset_list
				set is_trashed=v_webstory_istrashed,  
				is_published=v_webstory_status ,
				updated_date=v_sysdate
				where  asset_id        	  = v_webstory_id
				and    asset_type_id=v_webstory_assettypeid;
				
				update labgt.labgt_webstory
				set 
				is_trashed=v_webstory_istrashed,  
				is_published=v_webstory_status ,
				updated_date=v_sysdate
				where  webstory_id        	  = v_webstory_id;
				
                    update labgt.labgt_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_sysdate
					where  asset_id      = v_webstory_id
					and    asset_type_id = v_webstory_assettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   labgt.labgt_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_webstory_assettypeid);
          
          
          select max(ad1.version_number)
                  into v_webstory_versionnumber
                  from   labgt.labgt_asset_draft ad1
                  where  ad1.asset_id = v_webstory_id
                  and    ad1.asset_type_id = v_webstory_assettypeid;          
			end if;
			
		else
			
			select max(version_number)
			into   strict v_webstory_versionnumber
			from   labgt.labgt_asset_draft
			where  asset_type_id = v_webstory_assettypeid
			and    asset_id      = v_webstory_id;

			v_webstory_versionnumber := v_webstory_versionnumber + 1;

			insert into labgt.labgt_asset_draft
			(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
			updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values
			(v_assetdraftid, v_webstory_id, v_webstory_assettypeid, v_webstory_versionnumber, v_json, v_sysdate, 
			v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid); 

			update labgt.labgt_webstory
			set content_source_id=v_webstory_contentsourceid,
			webstory_meta=v_webstory_meta,
			webstory_type=v_webstory_type,
			title=v_webstory_title,
			title_alias=v_webstory_titlalias,
			short_title=v_webstory_shorttitle,
			webstory_desc=v_webstory_desc,
			partner_id=v_webstory_partnerid,
			show_in_web=v_webstory_showinweb,
			show_in_mobile=v_webstory_showinmobile,
			show_in_app=v_webstory_showinapp,
			cover_image=v_coverimage, 
			total_assets=v_webstory_totalassets, 
			published_version_number=v_webstory_versionnumber, 
			is_trashed=v_webstory_istrashed, 
			updated_date=v_sysdate, 
			updated_by=v_updatedby, 
			is_published=v_webstory_status ,
			published_date=v_published_date,
			show_copyright = v_show_copyright,
			content_source_link = v_content_source_link,
			order_number = v_order_number
			where  webstory_id        	  = v_webstory_id;

			update labgt.labgt_asset_list
			set
			asset_title=v_webstory_title,
			title_alias=v_webstory_titlalias,
			short_desc=v_webstory_desc,
			show_in_web=v_webstory_showinweb,
			show_in_mobile=v_webstory_showinmobile,
			show_in_app=v_webstory_showinapp,
			image_file_name = v_image_file_name,
			image_path = v_image_path,
			total_assets=v_webstory_totalassets, 
			published_version_number=v_webstory_versionnumber, 
			is_trashed=v_webstory_istrashed, 
			updated_date=v_sysdate, 
			updated_by=v_updatedby, 
			is_published=v_webstory_status ,
			published_date=v_published_date,
			show_copyright = v_show_copyright,
			order_number = v_order_number
			where  asset_id        	  = v_webstory_id
			and    asset_type_id=v_webstory_assettypeid;

			update labgt.labgt_seo_data
			set    meta_info 	 = v_seojson,
			updated_date  = v_sysdate
			where  asset_type_id = v_webstory_assettypeid
			and    asset_id      = v_webstory_id;
			
		end if;

	end if;
	
	
	if (v_webstory_id is null or (v_webstory_id is not null and v_webstory_status in (0,1) and v_webstory_istrashed = 0)) then
		
		select v_json->'data'->>'entitydata'
		into   v_albumentityjson;
		
		if v_albumentityjson is not null then
			
			delete
			from   labgt.labgt_asset_entity_map
			where  asset_type_id = v_webstory_assettypeid
			and    asset_id      = v_webstory_id;
			
			for v_entity in select * from json_array_elements(v_albumentityjson)
			loop
				
				select v_entity->>'entity_role_map_id', v_entity->>'priority',
				v_entity->>'is_linkable', v_entity->>'is_visible'
				into   v_entityrolemapid, v_priority,v_is_linkable,v_is_visible;
                
                select count(1) into v_entity_count from labgt.labgt_asset_list
				where tagged_entity is not null and tagged_entity@> Array[v_entityrolemapid]::int[];
				 
				update labgt.labgt_entity_role_map 
				set entity_count=v_entity_count
				where entity_role_map_id= v_entityrolemapid;
				
				if v_entityrolemapid is not null then
					
					v_assetentitymapid   := nextval('labgt.seq_labgt_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
					
					insert into labgt.labgt_asset_entity_map
					(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
					priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
					is_published, aemap_guid)
					values
					(v_assetentitymapid, coalesce(v_webstory_id, v_webstory_assetid), v_webstory_assettypeid,
					v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
					v_sysdate, v_updatedby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
					
					update labgt.labgt_asset_list
					set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
					secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
					where asset_id =  coalesce(v_webstory_id, v_webstory_assetid)
                         and    asset_type_id=v_webstory_assettypeid;
					
				end if;     
				
			end loop;
			
		end if;
		
		select v_json->'data'->'ImageSelected' into v_image_selected;
		
		select v_json->'data'->'ImageSelected'->>'imageID' into v_cover_imageid;
		select v_json->'data'->'ImageSelected'->>'imageName' into v_cover_imagename;
		select v_json->'data'->'ImageSelected'->>'imagePath' into v_cover_imagepath;
		
		
		     SELECT  obj.value->>'entity_role_map_id' into v_entity_lang_id
             from jsonb_array_elements(v_albumentityjson::jsonb) obj(value)
             where obj.value->>'is_lang'='1';   
				
            
			 update labgt.labgt_asset_list
             set    language_id=v_entity_lang_id,
             language_entity_role_map_id=v_entity_lang_id,
			 image_path      = v_cover_imagepath,
             image_file_name = v_cover_imagename
             where  asset_id        = coalesce(v_webstory_id, v_webstory_assetid)
             and    asset_type_id   = v_webstory_assettypeid;
			 
			 
		
		
		

	
		select v_json->'data'->'slides'
		into   v_webstory_slidejson; 
		
-- 		delete
-- 		from   labgt.labgt_webstory_asset_map
-- 		where  webstory_id      = coalesce(v_webstory_id, v_webstory_assetid);

	
		if v_webstory_slidejson is not null then
		
		v_counter:=0;
		
			for v_images in (select json_array_elements(v_webstory_slidejson)->>'data')
			loop
				
				select 
				v_images->>'webstory_slide_id',
				v_images->>'slide_title',
				v_images->>'slide_desc',
				v_images->>'mediatype',
               	v_images->>'vedio_url',
                v_images->>'thumbnail_url',
				v_images->>'cta_text',
				v_images->>'cta_link',
				v_images->>'is_slide_delete',
				v_images->>'photoimagdata',
				v_images->>'is_slide_delete',
				v_images->>'order_number',
				v_images->>'tooltip_text',
				v_images->>'tooltip_link',
				v_images->'photoimagdata'->>'imageName',
				v_images->'photoimagdata'->>'imageID',
				v_images->'photoimagdata'->>'imagePath'
				into   
				v_webstory_slide_id, 
				v_slide_title,
				v_slide_desc,
				v_mediatype,
				v_vedio_url, 
				v_thumbnail_url,
				v_cta_text,
				v_cta_link,
				v_is_slide_delete,
				v_photoimagdata,
				v_imagealbstatus,
				v_image_order,
				v_tooltip_text,
				v_tooltip_link,
				v_imageName,
				v_image_id,
				v_imagePath;

					
				v_webstory_assetmapid   := nextval('labgt.seq_labgt_webstory_asset_map_id');

				v_full_img_path := 'https://stg-gujarat-titans.sportz.io/static-assets/waf-images/'||v_imagePath||v_imageName;

-- 								 raise notice 'v_full_img_path:%',v_full_img_path;

--                	-- if v_isdeleted = 0 then

				   
--                    raise notice 'v_webstory_slide_id %',v_webstory_slide_id;
--                    raise notice 'coalesce(v_webstory_id, v_webstory_assetid) %',coalesce(v_webstory_id, v_webstory_assetid);
                   
			if exists (select 1 from labgt.labgt_webstory_asset_map 
                       where webstory_slide_id = v_webstory_slide_id 
                       and webstory_id = coalesce(v_webstory_id, v_webstory_assetid)) then
                       
            raise notice '2';
            
                update labgt.labgt_webstory_asset_map
                set slide_title = v_slide_title,
				     webstory_slide_id = v_webstory_slide_id,
				     is_active = case when v_is_slide_delete = 1 then 0 else 1 end,
				     is_delete = v_is_slide_delete,
					 thumbnail_url = v_thumbnail_url,
					 photoimagdata = v_photoimagdata,
					 is_published = v_imagealbstatus,
					 tooltip_link = v_tooltip_link,
					 tooltip_text = v_tooltip_text,
					 asset_id = v_image_id,
					 order_number = v_image_order,
					 cta_text = v_cta_text,
					 cta_link = v_cta_link
                where webstory_slide_id = v_webstory_slide_id and webstory_id = coalesce(v_webstory_id, v_webstory_assetid);
            
            else
                    
                     raise notice 'v_images %',v_images;
                    v_webstory_slide_id := nextval('labgt.seq_labgt_webstory_slide_id') ;
                        
                    	insert into labgt.labgt_webstory_asset_map
                    	(webstory_asset_map_id, webstory_id, webstory_slide_id, slide_title, slide_desc,
						mediatype,vedio_url,thumbnail_url,cta_text,cta_link,is_active,is_delete,photoimagdata,
						asset_type_id, created_date, 
                     	updated_date, created_by, updated_by,is_published,order_number,is_cover,asset_id,
						tooltip_text,tooltip_link)
                     	select 
                     	v_webstory_assetmapid,  coalesce(v_webstory_id, v_webstory_assetid), v_webstory_slide_id,v_slide_title,v_slide_desc,v_mediatype,v_vedio_url,
						v_thumbnail_url,v_cta_text,v_cta_link,
						case when v_is_slide_delete = 1 then 0 else 1 end,
						v_is_slide_delete , --v_full_img_path,
						v_photoimagdata,
                      	3, v_sysdate, v_sysdate, v_updatedby, v_updatedby, v_imagealbstatus,v_image_order,0,v_image_id,v_tooltip_text,v_tooltip_link;
			end if;			
                    	
               	-- end if;
					
					/*if v_is_cover = 1 then
						
						select image_path,image_file_name
						into v_image_path ,v_image_file_name
						from labgt.labgt_image
						where image_id = v_image_id;
						
						update labgt.labgt_asset_list
						set image_path = v_image_path,image_file_name = v_image_file_name
						where asset_id = coalesce(v_webstory_id, v_webstory_assetid)
						and    asset_type_id=v_webstory_assettypeid;
					
					else
                                              
                              select v_images->'data'->>'image_alt',
				v_images->'data'->>'image_copyright',
				v_images->'data'->>'title',
				v_images->'data'->>'image_desc'
                                              into v_imagealt, v_imagecopyright, v_imagetitle,v_imagedescription;
                                              
                                              update labgt.labgt_image
                                              set image_caption = v_imagealt,
                                              copyright_text = v_imagecopyright,
                                              title_alias = v_imagetitle,
                                              image_desc = v_imagedescription
                                              where image_id = v_image_id;
						
					end if;*/                          
                v_images:=jsonb_set(v_images::jsonb,'{photoimagdata,full_img_path}',('"'||coalesce(v_full_img_path,'')||'"')::jsonb, true);
				--raise notice  'v_images %',v_images;
				v_json= jsonb_set(v_json,('{data,slides,'||v_counter::text||',data}')::text[],
													 v_images::jsonb, true);
			   

				v_json= jsonb_set(v_json,('{data,slides,'||v_counter::text||',data,webstory_slide_id}')::text[],
													 ('"'||coalesce(v_webstory_slide_id::text,'0')||'"')::jsonb,true);
	 			--raise notice 'v_json %',v_json;
				v_counter:=v_counter+1;  
				--v_counter1:=v_counter1+1;  
					
				end loop;
			end if;

			
			if v_image_selected is not null and v_image_selected<>'{}'  THEN
			
			v_webstory_assetmapid   := nextval('labgt.seq_labgt_webstory_asset_map_id');
			
-- 			insert into labgt.labgt_webstory_asset_map
--                     	(webstory_asset_map_id, webstory_id, webstory_slide_id, slide_title, slide_desc,
-- 						mediatype,vedio_url,thumbnail_url,cta_text,cta_link,is_active,is_delete,photoimagdata,
-- 						asset_type_id, created_date, 
--                      	updated_date, created_by, updated_by,is_published,order_number,is_cover,asset_id)
--                      	select 
--                      	v_webstory_assetmapid,  coalesce(v_webstory_id, v_webstory_assetid), null,null,null,null,null,null,null,null,1,0,--v_full_img_path
-- 						 null
-- 						 ,3, v_sysdate, v_sysdate, v_updatedby, v_updatedby, 1,0,1,v_cover_imageid;
			
			end if;
			
			
			
  			
  			select v_json->'data'->>'author_data'
			into   v_authordatajson;
	     	
				if v_authordatajson is not null then
			
          			delete
					from   labgt.labgt_author_action
					where  asset_type_id = v_webstory_assettypeid
					and    asset_id      = v_webstory_id;
					
					v_counter:=0;
					
					for v_authordata in select * from json_array_elements(v_authordatajson)
					loop
				         	
               			select v_authordata->>'author_id',
               	  		v_authordata->>'action_id'
						into   v_author_id,
               	  		v_action_id;
						
			
               			if (v_author_id is not null and v_action_id is not null) then
						               
	               			v_authoractionid := nextval('labgt.seq_labgt_author_action_id');
     		               	
               	     		insert into labgt.labgt_author_action(author_action_id,
                    	          		                        author_id,
                         	               		              asset_id,
                              	                    		    asset_type_id,
                                   	                   			action_id,
                                        	              			created_date,
                                             	         			updated_date)
							values(v_authoractionid,
	                           	v_author_id,
     	                      	coalesce(v_webstory_id, v_webstory_assetid),
          	                 	v_webstory_assettypeid,
               	            	v_action_id,
                    	       	v_sysdate,
                         	  	v_sysdate);
		                    	
                          if v_action_id = 4 then 
                            update labgt.labgt_asset_list
                            set    author_id  = coalesce(v_author_id,author_id)
                            where  asset_id   = coalesce(v_webstory_id, v_webstory_assetid)
                        --		and    author_id is null
                                                 and    asset_type_id=v_webstory_assettypeid;
                          end if;
						  
						  ---
						select replace(lower(user_name),'_','-')||'-'||user_id,full_name  from labgt.labgt_user where user_id=v_author_id into v_author_slug,v_author_name;

						v_authordata:=jsonb_set(v_authordata,'{author_slug}',('"'||coalesce(v_author_slug,'')||'"')::jsonb, true);

						v_authordata:=jsonb_set(v_authordata,'{author_name}',('"'||coalesce(v_author_name,'')||'"')::jsonb, true);
							
						end if;
						
					v_json= jsonb_set(v_json,('{data,author_data,'||v_counter::text||'}')::text[],
					v_authordata::jsonb,true);
					v_counter:=v_counter+1;
		
					end loop;
	
				end if;
		
	end if;
     
	
	v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_webstory_versionnumber||'"')::text::jsonb, true);
    -- raise notice 'v_json %',v_json;
	p_result := 1;
     
	 
		if  (v_webstory_status = 1) or(v_webstory_status=0 and v_webstory_istrashed=0) then
        	
			
			select array(select entity_role_map_id 
					 from labgt.labgt_asset_entity_map
					 where asset_id = coalesce(v_webstory_id, v_webstory_assetid) 
					 and asset_type_id = 142
         
					)	a into v_array;   
					
					
			select row_to_json(row) into v_image from(
				select a.image_id,1 is_cover,a.image_caption,a.image_path imagePath,
				a.image_desc,a.image_caption as image_alt,a.image_file_name,a.title_alias as img_title,copyright_text image_src
				from labgt.labgt_image a
				where a.image_id in (
				select asset_id from labgt.labgt_webstory_asset_map
				where webstory_id = coalesce(v_webstory_id, v_webstory_assetid)  and is_cover = 1))row;
				
			v_web_listing_json := jsonb_set(v_web_listing_json, '{image_data}',coalesce(v_image,'{}'), true);
			
          update labgt.labgt_asset_list 
		  set web_detail_jsn = v_json,
			  tagged_entity=v_array
		  where asset_id = coalesce(v_webstory_id, v_webstory_assetid) and asset_type_id = v_webstory_assettypeid;

		  update labgt.labgt_asset_draft
		  set asset_data=v_json
		  where version_number=v_webstory_versionnumber and
		 asset_id = coalesce(v_webstory_id, v_webstory_assetid) and 
		 asset_type_id = v_webstory_assettypeid;

			select labgt._get_web_list_json(null,142,coalesce(v_webstory_id, v_webstory_assetid) ) 
			into strict v_web_listing_json;

		  update labgt.labgt_asset_list 
		  set web_listing_json = v_web_listing_json
		   where asset_id = coalesce(v_webstory_id, v_webstory_assetid) and asset_type_id = v_webstory_assettypeid;

		

		 
            
        end if;
		
     
	
	if p_result = 1 then
		
		p_data := v_json;
		
	end if;
	
end;

 

$$;


--
