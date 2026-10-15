-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_get_entity_type_listing(numeric)
-- Type: FUNCTION

-- Name: labjdtest_get_entity_type_listing(numeric); Type: FUNCTION; Schema: labjdtest; Owner: -
--

CREATE FUNCTION labjdtest.labjdtest_get_entity_type_listing(p_entitygroupid numeric, OUT p_entitytypejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$ 

declare
	
     v_entitytypejsonarr jsonb[];
     v_entitytypejson    jsonb;
     v_json			 varchar(4000) := '{"entity_types":[';
     
begin
     
     execute 'select array(select row_to_json(tab)
     				  from   (select entity_type_id, entity_type_name, entity_type_desc
                           		from   labJDTEST.labJDTEST_entity_type
                                   where  entity_type_id in(select distinct entity_type_id
                                   					from   labJDTEST.labJDTEST_entity_role
                                                            where  entity_group_id = $1)
                                   and    is_active  = 1
                                   and    is_deleted = 0) as tab)'
     into   v_entitytypejsonarr
     using  p_entitygroupid;
     
     foreach v_entitytypejson in array v_entitytypejsonarr
     loop
     	v_json := v_json||v_entitytypejson||',';
     end loop;
     
     v_json := substring(v_json,1,(length(v_json)-1))||']}';
     
     p_entitytypejson := v_json::jsonb;
     
end;

 $_$;


--
