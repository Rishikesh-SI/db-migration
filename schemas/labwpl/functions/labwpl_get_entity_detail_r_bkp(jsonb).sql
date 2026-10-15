-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_get_entity_detail_r_bkp(jsonb)
-- Type: FUNCTION

-- Name: labwpl_get_entity_detail_r_bkp(jsonb); Type: FUNCTION; Schema: labwpl; Owner: -
--

CREATE FUNCTION labwpl.labwpl_get_entity_detail_r_bkp(p_entity jsonb, OUT p_result numeric, OUT p_entityjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_entity numeric;
v_entity_role_map_id jsonb;
--v_entity_array  character varying[];
--v_entity_name character varying;
p_entityjson1 jsonb;
p_entityjson2 jsonb[];
i numeric;
begin
/*
select * from labwpl.labwpl_get_entity_detail_r_bkp('{"data":[
  1,
  18,
  4
]}')
*/

--select p_entity->'data'->>'entityids' into v_entity_role_map_id;
select p_entity->>'data' into v_entity_role_map_id;

--v_entity_array:=(SELECT string_to_array(v_entity_role_map_id,','));
--raise notice'v_entity_array:%',v_entity_array;
--(select entity_role_mapid from unnest(p_entityrole_mapid) U(entity_role_mapid)

--foreach i in array v_entity_role_map_id 
for v_entity in select * from jsonb_array_elements(v_entity_role_map_id)
--for v_entity in (select entity_role_id from unnest(v_entity_array) U(entity_role_id))
	loop

		raise notice'v_entity:%',v_entity;		
	

				if v_entity is not null then

				 select row_to_json(row_alias)
				 from 
					(select A.canonical_url,B.entity_role_map_id, B.source_object_id,B.priority,A.entity_display_name,
					 D.entity_type_name,D.entity_type_id,A.entity_name as name,
					 a.priority,case when b.entity_role_id = 2 then 1 else 0 end as is_lang
					from labwpl.labwpl_entity_master A
					join labwpl.labwpl_entity_role_map B
					on A.entity_master_id=B.entity_master_id
					join labwpl.labwpl_entity_role C
					on B.entity_role_id=C.entity_role_id
					join labwpl.labwpl_entity_type D
					on C.entity_type_id=D.entity_type_id
					--join labwpl.labwpl_asset_type F
					--on C.entity_role_id=F.entity_role_id 
					where B.entity_role_map_id =v_entity 
					and A.is_deleted=0
					and A.is_active=1
					and B.is_active=1)
					 row_alias
					into p_entityjson1;
                    
                    if p_entityjson1 is null then
                    
                    p_entityjson1:='{}';
                    
                    end if;
                    --raise notice'p_entityjson1:%',p_entityjson1;	
					p_entityjson2:= p_entityjson2 || p_entityjson1::jsonb ;
				
				else

					select json_agg(row_alias)
			   from 
						(select A.canonical_url,B.entity_role_map_id, B.source_object_id,B.priority,A.entity_display_name,
						 D.entity_type_name,D.entity_type_id,A.entity_name as name,
						 a.priority,case when b.entity_role_id = 2 then 1 else 0 end as is_lang

						 --,F.group_name,,A.entity_master_id
						from labwpl.labwpl_entity_master A
						join labwpl.labwpl_entity_role_map B
						on A.entity_master_id=B.entity_master_id
						join labwpl.labwpl_entity_role C
						on B.entity_role_id=C.entity_role_id
						join labwpl.labwpl_entity_type D
						on C.entity_type_id=D.entity_type_id
						--join labwpl.labwpl_entity_group F
						--on C.entity_group_id=F.entity_group_id 
						where A.is_deleted=0
						and A.is_active=1
						and B.is_active=1)
						 row_alias
						into p_entityjson  ;
		
		
				end if;

				
	end loop;

--select entity_role_id into v_entity_role_map_id from labwpl.labwpl_asset_type
--where asset_type_id = v_asset_type_id;

				--raise notice 'p_entityjson2 %',p_entityjson2;
				p_entityjson:=to_jsonb(p_entityjson2);
				
--select * from alabwpl;

p_result:=1;

end;
$$;


--
