-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_get_entity_details_r_09112023(jsonb)
-- Type: FUNCTION

-- Name: labtri_get_entity_details_r_09112023(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_get_entity_details_r_09112023(p_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
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
 v_entity_array character varying[];
 v_language_id numeric;

 
 
 BEGIN
 
 select p_json->'data'->>'entity_name' into v_entity;
 select p_json->'data'->>'languages_id' into v_language_id;
 
 if v_entity is not null then
 
 v_entity_array:= string_to_array(lower(v_entity),',');
 
	raise notice 'v_entity_array %',v_entity_array;
 
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
		 where lower(em.entity_name) in (select unnest (v_entity_array))
		 )x
		  into p_out_json;
 
 elsif (v_entity = '' or v_entity is null) or v_language_id is not null then
 
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
		 where erm.ref_id = v_language_id
		 )x
		  into p_out_json;
			  
end if;	
		  
 
 End;
 
$$;


--
