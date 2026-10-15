-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_entity_listing(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labgt01_v1_get_entity_listing(numeric, numeric, character varying); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_entity_listing(p_entitygroupid numeric, p_entitytypeid numeric, p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
 

declare
	
     v_searchkeyword varchar := upper(p_searchkeyword);
     v_entitysearchquery varchar := ' ';
     v_entityjsonarr jsonb[];
     v_entityjson jsonb;
     v_json varchar := '{"entities":[';
     
     v_entity_count numeric:=0;
begin
	
     if v_searchkeyword is not null then
     	
          v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
          
     end if;
     
     execute 'select array(select row_to_json(tab)
		    			  from   (select    em.entity_master_id, entity_role_map_id, entity_name, entity_display_name, canonical_url, em.priority
                     			from      labgt01_v1.labgt01_v1_entity_master em
                     			left join labgt01_v1.labgt01_v1_entity_role_map erm
                     			on        erm.entity_master_id = em.entity_master_id
                     			join      labgt01_v1.labgt01_v1_entity_role er
                     			on        er.entity_role_id    = erm.entity_role_id
                     			where     er.entity_group_id   = '||p_entitygroupid||'
                     			and       er.entity_type_id    = '|| p_entitytypeid||'
                     			and    	 er.is_active         = 1
                     			and    	 er.is_deleted        = 0
                     			and       erm.is_active        = 1
                     			and       em.is_active         = 1
                     			and       em.is_deleted        = 0'
                     			||v_entitysearchquery||
                    		   ') as tab
              			 )'
     into   v_entityjsonarr
     using  v_searchkeyword;
     raise notice 'v_entityjsonarr %',v_entityjsonarr;
     foreach v_entityjson in array v_entityjsonarr
     loop
     	v_json := v_json||v_entityjson||',';
     end loop;
     
	v_json := substring(v_json,1,(length(v_json)-1));
     
     v_json := v_json||']}';
      
     p_entityjson := v_json::jsonb;
     
-- exception
-- 	when others then
--      	p_entityjson := '{"entities":[{"error":"no record"}]}';
     
end;

 
$_$;


--
