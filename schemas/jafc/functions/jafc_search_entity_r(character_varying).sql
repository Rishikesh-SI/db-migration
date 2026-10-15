-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_search_entity_r(character varying)
-- Type: FUNCTION

-- Name: jafc_search_entity_r(character varying); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_search_entity_r(p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_entitysearchquery varchar(4000) := ' ';
     v_entityjsonarr jsonb[];
     v_entityjson jsonb;
     v_json varchar(30000) := '{"entities":[';
     
     v_entity_count numeric:=0;
begin
	
     if v_searchkeyword is not null then
     	
          v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
          
     end if;
     
     execute 'select array(select row_to_json(tab)
     				  from   (select entity_master_id, entity_name, entity_display_name, canonical_url, priority
                           		from   jafc.jafc_entity_master
                                   where  entity_master_id in(select entity_master_id
                                   					  from   jafc.jafc_entity_role_map
                                                              where  entity_role_id in(select entity_role_id
                                                              					  from   jafc.jafc_entity_role
                                                                                       where    is_active       = 1
                                                                                       and    is_deleted      = 0)
                                                              and    is_active       = 1
                                                              and    is_deleted      = 0)'
                                   ||v_entitysearchquery||
                                   'and    is_active       = 1
                                   and    is_deleted      = 0) as tab)'
	into   v_entityjsonarr
     using  v_searchkeyword;
     
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
