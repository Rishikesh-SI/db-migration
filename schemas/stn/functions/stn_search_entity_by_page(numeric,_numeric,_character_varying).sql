-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_search_entity_by_page(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: stn_search_entity_by_page(numeric, numeric, character varying); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_search_entity_by_page(p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
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
     
     V_ENTITY_COUNT NUMERIC:=0;
begin
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     if v_searchkeyword is not null then
     	
       --  v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
         --      v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( ''*''||'||'$1'||'||'':*'')';
              v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( '||'$1'||')';
              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
     end if;
     
        --           RAISE NOTICE '%',v_searchkeyword;              
     execute 'select array(select row_to_json(tab)
     				  from   (select em.entity_master_id, em.entity_name, em.entity_display_name, em.canonical_url, em.priority,
              row_number() over(order by et.search_priority nulls last,em.entity_name ) slno
                           		from   stn.stn_entity_master em
                              join   stn.stn_entity_role_map er
                              on em.entity_master_id=er.entity_master_id
                              and er.priority=1
                              join   stn.stn_entity_role ero
                              on er.entity_role_id=ero.entity_role_id
                              join   stn.stn_entity_type et
                              on ero.entity_type_id=et.entity_type_id
                                   where  1=1 '
                                   -- entity_master_id in(select entity_master_id
                                   --				  from   stn.stn_entity_role_map
                                   --                           where  entity_role_id in(select entity_role_id
                                    --                          					  from   stn.stn_entity_role
                                   --                                                    where    is_active       = 1
                                   --                                                    and    is_deleted      = 0)
                                  --                            and    is_active       = 1
                                  --                            and    is_deleted      = 0)'
                                   ||v_entitysearchquery||
                                   'and    em.is_active       = 1
                                   and    em.is_deleted      = 0
                                   )  as tab
                                   where  slno between '||'$2'||' and '||'$3'||'
                                   )
                                   '
	into   v_entityjsonarr
     using  v_searchkeyword, v_fromrownumber, v_torownumber;
      RAISE NOTICE '%',v_searchkeyword;        
     foreach v_entityjson in array v_entityjsonarr
     loop
     	v_json := v_json||v_entityjson||',';
     end loop;
     
     	SELECT COUNT(1)
    	INTO    V_ENTITY_COUNT
    	FROM    UNNEST(v_entityjsonarr) entity_master_id;
        
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     IF V_ENTITY_COUNT>0 THEN
     V_JSON:= substring(v_json,1,(length(v_json)-1));
     ELSE 
     V_JSON:= substring(v_json,1,(length(v_json)));
     END IF;
      
      v_json := v_json||']}';
      
     p_entityjson := v_json::jsonb;
     
end;

$_$;


--
