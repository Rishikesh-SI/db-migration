-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_asset_detail_r(character varying)
-- Type: FUNCTION

-- Name: stn_get_asset_detail_r(character varying); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_asset_detail_r(p_titlealias character varying, OUT p_assetjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_assetid numeric;
    v_assettypeid numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
    v_sysdate timestamp;
    v_assetjsonarr jsonb[];
    v_assetjson jsonb;
    v_json text := '{"items":[';
    v_asset_count numeric;
    
    -- parameters for changes for accomodating listing page data
    v_url VARCHAR(10000);
    v_count int;
    v_asset_alias varchar(10000);
    v_fulltext text := ' ';
    v_lang_canonical_url varchar(10);
    
begin
       v_sysdate:= current_timestamp at time zone 'utc';
       
       v_url :=upper(p_titlealias);
       select * into v_count from stn.REGEXP_COUNT(v_url, '/');
       v_asset_alias :=   split_part(v_url, '/', (v_count+1));
       
    begin
    
    	select asset_id, asset_type_id
    	into   v_assetid, v_assettypeid
    	from   stn.stn_asset_list
    	where  upper(title_alias) = v_asset_alias
      and    is_published=1
      and    published_date <= v_sysdate
      and    asset_type_id in (1,2,4,5);
      
      if v_assetid is null then
            select asset_id, asset_type_id
            into   v_assetid, v_assettypeid
            from   stn.stn_asset_list
            where  (upper(title_alias) = v_url
            		or p_titlealias ~ concat('^',title_alias,'$'))
            and    is_published=1
            and    published_date <= v_sysdate
            and    asset_type_id in (11);
      end if;
      
      if v_assettypeid = 1 then
      	select coalesce(full_text,' ') from stn.stn_article
        into v_fulltext
        where article_id = v_assetid;
        
        -- v_fulltext := replace(v_fulltext,'''','''''');
        
      end if;
      
    end;
    
    begin
    	select entity_role_map_id
    	into strict v_language_id
    	from   stn.stn_asset_entity_map
    	where  asset_type_id = v_assettypeid
    	and    asset_id = v_assetid
    	and    entity_role_map_id in(select entity_role_map_id
        	                         from   stn.stn_entity_role_map
            	                     where  entity_role_id = (select entity_role_id
                	                                          from   stn.stn_entity_category
                    	                                      where  category_name = 'Language'));
    exception
    	when no_data_found then
        	v_language_id := -1;
    end;
    
    begin
    	select entity_master_id
    	into strict v_language_mast_id
    	from   stn.stn_entity_role_map
    	where  entity_role_map_id = v_language_id;
    exception
    	when no_data_found then
        	v_language_mast_id := -1;
    end;
    
    begin
    	select canonical_url
    	into strict v_lang_canonical_url
    	from   stn.stn_entity_master
    	where  entity_master_id = v_language_mast_id;
    exception
    	when no_data_found then
        	v_lang_canonical_url := -1;
    end;
    
   -- v_sysdate := current_timestamp at time zone 'utc';
    if v_assetid <> -1 then
    execute 'select array(select row_to_json(row) as jsonrow
             from   (select *
                     from   (SELECT sl.asset_list_id, sl.asset_id, sl.asset_type_id, sl.asset_title, sl.title_alias, author_id, short_desc, tags,
                                    primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path, duration,
                             		show_in_web, show_in_mobile, show_in_app, sl.published_version_number, is_trashed, sl.created_date, sl.updated_date,
                             		sl.created_by, sl.updated_by, sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid,
                             		show_copyright, order_number, image_file_name, image_path,
                             		row_number()over (order by sl.published_date desc) as rno, u.display_name user_name,
                             		emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name,
                             		COALESCE(pel.entity_display_name, emp.entity_display_name) pri_ent_disp_name,
                             		COALESCE(sel.entity_display_name, ems.entity_display_name) sec_ent_disp_name,'
                                    ||v_language_id||' language_id, sd.meta_info->>''keywords'' keywords, sd.meta_info, $1 as full_text , $2 as lang_url
                             FROM   stn.stn_asset_list sl
                             left join stn.stn_user u
                             on     u.user_id = sl.author_id
                             join   stn.stn_entity_role_map ermp
                             on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                             join   stn.stn_entity_role_map erms
                             on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                             join   stn.stn_entity_master emp
                             on     emp.entity_master_id = ermp.entity_master_id
                             left join stn.stn_entity_language_map pel
                             on     emp.entity_master_id=pel.entity_master_id
                             and    pel.language_master_id ='||v_language_mast_id||'
                             join   stn.stn_entity_master ems
                             on     ems.entity_master_id = erms.entity_master_id
                             left join stn.stn_entity_language_map sel
                             on     ems.entity_master_id=sel.entity_master_id
                             and    sel.language_master_id ='||v_language_mast_id||'
                             left join   stn.stn_seo_data sd
                             on     sd.asset_id = sl.asset_id
                             and    sd.asset_type_id = sl.asset_type_id
                             where  sl.is_active=1
                             and    sl.is_deleted=0
                             and    sl.is_published=1
                             and    sl.published_date<='''||v_sysdate||'''
                             and    sl.asset_id = '||v_assetid||'
                             and    sl.asset_type_id = '||v_assettypeid||'
                            )  as tab1
                    ) row
            )'
            into v_assetjsonarr
            using v_fulltext,v_lang_canonical_url;
	end if;
    
    if v_assetjsonarr is not null then
	foreach v_assetjson in array v_assetjsonarr
	loop
    	v_json := v_json||v_assetjson||',';
    end loop;
    end if;
	
    SELECT COUNT(1)
    INTO   v_asset_count
    FROM   UNNEST(v_assetjsonarr) asset_id;
    
    IF v_asset_count > 0 THEN
		V_JSON:= substring(v_json,1,(length(v_json)-1));
    ELSE
    	V_JSON:= substring(v_json,1,(length(v_json)));
    END IF;
    
    v_json := v_json||']}';
    
    p_assetjson  := v_json::jsonb;
    
end;

$_$;


--
