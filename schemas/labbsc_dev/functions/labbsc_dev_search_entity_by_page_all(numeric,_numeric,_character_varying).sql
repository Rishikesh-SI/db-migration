-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_search_entity_by_page_all(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labbsc_dev_search_entity_by_page_all(numeric, numeric, character varying); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_search_entity_by_page_all(p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$ 

declare
	   v_fromrownumber numeric;
    v_torownumber numeric;
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_entitysearchquery varchar(4000) := ' ';
     v_entityjsonarr jsonb[];
     v_entityjson jsonb;
     v_json varchar(30000) := '{"entities":[';
     
     v_entity_count numeric:=0;
begin
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     if v_searchkeyword is not null then
     	
       --  v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
         --      v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( ''*''||'||'$1'||'||'':*'')';
              v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( '||'$1'||')';
              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
     end if;
     
        --           raise notice '%',v_searchkeyword;              
     execute 'select array(select row_to_json(tab)
     				  from   (select em.entity_master_id, em.entity_name, em.entity_display_name, em.canonical_url, em.priority,eg.group_name,
              row_number() over(order by et.search_priority nulls last,em.entity_name ) slno
                           		from   labbsc_dev.labbsc_dev_entity_master em
                              join   labbsc_dev.labbsc_dev_entity_role_map er
                              on em.entity_master_id=er.entity_master_id
                              -- and er.priority=1 -- all 
                              join   labbsc_dev.labbsc_dev_entity_role ero
                              on er.entity_role_id=ero.entity_role_id
                              join   labbsc_dev.labbsc_dev_entity_type et
                              on ero.entity_type_id=et.entity_type_id
							  join   labbsc_dev.labbsc_dev_entity_group eg
                              on ero.entity_group_id=eg.entity_group_id
                                   where  1=1 '
                                   -- entity_master_id in(select entity_master_id
                                   --				  from   labbsc_dev.labbsc_dev_entity_role_map
                                   --                           where  entity_role_id in(select entity_role_id
                                    --                          					  from   labbsc_dev.labbsc_dev_entity_role
                                   --                                                    where    is_active       = 1
                                   --                                                    and    is_deleted      = 0)
                                  --                            and    is_active       = 1
                                  --                            and    is_deleted      = 0)'
                                   ||v_entitysearchquery||
                                   'and    em.is_active       = 1
                                   and    em.is_deleted      = 0)  as tab
                                   where  slno between '||'$2'||' and '||'$3'||'
                                   )
                                   '
	into   v_entityjsonarr
     using  v_searchkeyword, v_fromrownumber, v_torownumber;
      raise notice '%',v_searchkeyword;        
     foreach v_entityjson in array v_entityjsonarr
     loop
     	v_json := v_json||v_entityjson||',';
     end loop;
     
     	select count(1)
    	into    v_entity_count
    	from    unnest(v_entityjsonarr) entity_master_id;
        
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     if v_entity_count>0 then
     v_json:= substring(v_json,1,(length(v_json)-1));
     else 
     v_json:= substring(v_json,1,(length(v_json)));
     end if;
      
      v_json := v_json||']}';
      
     p_entityjson := v_json::jsonb;
     
end;

 $_$;


--
