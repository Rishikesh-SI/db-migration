-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_get_asset_next_prev_r(numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: labstlz_get_asset_next_prev_r(numeric, numeric, numeric[]); Type: FUNCTION; Schema: labstlz; Owner: -
--

CREATE FUNCTION labstlz.labstlz_get_asset_next_prev_r(p_asset_id numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], OUT p_assetjson jsonb) RETURNS jsonb
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
     
     raise notice '%',1;
--    select primary_entity_role_map_id,secondary_entity_role_map_id
--        into v_pri_entity_role_map_id,v_sec_entity_role_map_id
--    from labstlz.labstlz_asset_list 
--    where asset_id=p_asset_id and asset_type_id=p_asset_type_id;  
--         raise notice '%',''||v_pri_entity_role_map_id||''||v_sec_entity_role_map_id||'';
    select   next_asset_id,next_asset_type_id,prev_asset_id,prev_asset_type_id
      into     v_next_asset_id,v_next_asset_type_id,v_prev_asset_id,v_prev_asset_type_id
    from 
    (
      select asset_id,asset_type_id ,lead(asset_id) over(order by updated_date) next_asset_id
      ,lead(asset_type_id) over(order by updated_date) next_asset_type_id
      ,lag(asset_id) over(order by updated_date) prev_asset_id
      ,lag(asset_type_id) over(order by updated_date) prev_asset_type_id
      from labstlz.labstlz_asset_list sl
      where    sl.is_active=1
          and    sl.is_deleted=0
          and    sl.is_published=1
      and    sl.asset_type_id in (p_asset_type_id) 
      and    sl.published_date<=v_sysdate
      and exists (select 1
                         from   labstlz.labstlz_asset_entity_map eam
                         where  eam.asset_id= sl.asset_id
                         and    eam.asset_type_id = sl.asset_type_id 
                         and    eam.entity_role_map_id in (select entity_id from unnest(p_entityrole_mapid)entity_id)
                              group by eam.asset_id,eam.asset_type_id
                              having count(1)=v_ent_count)
    ) all_rel
    where asset_id=p_asset_id 
    and asset_type_id=p_asset_type_id;
         raise notice '%',3;
    select array(select row_to_json(row) as jsonrow  
   from   (select * from (select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                          image_file_name, image_path
             , rank()over (order by sl.updated_date) as rno,u.user_name,emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name
            from labstlz.labstlz_asset_list sl
                          left join labstlz.labstlz_user u
                          on u.user_id = sl.author_id 
                          join   labstlz.labstlz_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   labstlz.labstlz_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   labstlz.labstlz_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          join   labstlz.labstlz_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
             where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
              and    sl.published_date<=v_sysdate
              and    sl.asset_type_id in (1,2,4,5,6)
               
             and (
                     (sl.asset_id =v_next_asset_id and sl.asset_type_id=v_next_asset_type_id)
                     or
                     (sl.asset_id =v_prev_asset_id and sl.asset_type_id=v_prev_asset_type_id) 
                   )
                   ) adata
                   ) row
                   
                   ) 
                   into v_assetjsonarr  
                   ;
              
              
               raise notice '%',4;    
     foreach v_assetjson in array v_assetjsonarr
     loop
     	v_json := v_json||v_assetjson||',';
     end loop;
          raise notice '%',5;
     select count(1)
    	into    v_asset_count
    	from    unnest(v_assetjsonarr) asset_id;
           raise notice '%',6;
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     if v_asset_count>0 then
        v_json:= substring(v_json,1,(length(v_json)-1));
     else 
        v_json:= substring(v_json,1,(length(v_json)));
     end if;
          raise notice '%',7;
     v_json := v_json||']}';
     
     p_assetjson  := v_json::jsonb; 
     
  
     
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

 $$;


--
