-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_asset_listing_by_cat_r_test(numeric, numeric, numeric[], numeric[], character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: khi_get_asset_listing_by_cat_r_test(numeric, numeric, numeric[], numeric[], character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_asset_listing_by_cat_r_test(p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_asset_count refcursor, p_asset_cur refcursor, p_category_cur refcursor) RETURNS SETOF refcursor
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
    v_titlealias JSON;
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
	 select khi.khi_get_entity_language_from_entities(p_entityrole_mapid) into v_language_id;
	 
	 
	 select entity_master_id
      into v_lang_master_id
      from khi.khi_entity_role_map
      where entity_role_map_id = v_language_id;
	  
     -- changes done by rakesh bhatkar date 23/03/2017----
    if v_ent_count > 0 then
    	
     v_entityrolemapidquery := 'and    EXISTS (select 1
                   from   khi.khi_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id in (SELECT entity_role_mapid
							 FROM UNNEST($2) U(entity_role_mapid))
                        GROUP BY eam.asset_id,eam.asset_type_id
                        HAVING COUNT(1)='||v_ent_count ||')';
     
    end if;
    
    
   v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    if v_searchkeyword is not null then
     	
--              v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( '||'$1'||')';
--              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
              
--              v_entitysearchquery := ' and ( to_tsvector( al.asset_title) @@@ to_tsquery( '||'$1'||') 
--                                        OR   to_tsvector( al.short_desc) @@@ to_tsquery( '||'$1'||'))';
--              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';

                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        OR   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
                
     end if;
    
    select count(asset_type_id)
	into   v_assettypeidcount
	from   unnest(p_asset_type_id) U(asset_type_id);
    
    if v_assettypeidcount > 0 then
    		
          v_assettypequery := 'and sl.asset_type_id in(SELECT asset_type_id FROM UNNEST($1) U(asset_type_id))';
          
    end if;
    
    /*v_qry_str:= 'SELECT DISTINCT count(1) OVER(PARTITION BY secondary_entity_role_map_id) cnt,
                  secondary_entity_role_map_id AS sentid
    
    FROM   khi.khi_asset_list sl
    join   khi.khi_entity_role_map erm
    on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
    and    sl.asset_type_id in (1,2,4,5,14) 
    and    erm.priority>0 '
    ||v_assettypequery||
    
    v_entityrolemapidquery
      ||v_entitysearchquery
     ;*/
     
     v_qry_str:= 'SELECT  count(1) cnt,
      eamc.entity_role_map_id AS sentid    
    			   FROM   khi.khi_asset_list sl
             join   khi.khi_entity_role_map erm
             on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
             join   khi.khi_asset_entity_map eamc
             on     eamc.asset_id = sl.asset_id
             and    eamc.asset_type_id = sl.asset_type_id
             and    eamc.entity_role_map_id in (SELECT EM.ENTITY_ROLE_MAP_ID   
                                            FROM khi.khi_ENTITY_ROLE_MAP EM
                                            JOIN khi.khi_ENTITY_MASTER E
                                            ON E.ENTITY_MASTER_ID=EM.ENTITY_MASTER_ID
                                            WHERE ENTITY_ROLE_ID IN(SELECT ENTITY_ROLE_ID 
                                                                FROM khi.khi_ENTITY_CATEGORY 
                                                                WHERE CATEGORY_NAME='||'''Category Type'''||' )
                                            AND E.IS_ACTIVE=1
                                            and    EM.priority>0)
                  where  sl.is_active=1
                  and    sl.is_deleted=0
                  and    sl.is_published=1
                  and    sl.published_date<='''||v_sysdate||'''
                  and    sl.asset_type_id in (1,2,4,5,6) 
                  and    erm.priority>0  '
                  ||v_assettypequery
                  /*and  sl.asset_type_id in(CASE WHEN $1 IS NOT NULL THEN (SELECT asset_type_id FROM UNNEST($1) U(asset_type_id))
                  							ELSE sl.asset_type_id
                                             END)
                  and    EXISTS (select 1
                  			   from   khi.khi_asset_entity_map eam
                                 where  eam.asset_id = sl.asset_id
                                 and    eam.asset_type_id = sl.asset_type_id
                                 and    eam.entity_role_map_id in (SELECT entity_role_mapid FROM UNNEST($2) U(entity_role_mapid))
                                 GROUP BY eam.asset_id,eam.asset_type_id
                                 HAVING COUNT(1)='||v_ent_count ||')'*/
    			   ||v_entityrolemapidquery
                  ||v_entitysearchquery || '
                  group by eamc.entity_role_map_id ' ;
                  
    open p_asset_count for 
    execute  v_qry_str
    using  p_asset_type_id,p_entityrole_mapid ;
    
   
   
   v_qry_str:= '
   select * from (SELECT asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                          image_file_name, image_path
             , rank()over (PARTITION BY secondary_entity_role_map_id order by sl.published_date desc) as rno,
             khi.khi_get_user_display_name(sl.author_id) user_name,emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name,
             erms.PRIORITY SENT_PRIORITY
            FROM khi.khi_asset_list sl
--                          left join khi.khi_user u
--                          on u.user_id = sl.author_id
                          /*join khi.khi_entity_role_map erm
                          on erm.entity_role_map_id = primary_entity_role_map_id
                          join khi.khi_entity_master em
                          on em.entity_master_id = erm.entity_master_id*/
                          join   khi.khi_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   khi.khi_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   khi.khi_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          join   khi.khi_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
             where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
              and    sl.published_date<='''||v_sysdate||'''
              and    sl.asset_type_id in (1,2,4,5,14)
              and    erms.priority>0 '
    ||v_assettypequery||
    /*and    sl.asset_type_id in 
                    (CASE WHEN $1 IS NOT NULL THEN
                    (SELECT asset_type_id FROM UNNEST($1) U(asset_type_id))
                    ELSE sl.asset_type_id
                    END )
    'and exists (select 1 from   khi.khi_asset_entity_map eam
                	where eam.asset_id= sl.asset_id
                 	and eam.asset_type_id = sl.asset_type_id 
                    and eam.entity_role_map_id in (SELECT  entity_role_mapid
                    FROM    UNNEST($2) U(entity_role_mapid) )
                     GROUP BY eam.asset_id,eam.asset_type_id
                                HAVING COUNT(1)='||v_ent_count ||'           
                                )'*/
                                v_entityrolemapidquery
                   ||v_entitysearchquery||           
                   '
             )  as tab1
        where rno between '||v_fromrownumber||' and '||v_torownumber||'
        ORDER BY SENT_PRIORITY,rno
        ' 
      ;
      
      open  p_asset_cur for
      execute v_qry_str
      using   p_asset_type_id,p_entityrole_mapid;
     
      
      open p_category_cur for
      SELECT EM.ENTITY_ROLE_MAP_ID entid,COALESCE(elm.entity_display_name, e.entity_display_name) as ENTITY_NAME,
      e.entity_display_name entity_eng_name
      FROM khi.khi_ENTITY_ROLE_MAP EM
      JOIN khi.khi_ENTITY_MASTER E
      ON E.ENTITY_MASTER_ID=EM.ENTITY_MASTER_ID
	  -- changes done by rakesh bhatkar date 23/03/2017----
	  left join khi.khi_entity_language_map elm
	    on elm.entity_master_id = e.entity_master_id
	   and elm.language_master_id = v_lang_master_id
	   -- changes done by rakesh bhatkar date 23/03/2017---
      WHERE ENTITY_ROLE_ID IN (
      SELECT ENTITY_ROLE_ID FROM khi.khi_ENTITY_CATEGORY
          WHERE CATEGORY_NAME='Category Type'
          )
      AND E.IS_ACTIVE=1 
      and    EM.priority>0 ;
--     foreach v_assetjson in array v_assetjsonarr
--     loop
--     	v_json := v_json||v_assetjson||',';
--     end loop;
--     
--     SELECT COUNT(1)
--    	INTO    v_asset_count
--    	FROM    UNNEST(v_assetjsonarr) asset_id;
--      
--    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
--     IF v_asset_count>0 THEN
--        V_JSON:= substring(v_json,1,(length(v_json)-1));
--     ELSE 
--        V_JSON:= substring(v_json,1,(length(v_json)));
--     END IF;
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
