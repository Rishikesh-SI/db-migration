-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_ins_upd_album_guid(jsonb)
-- Type: FUNCTION

-- Name: labdms_ins_upd_album_guid(jsonb); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_ins_upd_album_guid(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

 

declare

v_json             	   jsonb;
v_assetdraftid     	   labdms.labdms_asset_draft.asset_draft_id%type;
v_assetdraftguid   	   varchar(50);
v_imageassettypeid     numeric; 
v_createdby        	   numeric;
v_updatedby        	   numeric;      
v_albstatus            numeric; 
v_album_id        	   labdms.labdms_album.album_id%type;      
v_albumguid            varchar(256);      
v_albumassettypeid     numeric;
v_albumcontentsourceid numeric;  
v_albumversionnumber   numeric := 1 ;
v_albummeta       	   jsonb;
v_albumtype       	   numeric;
v_albumtitle           varchar(4000);
v_albumtitlealias      varchar(4000);
v_albumshorttitle      varchar(4000);
v_albumdesc            varchar(4000);
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
v_image_id        	   labdms.labdms_image.image_id%type;       
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

v_authordatajson      json;
	v_authordata          jsonb;
  v_author_id           numeric;        
	v_action_id           numeric;
	v_authoractionid      numeric;
     v_albumexists     numeric;
     v_continue  numeric;
     p_result1 numeric;
	 
	 v_content_provider_name text;
	v_content_provider_user_id numeric;
	p_schema_prefix text;
	v_array numeric[];
	v_web_listing_json jsonb;
	v_source_object_id text;
	v_counter numeric:=0;
	v_entity_role_id numeric;
	v_entity_group_type text;
		 v_cnt numeric; 
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
			   v_json->'data'->>'guid'

	into  v_album_id,
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
			   v_albumguid;
			   
           -- insert entry in labdms_redirect table :- changes done by rakesh bhatkar --    
	      select labdms.labdms_ins_up_redirect(v_album_id,v_albumtitlealias,v_albumstatus,v_albumassettypeid) into p_result1; 
           -- insert entry in labdms_redirect table :- changes done by rakesh bhatkar --
  
     begin
     	
     
      
      
          select album_id
     	into strict v_albumexists
     	from   labdms.labdms_album
     	where  upper(title_alias) = upper(v_albumtitlealias) ;
          
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
     into   strict v_coverimage
	from   coverimage ci, json_array_elements(ci.t_json#>'{}') obj
	where  (obj->'data'->>'is_cover')::numeric = 1;
                                               
	v_published_date:= coalesce(v_published_date,v_sysdate);
	v_assetdraftid   := nextval('labdms.seq_labdms_asset_draft_id');
	v_assetdraftguid := uuid_generate_v4();
	
	select content_provider_name into v_content_provider_name
		from labdms.labdms_content_provider 
		where content_provider_id = v_albumcontentsourceid
		and is_active = 1 ; 
		select count(1) into v_cnt from labdms.labdms_album where album_guid = v_albumguid;
	
	if not exists (select 1 from labdms.labdms_album where album_guid = v_albumguid )
	then
		
		v_albumassetid   := nextval('labdms.seq_labdms_album_id');
		-- v_albumguid      := uuid_generate_v4();
		v_seodataid      := nextval('labdms.seq_labdms_seo_data_id');
		v_seodataguid    := uuid_generate_v4();
		v_asset_list_id  := nextval ('labdms.seq_labdms_asset_list_id');
		raise notice '1-%',v_json;
		v_json 	       := jsonb_set(v_json, '{data,album_id}', ('"'||v_albumassetid||'"')::text::jsonb, true);
		raise notice '2-%',v_json;
		v_json 	       := jsonb_set(v_json, '{data,guid}', ('"'||v_albumguid||'"')::text::jsonb, true);
		-- v_json := jsonb_set(v_json, '{data,content_provider_name}', ('"'||v_content_provider_name||'"')::text::jsonb, true);
		raise notice '3-%',v_json;
		insert into labdms.labdms_asset_draft
		(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, 
		updated_date, created_by,updated_by, is_active, is_deleted, asset_draft_guid)
		values
		(v_assetdraftid, v_albumassetid, v_albumassettypeid, v_albumversionnumber, v_json, v_sysdate, 
		v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid);
		
		insert into labdms.labdms_album
		( album_id, content_source_id, album_meta, album_type, title, title_alias, 
		short_title, album_desc, partner_id, show_in_web, show_in_mobile, show_in_app,
		cover_image, total_assets, published_version_number, is_trashed, created_date, 
		updated_date, created_by, updated_by, is_active, is_deleted, is_published, album_guid,published_date,show_copyright,content_source_link,
		order_number)
		values 
		(v_albumassetid, v_albumcontentsourceid, v_albummeta, v_albumtype, v_albumtitle, v_albumtitlealias,
		v_albumshorttitle,v_albumdesc,v_albumpartnerid,v_albumshowinweb,v_albumshowinmobile,v_albumshowinapp,
		v_coverimage, v_albumtotalassets, v_albumversionnumber, v_albumistrashed, v_sysdate,
		v_sysdate, v_updatedby, v_updatedby, 1, 0, v_albumstatus, v_albumguid,v_published_date,v_show_copyright,v_content_source_link,
		v_order_number);
		
		insert
		into labdms.labdms_asset_list
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
		
		insert into labdms.labdms_seo_data
		(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, 
		updated_date, created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
		values
		(v_seodataid, v_albumassetid, v_albumassettypeid, v_seojson,v_albumversionnumber,  v_sysdate, 
		v_sysdate, v_updatedby, v_updatedby, 1, 0, v_albumstatus, v_seodataguid);
		
	else
		
		select album_id  into v_album_id from labdms.labdms_album where album_guid=v_albumguid ;
		
		if v_albumstatus = 0 then
		
			if v_albumistrashed = 0 then
				
				select coalesce(max(published_version_number),1)
				into   strict v_pubversionnumber
				from   labdms.labdms_album
				where  album_id      = v_album_id; 
				
				select max(version_number)
				into   strict v_albumversionnumber
				from   labdms.labdms_asset_draft
				where  asset_type_id = v_albumassettypeid
				and    asset_id      = v_album_id;
				
				if v_albumversionnumber > v_pubversionnumber then
					
					update labdms.labdms_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_sysdate
					where  asset_id      = v_album_id
					and    asset_type_id = v_albumassettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   labdms.labdms_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_albumassettypeid);
					
				else                           
					
					v_albumversionnumber := v_albumversionnumber + 1;
					
					insert into labdms.labdms_asset_draft
					(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
					updated_date,created_by, updated_by, is_active, is_deleted, asset_draft_guid)
					values
					( v_assetdraftid, v_album_id, v_albumassettypeid, v_albumversionnumber, v_json, 
					v_sysdate, v_sysdate, v_updatedby, v_updatedby,
					1, 0, v_assetdraftguid);
					
				end if;
				
			else
				
				update labdms.labdms_asset_list
				set is_trashed=v_albumistrashed,  
				is_published=v_albumstatus ,
				updated_date=v_sysdate
				where  asset_id        	  = v_album_id
				and    asset_type_id=v_albumassettypeid;
				
				update labdms.labdms_album
				set 
				is_trashed=v_albumistrashed,  
				is_published=v_albumstatus ,
				updated_date=v_sysdate
				where  album_id        	  = v_album_id;
				
                    update labdms.labdms_asset_draft ad
					set    asset_data        = v_json,
					updated_date      = v_sysdate
					where  asset_id      = v_album_id
					and    asset_type_id = v_albumassettypeid
					and    ad.version_number = (select max(ad1.version_number)
					from   labdms.labdms_asset_draft ad1
					where  ad1.asset_id = ad.asset_id
					and    ad1.asset_type_id = v_albumassettypeid);
          
          
          select max(ad1.version_number)
                  into v_albumversionnumber
                  from   labdms.labdms_asset_draft ad1
                  where  ad1.asset_id = v_album_id
                  and    ad1.asset_type_id = v_albumassettypeid;          
			end if;
			
		else
			
			select max(version_number)
			into   strict v_albumversionnumber
			from   labdms.labdms_asset_draft
			where  asset_type_id = v_albumassettypeid
			and    asset_id      = v_album_id;

			v_albumversionnumber := v_albumversionnumber + 1;
                                              
			v_json 	       := jsonb_set(v_json, '{data,album_id}', ('"'||v_album_id||'"')::text::jsonb, true);

			insert into labdms.labdms_asset_draft
			(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date,
			updated_date, created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values
			(v_assetdraftid, v_album_id, v_albumassettypeid, v_albumversionnumber, v_json, v_sysdate, 
			v_sysdate, v_updatedby, v_updatedby, 1, 0, v_assetdraftguid); 

			update labdms.labdms_album
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

			update labdms.labdms_asset_list
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

			update labdms.labdms_seo_data
			set    meta_info 	 = v_seojson,
			updated_date  = v_sysdate
			where  asset_type_id = v_albumassettypeid
			and    asset_id      = v_album_id;
			
		end if;

	end if;
	
	if (v_album_id is null or (v_album_id is not null and v_albumstatus = 1)) then
		
		if v_cnt=0 then 
		select v_json->'data'->>'entitydata'
		into   v_albumentityjson;
		
		if v_albumentityjson is not null then
			
			delete
			from   labdms.labdms_asset_entity_map
			where  asset_type_id = v_albumassettypeid
			and    asset_id      = v_album_id;
			
			--v_counter := 0;
			
			for v_entity in select * from json_array_elements(v_albumentityjson)
			loop
				
				select 
				v_entity->>'entity_role_map_id', 
				v_entity->>'priority',
				v_entity->>'is_linkable', 
				v_entity->>'is_visible'
				--v_entity->>'source_object_id',
				--v_entity->>'entity_group_type'
				into   v_entityrolemapid, v_priority,v_is_linkable,v_is_visible ; --v_source_object_id,v_entity_group_type;
				
				/*if (v_entityrolemapid is null and  v_source_object_id is not null   ) then 
					
					select b.entity_role_id into v_entity_role_id 
					from labdms.labdms_entity_type a
					join labdms.labdms_entity_role b on a.entity_type_id=b.entity_type_id
					where lower(entity_type_name)=lower(v_entity_group_type) limit 1;
					
					select entity_role_map_id into  v_entityrolemapid
				   	from labdms.labdms_entity_role_map
				    where entity_role_id=v_entity_role_id
					and source_object_id::text=v_source_object_id::text;
					
					if v_entityrolemapid is not null then 
				   	   v_json= jsonb_set(v_json,('{data,entitydata,'||v_counter::text||',entity_role_map_id}')::text[],
                                  ('"'||v_entityrolemapid||'"')::text::jsonb,true);
				  	end if;
				  	
					v_counter:=v_counter+1;
				
				end if;
				*/
				
				if v_entityrolemapid is not null then
					
					v_assetentitymapid   := nextval('labdms.seq_labdms_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
					
					insert into labdms.labdms_asset_entity_map
					(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
					priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
					is_published, aemap_guid)
					values
					(v_assetentitymapid, coalesce(v_album_id, v_albumassetid), v_albumassettypeid,
					v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
					v_sysdate, v_updatedby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
					
					update labdms.labdms_asset_list
					set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
					secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
					where asset_id =  coalesce(v_album_id, v_albumassetid)
                         and    asset_type_id=v_albumassettypeid;
					
				end if;     
				
			end loop;
			
			with tab as (select asset_id,asset_type_id,aem.entity_role_map_id
					   from labdms.labdms_asset_entity_map aem
					   join labdms.labdms_entity_role_map erm
					   on erm.entity_role_map_id = aem.entity_role_map_id
					   join labdms.labdms_entity_category ec
					   on ec.entity_role_id = erm.entity_role_id
					   where ec.category_name = 'language'
					   and aem.asset_id = coalesce(v_album_id, v_albumassetid)
					   and aem.asset_type_id = v_albumassettypeid)
			update labdms.labdms_asset_list al
			set language_id = t.entity_role_map_id
			from tab t
			where al.asset_id = t.asset_id
			and al.asset_type_id = t.asset_type_id;
			
		end if;
		
		end if;
		
		select v_json->'data'->>'images'
		into   v_albumimagejson;   
	
		delete
		from   labdms.labdms_album_asset_map
		where  album_id      = coalesce(v_album_id, v_albumassetid);
	
		if v_albumimagejson is not null then
			
			for v_images in select * from json_array_elements(v_albumimagejson)
			loop
				
				select v_images->'data'->>'image_id',
				v_images->'data'->>'is_cover',
				v_images->'data'->>'order_number',
				v_images->'data'->>'status',
               	v_images->'data'->>'is_delete',
                v_images->'data'->>'is_active'
				into   v_image_id, v_is_cover,v_image_order,v_imagealbstatus, v_isdeleted, v_isactive;
				
				v_albumassetmapid   := nextval('labdms.seq_labdms_asset_draft_id');
				
               	-- if v_isdeleted = 0 then
               		
                    	insert into labdms.labdms_album_asset_map
                    	( album_asset_map_id, album_id, asset_order, asset_id, asset_type_id, created_date, 
                     	updated_date, created_by, updated_by, is_active, is_deleted, is_published,is_cover)
                     	values 
                     	(v_albumassetmapid,  coalesce(v_album_id, v_albumassetid), v_image_order,v_image_id, 
                      	3, v_sysdate, v_sysdate, v_updatedby, v_updatedby, coalesce(v_isactive,1), coalesce(v_isdeleted,0), v_imagealbstatus, v_is_cover);
                    	
               	-- end if;
					
					if v_is_cover = 1 then
						
						select image_path,image_file_name
						into v_image_path ,v_image_file_name
						from labdms.labdms_image
						where image_id = v_image_id;
						
						update labdms.labdms_asset_list
						set image_path = v_image_path,image_file_name = v_image_file_name
						where asset_id = coalesce(v_album_id, v_albumassetid)
						and    asset_type_id=v_albumassettypeid;
						
					end if;
					
				end loop;
			
			end if;
  	
  			/*select v_json->'data'->>'author_data'
			into   v_authordatajson;
	     	
				if v_authordatajson is not null then
			
          			delete
					from   labdms.labdms_author_action
					where  asset_type_id = v_albumassettypeid
					and    asset_id      = v_album_id;
					
					for v_authordata in select * from json_array_elements(v_authordatajson)
					loop
				          	
               			select v_authordata->>'author_id',
               	  		v_authordata->>'action_id'
						into   v_author_id,
               	  		v_action_id;
			
               			if (v_author_id is not null and v_action_id is not null) then
						               
	               			v_authoractionid := nextval('labdms.seq_labdms_author_action_id');
     		               	
               	     		insert into labdms.labdms_author_action(author_action_id,
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
                            update labdms.labdms_asset_list
                            set    author_id  = coalesce(v_author_id,author_id)
                            where  asset_id   = coalesce(v_album_id, v_albumassetid)
                        --		and    author_id is null
                                                 and    asset_type_id=v_albumassettypeid;
                          end if;
							
						end if;
		
					end loop;
	
				end if;*/
	
	if not exists(select 1 from labdms.labdms_user u join labdms.labdms_provider_author_map pam on pam.author_id = u.user_id
					where lower(u.user_name) = 'no-author' and pam.content_provider_id = v_albumcontentsourceid) then
		
		v_content_provider_user_id := nextval('labdms.seq_labdms_user_id');
		
		insert into labdms.labdms_user
		select v_content_provider_user_id,'no-author','no-author','no-author',1,null,null,
				current_timestamp at time zone 'utc',current_timestamp at time zone 'utc',1,1,1,0,1,uuid_generate_v4(),
				'45537343653232554145595446476d72326b316655773d3d',null,null,0,null,null;
		
		insert into labdms.labdms_user_role
		select nextval('labdms.seq_labdms_user_role_id'),v_content_provider_user_id,4,current_timestamp at time zone 'utc',current_timestamp at time zone 'utc',
				1,1,1,0,1,uuid_generate_v4();
		
		insert into labdms.labdms_provider_author_map
		select nextval('labdms.seq_labdms_provider_author_map_id'),v_albumcontentsourceid,v_content_provider_user_id,'no-author',
				current_timestamp at time zone 'utc',current_timestamp at time zone 'utc',1,1,1,0;
		
	else
		
		select user_id into v_content_provider_user_id from labdms.labdms_user u join labdms.labdms_provider_author_map pam on pam.author_id = u.user_id
					where lower(u.user_name) = 'no-author' and pam.content_provider_id = v_albumcontentsourceid;
		
	end if;
	
	delete from labdms.labdms_author_action where asset_type_id = v_albumassettypeid and asset_id = v_album_id;
	
	insert into labdms.labdms_author_action
	select nextval('labdms.seq_labdms_author_action_id'),v_content_provider_user_id,coalesce(v_album_id, v_albumassetid),v_albumassettypeid,4,
			current_timestamp at time zone 'utc', current_timestamp at time zone 'utc';
	
	update labdms.labdms_asset_list set author_id  = v_content_provider_user_id
	where asset_id = coalesce(v_album_id, v_albumassetid) and asset_type_id = v_albumassettypeid;
		
		
		
	end if;
     
	
	   
	    v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_albumversionnumber||'"')::text::jsonb, true);
     
	      /*  select jsonb_agg(value) into v_albumentityjson
				from (
				select  value
             		  from jsonb_array_elements(v_albumentityjson::jsonb) obj(value)
             		  where obj.value->>'entity_role_map_id' is not null
				)tab;
				
			
          v_json := jsonb_set(v_json, '{data,entitydata}', v_albumentityjson::jsonb, true);
		  
		   update labdms.labdms_asset_draft
           set asset_data = v_json
           where asset_id = coalesce(v_album_id, v_albumassetid)
           and asset_type_id = v_albumassettypeid
           and version_number = v_albumversionnumber;
	 
	 */
	 
	p_result := 1;
          
     /*else
     	p_result := 0;
     end if;*/
     
     
	
	if p_result = 1 then
		
		p_data := v_json;
                                               
       if v_albumstatus = 1
     then
   -- p_schema_prefix:='labdms';
	execute 'select array(select entity_role_map_id 
					 from labdms.labdms_asset_entity_map
					 where asset_id = coalesce($1, $2) 
					 and asset_type_id = $3
					)	a '
					into v_array
					using v_album_id, v_albumassetid,v_albumassettypeid;
			
			execute 'select labdms._get_web_list_json(''labdms'',$2,$3)' 
			into v_web_listing_json
			using p_schema_prefix , v_albumassettypeid , v_album_id ;		
	      
		    update labdms.labdms_asset_list
            set tvs = setweight(to_tsvector(coalesce(asset_title,'')), 'a')    ||
                setweight(to_tsvector(coalesce(short_desc,'')), 'b'),
			    web_listing_json=v_web_listing_json,
				web_detail_jsn=v_json  ,
				tagged_entity=v_array
            where asset_id = coalesce(v_album_id, v_albumassetid)
			and asset_type_id=v_albumassettypeid; 

     end if;                                        
		
	end if;
--exception
--	when others then
--		p_result := -1;
end;

 

$_$;


--
