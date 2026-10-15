-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_asset_listing_all(numeric, numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying)
-- Type: FUNCTION

-- Name: dd_get_asset_listing_all(numeric, numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_asset_listing_all(p_status numeric, p_authorid numeric, p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
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
    
    v_draftcreatedbyquery   varchar(500) := ' ';
     v_assetcreatedbyquery varchar(500) := ' ';
     v_assetfilterquery varchar(4000) := ' ';
     v_assettypefilterquery varchar(4000) := ' ';  
     v_anyentfilterquery varchar(4000) := ' ';  
     v_any_ent_count numeric;
     v_asset_type_count numeric;
     
     
begin
    v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     select count(1)
     into   v_any_ent_count
     from   unnest(p_any_entityrole_mapid)entity_id;
     
     select count(1)
     into   v_asset_type_count
     from   unnest(p_asset_type_id)entity_id;
     
   v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
   create temp table if not exists t_allassetdata
     (
         asset_id numeric,
         asset_type_id numeric         
     );
   create temp table if not exists t_anyassetdata
     (
         asset_id numeric,
         asset_type_id numeric         
     );
    if p_authorid is not null then
     	
          v_draftcreatedbyquery   := ' and (ad.asset_id,ad.asset_type_id) 
                                        in(select asset_id,asset_type_id
                                        from dd.dd_author_action
                                               where action_id = 4 
                                               and author_id = $2) ';
		
     	v_assetcreatedbyquery := ' and (sl.asset_id,sl.asset_type_id) 
                                    in(select asset_id,asset_type_id
                                        from dd.dd_author_action
                                             where action_id = 4 
                                             and author_id = $5) ';
		
  	end if;
    
    if v_searchkeyword is not null then
     	
--              v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( '||'$1'||')';
--              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
              
--              v_entitysearchquery := ' and ( to_tsvector( al.asset_title) @@@ to_tsquery( '||'$1'||') 
--                                        OR   to_tsvector( al.short_desc) @@@ to_tsquery( '||'$1'||'))';
--              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
          if p_status = 0 then
          		v_searchkeyword := replace(v_searchkeyword,'''','''''');
                v_searchkeyword := replace(v_searchkeyword,':','');
                
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                
                v_entitysearchquery := ' and ( to_tsvector( asset_data->''data''->>''title'') @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        OR   to_tsvector( asset_data->''data''->>''intro_text'') @@@ to_tsquery( '''||v_searchkeyword||''')
                                        OR   to_tsvector( asset_data->''data''->>''desc'') @@@ to_tsquery( '''||v_searchkeyword||''')
                                        OR   to_tsvector( asset_data->''data''->>''album_desc'') @@@ to_tsquery( '''||v_searchkeyword||''')
                                        )';
          elsif p_status in (1,2) then
          		v_searchkeyword := replace(v_searchkeyword,'''','''''');
                v_searchkeyword := replace(v_searchkeyword,':','');
                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        OR   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';
          end if;
          
     end if;
    
    
    if v_ent_count > 0 AND p_status = 0 then
       
          EXECUTE ' with entitydata(t_json)
          as(select ((asset_data->''data''->>''entitydata'')::json), asset_id, ASSET_TYPE_ID
              from dd.dd_ASSET_DRAFT AD
              WHERE 1=1
              -- ASSET_TYPE_ID = '||v_asset_type_id||'
              ' || v_entitysearchquery || '
              and version_number=(SELECT MAX(VERSION_NUMBER)
                                  FROM dd.dd_ASSET_DRAFT ADI
                                  WHERE ADI.ASSET_ID=AD.ASSET_ID
                                  AND   ADI.ASSET_TYPE_ID=AD.ASSET_TYPE_ID)
			and (asset_data->''data''->''entitydata'') is not null
               and (asset_data->''data''->>''entitydata'')  like ''%[%''
            )
         insert INTO t_allassetdata
         select asset_id, ASSET_TYPE_ID
         from (
                 select  obj->>''entity_role_map_id'' , asset_id, ASSET_TYPE_ID
                 from   entitydata ci, json_array_elements(ci.t_json#>''{}'') obj
                 where  (obj->>''entity_role_map_id'')::numeric in 
                       (select entityid from unnest($1) U(entityid)) 
               ) jd
               group by asset_id, ASSET_TYPE_ID
               having count(1) = '||v_ent_count||' '
         USING p_entityrole_mapid; 
            
            if EXISTS (SELECT 1 FROM t_allassetdata) then
            	
            	v_assetfilterquery := ' and (ad.asset_id,ad.asset_type_id) 
                                    in (SELECT aad.asset_id,aad.asset_type_id FROM t_allassetdata aad) ';
            	
            end if;
    
    end if;
    if v_any_ent_count > 0 AND p_status = 0 then
       
          EXECUTE 'with entitydata(t_json)
          as(select (asset_data->''data''->>''entitydata'')::json,asset_id,ASSET_TYPE_ID
              from dd.dd_ASSET_DRAFT AD
             -- WHERE ASSET_TYPE_ID = '||v_asset_type_id||'
              and version_number=(SELECT MAX(VERSION_NUMBER)
                                  FROM dd.dd_ASSET_DRAFT ADI
                                  WHERE ADI.ASSET_ID=AD.ASSET_ID
                                  AND   ADI.ASSET_TYPE_ID=AD.ASSET_TYPE_ID)
			and (asset_data->''data''->''entitydata'') is not null
               and (asset_data->''data''->>''entitydata'')  like ''%[%''
            )
         insert INTO t_anyassetdata
         select DISTINCT asset_id,ASSET_TYPE_ID
         from (
         select  obj->>''entity_role_map_id'' , asset_id, ASSET_TYPE_ID
         from   entitydata ci, json_array_elements(ci.t_json#>''{}'') obj
         where  (obj->>''entity_role_map_id'')::numeric in 
               (select entityid from unnest($1) U(entityid))) jd '
         USING v_any_ent_count;
      
            
            if EXISTS (SELECT 1 FROM t_anyassetdata) then 
            	
            	v_assetfilterquery := ' and (ad.asset_id,ad.asset_type_id) 
                                    in (SELECT anyd.asset_id,anyd.asset_type_id FROM t_anyassetdata anyd ) ';
            	
            end if;
    
    end if;
    if  v_asset_type_count > 0 and p_status IN (1,2) then
    v_assettypefilterquery:=' and    sl.asset_type_id in  
                    (SELECT asset_type_id FROM UNNEST($1) U(asset_type_id)) ';
    elsif v_asset_type_count > 0 and p_status IN (0) then
    v_assettypefilterquery:=' and    ad.asset_type_id in  
                    (SELECT asset_type_id FROM UNNEST($1) U(asset_type_id)) ';
    end if;
    
    if v_any_ent_count > 0 and p_status IN (1,2) then
    v_anyentfilterquery:=' and    exists (select 1
                   from   dd.dd_asset_entity_map eam
                   where  eam.asset_id= sl.asset_id
                   and    eam.asset_type_id = sl.asset_type_id 
                   and    eam.entity_role_map_id in  
                    (SELECT any_entity_role_mapid FROM UNNEST($4) U(any_entity_role_mapid))
                    ) ';
        
     END IF;
    
    IF p_status IN (1,2) then          
        execute 'SELECT count(1)
        
        FROM   dd.dd_asset_list sl
        where  sl.is_active=1
        and    sl.is_deleted=0 
        and    sl.is_published=CASE WHEN '||p_status ||' = 1 THEN 1
                                    WHEN '||p_status ||' = 2 THEN 0
                                    ELSE -1
                                        END 
        and    sl.is_trashed=CASE WHEN '||p_status ||' = 1 THEN 0
                                    WHEN '||p_status ||' = 2 THEN 1
                                    ELSE -1
                                        END                                 
        and    sl.published_date<= CASE WHEN '||p_status ||' = 1 THEN '''||v_sysdate||'''
                                        ELSE sl.published_date 
                                        END 
        and    sl.asset_type_id in (1,2,4,5,6)  
        '||v_assettypefilterquery||'
        and    EXISTS (select 1
                       from   dd.dd_asset_entity_map eam
                       where  eam.asset_id= sl.asset_id
                       and    eam.asset_type_id = sl.asset_type_id 
                       and    eam.entity_role_map_id in (SELECT entity_role_mapid
                   FROM UNNEST($2) U(entity_role_mapid))
                            GROUP BY eam.asset_id,eam.asset_type_id
                            HAVING COUNT(1)='||v_ent_count ||')
         '||v_anyentfilterquery||'
                       '
         ||v_entitysearchquery||      ' ' 
          ||v_assetcreatedbyquery|| 
                       '
        
        '
        into   v_assetcount
        using  p_asset_type_id,p_entityrole_mapid ,	p_any_entityrole_mapid ,p_any_entityrole_mapid,p_authorid ;
        
       execute '
       select array(select row_to_json(row) as jsonrow  
       from   (select * from (SELECT asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                              short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                              image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                              published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                              sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                              image_file_name, image_path
                 , rank()over (order by sl.updated_date desc) as rno,u.user_name,emp.entity_name primary_entity_name,
                 ems.entity_name secondary_entity_name
                FROM dd.dd_asset_list sl
                              left join dd.dd_user u
                              on u.user_id = sl.author_id
                              /*join dd.dd_entity_role_map erm
                              on erm.entity_role_map_id = primary_entity_role_map_id
                              join dd.dd_entity_master em
                              on em.entity_master_id = erm.entity_master_id*/
                              join   dd.dd_entity_role_map ermp
                              on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                              join   dd.dd_entity_role_map erms
                              on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                              join   dd.dd_entity_master emp
                              on     emp.entity_master_id = ermp.entity_master_id
                              join   dd.dd_entity_master ems
                              on     ems.entity_master_id = erms.entity_master_id
                 where sl.is_active=1
                and sl.is_deleted=0 
                  and    sl.is_published=CASE WHEN '||p_status ||' = 1 THEN 1
                                    WHEN '||p_status ||' = 2 THEN 0
                                    ELSE -1
                                        END
                  and    sl.is_trashed=CASE WHEN '||p_status ||' = 1 THEN 0
                                    WHEN '||p_status ||' = 2 THEN 1
                                    ELSE -1
                                        END                         
                  and    sl.published_date<= CASE WHEN '||p_status ||' = 1 THEN '''||v_sysdate||'''
                                                  ELSE sl.published_date 
                                                  END 
                  and    sl.asset_type_id in (1,2,4,5,6)
                  '||v_assettypefilterquery||'  
                  and exists (select 1 from   dd.dd_asset_entity_map eam
                      where eam.asset_id= sl.asset_id
                      and eam.asset_type_id = sl.asset_type_id 
                        and eam.entity_role_map_id in (SELECT  entity_role_mapid
                        FROM    UNNEST($2) U(entity_role_mapid) )
                         GROUP BY eam.asset_id,eam.asset_type_id
                                    HAVING COUNT(1)='||v_ent_count ||'           
                                    )
               '||v_anyentfilterquery||'
                       '
                       ||v_entitysearchquery||  ' '
                       ||v_assetcreatedbyquery||
                       '
                 )  as tab1
            where rno between '||v_fromrownumber||' and '||v_torownumber||') row) 
            '
            into v_assetjsonarr  
            using p_asset_type_id,p_entityrole_mapid,p_any_entityrole_mapid,p_any_entityrole_mapid,p_authorid
      ;
     ELSIF p_status = 0 then
        EXECUTE 'select COUNT(1) 
                from   dd.dd_asset_draft as ad
                where  1 = 1
                
                and (ad.version_number,ad.asset_id,ad.asset_type_id) 
                                          in (select max(ad1.version_number),ad1.asset_id,ad1.asset_type_id
                                         from   dd.dd_asset_draft as ad1
                                         where  ad1.asset_id = ad.asset_id
                                         and    ad1.asset_type_id = ad.asset_type_id
                                         group by ad1.asset_id,ad1.asset_type_id)
                
                and ((exists (select 1
                              from   dd.dd_asset_list a
                              where  a.asset_id = ad.asset_id
                              and    a.asset_type_id=ad.asset_type_id
                              and    a.is_published = 0
                              and    a.is_trashed = 0))
                     or (ad.version_number > (select max(published_version_number)
                                              from   dd.dd_asset_list ai
                                              where  ai.asset_id = ad.asset_id
                                          and    ai.asset_type_id=ad.asset_type_id)))
                     ' || v_assetfilterquery || '   
                     '||v_anyentfilterquery||'
                     '||v_assettypefilterquery||'
                     '||v_draftcreatedbyquery||'
                     
                                          '
              into   v_assetcount
              using p_asset_type_id,p_authorid;
        EXECUTE 'select array(select row_to_json(row) as jsonrow
     	    			  from (select * from (select     row_number() over(order by ad.created_date desc) as rno, 
                                ad.ASSET_ID, ad.asset_type_id,
                                asset_data->''data''->>''title'' asset_title,asset_data->''data''->>''guid''  as guid,
                                asset_data->''data''->>''status'' status, ad.created_date,
                                ad.updated_date modified_date 
                                , ad.version_number,ad.created_by created_by,
                                dd.dd_get_user_name ( ad.created_by )   created_by_name,
                                asset_data->''data''->>''duration'' duration , 
                                asset_data->''data''->>''slug_url'' title_alias, 
                                dd.dd_get_entity_name_by_asset (   ad.asset_type_id ,   ad.ASSET_ID ,
                                                    ad.version_number   )  entity_name	
                           	   from       dd.dd_ASSET_DRAFT as ad  
                                where asset_type_id in (1,2,4,5,6) 
                                and (ad.version_number,ad.asset_id,ad.asset_type_id) 
                                          in (select max(ad1.version_number),ad1.asset_id,ad1.asset_type_id
                                         from   dd.dd_asset_draft as ad1
                                         where  ad1.asset_id = ad.asset_id
                                         and    ad1.asset_type_id = ad.asset_type_id
                                         group by ad1.asset_id,ad1.asset_type_id)
                
                                and ((exists (select 1
                                              from   dd.dd_asset_list a
                                              where  a.asset_id = ad.asset_id
                                              and    a.asset_type_id=ad.asset_type_id
                                              and    a.is_published = 0
                                              and    a.is_trashed = 0))
                                     or (ad.version_number > (select max(published_version_number)
                                                              from   dd.dd_asset_list ai
                                                              where  ai.asset_id = ad.asset_id
                                                          and    ai.asset_type_id=ad.asset_type_id)))
                                     ' || v_assetfilterquery || '   
                                     '||v_anyentfilterquery||'
                                     '||v_assettypefilterquery||'
                                     '||v_draftcreatedbyquery||'
                                     
                 )  as tab1
                      		where rno between '||v_fromrownumber||' and '||v_torownumber||'   ) row
                		 )
                     
                     '
                     into v_assetjsonarr  
                     using p_asset_type_id,p_authorid;
     END IF;
     RAISE NOTICE '%',v_assetjson;
     if v_assetjsonarr is not null then
        foreach v_assetjson in array v_assetjsonarr
     loop
     	v_json := v_json||v_assetjson||',';
     end loop;
     end if;
     SELECT COUNT(1)
    	INTO    v_asset_count
    	FROM    UNNEST(v_assetjsonarr) asset_id;
      
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     IF v_asset_count>0 THEN
        V_JSON:= substring(v_json,1,(length(v_json)-1));
     ELSE 
        V_JSON:= substring(v_json,1,(length(v_json)));
     END IF;
     
     v_json := v_json||']}';
     
     p_assetjson  := v_json::jsonb;
     p_assetcount := v_assetcount;
     
  drop table t_allassetdata;
  drop table t_anyassetdata;   
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

$_$;


--
