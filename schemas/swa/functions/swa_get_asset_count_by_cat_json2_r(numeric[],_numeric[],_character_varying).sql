-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_asset_count_by_cat_json2_r(numeric[], numeric[], character varying)
-- Type: FUNCTION

-- Name: swa_get_asset_count_by_cat_json2_r(numeric[], numeric[], character varying); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_asset_count_by_cat_json2_r(p_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, OUT p_asset_count jsonb, OUT p_category_cur jsonb) RETURNS record
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
     
begin
	
     v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
    	if v_ent_count > 0 then
    		
          v_entityrolemapidquery := 'and EXISTS (select 1
          							    from   swa.swa_asset_entity_map eam
                                                 where  eam.asset_id= sl.asset_id
                                                 and    eam.asset_type_id = sl.asset_type_id 
                                                 and    eam.entity_role_map_id in (SELECT entity_role_mapid
                                                 							   FROM UNNEST($2) U(entity_role_mapid))
                                                 GROUP BY eam.asset_id,eam.asset_type_id
                                                 HAVING COUNT(1)='||v_ent_count ||')';
     	
    	end if;
     
    	if v_searchkeyword is not null then
     	
          v_searchkeyword:='*' || replace(''||v_searchkeyword||'',' ',':* & *') || ':*';
          v_entitysearchquery := ' and (to_tsvector(sl.asset_title) @@@ to_tsquery('''||v_searchkeyword||''')
                                        OR to_tsvector(sl.short_desc) @@@ to_tsquery('''||v_searchkeyword||'''))';
     
     end if;
     
    	select count(asset_type_id)
     into   v_assettypeidcount
	from   unnest(p_asset_type_id) U(asset_type_id);
     
    	if v_assettypeidcount > 0 then
     	
          v_assettypequery := ' and sl.asset_type_id in(SELECT asset_type_id FROM UNNEST($1) U(asset_type_id))';
          
    	end if;
    	
    	v_qry_str:= 'select array_to_json(array_agg(row_to_json(t)))
     from (SELECT  count(1) cnt,
      erm.entity_role_map_id AS sentid    
    			   FROM   swa.swa_asset_list sl
             join   swa.swa_entity_role_map erm
             on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
             join   swa.swa_asset_entity_map eamc
             on     eamc.asset_id = sl.asset_id
             and    eamc.asset_type_id = sl.asset_type_id
             and    erm.entity_role_map_id in (SELECT EM.ENTITY_ROLE_MAP_ID   
                                            FROM SWA.SWA_ENTITY_ROLE_MAP EM
                                            JOIN SWA.SWA_ENTITY_MASTER E
                                            ON E.ENTITY_MASTER_ID=EM.ENTITY_MASTER_ID
                                            WHERE ENTITY_ROLE_ID IN(SELECT ENTITY_ROLE_ID 
                                                                FROM SWA.SWA_ENTITY_CATEGORY 
                                                                WHERE CATEGORY_NAME='||'''Category Type'''||' )
                                            AND E.IS_ACTIVE=1
                                            and    EM.priority>0)
                  where  sl.is_active=1
                  and    sl.is_deleted=0
                  and    sl.is_published=1
                  and  erm.entity_role_id in (SELECT ENTITY_ROLE_ID FROM SWA.SWA_ENTITY_CATEGORY WHERE CATEGORY_NAME = ''Category Type'')
                  and    sl.published_date<='''||v_sysdate||'''
                  and    sl.asset_type_id in (1,2,4,5,6) 
                  and    erm.priority>0  '
                  ||v_assettypequery
    			   ||v_entityrolemapidquery
                  ||v_entitysearchquery || '
                  group by erm.entity_role_map_id
                  order by erm.entity_role_map_id)t' ;
	
    		execute  v_qry_str
            into p_asset_count
    		using  p_asset_type_id,p_entityrole_mapid ;
     
     select array_to_json(array_agg(row_to_json(t)))
     from (SELECT EM.ENTITY_ROLE_MAP_ID entid, E.ENTITY_NAME, tab.cnt count
           FROM SWA.SWA_ENTITY_ROLE_MAP EM
           JOIN SWA.SWA_ENTITY_MASTER E
           ON E.ENTITY_MASTER_ID = EM.ENTITY_MASTER_ID
           left join (select (json_array_elements(p_asset_count::json)->>'sentid')::numeric,
                      		 (json_array_elements(p_asset_count::json)->>'cnt')::numeric) tab(sentid, cnt)
           on tab.sentid = em.ENTITY_ROLE_MAP_ID
           WHERE ENTITY_ROLE_ID IN(SELECT ENTITY_ROLE_ID FROM SWA.SWA_ENTITY_CATEGORY WHERE CATEGORY_NAME = 'Category Type')
           AND E.IS_ACTIVE = 1
           and EM.priority > 0
           order by entid
     )t
     into p_category_cur;
     
end;

$_$;


--
