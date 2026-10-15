-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_get_asset_detail_r(character varying)
-- Type: FUNCTION

-- Name: labstmp_get_asset_detail_r(character varying); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_get_asset_detail_r(p_titlealias character varying, OUT p_assetjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_assetid numeric;
    v_assettypeid numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';
    v_assetjsonarr jsonb[];
    v_assetjson jsonb;
    v_json text := '{"items":[';
    v_asset_count numeric;
    
    -- parameters for changes for accomodating listing page data
    v_url text := upper(p_titlealias);
    v_count int;
    v_asset_alias varchar(10000);
    v_fulltext text := ' ';
    v_lang_canonical_url varchar(10);
    v_version_number numeric;
    v_browser_title varchar(10000) := '';
    v_amp numeric := 0;
	v_entity_json jsonb := '[]'::jsonb;
    
begin
	
	select *
	into v_count
	from labstmp.regexp_count(v_url, '/');
	
	v_asset_alias :=   split_part(v_url, '/', (v_count + 1));
	
	begin
		
		select asset_id, asset_type_id
		into v_assetid, v_assettypeid
		from labstmp.labstmp_asset_list
		where (upper(title_alias) = v_url
			   or p_titlealias ~ concat('^',title_alias,'$'))
		and is_published = 1
		and published_date <= v_current_timestamp
		and asset_type_id = 11;
		
      	if v_assetid is null then
			
			select asset_id, asset_type_id, published_version_number
			into v_assetid, v_assettypeid , v_version_number 
			from labstmp.labstmp_asset_list
			where upper(title_alias) = v_asset_alias
			and is_published = 1
			and published_date <= v_current_timestamp
			and asset_type_id in (1,2,4,5,29);
      		
      	end if;
      	
		begin
			
			select asset_data->'data'->>'entitydata'
			into strict v_entity_json
			from labstmp.labstmp_asset_draft
			where asset_id = v_assetid
			and asset_type_id = v_assettypeid
			and version_number = v_version_number;
			
			v_entity_json := coalesce(v_entity_json,'[]'::jsonb);
			
		exception
			when no_data_found then
				v_entity_json := '[]'::jsonb;
		end;
		
		raise notice 'v_entity_json : %',v_entity_json;
		
      	if v_assettypeid in (2,4) then
			
			select asset_data->'data'->>'browser_title'
			into v_browser_title
          	from labstmp.labstmp_asset_draft 
          	where asset_type_id = v_assettypeid
          	and asset_id = v_assetid
          	and version_number = v_version_number;
			
      	end if;
      	
      	if v_assettypeid = 1 then
			
			select coalesce(full_text,' ')
			into v_fulltext
			from labstmp.labstmp_article
         	where article_id = v_assetid;
        	
			if exists(select count(1)
					  from labstmp.labstmp_page
					  where asset_type_id = 1
					  and is_amp = 1) then
				v_amp = 1;
			else
				v_amp = 0;
			end if;
			
		end if;
		
	end;
    
	begin
		select entity_role_map_id
    	into strict v_language_id
    	from labstmp.labstmp_asset_entity_map
    	where asset_type_id = v_assettypeid
    	and asset_id = v_assetid
    	and entity_role_map_id in(select entity_role_map_id
								  from labstmp.labstmp_entity_role_map
								  where entity_role_id = (select entity_role_id
														  from labstmp.labstmp_entity_category
														  where category_name = 'Language'));
	exception
		when no_data_found then
			v_language_id := -1;
    end;
    
    begin
		select entity_master_id
    	into strict v_language_mast_id
    	from labstmp.labstmp_entity_role_map
    	where entity_role_map_id = v_language_id;
    exception
		when no_data_found then
			v_language_mast_id := -1;
    end;
    
    begin
		select canonical_url
    	into strict v_lang_canonical_url
    	from labstmp.labstmp_entity_master
    	where entity_master_id = v_language_mast_id;
	exception
    	when no_data_found then
			v_lang_canonical_url := -1;
    end;
	
    if v_assetid <> -1 then
		
    	execute 'select (''{"items":''||json_agg(row_to_json(row))::text||''}'')::jsonb
					from (select *
							from (select sl.asset_list_id, sl.asset_id, sl.asset_type_id, sl.asset_title, sl.title_alias, author_id, short_desc,
											tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name,
											image_path, duration, sl.show_in_web, sl.show_in_mobile, sl.show_in_app, sl.published_version_number,
											sl.is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by, sl.is_active,
											sl.is_deleted, sl.is_published, sl.published_date, asset_guid, sl.show_copyright, sl.order_number,
											image_file_name, image_path, row_number() over (order by sl.published_date desc) as rno,
											u.display_name user_name, emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name,
											coalesce(pel.entity_display_name, emp.entity_display_name) pri_ent_disp_name,
											coalesce(sel.entity_display_name, ems.entity_display_name) sec_ent_disp_name,
											'||v_language_id||' language_id, sd.meta_info->>''keywords'' keywords, sd.meta_info, $1 as full_text,
											$2 as lang_url, coalesce(ar.browser_title, $3) browser_title, '||v_amp||' is_amp,
											$4 entitydata
									from labstmp.labstmp_asset_list sl
									join labstmp.labstmp_entity_role_map ermp
									on ermp.entity_role_map_id = sl.primary_entity_role_map_id
									join labstmp.labstmp_entity_role_map erms
									on erms.entity_role_map_id = sl.secondary_entity_role_map_id
									join labstmp.labstmp_entity_master emp
									on emp.entity_master_id = ermp.entity_master_id
									join labstmp.labstmp_entity_master ems
									on ems.entity_master_id = erms.entity_master_id
									left join labstmp.labstmp_entity_language_map pel
									on emp.entity_master_id=pel.entity_master_id
									and pel.language_master_id ='||v_language_mast_id||'
									left join labstmp.labstmp_entity_language_map sel
									on ems.entity_master_id=sel.entity_master_id
									and sel.language_master_id ='||v_language_mast_id||'
									left join labstmp.labstmp_seo_data sd
									on sd.asset_id = sl.asset_id
									and sd.asset_type_id = sl.asset_type_id
									left join labstmp.labstmp_article ar
									on ar.article_id = sl.asset_id
									and sl.asset_type_id = 1
									left join labstmp.labstmp_user u
									on u.user_id = sl.author_id
									where sl.is_active = 1
									and sl.is_deleted = 0
									and sl.is_published = 1
									and sl.published_date <= '''||v_current_timestamp||'''
									and sl.asset_id = '||v_assetid||'
									and sl.asset_type_id = '||v_assettypeid||'
								) as tab1
						) row'
		into p_assetjson
		using v_fulltext, v_lang_canonical_url, v_browser_title, v_entity_json;
		
	end if;
	
exception
	when others then
		p_assetjson := '{"items":[]}'::jsonb;
end;

$_$;


--
