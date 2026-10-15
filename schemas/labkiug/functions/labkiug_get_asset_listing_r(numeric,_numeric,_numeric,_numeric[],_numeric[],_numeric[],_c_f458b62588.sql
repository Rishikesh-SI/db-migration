-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiug
-- Object: labkiug_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric)
-- Type: FUNCTION

-- Name: labkiug_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric); Type: FUNCTION; Schema: labkiug; Owner: -
--

CREATE FUNCTION labkiug.labkiug_get_asset_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_author_id numeric, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$ 

declare
	
    v_createdbyquery varchar(50) := ' ';
    
    v_searchkeyword varchar(4000) := p_searchkeyword;
    v_entitysearchquery varchar(4000) := ' ';
     
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
    v_sysdate timestamp;
    v_ent_count numeric;
    v_language_id numeric;
    v_language_mast_id numeric;
    
    v_anyentityrolemapidquery varchar(4000) := ' ';
    v_any_ent_count numeric;
    
    v_arr_asset_list_id numeric[];
    v_str_arr_asset_list_id varchar(1000000);
    
    v_str_entityrole_mapid varchar(1000000);
    v_author_filter_query varchar(4000) := ' ';
begin

/*-- new changes done by rakesh bhatkar
 add username and full_name
 date :-15112017 
-- end--
*/
    v_sysdate:= current_timestamp at time zone 'utc';
     select count(distinct entity_id)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     select count(1)
     into   v_any_ent_count
     from   unnest(p_any_entityrole_mapid)entity_id;
     
     -- changes done by rakesh b date :-20-04-2017--
     
     
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
  -- v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	-- v_torownumber   := (p_pagenumber * p_itemnumber);
    -- changes done by rakesh b date :-20-04-2017--
    
    select labkiug.labkiug_get_entity_language_from_entities(p_entityrole_mapid)
    into v_language_id;
    
   -- raise notice '% 1' ,v_language_id;
   -- select 1/0;
    
    select  erm.entity_master_id into v_language_mast_id 
    from labkiug.labkiug_entity_role_map erm 
    where erm.entity_role_map_id =(v_language_id);
    
    v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
    
    if v_searchkeyword is not null then
     	
--              v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( '||'$1'||')';
--              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
              
--              v_entitysearchquery := ' and ( to_tsvector( al.asset_title) @@@ to_tsquery( '||'$1'||') 
--                                        or   to_tsvector( al.short_desc) @@@ to_tsquery( '||'$1'||'))';
--              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';

                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                
     end if;
     
     if p_author_id is not null then
    	
        v_author_filter_query := ' and exists (select 1
                    from   labkiug.labkiug_author_action aa
                    where  aa.author_id = '||p_author_id||'
                     and    aa.action_id = 4
                 	-- and aa.author_id = sl.created_by
                   and aa.asset_id = sl.asset_id
                   and aa.asset_type_id = sl.asset_type_id)';
        
    end if;
     
    if v_any_ent_count > 0 then
    	
     v_anyentityrolemapidquery := ' and    exists (select 1
                                         from   labkiug.labkiug_asset_entity_map eam
                                         where  eam.asset_id= sl.asset_id
                                         and    eam.asset_type_id = sl.asset_type_id 
                                         and    eam.entity_role_map_id in 
                                          (select any_entity_role_mapid 
                                          from unnest($4) u(any_entity_role_mapid))
                                         ) ';
     
    end if;
     
    execute 'select array( select asset_list_id
    
    from   labkiug.labkiug_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
    and    sl.asset_type_id in (1,2,4,5) 
    and    sl.asset_type_id in 
                    (case when $1 is not null then
                    (select asset_type_id from unnest($1) u(asset_type_id))
                    else sl.asset_type_id
                    end )
    and    exists (select 1
                   from   labkiug.labkiug_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id =any ($2::numeric[])
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)='||v_ent_count ||') '
     ||v_anyentityrolemapidquery||  ' '
     ||v_entitysearchquery
     ||v_author_filter_query
     ||')'
    into   v_arr_asset_list_id
    using  p_asset_type_id,v_str_entityrole_mapid ,	p_any_entityrole_mapid ,p_any_entityrole_mapid ;
    
    select count(1)
     into   v_assetcount
     from   unnest(v_arr_asset_list_id)al_id;
    
   v_str_arr_asset_list_id:=  '{'||array_to_string(v_arr_asset_list_id,',')||'}';
    
   execute '
   select array(select row_to_json(row) as jsonrow  
   from   (select * from (select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                          image_file_name, image_path
             , row_number()over (order by sl.published_date desc) as rno
             ,u.display_name display_name,
              --new change date 15112017 --
             u.user_name user_name,
            u.full_name full_name,
            --new change date 15112017 --
             emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name,
         --    labkiug.labkiug_get_entity_display_name_by_language('||v_language_id||', 
        --     primary_entity_role_map_id) pri_ent_disp_name,
        coalesce(pel.entity_display_name,emp.entity_display_name) pri_ent_disp_name,
        --     labkiug.labkiug_get_entity_display_name_by_language('||v_language_id||',
        --     secondary_entity_role_map_id) sec_ent_disp_name
           coalesce(sel.entity_display_name,ems.entity_display_name) sec_ent_disp_name  
            from labkiug.labkiug_asset_list sl
                          left join labkiug.labkiug_user u
                          on u.user_id = sl.author_id
                          /*join labkiug.labkiug_entity_role_map erm
                          on erm.entity_role_map_id = primary_entity_role_map_id
                          join labkiug.labkiug_entity_master em
                          on em.entity_master_id = erm.entity_master_id*/
                          join   labkiug.labkiug_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   labkiug.labkiug_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   labkiug.labkiug_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          left join labkiug.labkiug_entity_language_map pel
                          on     emp.entity_master_id=pel.entity_master_id
                          and    pel.language_master_id ='||v_language_mast_id||'
                          join   labkiug.labkiug_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
                          left join labkiug.labkiug_entity_language_map sel
                          on     ems.entity_master_id=sel.entity_master_id
                          and    sel.language_master_id ='||v_language_mast_id||'
             where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
              and    sl.published_date<='''||v_sysdate||'''
              and    sl.asset_type_id in (1,2,4,5)
              and    sl.asset_list_id =any ( $6::numeric[] ) '
              ||v_author_filter_query
              ||'
                   
             )  as tab1'
             
             ||'
        where rno between '||v_fromrownumber||' and '||v_torownumber||') row) 
        '
        into v_assetjsonarr  
        using p_asset_type_id,p_entityrole_mapid,p_any_entityrole_mapid,p_any_entityrole_mapid,
        v_arr_asset_list_id,v_str_arr_asset_list_id
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

 $_$;


--
