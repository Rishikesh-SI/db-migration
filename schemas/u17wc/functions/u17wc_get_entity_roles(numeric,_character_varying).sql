-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_entity_roles(numeric, character varying)
-- Type: FUNCTION

-- Name: u17wc_get_entity_roles(numeric, character varying); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_entity_roles(p_entity_master_id numeric, p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$     

declare
	
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_entitysearchquery varchar(4000) := ' ';
     v_entityjsonarr jsonb[];
     v_entityjson jsonb;
     v_json varchar(4000) := '{"entities":[';
     
     V_ENTITY_COUNT NUMERIC:=0;
begin
	
     if v_searchkeyword is not null then
     	
          v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
          
     end if;
     
     execute 'select array(select row_to_json(tab)
     				  from   ( select erm.entity_role_id,erm.entity_role_map_id ,et.entity_type_id,et.entity_type_name,
                                                eg.entity_group_id,eg.group_name
                                   					  from   u17wc.u17wc_entity_role_map erm
                                                      join  u17wc.u17wc_entity_role er
                                                      on er.entity_role_id =erm.entity_role_id
                                                      join  u17wc.u17wc_entity_type et
                                                      on et.entity_type_id = er.entity_type_id
                                                       join  u17wc.u17wc_entity_group eg
                                                      on er.entity_group_id = eg.entity_group_id
                                                                      where er.is_deleted=0
                                                                      and er.is_active=1
                                                                      and eg.is_active=1
                                                                      and eg.is_deleted=0
                                                              and entity_master_id = '||p_entity_master_id||') as tab)'
	into   v_entityjsonarr
     using  v_searchkeyword;
     
     foreach v_entityjson in array v_entityjsonarr
     loop
     	v_json := v_json||v_entityjson||',';
     end loop;
     
     	SELECT COUNT(1)
    	INTO    V_ENTITY_COUNT
    	FROM    UNNEST(v_entityjsonarr) entity_role_id;
        
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
