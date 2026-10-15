-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_entity_group_listing()
-- Type: FUNCTION

-- Name: swa_get_entity_group_listing(); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_entity_group_listing(OUT p_entitygroupjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
     v_entitygroupjsonarr jsonb[];
     v_entitygroupjson    jsonb;
     v_json			 varchar(4000) := '{"entity_groups":[';
     
begin
	
     execute 'select array(select row_to_json(tab)
     				  from   (select entity_group_id, group_name, group_desc
                           		from   swa.swa_entity_group
                                   where  is_active  = 1
                                   and    is_deleted = 0 order by group_name) as tab)'
     into   v_entitygroupjsonarr;
     
     foreach v_entitygroupjson in array v_entitygroupjsonarr
     loop
     	v_json := v_json||v_entitygroupjson||',';
     end loop;
     
     v_json := substring(v_json,1,(length(v_json)-1))||']}';
     
     p_entitygroupjson := v_json::jsonb;
     
end;

$$;


--
