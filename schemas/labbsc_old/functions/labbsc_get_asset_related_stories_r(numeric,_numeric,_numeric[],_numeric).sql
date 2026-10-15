-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_get_asset_related_stories_r(numeric, numeric, numeric[], numeric)
-- Type: FUNCTION

-- Name: labbsc_get_asset_related_stories_r(numeric, numeric, numeric[], numeric); Type: FUNCTION; Schema: labbsc_old; Owner: -
--

CREATE FUNCTION labbsc_old.labbsc_get_asset_related_stories_r(p_asset_id numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], p_cnt numeric, OUT p_assetjson jsonb) RETURNS jsonb
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
    
    v_asset_published_date timestamp;
    
    v_ec numeric := p_cnt; -- count of rows required before and after
    v_bc numeric;-- count of rows available before
    v_ac numeric;-- count of rows available after
    v_br numeric:=v_ec;-- count of rows to pull from before
    v_ar numeric:=v_ec;-- count of rows to pull from after
    v_bd numeric;-- less rows in before
    v_ad numeric;-- less rows in after
    
    v_arr_asset_id numeric[];
    
begin
     v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     select published_date 
     into   v_asset_published_date
     from   labbsc.labbsc_asset_list 
     where  asset_id=p_asset_id 
     and    asset_type_id=p_asset_type_id;
     
     select  
      count(case when sl.published_date <= v_asset_published_date then 1 end) count_before,
      count(case when sl.published_date > v_asset_published_date then 1 end) count_after
     into v_bc,v_ac
     from labbsc.labbsc_asset_list  sl
     where sl.is_active=1
          and    sl.is_deleted=0
          and    sl.is_published=1
      and    sl.asset_type_id in (p_asset_type_id) 
      and    sl.published_date<=v_sysdate
      and (sl.asset_id,sl.asset_type_id) not in (select p_asset_id,p_asset_type_id)
      and exists (select 1
                         from   labbsc.labbsc_asset_entity_map eam
                         where  eam.asset_id= sl.asset_id
                         and    eam.asset_type_id = sl.asset_type_id 
                         and    eam.entity_role_map_id in (select entity_id from unnest(p_entityrole_mapid)entity_id)
                              group by eam.asset_id,eam.asset_type_id
                              having count(1)=v_ent_count);

     raise notice '%',1;
--    select primary_entity_role_map_id,secondary_entity_role_map_id
--        into v_pri_entity_role_map_id,v_sec_entity_role_map_id
--    from labbsc.labbsc_asset_list 
--    where asset_id=p_asset_id and asset_type_id=p_asset_type_id;  
--         raise notice '%',''||v_pri_entity_role_map_id||''||v_sec_entity_role_map_id||'';
    
    v_bd:=greatest((v_ec-v_bc),0);
    v_ar:=least( (v_ar+v_bd),v_ac);
    
    v_ad:=greatest((v_ec-v_ac),0);
    v_br:=least((v_br+v_ad),v_bc);
    
    select array(
    select   asset_id
    
    from 
    (
      select asset_id,asset_type_id 
      ,row_number() over(partition by (case when sl.published_date <= v_asset_published_date 
                                            then 1 
                                            else 0 end
                                      ) order by sl.published_date) rno
       ,row_number() over(partition by (case when sl.published_date <= v_asset_published_date
                                            then 1 
                                            else 0 end
                                      ) order by   sl.published_date  desc) brno                                    
      ,case when sl.published_date <= v_asset_published_date 
                                            then 1 
                                            else 0 end is_bef                                
      from labbsc.labbsc_asset_list sl
      where    sl.is_active=1
          and    sl.is_deleted=0
          and    sl.is_published=1
      and    sl.asset_type_id in (p_asset_type_id) 
      and    sl.published_date<=v_sysdate
        and sl.asset_id<>p_asset_id
      and exists (select 1
                         from   labbsc.labbsc_asset_entity_map eam
                         where  eam.asset_id= sl.asset_id
                         and    eam.asset_type_id = sl.asset_type_id 
                         and    eam.entity_role_map_id in (select entity_id from unnest(p_entityrole_mapid)entity_id)
                              group by eam.asset_id,eam.asset_type_id
                              having count(1)=v_ent_count)
    ) all_rel
    where (rno<=v_ar and is_bef=0) or (brno<=v_br and is_bef=1)
    ) 
      into   v_arr_asset_id;
         raise notice '%',3;
    select array(select row_to_json(row) as jsonrow  
   from   (select * from (select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                          image_file_name, image_path
             , rank()over (order by sl.published_date) as rno,u.user_name,emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name
            from labbsc.labbsc_asset_list sl
                          left join labbsc.labbsc_user u
                          on u.user_id = sl.author_id 
                          join   labbsc.labbsc_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   labbsc.labbsc_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   labbsc.labbsc_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          join   labbsc.labbsc_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
             where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
              and    sl.published_date<=v_sysdate
              and    sl.asset_type_id in (p_asset_type_id)
               
             and  sl.asset_id in (select asset_id from unnest(v_arr_asset_id)asset_id)
                   ) adata
                   ) row order by rno
                   
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
