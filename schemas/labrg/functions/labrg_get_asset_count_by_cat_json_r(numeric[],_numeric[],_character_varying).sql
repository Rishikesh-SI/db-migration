-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_get_asset_count_by_cat_json_r(numeric[], numeric[], character varying)
-- Type: FUNCTION

-- Name: labrg_get_asset_count_by_cat_json_r(numeric[], numeric[], character varying); Type: FUNCTION; Schema: labrg; Owner: -
--

CREATE FUNCTION labrg.labrg_get_asset_count_by_cat_json_r(p_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, OUT p_asset_count jsonb, OUT p_category_cur jsonb) RETURNS record
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
     
begin
	
     v_sysdate:= current_timestamp at time zone 'utc';
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
    	if v_ent_count > 0 then
    		
          v_entityrolemapidquery := 'and exists (select 1
          							    from   labrg.labrg_asset_entity_map eam
                                                 where  eam.asset_id= sl.asset_id
                                                 and    eam.asset_type_id = sl.asset_type_id 
                                                 and    eam.entity_role_map_id in (select entity_role_mapid
                                                 							   from unnest($2) u(entity_role_mapid))
                                                 group by eam.asset_id,eam.asset_type_id
                                                 having count(1)='||v_ent_count ||')';
     	
    	end if;
     
    	if v_searchkeyword is not null then
     	
          v_searchkeyword:='*' || replace(''||v_searchkeyword||'',' ',':* & *') || ':*';
          v_entitysearchquery := ' and (to_tsvector(sl.asset_title) @@@ to_tsquery('''||v_searchkeyword||''')
                                        or to_tsvector(sl.short_desc) @@@ to_tsquery('''||v_searchkeyword||'''))';
     
     end if;
     
    	select count(asset_type_id)
     into   v_assettypeidcount
	from   unnest(p_asset_type_id) u(asset_type_id);
     
    	if v_assettypeidcount > 0 then
     	
          v_assettypequery := ' and sl.asset_type_id in(select asset_type_id from unnest($1) u(asset_type_id))';
          
    	end if;
    	
    	v_qry_str:= 'select array_to_json(array_agg(row_to_json(t)))
     from (select  count(1) cnt,
      eamc.entity_role_map_id as sentid    
    			   from   labrg.labrg_asset_list sl
             join   labrg.labrg_entity_role_map erm
             on     sl.secondary_entity_role_map_id = erm.entity_role_map_id
             join   labrg.labrg_asset_entity_map eamc
             on     eamc.asset_id = sl.asset_id
             and    eamc.asset_type_id = sl.asset_type_id
             and    eamc.entity_role_map_id in (select em.entity_role_map_id   
                                            from labrg.labrg_entity_role_map em
                                            join labrg.labrg_entity_master e
                                            on e.entity_master_id=em.entity_master_id
                                            where entity_role_id in(select entity_role_id 
                                                                from labrg.labrg_entity_category 
                                                                where category_name='||'''category type'''||' )
                                            and e.is_active=1
                                            and    em.priority>0)
                  where  sl.is_active=1
                  and    sl.is_deleted=0
                  and    sl.is_published=1
                  and    sl.published_date<='''||v_sysdate||'''
                  and    sl.asset_type_id in (1,2,4,5,6) 
                  and    erm.priority>0  '
                  ||v_assettypequery
    			   ||v_entityrolemapidquery
                  ||v_entitysearchquery || '
                  group by eamc.entity_role_map_id
                  order by eamc.entity_role_map_id)t' ;
	
    		execute  v_qry_str
            into p_asset_count
    		using  p_asset_type_id,p_entityrole_mapid ;
     
     select array_to_json(array_agg(row_to_json(t)))
     from (select em.entity_role_map_id entid, e.entity_name, tab.cnt count
           from labrg.labrg_entity_role_map em
           join labrg.labrg_entity_master e
           on e.entity_master_id = em.entity_master_id
           left join (select (json_array_elements(p_asset_count::json)->>'sentid')::numeric,
                      		 (json_array_elements(p_asset_count::json)->>'cnt')::numeric) tab(sentid, cnt)
           on tab.sentid = em.entity_role_map_id
           where entity_role_id in(select entity_role_id from labrg.labrg_entity_category where category_name = 'category type')
           and e.is_active = 1
           and em.priority > 0
           order by entid
     )t
     into p_category_cur;
     
end;

 $_$;


--
