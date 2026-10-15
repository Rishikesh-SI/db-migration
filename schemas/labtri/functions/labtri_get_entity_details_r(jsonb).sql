-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_get_entity_details_r(jsonb)
-- Type: FUNCTION

-- Name: labtri_get_entity_details_r(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_get_entity_details_r(p_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
/*	input:
'{
  "data":{
     "entity_name":"news,photos,videos"
	 "language_id":""
         }  
 }' 
 
 or
 
 '{
  "data":{
     "entity_name":""
	 "language_id":"1"
         }  
 }'*/
 
 v_entity character varying;
 v_entity_detail jsonb;
 v_language_array numeric[];
 v_language_id1 character varying;
 v_language_id2 character varying;
 v_asset_type_id numeric;
 v_cannonical	character varying;
 
 BEGIN
 
 select p_json->'data'->>'ref_ids' into v_language_id1;
 select p_json->'data'->>'languages_id' into v_language_id2;
 select p_json->'data'->>'asset_type' into v_asset_type_id;
 select p_json->'data'->>'cannonical' into v_cannonical;
 
 
--  insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'insert-entity-details','logs',uuid_generate_v4(),p_json,current_timestamp,'labtri','logs');
  
 
 v_language_array:= (string_to_array(lower(COALESCE(v_language_id1,v_language_id2)),','))::numeric[];
 
raise notice 'v_language_array %',v_language_array;

if (v_cannonical is not null) then 

	select ('{"data":'||json_agg(x)||'}')
		from (select 
		 em.entity_master_id,
		 em.entity_name,
		 em.entity_display_name,
		 em.canonical_url,
		 em.created_date,
		 em.updated_date,
		 em.is_active,
		 em.is_deleted,
		 em.entity_url,
		 erm.entity_role_map_id,
		 erm.entity_role_id,
		 erm.source_object_id
		 from  labtri.labtri_entity_master em
		 join  labtri.labtri_entity_role_map  erm
		 on (em.entity_master_id = erm.entity_master_id)
		 join labtri.labtri_asset_type ast	  
		 on ast.entity_role_id=erm.entity_role_id	  
 		 where 
-- 			  erm.ref_id in (select unnest (v_language_array))
-- 		 and 
			  ast.asset_type_id = v_asset_type_id 
		 and em.canonical_url = v_cannonical
		 )x
		  into p_out_json;
		
else 
		select ('{"data":'||json_agg(x)||'}')
		from (select 
		 em.entity_master_id,
		 em.entity_name,
		 em.entity_display_name,
		 em.canonical_url,
		 em.created_date,
		 em.updated_date,
		 em.is_active,
		 em.is_deleted,
		 em.entity_url,
		 erm.entity_role_map_id,
		 erm.entity_role_id,
		 erm.source_object_id
		 from  labtri.labtri_entity_master em
		 join  labtri.labtri_entity_role_map  erm
		 on (em.entity_master_id = erm.entity_master_id)
		 join labtri.labtri_asset_type ast	  
		 on ast.entity_role_id=erm.entity_role_id	  
		 where erm.ref_id in (select unnest (v_language_array))
		 and ast.asset_type_id = v_asset_type_id 
		 )x
		  into p_out_json;
			  
		 raise notice 'v_language_array %',v_language_array; 
		 
end if;
		
 
 End;
 
$$;


--
