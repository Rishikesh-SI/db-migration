-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_asset_count_by_cat_rb_r(numeric[], numeric[], character varying, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: dhm_get_asset_count_by_cat_rb_r(numeric[], numeric[], character varying, numeric, refcursor, refcursor); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_asset_count_by_cat_rb_r(p_entity_role_map_id numeric[], p_asset_type_id numeric[], p_search_keyword character varying, p_author_id numeric, p_asset_count refcursor, p_category_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$ 

declare
	
    	v_createdbyquery varchar(50) := ' ';
    	v_searchkeyword varchar(4000) := p_search_keyword;
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
        v_author_filter_query varchar(4000) := ' ';
        v_str_arr_erm_id varchar(4000);
        v_entity_role_map_id numeric[];
     
begin
	
     v_sysdate:= current_timestamp at time zone 'utc';
     
   select array(  select erm.entity_role_map_id 
    from dhm.dhm_entity_category ec
    join dhm.dhm_entity_role_map erm  on erm.entity_role_id=ec.entity_role_id
     where category_name='language'
   and erm.entity_role_map_id in ( select ent_id from unnest(array[p_entity_role_map_id]) as ent_id)
                ) into v_entity_role_map_id
;
     
     
     
     select count(1)
     into   v_ent_count
     from   unnest(v_entity_role_map_id)entity_id;
     
    	if v_ent_count > 0 then
    		
          v_entityrolemapidquery := 'and exists (select 1
          							    from   dhm.dhm_asset_entity_map eam
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
        
        if p_author_id is not null then
    	
        v_author_filter_query := ' and (sl.asset_id, sl.asset_type_id) in (select aa.asset_id, aa.asset_type_id
        																   from   dhm.dhm_author_action aa
                                                                           where  aa.author_id = '||p_author_id
                                                                           ||' -- and    aa.author_id = sl.created_by
                                                                           and    aa.action_id = 4)';
        
    end if;
    	v_str_arr_erm_id:=  '{'||array_to_string(v_entity_role_map_id,',')||'}';
    	v_qry_str:= 'select count(1) cnt, eamc.entity_role_map_id as sentid    
    			   from   dhm.dhm_asset_list sl
             join   dhm.dhm_asset_entity_map eamc
             on     eamc.asset_id = sl.asset_id
             and    eamc.asset_type_id = sl.asset_type_id
             and    eamc.entity_role_map_id in (select em.entity_role_map_id   
                                            	from dhm.dhm_entity_role_map em
                                            	join dhm.dhm_entity_master e
                                            	on e.entity_master_id=em.entity_master_id
                                            	where entity_role_id in(select entity_role_id 
                                                						from dhm.dhm_entity_category 
                                                                		where category_name='||'''category type'''||' )
												-- and  em.entity_role_map_id =any ($3::numeric[])
                                            	and e.is_active=1
                                            	and em.priority>0)
                  where  sl.is_active=1
                  and    sl.is_deleted=0
                  and    sl.is_published=1
                  and    sl.published_date<='''||v_sysdate||'''
                  and    sl.asset_type_id in (1,2,4,5,6) '
                  ||v_assettypequery
    			  ||v_entityrolemapidquery
                  ||v_entitysearchquery
                  ||v_author_filter_query
                  ||'group by eamc.entity_role_map_id ' ;
	
    	open p_asset_count for
    		execute  v_qry_str
    		using  p_asset_type_id,v_entity_role_map_id, v_str_arr_erm_id ;
     
     open p_category_cur for
     	select em.entity_role_map_id entid,e.entity_name  
          from dhm.dhm_entity_role_map em
          join dhm.dhm_entity_master e
          on e.entity_master_id=em.entity_master_id
          where entity_role_id in(select entity_role_id from dhm.dhm_entity_category where category_name='category type')
          and e.is_active=1
          and    em.priority>0 ;
     
end;

 $_$;


--
