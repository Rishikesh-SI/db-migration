-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_entity_details_r_10062024(jsonb)
-- Type: FUNCTION

-- Name: labwis_get_entity_details_r_10062024(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_entity_details_r_10062024(p_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
/*	input:
'{
"data":{
"ref_id":"",
"asset_type_id":""
}
}'
*/
 
 v_entity character varying;
 v_entity_detail jsonb;
 v_language_array numeric[];
 v_ref_category_ids character varying;
 v_language_id2 character varying;
 v_asset_type_id numeric;
 v_array numeric[];
 v_entity_data jsonb[];
 i numeric;
 j numeric;
v_series numeric;
v_count numeric:=0;
v_counter numeric:=0;
p_out_json1 jsonb;
v_arraycount numeric;
k numeric;
v_iterate numeric;
 BEGIN
 
 select p_json->'data'->>'ref_id' into v_ref_category_ids;
 --select p_json->'data'->>'languages_id' into v_language_id2;
 select p_json->'data'->>'asset_type_id' into v_asset_type_id;
 
 
--  insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-entity-details','logs',uuid_generate_v4(),p_json,current_timestamp,'labwis','logs');
 
 --v_language_array:= (string_to_array(lower(COALESCE(v_language_id1,v_language_id2)),','))::numeric[];
 select string_to_array(v_ref_category_ids, ',')::int[] into v_array;
--raise notice 'v_language_array %',v_language_array;
--raise notice 'v_language_array %',v_language_array;

			for j in (select * from unnest(v_array)) 
			loop

					if exists(select 1 from labwis.labwis_entity_role_map where entity_role_id=6 and ref_category_ids @> array[j]) then

							v_series:=1;
							
						end if;	

			end loop;
			
			v_iterate := 0;
			
			for k in (select * from unnest(v_array)) 
			loop

					if exists(select 1 from labwis.labwis_entity_role_map where entity_role_id=1 and ref_category_ids @> array[k]) then

							v_iterate:= v_iterate + 1;
							
						end if;	

			end loop;
	raise notice 'v_iterate %',v_iterate;
	if v_iterate > 1 then
	
		v_array:= array_remove(v_array::int[],255);
		
	end if;
	
			raise notice 'v_series %',v_series;

	--raise notice 'v_array %',v_array;
	
for i in (select * from unnest(v_array)) 
		loop
		
	if exists(select 1 from labwis.labwis_entity_role_map where ref_category_ids::numeric[] @> array[i]) then
	
		if (v_series=1) then

			v_counter := v_counter + 1; 

		if v_counter = 1 then
--raise notice '1';
				select json_agg(x)
					from (select 
					 em.entity_name as name,
					 case when erm.entity_role_id=2 then 1 else 0 end as is_lang,
					case when ast.entity_role_id in (6) then 1 when ast.entity_role_id=1 then 2 else 0 end as priority,	  
					 1 as is_linkable,
					 1 as is_visible,
					 em.canonical_url as canonical,
					 em.entity_name as ent_disp_name,
					 est.entity_type_id,
					 est.entity_type_name,
					 erm.source_object_id,
					 erm.entity_role_map_id
					 from  labwis.labwis_entity_master em
					 join  labwis.labwis_entity_role_map  erm
					 on (em.entity_master_id = erm.entity_master_id)
					 join labwis.labwis_asset_type ast	  
					 on ast.entity_role_id=erm.entity_role_id	
					 join labwis.labwis_entity_role er
					 on er.entity_role_id=erm.entity_role_id
					 join labwis.labwis_entity_type est 	
					 on est.entity_type_id=er.entity_type_id
					 where erm.ref_category_ids::numeric[] @> array[i]
					 --(select unnest (v_language_array))
					 --and ast.asset_type_id = v_asset_type_id 
					 )x
					  into p_out_json;
					--raise notice 'p_out_json %',p_out_json;

			else 
--raise notice '2';
			select row_to_json(x)
					from (select 
					 em.entity_name as name,
					 case when erm.entity_role_id=2 then 1 else 0 end as is_lang,
					case when ast.entity_role_id in (6) then 1 when ast.entity_role_id=1 then 2 else 0 end as priority,	  
					 1 as is_linkable,
					 1 as is_visible,
					 em.canonical_url as canonical,
					 em.entity_name as ent_disp_name,
					 est.entity_type_id,
					 est.entity_type_name,
					 erm.source_object_id,
					 erm.entity_role_map_id
					 from  labwis.labwis_entity_master em
					 join  labwis.labwis_entity_role_map  erm
					 on (em.entity_master_id = erm.entity_master_id)
					 join labwis.labwis_asset_type ast	  
					 on ast.entity_role_id=erm.entity_role_id	
					 join labwis.labwis_entity_role er
					 on er.entity_role_id=erm.entity_role_id
					 join labwis.labwis_entity_type est 	
					 on est.entity_type_id=er.entity_type_id
					 where erm.ref_category_ids::numeric[] @> array[i]
					 --(select unnest (v_language_array))
					 --and ast.asset_type_id = v_asset_type_id 
					 )x
					  into p_out_json1;

				if 	p_out_json1 is not null then

					  p_out_json := p_out_json || p_out_json1;

				end if;	  
			end if;
-- 		if (p_out_json is not null) then
-- 		  	v_entity_data:= array_to_json(v_entity_data::jsonb[]);		  
-- 		  end if;
		  
		--raise notice 'p_out_json %',p_out_json;

else

 --raise notice 'v_arraycount123456 %',i;

		v_count:=v_count+1;
		v_counter := v_counter + 1; 

 
if v_counter = 1 then

		  
--raise notice 'p_out_json %',p_out_json;
				select json_agg(x)
					from (select 
					 em.entity_name as name,
					 case when erm.entity_role_id=2 then 1 else 0 end as is_lang,
					case when ast.entity_role_id in (6) then 1 when ast.entity_role_id=1 then 2 else 0 end as priority,	  
					 1 as is_linkable,
					 1 as is_visible,
					 em.canonical_url as canonical,
					 em.entity_name as ent_disp_name,
					 est.entity_type_id,
					 est.entity_type_name,
					 erm.source_object_id,
					 erm.entity_role_map_id
					 from  labwis.labwis_entity_master em
					 join  labwis.labwis_entity_role_map  erm
					 on (em.entity_master_id = erm.entity_master_id)
					 join labwis.labwis_asset_type ast	  
					 on ast.entity_role_id=erm.entity_role_id	
					 join labwis.labwis_entity_role er
					 on er.entity_role_id=erm.entity_role_id
					 join labwis.labwis_entity_type est 	
					 on est.entity_type_id=er.entity_type_id
					 where erm.ref_category_ids::numeric[] @> array[i]
					 --(select unnest (v_language_array))
					 --and ast.asset_type_id = v_asset_type_id 
					 )x
					  into p_out_json;
					  
					--raise notice 'p_out_json %',p_out_json;

			else 
			

			select row_to_json(x)
					from (select 
					 em.entity_name as name,
					 case when erm.entity_role_id=2 then 1 else 0 end as is_lang,
					case when ast.entity_role_id in (6) then 1 when ast.entity_role_id=1 then 2 else 0 end as priority,	  
					 1 as is_linkable,
					 1 as is_visible,
					 em.canonical_url as canonical,
					 em.entity_name as ent_disp_name,
					 est.entity_type_id,
					 est.entity_type_name,
					 erm.source_object_id,
					 erm.entity_role_map_id
					 from  labwis.labwis_entity_master em
					 join  labwis.labwis_entity_role_map  erm
					 on (em.entity_master_id = erm.entity_master_id)
					 join labwis.labwis_asset_type ast	  
					 on ast.entity_role_id=erm.entity_role_id	
					 join labwis.labwis_entity_role er
					 on er.entity_role_id=erm.entity_role_id
					 join labwis.labwis_entity_type est 	
					 on est.entity_type_id=er.entity_type_id
					 where erm.ref_category_ids::numeric[] @> array[i]
					 --(select unnest (v_language_array))
					 --and ast.asset_type_id = v_asset_type_id 
					 )x
					  into p_out_json1;
		--  raise notice 'v_arraycount %',i;
  
		if p_out_json1 is not null then
		
		  p_out_json := p_out_json || p_out_json1;
		  
		end if;  
end if;

end if;

	end if;

end loop;
	
	
	if v_series <> 1 or v_series is null then
	
		p_out_json := p_out_json || '{
        "name": "Generic",
        "is_lang": "0",
        "asset_id": null,
        "priority": "1",
        "canonical": "/wisden/tags/generic-190727",
        "is_visible": "1",
        "entity_code": null,
        "is_linkable": "1",
        "ent_disp_name": "Generic",
        "entity_role_map_id": "190727"
				}';
	
	end if;
--raise notice 'v_entity_data:%',v_entity_data;			  
		 ---raise notice 'v_language_array %',v_language_array; 
-- p_out_json:=v_entity_data;

--  insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'output-entity-details','logs',uuid_generate_v4(),p_out_json,current_timestamp,'labwis','logs');
 
 End;
 
$$;


--
