-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_source_role_asset_listing(character varying, integer, numeric[])
-- Type: FUNCTION

-- Name: stn_get_source_role_asset_listing(character varying, integer, numeric[]); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_source_role_asset_listing(p_source_object_id character varying, p_role_id integer, p_asset_type_id numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_asset_type_count numeric;
	 v_assetcount numeric := 0;
	 v_sysdate timestamp;
	 v_json text := '{"items":[';
     v_assetjsonarr jsonb[];
      v_assetjson jsonb;
      v_asset_count numeric:=0;
     
     
begin
    v_sysdate:= current_timestamp at time zone 'utc';
     
    
	-- v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	-- v_torownumber   := (p_pagenumber * p_itemnumber);
    
	create local temp table tbl_asset_data on  commit drop as 
	select * from 
	(SELECT asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
            short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
            image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
            published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
            sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
            rank()over (order by sl.updated_date desc) as rno,u.user_name,emp.entity_name primary_entity_name,
            ems.entity_name secondary_entity_name
     FROM stn.stn_asset_list sl
     left join stn.stn_user u
     on u.user_id = sl.author_id                             
     join   stn.stn_entity_role_map ermp
     on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
     join   stn.stn_entity_role_map erms
     on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
     join   stn.stn_entity_master emp
     on     emp.entity_master_id = ermp.entity_master_id
     join   stn.stn_entity_master ems
     on     ems.entity_master_id = erms.entity_master_id
     where sl.is_active = 1
     and sl.is_deleted = 0 
     and    sl.is_published = 1
     and    sl.is_trashed = 0                        
     and    sl.published_date <= v_sysdate
     --   and    sl.asset_type_id in (1,2,4,5,6)
     and   (sl.asset_type_id in (select entityid from unnest(p_asset_type_id ) U(entityid)) 
            or 0 in (coalesce((select entityid from unnest(p_asset_type_id) U(entityid)),0))
           )
     and exists (select entity_role_map_id from stn.stn_entity_role_map RM 
                 where RM.entity_role_id = p_role_id and RM.source_object_id = p_source_object_id
                 and (RM.entity_role_map_id = sl.primary_entity_role_map_id
                      or RM.entity_role_map_id = sl.secondary_entity_role_map_id)
                ) 
     /*    and exists (select 1 from   stn.stn_asset_entity_map eam
     where eam.asset_id= sl.asset_id
     and eam.asset_type_id = sl.asset_type_id 
     and eam.entity_role_map_id in (SELECT  entity_role_mapid
     FROM    UNNEST($2) U(entity_role_mapid) )
     GROUP BY eam.asset_id,eam.asset_type_id
     HAVING COUNT(1)='||v_ent_count ||'           
    )
     */
    )  as tab1
    -- where rno between '||v_fromrmber||' and '||v_torownumber||'
    ;

	 select array(select row_to_json(row) as jsonrow
                  from (select * from tbl_asset_data) row
                 ) 
    into v_assetjsonarr
    ; 
	
    select count(1) into v_assetcount 
	from tbl_asset_data ; 
	
    if v_assetjsonarr is not null then
        foreach v_assetjson in array v_assetjsonarr
    loop
     	v_json := v_json||v_assetjson||',';
    end loop;
    end if;
	
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
     
     
  
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

$_$;


--
