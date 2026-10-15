-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_get_asset_listing_press_coverage_r(numeric, numeric, numeric, numeric[], numeric[], timestamp without time zone)
-- Type: FUNCTION

-- Name: pkl_get_asset_listing_press_coverage_r(numeric, numeric, numeric, numeric[], numeric[], timestamp without time zone); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.pkl_get_asset_listing_press_coverage_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_asset_type_id numeric[], p_pressreleasedate timestamp without time zone, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	v_titlealias JSON;
    v_entityjson json;
    v_entity json;
    v_json text := '{"items":[';
    v_assetcount numeric := 0;
    v_asset_count numeric:=0;
    v_assetjson jsonb;
    v_sysdate timestamp;
    v_ent_count numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
  
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_assetjsonarr jsonb[];
    v_date 				date[];
    v_asset_type_id numeric := 1;

begin
    v_sysdate:= current_timestamp at time zone 'utc';
    
    select count(distinct entity_id)
     into   v_ent_count
    from   unnest(p_entityrole_mapid)entity_id;
    
    if p_page1_size is null 
    then 
              v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
              v_torownumber   := (p_pagenumber * p_itemnumber);
    else 
          if (p_pagenumber=1) then 
          	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          else 
          	v_fromrownumber := p_page1_size + ( (( (p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
          end if;
       v_torownumber   := p_page1_size + ( (p_pagenumber-1) * p_itemnumber);
	end if;
     
    SELECT pkl.pkl_get_entity_language_from_entities(p_entityrole_mapid)
    INTO v_language_id;
    
    SELECT  ERM.entity_master_id into v_language_mast_id 
    FROM pkl.pkl_ENTITY_ROLE_MAP ERM 
    where ERM.ENTITY_ROLE_MAP_ID =(v_language_id);
    
   --- v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
    
    SELECT count(1) into v_assetcount    
    FROM   pkl.pkl_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date <=  v_sysdate
   -- and    sl.asset_type_id in (1)
    and sl.asset_type_id in 
                    (CASE WHEN p_asset_type_id IS NOT NULL THEN
                    (SELECT asset_type_id FROM UNNEST(p_asset_type_id) U(asset_type_id))
                    ELSE sl.asset_type_id
                    END )
    and    sl.secondary_entity_role_map_id = 1053 ;
    
    if p_pressreleasedate is null then 
   	
        select array_agg(published_date::date)
        into v_date
        from  
        (select distinct  published_date 
        FROM   pkl.pkl_asset_list sl
        where  sl.is_active=1
        and    sl.is_deleted=0
        and    sl.is_published=1
        and    sl.published_date <=  v_sysdate
        and    sl.asset_type_id in (1) 
        and    sl.secondary_entity_role_map_id = 1053
        order by published_date desc    
        limit 10
         )A ;
     
   else 
   
       select array_agg(published_date::date) 
       into v_date
        from  
        (select distinct  published_date 
         FROM   pkl.pkl_asset_list sl
         where  sl.is_active=1
         and    sl.is_deleted=0
         and    sl.is_published=1
         and    sl.published_date <=  v_sysdate
         and    sl.asset_type_id in  (CASE WHEN p_asset_type_id IS NOT NULL THEN
                    (SELECT asset_type_id FROM UNNEST(p_asset_type_id) U(asset_type_id))
                    ELSE sl.asset_type_id
                    END )
         and    sl.secondary_entity_role_map_id = 1053
         and  published_date::date < p_pressreleasedate::date
         order by published_date desc    
         limit 10
        )A ;
   
   end if ;
                   
    select array(select row_to_json(row) as jsonrow  
    from  
    (
       select * from (
       SELECT asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
       short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
       image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
       published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
       sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
       image_file_name, image_path
        , row_number()over (order by sl.published_date desc) as rno
       ,u.display_name user_name,emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name,
         
        COALESCE(pel.entity_display_name,emp.entity_display_name) pri_ent_disp_name,        
        COALESCE(sel.entity_display_name,ems.entity_display_name) sec_ent_disp_name  
       FROM pkl.pkl_asset_list sl
       left join pkl.pkl_user u
       on u.user_id = sl.author_id       
       join   pkl.pkl_entity_role_map erms
       on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
       join   pkl.pkl_entity_master emp
       on     emp.entity_master_id = erms.entity_master_id
       left join pkl.pkl_entity_language_map pel
       on     emp.entity_master_id=pel.entity_master_id
       --and    pel.language_master_id = v_language_mast_id
       join   pkl.pkl_entity_master ems
       on     ems.entity_master_id = erms.entity_master_id
       left join pkl.pkl_entity_language_map sel
       on     ems.entity_master_id=sel.entity_master_id
      and    sel.language_master_id = v_language_mast_id
       where sl.is_active=1
       and sl.is_deleted=0
       and    sl.is_published=1
      and    sl.published_date<= v_sysdate
      and    sl.asset_type_id in  (CASE WHEN p_asset_type_id IS NOT NULL THEN
                    (SELECT asset_type_id FROM UNNEST(p_asset_type_id) U(asset_type_id))
                    ELSE sl.asset_type_id
                    END )
       -- and    sl.asset_list_id =ANY ( $6::NUMERIC[] )              
	 and	erms.entity_role_map_id = 1053
      and exists (select 1 from unnest(v_date) dt
                    where dt.dt = sl.published_date::date)
    
       )  as tab1
     )
   row)  
   into v_assetjsonarr;    
   
    
     foreach v_assetjson in array v_assetjsonarr
     loop
     	v_json := v_json||v_assetjson||',';
     end loop;
     
     SELECT COUNT(1)
    	INTO    v_asset_count
    	FROM    UNNEST(v_assetjsonarr) asset_id;
      
    
     IF v_asset_count>0 THEN
        V_JSON:= substring(v_json,1,(length(v_json)-1));
     ELSE 
        V_JSON:= substring(v_json,1,(length(v_json)));
     END IF;
     
     v_json := v_json||']}';
     
     p_assetjson  := v_json::jsonb;
     p_assetcount := v_assetcount;
     
  
     

     
end;

$_$;


--
