-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_asset_next_prev_r(numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: yho_get_asset_next_prev_r(numeric, numeric, numeric[]); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_asset_next_prev_r(p_asset_id numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], OUT p_assetjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare
    v_assetjsonarr jsonb[];
    v_assetjson jsonb;
    v_json text := '{"items":[';
    
    v_sysdate timestamp;
    v_ent_count numeric;
    
    v_pri_entity_role_map_id numeric;
    v_sec_entity_role_map_id numeric;
    
    v_next_asset_id numeric;
    v_next_asset_type_id numeric;
    v_prev_asset_id numeric;
    v_prev_asset_type_id numeric;
    
    v_asset_count numeric:=0;
    
begin
     v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     RAISE NOTICE '%',1;
--    SELECT PRIMARY_ENTITY_ROLE_MAP_ID,SECONDARY_ENTITY_ROLE_MAP_ID
--        into v_pri_entity_role_map_id,v_sec_entity_role_map_id
--    FROM yho.yho_ASSET_LIST 
--    WHERE ASSET_ID=p_asset_id AND ASSET_TYPE_ID=p_asset_type_id;  
--         RAISE NOTICE '%',''||v_pri_entity_role_map_id||''||v_sec_entity_role_map_id||'';
    SELECT   NEXT_ASSET_ID,NEXT_ASSET_TYPE_ID,PREV_ASSET_ID,PREV_ASSET_TYPE_ID
      INTO     v_next_asset_id,v_next_asset_type_id,v_prev_asset_id,v_prev_asset_type_id
    FROM 
    (
      SELECT ASSET_ID,ASSET_TYPE_ID ,LEAD(ASSET_ID) OVER(ORDER BY UPDATED_DATE) NEXT_ASSET_ID
      ,LEAD(ASSET_TYPE_ID) OVER(ORDER BY UPDATED_DATE) NEXT_ASSET_TYPE_ID
      ,LAG(ASSET_ID) OVER(ORDER BY UPDATED_DATE) PREV_ASSET_ID
      ,LAG(ASSET_TYPE_ID) OVER(ORDER BY UPDATED_DATE) PREV_ASSET_TYPE_ID
      FROM yho.yho_ASSET_LIST sl
      WHERE    sl.is_active=1
          and    sl.is_deleted=0
          and    sl.is_published=1
      and    sl.asset_type_id in (p_asset_type_id) 
      and    sl.published_date<=v_sysdate
      AND EXISTS (select 1
                         from   yho.yho_asset_entity_map eam
                         where  eam.asset_id= sl.asset_id
                         and    eam.asset_type_id = sl.asset_type_id 
                         and    eam.entity_role_map_id in (select entity_id from unnest(p_entityrole_mapid)entity_id)
                              GROUP BY eam.asset_id,eam.asset_type_id
                              HAVING COUNT(1)=v_ent_count)
    ) ALL_rel
    WHERE ASSET_ID=p_asset_id 
    AND ASSET_TYPE_ID=p_asset_type_id;
         RAISE NOTICE '%',3;
    select array(select row_to_json(row) as jsonrow  
   from   (select * from (SELECT asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                          image_file_name, image_path
             , rank()over (order by sl.updated_date) as rno,u.user_name,emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name
            FROM yho.yho_asset_list sl
                          left join yho.yho_user u
                          on u.user_id = sl.author_id 
                          join   yho.yho_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   yho.yho_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   yho.yho_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          join   yho.yho_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
             where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
              and    sl.published_date<=v_sysdate
              and    sl.asset_type_id in (1,2,4,5,6)
               
             and (
                     (sl.asset_id =v_next_asset_id and sl.asset_type_id=v_next_asset_type_id)
                     OR
                     (sl.asset_id =v_prev_asset_id and sl.asset_type_id=v_prev_asset_type_id) 
                   )
                   ) adata
                   ) row
                   
                   ) 
                   into v_assetjsonarr  
                   ;
              
              
               RAISE NOTICE '%',4;    
     foreach v_assetjson in array v_assetjsonarr
     loop
     	v_json := v_json||v_assetjson||',';
     end loop;
          RAISE NOTICE '%',5;
     SELECT COUNT(1)
    	INTO    v_asset_count
    	FROM    UNNEST(v_assetjsonarr) asset_id;
           RAISE NOTICE '%',6;
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     IF v_asset_count>0 THEN
        V_JSON:= substring(v_json,1,(length(v_json)-1));
     ELSE 
        V_JSON:= substring(v_json,1,(length(v_json)));
     END IF;
          RAISE NOTICE '%',7;
     v_json := v_json||']}';
     
     p_assetjson  := v_json::jsonb; 
     
  
     
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

 $$;


--
