-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_type_details_r(character varying, jsonb)
-- Type: FUNCTION

-- Name: _get_entity_type_details_r(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_type_details_r(p_schema_prefix character varying, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	 v_entity_type_id numeric;
	 v_client_id numeric;
	 v_waf_entity_type_id numeric;
	 v_entity_type_name varchar(4000);
	 v_entity_type_desc varchar(4000);
	 v_entity_type_identifier varchar(4000);
	 v_is_active numeric;
	 v_is_deleted numeric;
	 v_created_date timestamp without time zone;
	 v_updated_date timestamp without time zone;
	 v_created_by numeric;
	 v_updated_by numeric;
	 v_search_priority numeric;
	 v_is_child numeric;
	 v_role_list jsonb;
	 v_current_timestamp timestamp without time zone;
	 v_entity_url_type  numeric;

begin

v_current_timestamp := current_timestamp at time zone 'utc';
     
	 select  p_json->'id'
	 into    v_entity_type_id;
	 
	 if v_entity_type_id=null  then
	    v_entity_type_id:=0;
	 end if;
	 
	 execute 'select waf_entity_type_id,client_id,
	          entity_type_name,entity_type_desc,created_date,updated_date,
			  created_by,updated_by,entity_type_identifier,search_priority,
			  is_child,is_active,is_deleted,entity_url_type
	          from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type 
			  where entity_type_id='||v_entity_type_id||''	 
	 into    v_waf_entity_type_id,v_client_id,
	          v_entity_type_name,v_entity_type_desc,v_created_date,v_updated_date,
			  v_created_by,v_updated_by,v_entity_type_identifier,v_search_priority,
			  v_is_child,v_is_active,v_is_deleted,v_entity_url_type;
	 
	 execute 'SELECT JSON_AGG(src) FROM(SELECT gp.entity_group_id,gp.group_name,coalesce(r.entity_type_id,0) as entity_type_id,coalesce(r.entity_role_id,0)as entity_role_id
              ,coalesce(r.is_active,0) as is_active,coalesce(r.is_deleted,1) as is_deleted
			  FROM '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group gp
              left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role r on gp.entity_group_id=r.entity_group_id
              and r.entity_type_id='||v_entity_type_id||'
			  where gp.is_active=1
			  and gp.is_deleted=0) src'
	 into v_role_list;
	 
	 
	  p_data = '{
	 "entity_type_id":'||coalesce(v_entity_type_id,0)||',
	 "is_active":'|| coalesce(v_is_active,0)||',
	 "is_deleted":'|| coalesce(v_is_deleted,0)||',
	 "waf_entity_type_id":'|| coalesce(v_waf_entity_type_id,0)||',
	 "client_id":'||coalesce(v_client_id,0)||',
	 "entity_type_name":"'|| coalesce(v_entity_type_name,'')||'",
	 "entity_type_desc":"'||coalesce(v_entity_type_desc,'')||'",
	 "created_date":"'|| coalesce(v_created_date,v_current_timestamp)||'",
	 "updated_date":"'||coalesce(v_updated_date,v_current_timestamp)||'",
	 "created_by":'|| coalesce(v_created_by,0)||',
	 "updated_by":'||coalesce(v_updated_by,0)||',
	 "entity_type_identifier":"'|| coalesce(v_entity_type_identifier,'')||'",
	 "search_priority":'||coalesce(v_search_priority,0)||',
	 "is_child":'|| coalesce(v_is_child,0)||',
	 "EntityRoleList":'||v_role_list ::text||',
	 "entity_url_type":'|| coalesce(v_entity_url_type,0)||'
	 }' ;  
	 
	 
end;
$$;


--
