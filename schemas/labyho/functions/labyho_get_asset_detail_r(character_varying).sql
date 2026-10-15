-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_get_asset_detail_r(character varying)
-- Type: FUNCTION

-- Name: labyho_get_asset_detail_r(character varying); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_get_asset_detail_r(p_titlealias character varying, OUT p_assetjson jsonb) RETURNS jsonb
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
    v_url varchar(10000);
    v_count int;
    v_asset_alias varchar(10000);
    v_fulltext text := ' ';
    v_lang_canonical_url varchar(10);
    v_version_number numeric;
    v_browser_title varchar(10000) := '';
    v_amp numeric := 0;
	v_amp_1 numeric;
    
begin
       v_sysdate:= current_timestamp at time zone 'utc';
       
       v_url :=lower(p_titlealias);
       select * into v_count from labyho.regexp_count(v_url, '/');
       v_asset_alias :=   split_part(v_url, '/', (v_count+1));
	   
	   if v_url like lower('amp/%') then
	   
	    v_amp_1 := 1;
		
		v_url := replace(v_url,'amp/','');
		p_titlealias := replace(p_titlealias,'amp/','');
		
	    else
		
		v_amp_1 := 0;
	   	 
	    end if;
	   
       
       
    begin
    
    	    select al.asset_id, al.asset_type_id
            into   v_assetid, v_assettypeid
            from   labyho.labyho_asset_list al
			join   labyho.labyho_page p on al.asset_id = p.page_id and coalesce(p.is_amp,0) = v_amp_1
            where  (lower(al.title_alias) = v_url
            		or p_titlealias ~ concat('^',al.title_alias,'$'))
            and    al.is_published=1
            and    al.published_date <= v_sysdate
            and    al.asset_type_id in (11);
            
      
      if v_assetid is null then
            
           -- raise notice '1 : %', v_assetid ; 
            
        select asset_id, asset_type_id, published_version_number
    	into   v_assetid, v_assettypeid , v_version_number 
    	from   labyho.labyho_asset_list
    	where  lower(title_alias) = v_asset_alias
        and    is_published=1
        and    published_date <= v_sysdate
        and    asset_type_id in (1,2,4,5);
            
      end if;
      
      if v_assettypeid in (2,4)
      then 
          select asset_data->'data'->>'browser_title' into v_browser_title
          from labyho.labyho_asset_draft 
          where asset_type_id = v_assettypeid
          and asset_id = v_assetid
          and version_number = v_version_number ;
                             
      end if ; 
      
      
      if v_assettypeid = 1 then
      	 select coalesce(full_text,' ') from labyho.labyho_article
         into v_fulltext
         where article_id = v_assetid;
        -- v_fulltext := replace(v_fulltext,'''','''''');
        
      end if;
      
	  if exists (select 1 from labyho.labyho_page
        where asset_type_id=v_assettypeid and is_amp=1) then 
		
        v_amp=1;
		
      elseif v_amp_1 = 1 then
	  	
		v_amp = 1;
	  
	  else
	  
        v_amp=0;
		
      end if ;
	  
	  
      
    end;
    
    begin
    	select entity_role_map_id
    	into strict v_language_id
    	from   labyho.labyho_asset_entity_map
    	where  asset_type_id = v_assettypeid
    	and    asset_id = v_assetid
    	and    entity_role_map_id in(select entity_role_map_id
        	                         from   labyho.labyho_entity_role_map
            	                     where  entity_role_id = (select entity_role_id
                	                                          from   labyho.labyho_entity_category
                    	                                      where  category_name = 'Language'));
                                                              
                                                             
    exception
    	when no_data_found then
        	v_language_id := -1;
    end;
    
    begin
    	select entity_master_id
    	into strict v_language_mast_id
    	from   labyho.labyho_entity_role_map
    	where  entity_role_map_id = v_language_id;
        
    exception
    	when no_data_found then
        	v_language_mast_id := -1;
    end;
    
    begin
    	select canonical_url
    	into strict v_lang_canonical_url
    	from   labyho.labyho_entity_master
    	where  entity_master_id = v_language_mast_id;
        
    exception
    	when no_data_found then
        	v_lang_canonical_url := -1;
    end;
    
   -- v_sysdate := current_timestamp at time zone 'utc';
    if v_assetid <> -1 then
    execute 'select array(select row_to_json(row) as jsonrow
             from   (select *
                     from   (select sl.asset_list_id, 
					                sl.asset_id, coalesce(p.asset_type_id,sl.asset_type_id) as asset_type_id, sl.asset_title, sl.title_alias, sl.author_id, short_desc, tags,
                                    primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path, duration,
                             		sl.show_in_web, sl.show_in_mobile, sl.show_in_app, sl.published_version_number, sl.is_trashed, sl.created_date, sl.updated_date,
                             		sl.created_by, sl.updated_by, sl.is_active, 
									sl.is_deleted, sl.is_published, sl.published_date, asset_guid,
                             		sl.show_copyright, sl.order_number, image_file_name, image_path,
                             		row_number()over (order by sl.published_date desc) as rno, u.display_name user_name,
                             		emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name,
                             		coalesce(pel.entity_display_name, emp.entity_display_name) pri_ent_disp_name,
                             		coalesce(sel.entity_display_name, ems.entity_display_name) sec_ent_disp_name,'
                                    ||v_language_id||' language_id, sd.meta_info->>''keywords'' keywords,
                                    sd.meta_info, $1 as full_text , $2 as lang_url
                             		, coalesce(ar.browser_title, $3) browser_title,'
                                    ||v_amp||' is_amp,
									cp.content_provider_id content_source_id,
									cp.content_provider_name,
									web_detail_jsn->''data''->>''client_canonical_url'' as client_canonical_url
                             from   labyho.labyho_asset_list sl
                             left join labyho.labyho_user u
                             on     u.user_id = sl.author_id
                             join   labyho.labyho_entity_role_map ermp
                             on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                             join   labyho.labyho_entity_role_map erms
                             on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                             join   labyho.labyho_entity_master emp
                             on     emp.entity_master_id = ermp.entity_master_id
                             left join labyho.labyho_entity_language_map pel
                             on     emp.entity_master_id=pel.entity_master_id
                             and    pel.language_master_id ='||v_language_mast_id||'
                             join   labyho.labyho_entity_master ems
                             on     ems.entity_master_id = erms.entity_master_id
                             left join labyho.labyho_entity_language_map sel
                             on     ems.entity_master_id=sel.entity_master_id
                             and    sel.language_master_id ='||v_language_mast_id||'
                             left join   labyho.labyho_seo_data sd
                             on     sd.asset_id = sl.asset_id
                             and    sd.asset_type_id = sl.asset_type_id
                             left join labyho.labyho_article ar 
                             on (ar.article_id =  sl.asset_id and sl.asset_type_id = 1) 
							 left join yho.yho_provider_author_map pam
							 on pam.author_id = sl.author_id
							 left join yho.yho_content_provider cp
							 on cp.content_provider_id = pam.content_provider_id
							 left join labyho.labyho_page p on p.page_id=sl.asset_id and  sl.asset_type_id=11
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
            using v_fulltext,v_lang_canonical_url, v_browser_title;
	end if;
    
   
    
    if v_assetjsonarr is not null then
	foreach v_assetjson in array v_assetjsonarr
	loop
    	v_json := v_json||v_assetjson||',';
    end loop;
    end if;
	
    select count(1)
    into   v_asset_count
    from   unnest(v_assetjsonarr) asset_id;
    
    if v_asset_count > 0 then
		v_json:= substring(v_json,1,(length(v_json)-1));
    else
    	v_json:= substring(v_json,1,(length(v_json)));
    end if;
    
    v_json := v_json||']}';
    
    p_assetjson  := v_json::jsonb;

end;

 

$_$;


--
