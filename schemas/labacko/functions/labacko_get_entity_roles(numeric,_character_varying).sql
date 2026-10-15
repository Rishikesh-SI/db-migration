-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_get_entity_roles(numeric, character varying)
-- Type: FUNCTION

-- Name: labacko_get_entity_roles(numeric, character varying); Type: FUNCTION; Schema: labacko; Owner: -
--

CREATE FUNCTION labacko.labacko_get_entity_roles(p_entity_master_id numeric, p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
 

declare
	
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_entitysearchquery varchar(4000) := ' ';
     v_entityjsonarr jsonb[];
     v_entityjson jsonb;
     v_json varchar(4000) := '{"entities":[';
     
     v_entity_count numeric:=0;
begin
	
     if v_searchkeyword is not null then
     	
          v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
          
     end if;
     
     execute 'select array(select row_to_json(tab)
     				  from   ( select erm.entity_role_id,
					           erm.entity_role_map_id ,
					                  et.entity_type_id,et.entity_type_name,
                                                eg.entity_group_id,eg.group_name,
												em.canonical_url
                                   					  from   labacko.labacko_entity_role_map erm
                                                      join  labacko.labacko_entity_role er
                                                      on er.entity_role_id =erm.entity_role_id
                                                      join  labacko.labacko_entity_type et
                                                      on et.entity_type_id = er.entity_type_id
                                                       join  labacko.labacko_entity_group eg
                                                      on er.entity_group_id = eg.entity_group_id
													join labacko.labacko_entity_master em
												    on em.entity_master_id=erm.entity_master_id
                                                                      where er.is_deleted=0
                                                                      and er.is_active=1
                                                                      and eg.is_active=1
                                                                      and eg.is_deleted=0
                                                              and erm.entity_master_id = '||p_entity_master_id||') as tab)'
	into   v_entityjsonarr
     using  v_searchkeyword;
     
     foreach v_entityjson in array v_entityjsonarr
     loop
     	v_json := v_json||v_entityjson||',';
     end loop;
     
     	select count(1)
    	into    v_entity_count
    	from    unnest(v_entityjsonarr) entity_role_id;
        
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
