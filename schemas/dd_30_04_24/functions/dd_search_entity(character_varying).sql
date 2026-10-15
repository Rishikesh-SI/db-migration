-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_search_entity(character varying)
-- Type: FUNCTION

-- Name: dd_search_entity(character varying); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_search_entity(p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_entitysearchquery varchar(4000) := ' ';
     v_entityjsonarr jsonb[];
     v_entityjson jsonb;
     v_json varchar(3000000) := '{"entities":[';
     
     V_ENTITY_COUNT NUMERIC:=0;
begin
	
     if v_searchkeyword is not null then
     	
          v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
          
     end if;
     
     execute 'select array(select row_to_json(tab)
     				  from   (select a.entity_master_id, a.entity_name, 
                      a.entity_display_name, a.canonical_url, a.priority,
                      b.entity_role_map_id
                           		from   dd.dd_entity_master a 
                                JOIN    dd.dd_entity_role_map b on a.entity_master_id=b.entity_master_id and b.is_active=1             
                                 where  b.entity_role_id in(select entity_role_id
                                                              					  from   dd.dd_entity_role
                                                                                       where    is_active       = 1
                                                                                       and    is_deleted      = 0)'
                                   ||v_entitysearchquery||
                                   '
                                   
                                   and    a.is_active       = 1
                                   and    a.is_deleted      = 0) as tab
                                   )'
	into   v_entityjsonarr
     using  v_searchkeyword;
     
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
