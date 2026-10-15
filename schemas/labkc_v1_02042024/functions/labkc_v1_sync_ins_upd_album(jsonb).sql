-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_sync_ins_upd_album(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_sync_ins_upd_album(jsonb); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_sync_ins_upd_album(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare

v_json             	   jsonb;
v_assetdraftid     	   labkc_v1.labkc_v1_asset_draft.asset_draft_id%type;
v_assetdraftguid   	   varchar(50);
v_imageassettypeid     numeric; 
v_createdby        	   numeric;
v_updatedby        	   numeric;      
v_albstatus            numeric; 
v_album_id        	   labkc_v1.labkc_v1_album.album_id%type;      
v_albumguid            varchar(256);      
v_albumassettypeid     numeric;
v_albumcontentsourceid numeric;  
v_albumversionnumber   numeric := 1 ;
v_albummeta       	   jsonb;
v_albumtype       	   numeric;
v_albumtitle           varchar(4000);
v_albumtitlealias      varchar(4000);
v_albumshorttitle      varchar(4000);
v_albumdesc            text;
v_albumpartnerid       numeric;
v_albumshowinweb       numeric;
v_albumshowinmobile    numeric;
v_albumshowinapp       numeric;
v_albumscoveraimage    varchar(4000);
v_albumtotalassets     numeric;
v_albumstatus          numeric;
v_albumistrashed       numeric;
v_coverimage           varchar(4000);
v_albumassetid         numeric;
v_published_date       timestamp;
v_albumassetmapid      numeric;
v_albumassetmapguid    numeric;
v_image_id        	   labkc_v1.labkc_v1_image.image_id%type;       
v_imageguid            varchar(256);
v_imagecontentsourceid numeric;  
v_imageversionnumber   numeric := 1;
v_imagecaption     	   varchar(4000);
v_imagemeta       	   varchar(4000);
v_imagedesc        	   varchar(4000);
v_imagepath       	   varchar(4000);
v_imagecopyrighttext   varchar(4000);
v_imagefilename        varchar(4000);
v_imagestatus          numeric;
v_imageassetid         numeric;
v_image_order          numeric; 
v_imagealbstatus       numeric;
v_albumentityjson 	   json;
v_entityrolemapid      numeric;
v_priority 	    	   numeric;
v_is_linkable          numeric;
v_is_visible           numeric;
v_albumimagejson       json;
v_sysdate              timestamp;
v_assetentitymapid     numeric;
v_assetentitymapguid   varchar(50);    	   
v_seojson 		       jsonb;
v_seodataid 		   numeric;
v_seodataguid 		   varchar(50);
v_entity 			   json;
v_images               json;
v_imageexists 	       numeric;
v_seoexists 		   numeric;
v_entityexists 	       numeric;
v_img_ret              numeric;
v_img_ret_data         json;
v_show_copyright 	   numeric;
v_content_source_link  varchar(4000);
v_order_number         numeric;
v_asset_list_id        numeric; 
v_image_file_name      varchar(4000);
v_image_path           varchar(4000);
v_pubversionnumber     numeric;
v_is_cover             numeric;
v_isdeleted		   numeric;
v_isactive numeric;
v_counter numeric;
v_authordatajson      json;
	v_authordata          jsonb;
  v_author_id           numeric;        
	v_action_id           numeric;
	v_authoractionid      numeric;
     v_albumexists     numeric;
     v_continue  numeric;
     p_result1 numeric;
	 v_titlealias_exist numeric := 0;
     
     v_imagealt labkc_v1.labkc_v1_image.image_caption%type;
     v_imagecopyright labkc_v1.labkc_v1_image.copyright_text%type;
     v_imagetitle labkc_v1.labkc_v1_image.title_alias%type;
     v_imagedescription  labkc_v1.labkc_v1_image.image_desc%type;
     v_photo_type_id numeric;
	 v_position_id numeric ;
	 v_schema_prefix character varying;
	 v_entity_lang_id numeric;
	 v_web_listing_json jsonb;
	  v_array numeric[];
	  v_entity_code character varying;
	  v_user_code character varying;
	  v_updatedby_code character varying;
      v_created_by_code character varying;
	  v_ref_guid character varying;	
	  v_unq_album_id numeric;
begin
	
	v_json := p_json;
	v_sysdate:=  current_timestamp at time zone 'utc';
	
	select v_json->'data'->>'album_id', 
			v_json->'data'->>'asset_type',
			v_json->'data'->>'content_source_id',
			v_json->'data'->>'album_meta',
			v_json->'data'->>'album_type',
			v_json->'data'->>'title',
			-- v_json->'data'->>'title_alias',
			v_json->'data'->>'short_title',
			v_json->'data'->>'album_desc',
			v_json->'data'->>'partner_id',
			v_json->'data'->>'show_in_web',
			v_json->'data'->>'show_in_mobile',
			v_json->'data'->>'show_in_app',
			v_json->'data'->>'total_assets',
			v_json->'data'->>'is_trashed',
			v_json->'data'->>'status', 
			v_json->'data'->>'updated_by',
			-- v_json->'data'->>'cover_image',
			v_json->'data'->>'seo',
			v_json->'data'->>'show_copyright',
			v_json->'data'->>'content_source_link',
			v_json->'data'->>'published_date',
			v_json->'data'->>'order_number',
            v_json->'data'->>'slug_url',
            v_json->'data'->>'schema_prefix',
			v_json->'data'->>'updated_by_code',
            v_json->'data'->>'created_by_code',
			v_json->'data'->>'guid'
	into    v_unq_album_id,
			v_albumassettypeid,
			v_albumcontentsourceid,
			v_albummeta,
			v_albumtype,
			v_albumtitle,
			-- v_albumtitlealias,
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
			-- v_coverimage,
			v_seojson,
			v_show_copyright,
			v_content_source_link,
			v_published_date,
			v_order_number,
            v_albumtitlealias,
			v_schema_prefix,
			v_updatedby_code,
            v_created_by_code,
			v_ref_guid
            ;
			
           -- insert entry in labkc_v1_redirect table :- changes done by rakesh bhatkar --    
	      select labkc_v1.labkc_v1_ins_up_redirect(v_album_id,v_albumtitlealias,v_albumstatus,v_albumassettypeid) into p_result1; 
           -- insert entry in labkc_v1_redirect table :- changes done by rakesh bhatkar --
  
     begin
     	
     
     
	v_json := jsonb_set(v_json, '{data,album_id}','null'::jsonb, true); 
      
          select album_id
     	into strict v_albumexists
     	from   labkc_v1.labkc_v1_album
     	where  upper(title_alias) = upper(v_titlealias) ;
          
          if v_album_id is null then
          	v_continue := -1;
          else
          	if v_albumexists = v_album_id then
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
	v_assetdraftid   := nextval('labkc_v1.seq_labkc_v1_asset_draft_id');
	v_assetdraftguid := uuid_generate_v4();

	if v_created_by_code is not null then
	
		select user_id into v_createdby 
		from labkc_v1.labkc_v1_user
		where user_code=v_created_by_code;
		
	end if;
    
	if v_updatedby_code is not null then
		select user_id into v_updatedby  
		from labkc_v1.labkc_v1_user
		where user_code=v_updatedby_code;
			
	end if;
		
		
		if (v_albumistrashed=1 and v_albumstatus=0) then
	 
	 	select ref_id,ref_guid into v_unq_album_id,v_ref_guid
		from labkc_v1.labkc_v1_album
		where source = v_schema_prefix
		and title_alias=v_albumtitlealias;
		
	end if;
		
		
	if not exists (select 1 from labkc_v1.labkc_v1_album where source = v_schema_prefix and ref_id = v_unq_album_id and ref_guid = v_ref_guid)  --- condition added by purushottam on dated 20170924 
		then 
				v_albumassetid   := nextval('labkc_v1.seq_labkc_v1_album_id');
				v_albumguid      := uuid_generate_v4();
				v_seodataid      := nextval('labkc_v1.seq_labkc_v1_seo_data_id');
				v_seodataguid    := uuid_generate_v4();
				v_asset_list_id  := nextval ('labkc_v1.seq_labkc_v1_asset_list_id');
				v_json 	       := jsonb_set(v_json, '{data,album_id}', v_albumassetid::text::jsonb, true);
				v_json 	       := jsonb_set(v_json, '{data,guid}', ('"'||v_albumguid||'"')::text::jsonb, true);
				-- v_albumtitlealias := v_albumtitlealias||'-'||v_albumassetid;
				v_json 	       := jsonb_set(v_json, '{data,slug_url}', ('"'||v_albumtitlealias||'"')::text::jsonb, true);
				
				insert into labkc_v1.labkc_v1_asset_draft
				(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
				updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
				values
				(v_assetdraftid, v_albumassetid, v_albumassettypeid, v_albumversionnumber, v_json, v_sysdate, 
				v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid);
				
				insert into labkc_v1.labkc_v1_album
				( album_id, content_source_id, album_meta, album_type, title, title_alias, 
				short_title, album_desc, partner_id, show_in_web, show_in_mobile, show_in_app,
				cover_image, total_assets, published_version_number, is_trashed, created_date, 
				updated_date, created_by, updated_by, is_active, is_deleted, is_published, album_guid,published_date,show_copyright,content_source_link,
				order_number,source,ref_id,ref_guid)
				values 
				(v_albumassetid, v_albumcontentsourceid, v_albummeta, v_albumtype, v_albumtitle, v_albumtitlealias,
				v_albumshorttitle,v_albumdesc,v_albumpartnerid,v_albumshowinweb,v_albumshowinmobile,v_albumshowinapp,
				v_coverimage, v_albumtotalassets, v_albumversionnumber, v_albumistrashed, v_sysdate,
				v_sysdate, v_updatedby, v_updatedby, 1, 0, v_albumstatus, v_albumguid,v_published_date,v_show_copyright,v_content_source_link,
				v_order_number,v_schema_prefix,v_unq_album_id,v_ref_guid);
				
				insert
				into labkc_v1.labkc_v1_asset_list
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
				v_albumassetid,
				v_albumassettypeid,
				v_albumtitle,
				v_albumtitlealias,
				null,
				v_albumdesc,
				null,
				null,
				null,
				v_albumtotalassets,
				v_image_file_name,
				v_image_path,
				null,
				v_albumshowinweb,
				v_albumshowinmobile,
				v_albumshowinapp,
				v_albumversionnumber,
				v_albumistrashed,
				v_sysdate,
				v_sysdate,
				v_updatedby,
				v_updatedby,
				1,
				0,
				v_albumstatus,
				v_published_date,
				v_albumguid,
				v_show_copyright,
				v_order_number
				);
				
				insert into labkc_v1.labkc_v1_seo_data
				(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, 
				updated_date, created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
				values
				(v_seodataid, v_albumassetid, v_albumassettypeid, v_seojson,v_albumversionnumber,  v_sysdate, 
				v_sysdate, v_updatedby, v_updatedby, 1, 0, v_albumstatus, v_seodataguid);

	elsif exists (select 1 from labkc_v1.labkc_v1_album where source = v_schema_prefix and ref_id = v_unq_album_id and ref_guid = v_ref_guid) then
		v_albumassettypeid:=2;
		select album_id into v_album_id
		from labkc_v1.labkc_v1_album
		where source = v_schema_prefix and 
		ref_id = v_unq_album_id and 
		ref_guid = v_ref_guid;
		
		
	v_json := jsonb_set(v_json, '{data,album_id}',v_album_id::text::jsonb, true);
		
		if v_albumstatus = 0 then
		
			if v_albumistrashed = 0 then
				
				select coalesce(max(published_version_number),1)
				into   strict v_pubversionnumber
				from   labkc_v1.labkc_v1_album
				where  album_id      = v_album_id; 
				
				select max(version_number)
				into   strict v_albumversionnumber
				from   labkc_v1.labkc_v1_asset_draft
				where  asset_type_id = v_albumassettypeid
				and    asset_id      = v_album_id;
				
				if v_albumversionnumber > v_pubversionnumber then
					
					update labkc_v1.labkc_v1_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_sysdate
					where  asset_id      = v_album_id
					and    asset_type_id = v_albumassettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   labkc_v1.labkc_v1_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_albumassettypeid);
					
				else                           
					
					v_albumversionnumber := v_albumversionnumber + 1;
					
					insert into labkc_v1.labkc_v1_asset_draft
					(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
					updated_date,created_by, updated_by, is_active, is_deleted, asset_draft_guid)
					values
					( v_assetdraftid, v_album_id, v_albumassettypeid, v_albumversionnumber, v_json, 
					v_sysdate, v_sysdate, v_updatedby, v_updatedby,
					1, 0, v_assetdraftguid);
					
				end if;
				
			else
				
				update labkc_v1.labkc_v1_asset_list
				set is_trashed=v_albumistrashed,  
				is_published=v_albumstatus ,
				updated_date=v_sysdate
				where  asset_id        	  = v_album_id
				and    asset_type_id=v_albumassettypeid;
				
				update labkc_v1.labkc_v1_album
				set 
				is_trashed=v_albumistrashed,  
				is_published=v_albumstatus ,
				updated_date=v_sysdate
				where  album_id        	  = v_album_id;
				
                    update labkc_v1.labkc_v1_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_sysdate
					where  asset_id      = v_album_id
					and    asset_type_id = v_albumassettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   labkc_v1.labkc_v1_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_albumassettypeid);
          
          
          select max(ad1.version_number)
                  into v_albumversionnumber
                  from   labkc_v1.labkc_v1_asset_draft ad1
                  where  ad1.asset_id = v_album_id
                  and    ad1.asset_type_id = v_albumassettypeid;          
			end if;
			
		else
			
			select max(version_number)
			into   strict v_albumversionnumber
			from   labkc_v1.labkc_v1_asset_draft
			where  asset_type_id = v_albumassettypeid
			and    asset_id      = v_album_id;

			v_albumversionnumber := v_albumversionnumber + 1;

			insert into labkc_v1.labkc_v1_asset_draft
			(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
			updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values
			(v_assetdraftid, v_album_id, v_albumassettypeid, v_albumversionnumber, v_json, v_sysdate, 
			v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid); 

			update labkc_v1.labkc_v1_album
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
			is_published=v_albumstatus ,
			published_date=v_published_date,
			show_copyright = v_show_copyright,
			content_source_link = v_content_source_link,
			order_number = v_order_number
			where  album_id        	  = v_album_id;

			update labkc_v1.labkc_v1_asset_list
			set
			asset_title=v_albumtitle,
			title_alias=v_albumtitlealias,
			short_desc=v_albumdesc,
			show_in_web=v_albumshowinweb,
			show_in_mobile=v_albumshowinmobile,
			show_in_app=v_albumshowinapp,
			image_file_name = v_image_file_name,
			image_path = v_image_path,
			total_assets=v_albumtotalassets, 
			published_version_number=v_albumversionnumber, 
			is_trashed=v_albumistrashed, 
			updated_date=v_sysdate, 
			updated_by=v_updatedby, 
			is_published=v_albumstatus ,
			published_date=v_published_date,
			show_copyright = v_show_copyright,
			order_number = v_order_number
			where  asset_id        	  = v_album_id
			and    asset_type_id=v_albumassettypeid;

			update labkc_v1.labkc_v1_seo_data
			set    meta_info 	 = v_seojson,
			updated_date  = v_sysdate
			where  asset_type_id = v_albumassettypeid
			and    asset_id      = v_album_id;
			
		end if;

	end if;
	
	
	if (v_albumtitlealias is not null and v_albumstatus = 1) then
		
		select v_json->'data'->>'entitydata'
		into   v_albumentityjson;
		
		if v_albumentityjson is not null then
			
			delete
			from   labkc_v1.labkc_v1_asset_entity_map
			where  asset_type_id = v_albumassettypeid
			and    asset_id      = v_album_id;

				v_counter := 0 ;				
			
			for v_entity in select * from json_array_elements(v_albumentityjson)
			loop
				
				select v_entity->>'entity_role_map_id', v_entity->>'priority',
				v_entity->>'is_linkable', v_entity->>'is_visible',v_entity->>'entity_code'
				into   v_entityrolemapid, v_priority,v_is_linkable,v_is_visible,v_entity_code;
/*				
				select entity_role_map_id 
				into v_entityrolemapid
				from labkc_v1.labkc_v1_entity_role_map 
				where ref_id in (select ref_id from labkkr.labkkr_entity_role_map
										where entity_role_map_id=v_entityrolemapid);
*/
				select entity_role_map_id into v_entityrolemapid 
				from labkc_v1.labkc_v1_entity_role_map
						   where entity_code =v_entity_code;					
						  

				if v_entityrolemapid is not null then

				v_json= jsonb_set(v_json,('{data,entitydata,'||v_counter::text||',entity_role_map_id}')::text[],
													 ('"'||v_entityrolemapid||'"')::text::jsonb,true); 
													 
				end if;
					   										
					
				
				
				if v_entityrolemapid is not null then
					
					v_assetentitymapid   := nextval('labkc_v1.seq_labkc_v1_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
					
					insert into labkc_v1.labkc_v1_asset_entity_map
					(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
					priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
					is_published, aemap_guid)
					values
					(v_assetentitymapid, coalesce(v_album_id, v_albumassetid), v_albumassettypeid,
					v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
					v_sysdate, v_updatedby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
					
					update labkc_v1.labkc_v1_asset_list
					set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
					secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
					where asset_id =  coalesce(v_album_id, v_albumassetid)
                         and    asset_type_id=v_albumassettypeid;
					
				end if;    
				
					v_counter := v_counter + 1;
				
			end loop;
			
		end if;
		
		
		     SELECT  obj.value->>'entity_role_map_id' into v_entity_lang_id
             from jsonb_array_elements(v_albumentityjson::jsonb) obj(value)
             where obj.value->>'is_lang'='1';   
				
            
			 update labkc_v1.labkc_v1_asset_list
             set    language_id=v_entity_lang_id,
             language_entity_role_map_id=v_entity_lang_id
             where  asset_id        = coalesce(v_album_id, v_albumassetid)
             and    asset_type_id   = v_albumassettypeid;
		
		select v_json->'data'->>'images'
		into   v_albumimagejson;   
	
		delete
		from   labkc_v1.labkc_v1_album_asset_map
		where  album_id      = coalesce(v_album_id, v_albumassetid);
	
		if v_albumimagejson is not null then
		
			raise notice 'v_albumimagejson %',v_albumimagejson;
			
			for v_images in select * from json_array_elements(v_albumimagejson)
			loop
				
				select v_images->'data'->>'image_id',
				v_images->'data'->>'is_cover',
				v_images->'data'->>'order_number',
				v_images->'data'->>'status',
               	v_images->'data'->>'is_delete',
                v_images->'data'->>'is_active',
				v_images->'data'->>'phototypeid',
				v_images->'data'->>'position_id'
				into   v_image_id, v_is_cover,v_image_order,v_imagealbstatus, v_isdeleted, v_isactive,v_photo_type_id,v_position_id;
				
				v_albumassetmapid   := nextval('labkc_v1.seq_labkc_v1_album_asset_map_id');
				
               	-- if v_isdeleted = 0 then
				
							raise notice 'v_album_id %',v_album_id;

                    	insert into labkc_v1.labkc_v1_album_asset_map
                    	( album_asset_map_id, album_id, asset_order, asset_id, asset_type_id, created_date, 
                     	updated_date, created_by, updated_by, is_active, is_deleted, is_published,is_cover,phototypeid,position_id)
                     	values 
                     	(v_albumassetmapid,  coalesce(v_album_id, v_albumassetid), v_image_order,v_image_id, 
                      	3, v_sysdate, v_sysdate, v_updatedby, v_updatedby, coalesce(v_isactive,1), coalesce(v_isdeleted,0), v_imagealbstatus, v_is_cover,coalesce(v_photo_type_id,0),v_position_id);
                    	
               	-- end if;
					
					if v_is_cover = 1 then
						
						select image_path,image_file_name
						into v_image_path ,v_image_file_name
						from labkc_v1.labkc_v1_image
						where image_id = v_image_id;
						
						update labkc_v1.labkc_v1_asset_list
						set image_path = v_image_path,image_file_name = v_image_file_name
						where asset_id = coalesce(v_album_id, v_albumassetid)
						and    asset_type_id=v_albumassettypeid;
					
					else
                                              
                              select v_images->'data'->>'image_alt',
				v_images->'data'->>'image_copyright',
				v_images->'data'->>'title',
				v_images->'data'->>'image_desc'
                                              into v_imagealt, v_imagecopyright, v_imagetitle,v_imagedescription;
                                              
                                              update labkc_v1.labkc_v1_image
                                              set image_caption = v_imagealt,
                                              copyright_text = v_imagecopyright,
                                              title_alias = v_imagetitle,
                                              image_desc = v_imagedescription
                                              where image_id = v_image_id;
						
					end if;
                                              
                                              
					
				end loop;
			
			end if;
  	
  			select v_json->'data'->>'author_data'
			into   v_authordatajson;
	     	
				if v_authordatajson is not null then
			
          			delete
					from   labkc_v1.labkc_v1_author_action
					where  asset_type_id = v_albumassettypeid
					and    asset_id      = v_album_id;

					v_counter := 0 ;				
					
					for v_authordata in select * from json_array_elements(v_authordatajson)
					loop
				          	
               			select v_authordata->>'author_id',
               	  		v_authordata->>'action_id',
						v_authordata->>'user_code'
						into   v_author_id,
               	  		v_action_id,
						v_user_code;
/*
						select user_id 
						into v_author_id
						from labkc_v1.labkc_v1_user
						where ref_id in (select ref_id from labkkr.labkkr_user
										where user_id=v_author_id);
*/
						select user_id into v_author_id from labkc_v1.labkc_v1_user 
								   where user_code = v_user_code;					
						  
										
					--	v_author_id:=1;
					if v_author_id is not null then

					v_json= jsonb_set(v_json,('{data,author_data,'||v_counter::text||',author_id}')::text[],('"'||v_author_id||'"')::text::jsonb,true);
					
					end if;						   
					
					raise notice 'v_json %',v_json;
			
               			if (v_author_id is not null and v_action_id is not null) then
						               
	               			v_authoractionid := nextval('labkc_v1.seq_labkc_v1_author_action_id');
     		               	
               	     		insert into labkc_v1.labkc_v1_author_action(author_action_id,
                    	          		                        author_id,
                         	               		              asset_id,
                              	                    		    asset_type_id,
                                   	                   			action_id,
                                        	              			created_date,
                                             	         			updated_date)
							values(v_authoractionid,
	                           	v_author_id,
     	                      	coalesce(v_album_id, v_albumassetid),
          	                 	v_albumassettypeid,
               	            	v_action_id,
                    	       	v_sysdate,
                         	  	v_sysdate);
		                    	
                          if v_action_id = 4 then 
                            update labkc_v1.labkc_v1_asset_list
                            set    author_id  = coalesce(v_author_id,author_id)
                            where  asset_id   = coalesce(v_album_id, v_albumassetid)
                        --		and    author_id is null
                                                 and    asset_type_id=v_albumassettypeid;
                          end if;
							
						end if;

					v_counter := v_counter + 1;
		
					end loop;
	
				end if;
		
	end if;
     
	
	   
	v_json := jsonb_set(v_json, '{data,version_number}', ('"'||coalesce(v_albumversionnumber,0)||'"')::text::jsonb, true);
     
	p_result := 1;
     
	 
	--	if  v_albumstatus = 1 then
 -- raise notice 'v_album_id %',v_album_id;
--raise notice 'v_albumassetid %',v_albumassetid;
      	
			select labkc_v1._get_web_list_json(null,2,coalesce(v_album_id, v_albumassetid) ) 
			into strict v_web_listing_json;
			
			select array(select entity_role_map_id 
					 from labkc_v1.labkc_v1_asset_entity_map
					 where asset_id = coalesce(v_album_id, v_albumassetid) 
					 and asset_type_id = 2
         
					)	a into v_array;   
			
		
--raise notice 'v_web_listing_json %',v_web_listing_json;
--raise notice 'v_json %',v_json;

		
          update labkc_v1.labkc_v1_asset_list 
		  set web_listing_json = v_web_listing_json,
			  web_detail_jsn = v_json,
			  tagged_entity=v_array
		  where asset_id = coalesce(v_album_id, v_albumassetid) and asset_type_id = v_albumassettypeid;
            
    --    end if;
	update labkc_v1.labkc_v1_asset_draft
	set    asset_data        = v_json
	where  asset_id          = coalesce(v_album_id, v_albumassetid) 
	and    asset_type_id     = v_albumassettypeid ;		
     
	
	if p_result = 1 then
		
		p_data := v_json;
		
	end if;
	
end;

 

$$;


--
