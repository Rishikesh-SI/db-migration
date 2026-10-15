-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_ins_upd_product(jsonb)
-- Type: FUNCTION

-- Name: labmi_ins_upd_product(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_ins_upd_product(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare

v_json 								jsonb;
v_short_desc						character varying;
v_ldesc								text;
v_sysdate 							timestamp;
v_created_by 						numeric;
v_updated_by						numeric;
v_product_guid						character varying;
v_product_id 						numeric;
v_product_name						character varying;
v_attribute_specification_id		numeric;
-- v_sku								character varying;
v_is_visible_individually			numeric;
v_product_tag						character varying;
v_gtin_number						character varying;
v_manufacturer_part_number			character varying;
v_is_show_homepage					numeric;
v_is_allow_customer_review			numeric;
v_available_start_date				timestamp;
v_available_end_date				timestamp;
v_price 							numeric;
v_oldprice							numeric;
v_product_cost 						numeric;
v_discounts 						numeric;
v_is_fix_percentage					numeric;
v_is_tax_exempt						numeric;
v_tax_category						numeric;
v_is_mark_new						numeric;
v_is_shipping_enabled				numeric;
v_is_customize						numeric;
v_admin_comment						character varying;
v_status							numeric;
v_is_deleted						numeric;
v_is_active							numeric;
v_is_trashed						numeric;
v_imagejson							json;
v_inventoryjson						jsonb;
v_prod_shipping						jsonb;
v_product_mapping					jsonb;
v_seojson							jsonb;
v_product_asset_type_id				numeric := 23;
v_product_type_id					numeric;
v_inventory_id						numeric;
v_inventory_method_id				numeric;
v_stock_quantity					numeric;
v_inventory_guid					character varying;
v_product_shipping_id				numeric;
v_weight							numeric;
v_length							numeric;
v_width								numeric;
v_height							numeric;
v_is_free_shipping					numeric;
v_is_ship_separated					numeric;
v_additional_shipping_charges		numeric;
v_delivery_date						timestamp;		
v_product_mapping_id				numeric;
v_product_category_id				numeric;
v_product_manufacturer_id			numeric;
v_stores_limit 						numeric;
--v_product_mapping_id 				numeric;
v_product_mapping_guid				character varying;
v_meta_desc							character varying;
v_focus_key							character varying;
v_custom_meta 						character varying;
v_meta_fields						character varying;
v_keywords							character varying;
v_meta_robots						character varying;
v_canonical_url						character varying;
v_seodataid  						numeric;
v_seodataguid						character varying;
v_productimagemap					jsonb;
v_image_status						numeric;					
v_image_id							numeric;
v_image_desc						character varying;
v_image_order						numeric;
v_product_shipping_guid				character varying;
v_product_image_mapid   			numeric;
v_product_image_mapguid 			character varying;
v_prodentityjson 					json;
v_entity							jsonb;
v_entityrolemapid					numeric;
v_priority							numeric;
v_is_linkable						numeric;
v_is_visible						numeric;
v_assetentitymapid					numeric;
v_assetentitymapguid				character varying;
v_prodspecification					json;
v_specifications					json;
v_product_specificationid			numeric; 
--v_price								numeric;
v_is_addedprice						numeric;
--v_is_customize						numeric;

v_specification_mapid 				numeric;
v_specification_guid			 	character varying;
v_skujson 							json;
v_skuimagejson						json;
v_sku								jsonb;
v_product_skuid						numeric;
v_product_specificationids			numeric[];

v_product_price						numeric;
v_customize_ids						character varying;
v_customize_price					numeric;
v_sku_guid							character varying;
v_sku_code 							character varying;
v_product_code						character varying;
v_codesku							character varying;
v_customizejson						json;
v_customize							jsonb;
v_product_customizeid				numeric;
v_product_customize_mapid 			numeric;
v_customizemap_guid					character varying;
v_product_title 					character varying;
v_slug_url 							character varying;
v_show_in_web						numeric;
v_show_in_mobile					numeric;
v_show_in_app						numeric;
v_asset_list_id 					numeric;
v_image_file_name 	  				varchar(4000);
v_image_path 		  				varchar(4000);
v_imageid 		      				numeric;
v_published_date 					timestamp;
v_show_copyright  					numeric;
v_order_number		  				numeric;
v_assetdraftid 						numeric;
v_assetdraftguid					character varying;
v_versionnumber						numeric := 1;
v_productpublishedstatus			numeric;
v_producttrashedstatus				numeric;
v_pubversionnumber					numeric;
v_ispublished         				numeric;
v_product_customize_map_id numeric;			

v_is_cover numeric ;
v_is_deactivated numeric ;

v_is_delete_img numeric ;
v_is_active_img numeric  ;
BEGIN

		select current_timestamp at time zone 'utc' 
		into   v_sysdate;
		
		-------------------------------------------------------------
		v_json :=p_json;
		-------------------------------------------------------------
		/* ** Get data from JSON	** */
		
		select 	v_json->'data'->>'product_id',
				v_json->'data'->>'product_name',
				v_json->'data'->>'short_desc',
				v_json->'data'->>'description',
				v_json->'data'->>'product_type_id',				
				-- v_json->'data'->>'sku',
				v_json->'data'->>'is_visible_individually',
				v_json->'data'->>'product_tag',
				v_json->'data'->>'gtin_number',
				v_json->'data'->>'manufacturer_part_number',
				v_json->'data'->>'is_show_homepage',
				v_json->'data'->>'is_allow_customer_review',
				v_json->'data'->>'available_start_date',
				v_json->'data'->>'available_end_date',				
				v_json->'data'->>'discounts',
				v_json->'data'->>'is_fix_percentage',
				v_json->'data'->>'is_tax_exempt',
				v_json->'data'->>'tax_category',
				v_json->'data'->>'is_mark_new',
				v_json->'data'->>'is_shipping_enabled',
				v_json->'data'->>'is_customize',
				v_json->'data'->>'admin_comment',
				v_json->'data'->>'is_published',
				v_json->'data'->>'is_deleted',
				v_json->'data'->>'is_active',
				v_json->'data'->>'is_trashed',
				v_json->'data'->>'imagejson',
				v_json->'data'->>'inventoryjson',
				v_json->'data'->>'prod_shipping',
				v_json->'data'->>'product_mapping',
				v_json->'data'->>'seo',
				v_json->'data'->>'created_by',
				v_json->'data'->>'updated_by',
                v_json->'data'->>'product_code',
                v_json->'data'->>'slug_url',
                v_json->'data'->>'product_title',
                v_json->'data'->>'show_in_web',
                v_json->'data'->>'show_in_mobile',
                v_json->'data'->>'show_in_app',
                v_json->'data'->>'image_id',
           		v_json->'data'->>'image_file_name',
           		v_json->'data'->>'image_path',
                v_json->'data'->>'published_date',
				v_json->'data'->>'product_price'
                
		into 			
				v_product_id,
				v_product_name,
				v_short_desc,
				v_ldesc,
				v_product_type_id,				
				v_is_visible_individually,
				v_product_tag,
				v_gtin_number,
				v_manufacturer_part_number,
				v_is_show_homepage,
				v_is_allow_customer_review,
				v_available_start_date,
				v_available_end_date,				
				v_discounts,
				v_is_fix_percentage,
				v_is_tax_exempt,
				v_tax_category,
				v_is_mark_new,
				v_is_shipping_enabled,
				v_is_customize,
				v_admin_comment,
				v_status,
				v_is_deleted,
				v_is_active,
				v_is_trashed,
				v_imagejson,
				v_inventoryjson,
				v_prod_shipping,
				v_product_mapping,
				v_seojson,
				v_created_by, 
				v_updated_by,
                v_product_code,
                v_slug_url,
                v_product_title,
                v_show_in_web,
                v_show_in_mobile,
                v_show_in_app,
                v_imageid,
           		v_image_file_name,
           		v_image_path,
                v_published_date,
				v_price;
		           
  		select  v_inventoryjson->>'inventory_method_id', 
        		v_inventoryjson->>'product_inventory_id',
                v_inventoryjson->>'stock_quantity'
        into    v_inventory_method_id,
        	    v_inventory_id,
                v_stock_quantity;
                
		select 	v_prod_shipping->>'product_shipping_id',
				v_prod_shipping->>'weight',
				v_prod_shipping->>'length',
				v_prod_shipping->>'width',
				v_prod_shipping->>'height',
				v_prod_shipping->>'is_shipping_enabled',
				v_prod_shipping->>'is_free_shipping',
				v_prod_shipping->>'is_ship_separated',
				v_prod_shipping->>'additional_shipping_charges',
				v_prod_shipping->>'delivery_date'
				
		into 	 v_product_shipping_id
			 	 v_weight,
                 v_length,
                 v_width,
                 v_height,
                 v_is_shipping_enabled,
                 v_is_free_shipping,
                 v_is_ship_separated,
                 v_additional_shipping_charges,
                 v_delivery_date;
				 
		v_assetdraftid := nextval('labmi.seq_labmi_asset_draft_id');
		v_assetdraftguid := uuid_generate_v4();		 
 
 insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'labmi_ins_upd_product','logs',uuid_generate_v4(),p_json,current_timestamp,'labmi','logs');

 
		if v_product_id is null 
		then
			
			v_product_id := nextval('labmi.seq_labmi_product_id');
			v_product_guid :=  uuid_generate_v4();
            v_asset_list_id := nextval ('labmi.seq_labmi_asset_list_id');
            v_product_shipping_id := nextval('labmi.seq_labmi_product_shipping_id');	
            v_product_shipping_guid := uuid_generate_v4();			
            v_seodataid := nextval('labmi.seq_labmi_seo_data_id');
			v_seodataguid := uuid_generate_v4();
			
			v_json := jsonb_set(v_json, '{data,product_id}', v_product_id::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,product_guid}', ('"'||v_product_guid||'"')::jsonb, true);
	
           		
            v_json := jsonb_set(to_jsonb(v_json),'{data,prod_shipping,product_shipping_id}', v_product_shipping_id::text::jsonb, true); 
            v_json := jsonb_set(to_jsonb(v_json),'{data,prod_shipping,product_shipping_guid}', ('"'||v_product_shipping_guid||'"')::jsonb, true); 
            v_json := jsonb_set(to_jsonb(v_json),'{data,prod_shipping,product_id}', v_product_id::text::jsonb, true);
                                
			insert into labmi.labmi_product
				(product_id, product_name, product_title, title_alias, short_desc, description, product_type_id, product_code, product_price, is_visible_individually, 
				 gtin_number, manufacturer_part_number, is_show_homepage, is_allow_customer_review, available_start_date, available_end_date, 
                 discounts, is_fix_percentage, is_tax_exempt, tax_category, product_json, is_mark_new, is_shipping_enabled,
				 admin_comment, created_date, updated_date, created_by, updated_by, product_guid, is_active, is_deleted, is_published, is_trashed,
                 show_in_web, show_in_mobile, show_in_app, published_date,published_version_number)
			values
				(v_product_id, v_product_name, v_product_title, v_slug_url, v_short_desc, v_ldesc, v_product_type_id, v_product_code, v_price, v_is_visible_individually,
				 v_gtin_number, v_manufacturer_part_number, v_is_show_homepage, v_is_allow_customer_review, v_available_start_date, v_available_end_date, 
                 v_discounts, v_is_fix_percentage, v_is_tax_exempt, v_tax_category,  v_json, v_is_mark_new, v_is_shipping_enabled,
				 v_admin_comment, v_sysdate, v_sysdate,  v_created_by, v_updated_by, v_product_guid, v_is_active, v_is_deleted, v_status, v_is_trashed,
                 v_show_in_web, v_show_in_mobile, v_show_in_app, v_published_date, v_versionnumber
				) ;
			
			insert into labmi.labmi_asset_draft
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
			values(v_assetdraftid, v_product_id, v_product_asset_type_id, v_versionnumber, v_json, v_sysdate, v_sysdate, v_created_by, v_updated_by, 1, 0, v_assetdraftguid);
			
							
			insert into labmi.labmi_product_shipping
				(product_shipping_id, product_id, weight, length, width, height, is_shipping_enabled, is_free_shipping, is_ship_separated,
				 additional_shipping_charges, delivery_date, created_date, updated_date, created_by, updated_by, product_shipping_guid,
				is_active, is_deleted, is_published)
			values(v_product_shipping_id, v_product_id, v_weight, v_length, v_width, v_height, v_is_shipping_enabled, v_is_free_shipping, v_is_ship_separated,
					v_additional_shipping_charges, v_delivery_date, v_sysdate, v_sysdate, v_created_by, v_updated_by, v_product_shipping_guid, v_is_active, v_is_deleted, 
					v_status);					
            
            insert into labmi.labmi_asset_list
            (asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags,
            primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path,
            duration, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, 
            updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid,
            show_copyright, order_number,short_title)
            
            select v_asset_list_id, v_product_id, v_product_asset_type_id, v_product_title, v_slug_url, null, 
                   v_short_desc, null, null, null, null, v_image_file_name, v_image_path, null, 
                   v_show_in_web, v_show_in_mobile, 0, v_versionnumber, v_is_trashed, v_sysdate, v_sysdate,
               	   v_created_by, v_updated_by, 1, 0, v_status, v_published_date, v_product_guid, v_show_copyright, 
                   v_order_number,v_product_name;
            
			insert into labmi.labmi_seo_data
				(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, updated_date,
                 created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
			values(v_seodataid, v_product_id, v_product_asset_type_id, v_seojson, 1, v_sysdate, v_sysdate, v_created_by, v_updated_by, 
					v_is_active, v_is_deleted, v_status, v_seodataguid);
			
            
		else 
			
			select is_published, is_trashed
			into v_productpublishedstatus, v_producttrashedstatus
			from labmi.labmi_product 
			where product_id = v_product_id;
						
			insert into  labmi.labmi_product_hist 
			select *, v_sysdate from labmi.labmi_product 
			where product_id = v_product_id;
			
            if v_status = 0 then
            	
                if v_is_trashed = 0 then 
				
					select coalesce(published_version_number,1), is_published
					into   strict v_pubversionnumber, v_ispublished
					from   labmi.labmi_product
					where  product_id = v_product_id;
						
					select max(version_number)
					into   strict v_versionnumber
					from   labmi.labmi_asset_draft
					where asset_id = v_product_id
					and asset_type_id = v_product_asset_type_id;
					
					if ((v_versionnumber = v_pubversionnumber and v_ispublished = 0) or (v_versionnumber > v_pubversionnumber)) then
						
                        update labmi.labmi_asset_draft ad
						set    asset_data        = v_json,
						       updated_date      = v_sysdate
						where  asset_id          = v_product_id
                        and    asset_type_id     = v_product_asset_type_id
						and    ad.version_number = (select max(ad1.version_number)
                                                    from   labmi.labmi_asset_draft ad1
                                                    where  ad1.asset_id = ad.asset_id
                                                    and    ad1.asset_type_id = ad.asset_type_id);
						
					else
						
						v_versionnumber := v_versionnumber + 1;
                        
						insert into labmi.labmi_asset_draft
						(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,  created_by, updated_by, is_active, is_deleted, asset_draft_guid)
						values(v_assetdraftid, v_product_id, v_product_asset_type_id, v_versionnumber, v_json, v_sysdate, v_sysdate, v_created_by, v_updated_by, 1, 0, v_assetdraftguid);
						
                    end if;
					
				else	
					
					 update labmi.labmi_product
					 set    is_published = v_status,
                    	   is_trashed   = 1,
						   updated_date = v_sysdate					 
					where  product_id = v_product_id;
					
                    update labmi.labmi_asset_draft ad
                    set    asset_data        = v_json,
                    	   updated_date      = v_sysdate
					where  asset_id          = v_product_id
					and    asset_type_id     = v_product_asset_type_id
                    and    ad.version_number = (select max(ad1.version_number)
                                                from   labmi.labmi_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
					
					update labmi.labmi_asset_list
					set    updated_date = v_sysdate,
						   updated_by   = v_updated_by,                           
                           is_published = v_status,
                           is_trashed   = v_is_trashed
					where  asset_id     = v_product_id
          			and asset_type_id   = v_product_asset_type_id;
                    
			  		select max(ad1.version_number)
                    into   v_versionnumber
                    from   labmi.labmi_asset_draft ad1
                    where  ad1.asset_id = v_product_id
					and    ad1.asset_type_id = v_product_asset_type_id;
				
				end if ;
				
			else	
				
				select max(version_number)
				into   strict v_versionnumber
				from   labmi.labmi_asset_draft
				where  asset_type_id = v_product_asset_type_id
				and    asset_id      = v_product_id;
				
				raise notice ' no % %',v_product_asset_type_id,v_product_id ;
				
				v_versionnumber := v_versionnumber + 1;
				
				
				
				insert into labmi.labmi_asset_draft
				(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,  created_by, updated_by, is_active, is_deleted, asset_draft_guid)
				values(v_assetdraftid, v_product_id, v_product_asset_type_id, v_versionnumber, v_json, v_sysdate, v_sysdate, v_created_by, v_updated_by, 1, 0, v_assetdraftguid);
			
				update labmi.labmi_product 
                set product_name = v_product_name,
                	product_title = v_product_title, 
                    title_alias = v_slug_url,
                	short_desc = v_short_desc, 
                    description = v_ldesc, 
                    product_type_id = v_product_type_id,                    
                    product_code = v_product_code,
                    is_visible_individually = v_is_visible_individually,                   
				 	gtin_number = v_gtin_number, 
                    manufacturer_part_number = v_manufacturer_part_number, 
                    is_show_homepage = v_is_show_homepage, 
                    is_allow_customer_review = v_is_allow_customer_review, 
                    available_start_date = v_available_start_date, 
                    available_end_date = v_available_end_date,                   
                   -- discounts = v_discounts, 
                    is_fix_percentage = v_is_fix_percentage, 
                    is_tax_exempt = v_is_tax_exempt, 
                    tax_category = v_tax_category, 
                    product_json = v_json, 
                    is_mark_new = v_is_mark_new, 
                    is_shipping_enabled = v_is_shipping_enabled,
				 	-- is_customize = v_is_customize, 
                    admin_comment = v_admin_comment,                     
                    updated_date = v_sysdate,                    
                    updated_by = v_updated_by,                      
                    is_active = v_is_active, 
                    is_deleted = v_is_deleted, 
                    is_published = v_status, 
                    is_trashed = v_is_trashed,
                    show_in_web = v_show_in_web, 
                    show_in_mobile = v_show_in_mobile, 
                    show_in_app = v_show_in_app,
                    published_date = v_published_date,
					product_price = v_price,
					published_version_number = v_versionnumber
                 where product_id = v_product_id;
               
                update labmi.labmi_product_shipping
                set weight = v_weight, 
                    length = v_length, 
                    width = v_width, 
                    height = v_height, 
                    is_shipping_enabled = v_is_shipping_enabled, 
                    is_free_shipping = v_is_free_shipping, 
                    is_ship_separated = v_is_ship_separated,
				 	additional_shipping_charges = v_additional_shipping_charges, 
                    delivery_date = v_delivery_date, 
                    updated_date = v_sysdate, 
                    updated_by = v_updated_by,                     
                    is_active = v_is_active, 
                    is_deleted = v_is_deleted, 
                    is_published = v_status
               where product_shipping_id = v_product_shipping_id
               and product_id = v_product_id;
                              
               update labmi.labmi_asset_list
               set    asset_title        	   = v_product_title,
					  title_alias       	   = v_slug_url,
                      short_desc    	       = v_short_desc,
                      show_in_app       	   = 0,
                      published_version_number = v_versionnumber,
                      updated_date      	   = v_sysdate,
                      updated_by        	   = v_updated_by,
                      is_active         	   = 1,
                      is_deleted        	   = 0,
                      is_published      	   = v_status,
                      is_trashed        	   = v_is_trashed,
                      published_date           = v_published_date,
                      show_in_web              = v_show_in_web ,
                      show_in_mobile           = v_show_in_mobile,
                      show_copyright           = v_show_copyright,
                      order_number 			   = v_order_number,
                      short_title              = v_product_name
             where asset_id = v_product_id
             and asset_type_id = v_product_asset_type_id; 
			 
               
               update  labmi.labmi_seo_data
               set meta_info = v_seojson, 
               	   updated_date = v_sysdate,
                   updated_by = v_updated_by, 
                   is_active = v_is_active, 
                   is_deleted = v_is_deleted, 
                   is_published = v_status
               where seo_data_id = v_seodataid
               and asset_id = v_product_id
               and asset_type_id = v_product_asset_type_id;
			   
			end if ;       
		end if ; 
		
	 if (v_status in (0, 1)) then
	--if (v_product_id is null or (v_product_id is not null and v_status = 1) or (v_productpublishedstatus = 0 and v_producttrashedstatus = 0)) then
		
		select v_json->'data'->>'entitydata', 
        	
        	   v_json->'data'->>'skujson' , 
               v_json->'data'->'skujson'->>'imagedata',
               v_json->'data'->>'customizejson'
		into   v_prodentityjson,         	
        	   v_skujson, 
               v_skuimagejson,
               v_customizejson;
		
		if v_skujson is not null then 	
			
         -- delete from  labmi.labmi_product_sku
          --where product_id = v_product_id ; 

		  --delete from labmi.labmi_product_inventory
          --where product_id = v_product_id ; 
          
			for v_sku in select * from json_array_elements(v_skujson)
			loop
            
            
				select  v_sku->'skudata'->>'product_sku_id', 					   		
					   --	v_sku->>'sku_code', 
                        v_sku->'skudata'->>'attribute_specification_ids',
					   	v_sku->'skudata'->>'product_price',						
						v_sku->'skudata'->>'is_customize',
                        v_sku->'skudata'->>'product_customize_ids',
                        v_sku->'skudata'->>'customize_price',
                        v_sku->'skudata'->>'stock_quantity',
                        v_sku->'skudata'->>'sku_guid',
                        v_sku->'skudata'->>'inventory_method_id'
							
				into   	v_product_skuid, 
						v_product_specificationids, 
						v_product_price,						
						v_is_customize, 
                        v_customize_ids,
                        v_customize_price,
                        v_stock_quantity,
                        v_sku_guid,
                        v_inventory_method_id;
				
				     if v_product_skuid is null 
					     then 
                             v_product_skuid := nextval('labmi.seq_labmi_product_sku_id');
				             v_sku_guid := uuid_generate_v4();                
                             v_inventory_id := nextval('labmi.seq_labmi_product_inventory_id');
                             v_inventory_guid := uuid_generate_v4();
                
                             v_sku := jsonb_set(v_sku,'{skudata,product_sku_id}', v_product_skuid::text::jsonb, true);                 
                             v_sku := jsonb_set(v_sku, '{skudata,product_inventory_id}', v_inventory_id::text::jsonb, true);                
            	             v_sku := jsonb_set(v_sku,'{skudata,sku_guid}', ('"'||v_sku_guid||'"')::jsonb, true); 
		 		             v_sku := jsonb_set(v_sku,'{skudata,product_id}', v_product_id::text::jsonb, true);                 
                
            
                         select string_agg(ab.specification_code,'-') into v_codesku
                         from (select a.attribute_name,  s.specification_code
                         from labmi.labmi_product_attribute_specification s
                         inner join labmi.labmi_product_attribute a on (a.product_attribute_id = s.product_attribute_id)                
                         where product_attribute_specification_id in (select unnest(v_product_specificationids))
                         order by a.attribute_name  
                        )ab ;
                  
                         v_sku_code := v_product_code||'-'||v_codesku||'-'||v_product_skuid::text ;
                
           		
               -- v_json := jsonb_set(v_json, '{data,product_guid}', ('"'||v_product_guid||'"')::jsonb, true);
			
				    insert into labmi.labmi_product_sku
                       (product_sku_id, 
					   product_id, 
					   sku_code, 
					   attribute_specification_ids, 
					   product_price, 
					   is_customize,
                       sku_json, 
					   sku_guid, 
					   created_date, 
					   updated_date, 
					   created_by, 
                       updated_by, 
					   is_active, 
					   is_deleted, 
					   is_published )
                select   v_product_skuid, 
				         v_product_id, 
				         v_sku_code, 
					     v_product_specificationids, 
					     v_product_price, 
					     v_is_customize,
                		 v_sku, 
						 v_sku_guid, 
						 v_sysdate, 
						 v_sysdate, 
						 v_created_by, 
						 v_updated_by,
                         v_is_active, 
						 v_is_deleted, 
						 V_status;
                        
                 insert into labmi.labmi_product_inventory
				 (product_inventory_id, 
				 inventory_method_id, 
				 product_id, 
				 product_sku_id, 
				 stock_quantity, 
				 created_date, 
				 updated_date, 
				 created_by, 
				 updated_by, 
				 product_inventory_guid, 
				 is_active, 
				 is_deleted,
				 is_published)
				values(v_inventory_id, 
				v_inventory_method_id, 
				v_product_id, 
				v_product_skuid, 
				v_stock_quantity, 
                       v_sysdate, 
					   v_sysdate, 
					   v_created_by, 
					   v_updated_by, 
					   v_inventory_guid, 
					   v_is_active, 
					   v_is_deleted, 
                       v_status );   

                    else 
					
					     update labmi.labmi_product_sku
					     set product_price=v_product_price,updated_date=v_sysdate
					    where product_sku_id=v_product_skuid ;
					  
					    update labmi.labmi_product_inventory
					    set stock_quantity=v_stock_quantity,
						updated_date=v_sysdate
					    where product_sku_id=v_product_skuid;
					 

                 end if;
					   
				
			end loop; 
			
			
			
			
			
			
		end if ;
		
        if v_customizejson is not null then 
        
        	-- delete from labmi.labmi_product_customize_map
            -- where product_id = v_product_id ; 

        	for v_customize in select * from json_array_elements(v_customizejson)
			loop
        			select  v_customize->'data'->>'product_customize_id', 
                            v_customize->'data'->>'customize_price', 
                            v_customize->'data'->>'is_added_price'  ,
                            v_customize->'data'->>'product_customize_map_id' 	,
							v_customize->'data'->>'is_deactivated'
                    into 	v_product_customizeid,
                         	v_customize_price,
                         	v_is_addedprice,
                            v_product_customize_map_id  ,
							v_is_deactivated;                
                            
							
							if v_product_customize_map_id is null
							
							then 
							
                     v_product_customize_mapid := nextval('labmi.seq_labmi_product_customize_map_id');
                     v_customizemap_guid := uuid_generate_v4();                    
                     
                    insert into labmi.labmi_product_customize_map
					(product_customize_map_id, product_id, product_customize_id, customize_price, is_added_price, created_date,
					 updated_date, created_by, updated_by, pcm_guid, is_active, is_deleted, is_published,is_deactivated )   
                    select v_product_customize_mapid, v_product_id, v_product_customizeid, v_customize_price, v_is_addedprice,
                    	v_sysdate, v_sysdate,v_created_by, v_updated_by, v_customizemap_guid, 1, 0, 1 ,v_is_deactivated ;
                    
					
					else 
					  update labmi.labmi_product_customize_map
					  set product_customize_id=v_product_customizeid,
					      customize_price=v_customize_price,
						  updated_date=v_sysdate,
						  is_deactivated=v_is_deactivated
					  where product_customize_map_id=v_product_customize_map_id;
					
					end if ;
					
            end loop;
			
			
        end if ; 
		
		if v_prodentityjson is not null then
			
			delete from labmi.labmi_asset_entity_map
			where  asset_type_id = v_product_asset_type_id
			and    asset_id      = v_product_id;
			
			for v_entity in select * from json_array_elements(v_prodentityjson)
			loop
				
				select v_entity->>'entity_role_map_id', 
					   v_entity->>'priority',
					   v_entity->>'is_linkable', 
					   v_entity->>'is_visible'
				into   v_entityrolemapid, v_priority,v_is_linkable,v_is_visible;
				
				if v_entityrolemapid is not null then
					
					v_assetentitymapid   := nextval('labmi.seq_labmi_asset_entity_map_id');
					v_assetentitymapguid := uuid_generate_v4();
					
					insert into labmi.labmi_asset_entity_map
					(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
					priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
					is_published, aemap_guid)
					values (v_assetentitymapid, v_product_id, v_product_asset_type_id,
					v_entityrolemapid, v_is_linkable, v_is_visible, v_priority, v_sysdate,
					v_sysdate, v_created_by, v_updated_by, 1, 0, 1, v_assetentitymapguid);
					
					update labmi.labmi_asset_list
					set primary_entity_role_map_id = case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
					secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
					where asset_id = v_product_id
                    and  asset_type_id = v_product_asset_type_id;
                         
				end if;     
				
			end loop;
			
		end if;	
            
		if v_imagejson is not null then
		
			delete
			from   labmi.labmi_product_image_map
			where  product_id      = v_product_id;
			
			for v_productimagemap in select * from json_array_elements(v_imagejson)
			loop
				
				select v_productimagemap->'data'->>'status',                    	   
					   v_productimagemap->'data'->>'image_id',
					   v_productimagemap->'data'->>'image_desc',
					   v_productimagemap->'data'->>'order_number',
					   v_productimagemap->'data'->>'is_cover',
					   v_productimagemap->'data'->>'is_delete',
					   v_productimagemap->'data'->>'is_active'
				into   v_image_status,
					   v_image_id,
					   v_image_desc,
					   v_image_order,
					   v_is_cover,
					   v_is_delete_img,
					   v_is_active_img;
				 
					v_product_image_mapid   := nextval('labmi.seq_labmi_product_image_map_id');
					v_product_image_mapguid := uuid_generate_v4();
					
					
					-- select * from labmi.labmi_product_image_map;
					insert into labmi.labmi_product_image_map
						(product_image_map_id, product_id, image_id, image_order, created_date, updated_date, created_by, updated_by,
						is_active, is_deleted, is_published,is_cover)
					values(v_product_image_mapid, v_product_id,
						v_image_id, v_image_order,
						v_sysdate, v_sysdate, v_created_by, 
						v_updated_by,
						v_is_active_img, 
						v_is_delete_img, 
						v_image_status,
						v_is_cover);				
				
			end loop;
			
		end if;
    end if;        
			p_result := 1;
			
			raise notice '%',v_versionnumber;
			--select 1/0;
			--v_json:=jsonb_set(v_json, '{data,version_number}',v_versionnumber::text::jsonb,true) ;

            p_data := v_json;
			
    
 /* exception 
    	when others then 
        	p_result := -1;
            p_data := null;
  */         
END;

$$;


--
