-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_get_asset_listing_for_any_ent_r(numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: labiis_get_asset_listing_for_any_ent_r(numeric, numeric, numeric[]); Type: FUNCTION; Schema: labiis; Owner: -
--

CREATE FUNCTION labiis.labiis_get_asset_listing_for_any_ent_r(p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_createdbyquery varchar(50) := ' ';
  
    v_searchdraftquery varchar(200) := ' ';
    v_searchassetquery varchar(200) := ' ';
	  v_drafassetcount numeric := 0;
    v_assetdraftidarr numeric[];
    v_assetdraftid numeric;
    v_titlealias json;
    v_entityjson json;
    v_entity json;
    v_entitymasterid numeric;
    v_priority numeric;
    v_assetcount numeric := 0;
	  v_fromrownumber numeric;
    v_torownumber numeric;
    v_count numeric;
    v_assetjsonarr jsonb[];
    v_assetjson jsonb;
    v_json text := '{"items":[';
    v_asset_count numeric:=0;
    v_asset_type_id numeric:=2;
begin
    
    
   v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    select count(1)
    into   v_assetcount
    from   labiis.labiis_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<=v_sysdate
    and    exists (select 1
                   from   labiis.labiis_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id in (select entity_role_mapid from unnest(p_entityrole_mapid) u(entity_role_mapid)));
   
   select array(select row_to_json(row) as jsonrow  
   from   (select * from (select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                          image_file_name, image_path
             , rank()over (order by asset_id) as rno,u.user_name,entity_name
            from labiis.labiis_asset_list sl
                          left join labiis.labiis_user u
                          on u.user_id = sl.author_id
                          join labiis.labiis_entity_role_map erm
                          on erm.entity_role_map_id = primary_entity_role_map_id
                          join labiis.labiis_entity_master em
                          on em.entity_master_id = erm.entity_master_id
             where sl.is_active=1
       		  and sl.is_deleted=0
   and    sl.is_published=1
            and    sl.published_date<=v_sysdate
             and exists (select 1 from   labiis.labiis_asset_entity_map eam
                where eam.asset_id= sl.asset_id
                 and eam.asset_type_id = sl.asset_type_id 
            and eam.entity_role_map_id in (select  entity_role_mapid
            from    unnest(p_entityrole_mapid) u(entity_role_mapid) ))
             )  as tab1
        where rno between v_fromrownumber and v_torownumber) row) into v_assetjsonarr  
             
	;
     
     
     
     foreach v_assetjson in array v_assetjsonarr
     loop
     	v_json := v_json||v_assetjson||',';
     end loop;
     
     select count(1)
    	into    v_asset_count
    	from    unnest(v_assetjsonarr) asset_id;
      
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     if v_asset_count>0 then
        v_json:= substring(v_json,1,(length(v_json)-1));
     else 
        v_json:= substring(v_json,1,(length(v_json)));
     end if;
     
     v_json := v_json||']}';
     
     p_assetjson  := v_json::jsonb;
     p_assetcount := v_assetcount;
     
  
     
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

 $$;


--
