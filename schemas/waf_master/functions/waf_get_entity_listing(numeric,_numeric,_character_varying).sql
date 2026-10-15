-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_entity_listing(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: waf_get_entity_listing(numeric, numeric, character varying); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_entity_listing(p_entitygroupid numeric, p_entitytypeid numeric, p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_entitysearchquery varchar(4000) := ' ';
     v_entityjsonarr jsonb[];
     v_entityjson jsonb;
     v_json varchar(4000) := '{"entities":[';
     
begin
	
     if v_searchkeyword is not null then
     	
          v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
          
     end if;
     
     execute 'select array(select row_to_json(tab)
     				  from   (select entity_master_id, entity_name, entity_display_name, canonical_url, priority
                           		from   waf_master.waf_entity_master
                                   where  entity_master_id in(select entity_master_id
                                   					  from   waf_master.waf_entity_role_map
                                                              where  entity_role_id in(select entity_role_id
                                                              					  from   waf_master.waf_entity_role
                                                                                       where  entity_group_id = p_entitygroupid
                                                                                       and    entity_type_id  = p_entitytypeid
                                                                                       and    is_active       = 1
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
     
     v_json := substring(v_json,1,(length(v_json)-1))||']}';
     
     p_entityjson := v_json::jsonb;
     
end;

$_$;


--
