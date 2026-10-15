-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_get_asset_listing_by_cat_r(numeric, numeric, numeric[], numeric[], character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: jafc_get_asset_listing_by_cat_r(numeric, numeric, numeric[], numeric[], character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_get_asset_listing_by_cat_r(p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_asset_count refcursor, p_asset_cur refcursor, p_category_cur refcursor) RETURNS SETOF refcursor
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
    v_assettypeidcount numeric;
    v_assettypequery varchar(4000) := ' ';
    v_entityrolemapidquery varchar(4000) := ' ';
    v_qry_str varchar(100000);
	v_language_id numeric;
	v_lang_master_id numeric;
begin
    v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
	 
	  -- changes done by rakesh bhatkar date 23/03/2017----
	 select jafc.jafc_get_entity_language_from_entities(p_entityrole_mapid) into v_language_id;
	 
	 
	 select entity_master_id
      into v_lang_master_id
      from jafc.jafc_entity_role_map
      where entity_role_map_id = v_language_id;
	  
     -- changes done by rakesh bhatkar date 23/03/2017----
    if v_ent_count > 0 then
    	
     v_entityrolemapidquery := 'and    exists (select 1
                   from   jafc.jafc_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id in (select entity_role_mapid
							 from unnest($2) u(entity_role_mapid))
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)='||v_ent_count ||')';
     
    end if;
    
    
   v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
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
    
    select count(asset_type_id)
	into   v_assettypeidcount
	from   unnest(p_asset_type_id) u(asset_type_id);
    
    if v_assettypeidcount > 0 then
    		
          v_assettypequery := 'and sl.asset_type_id in(select asset_type_id from unnest($1) u(asset_type_id))';
          
    end if;
    
    v_qry_str:= 'select distinct count(1) over(partition by secondary_entity_role_map_id) cnt,
                  secondary_entity_role_map_id as sentid
    
    from   jafc.jafc_asset_list sl
    join   jafc.jafc_entity_role_map erm
    on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
    and    sl.asset_type_id in (1,2,4,5,14) 
    and    erm.priority>0 '
    ||v_assettypequery||
    /*and    sl.asset_type_id in 
                    (case when $1 is not null then
                    (select asset_type_id from unnest($1) u(asset_type_id))
                    else sl.asset_type_id
                    end )
    ' and    exists (select 1
                   from   jafc.jafc_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id in (select entity_role_mapid
							 from unnest($2) u(entity_role_mapid))
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)='||v_ent_count ||')'*/
    v_entityrolemapidquery
      ||v_entitysearchquery
     ;
    open p_asset_count for 
    execute  v_qry_str
    using  p_asset_type_id,p_entityrole_mapid ;
    
   
   
   v_qry_str:= '
   select * from (select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                          image_file_name, image_path
             , rank()over (partition by secondary_entity_role_map_id order by sl.published_date desc) as rno,
             jafc.jafc_get_user_display_name(sl.author_id) user_name,emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name,
             erms.priority sent_priority
            from jafc.jafc_asset_list sl
--                          left join jafc.jafc_user u
--                          on u.user_id = sl.author_id
                          /*join jafc.jafc_entity_role_map erm
                          on erm.entity_role_map_id = primary_entity_role_map_id
                          join jafc.jafc_entity_master em
                          on em.entity_master_id = erm.entity_master_id*/
                          join   jafc.jafc_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   jafc.jafc_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   jafc.jafc_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          join   jafc.jafc_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
             where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
              and    sl.published_date<='''||v_sysdate||'''
              and    sl.asset_type_id in (1,2,4,5,14)
              and    erms.priority>0 '
    ||v_assettypequery||
    /*and    sl.asset_type_id in 
                    (case when $1 is not null then
                    (select asset_type_id from unnest($1) u(asset_type_id))
                    else sl.asset_type_id
                    end )
    'and exists (select 1 from   jafc.jafc_asset_entity_map eam
                	where eam.asset_id= sl.asset_id
                 	and eam.asset_type_id = sl.asset_type_id 
                    and eam.entity_role_map_id in (select  entity_role_mapid
                    from    unnest($2) u(entity_role_mapid) )
                     group by eam.asset_id,eam.asset_type_id
                                having count(1)='||v_ent_count ||'           
                                )'*/
                                v_entityrolemapidquery
                   ||v_entitysearchquery||           
                   '
             )  as tab1
        where rno between '||v_fromrownumber||' and '||v_torownumber||'
        order by sent_priority,rno
        ' 
      ;
      
      open  p_asset_cur for
      execute v_qry_str
      using   p_asset_type_id,p_entityrole_mapid;
     
      
      open p_category_cur for
      select em.entity_role_map_id entid,coalesce(elm.entity_display_name, e.entity_display_name) as entity_name,
      e.entity_display_name entity_eng_name
      from jafc.jafc_entity_role_map em
      join jafc.jafc_entity_master e
      on e.entity_master_id=em.entity_master_id
	  -- changes done by rakesh bhatkar date 23/03/2017----
	  left join jafc.jafc_entity_language_map elm
	    on elm.entity_master_id = e.entity_master_id
	   and elm.language_master_id = v_lang_master_id
	   -- changes done by rakesh bhatkar date 23/03/2017---
      where entity_role_id in (
      select entity_role_id from jafc.jafc_entity_category
          where category_name='Category Type'
          )
      and e.is_active=1 
      and    em.priority>0 ;
--     foreach v_assetjson in array v_assetjsonarr
--     loop
--     	v_json := v_json||v_assetjson||',';
--     end loop;
--     
--     select count(1)
--    	into    v_asset_count
--    	from    unnest(v_assetjsonarr) asset_id;
--      
--    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
--     if v_asset_count>0 then
--        v_json:= substring(v_json,1,(length(v_json)-1));
--     else 
--        v_json:= substring(v_json,1,(length(v_json)));
--     end if;
--     
--     v_json := v_json||']}';
--     
--     p_assetjson  := v_json::jsonb;
--     p_assetcount := v_assetcount;
     
  
     
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

$_$;


--
