-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_entity_detail_r_bkp(jsonb)
-- Type: FUNCTION

-- Name: labuww_get_entity_detail_r_bkp(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_entity_detail_r_bkp(p_entity jsonb, OUT p_result numeric, OUT p_entityjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_entity character varying[];
v_entity1 jsonb;
v_entity2 character varying;
v_entity_role_id numeric;
v_asset_type_id numeric;
v_entity_array jsonb;
v_entity_name character varying;
v_ref_id numeric;
v_ref_guid character varying;
p_entityjson1 jsonb;
p_entityjson2 jsonb[];
begin

select p_entity->>'data' into v_entity1;

for v_entity_array in select * from jsonb_array_elements(v_entity1)
	loop

		select v_entity_array->>'entity_name',
			   v_entity_array->>'ref_id',
			   v_entity_array->>'ref_guid',
			   v_entity_array->>'asset_type_id'
		into  
				v_entity_name,
				v_ref_id,
				v_ref_guid,
				v_asset_type_id;
				
				
				
		select entity_role_id
		into v_entity_role_id
		from labuww.labuww_asset_type
		where asset_type_id=v_asset_type_id;
		
		raise notice 'v_entity_role_id %',v_entity_role_id;

				if v_entity_role_id is not null then

				 select row_to_json(row_alias)
				 from 
					(select A.canonical_url,B.entity_role_map_id, B.source_object_id,B.priority,A.entity_display_name,
					 D.entity_type_name,D.entity_type_id,A.entity_name as name,
					 a.priority,case when b.entity_role_id = 2 then 1 else 0 end as is_lang
					from labuww.labuww_entity_master A
					join labuww.labuww_entity_role_map B
					on A.entity_master_id=B.entity_master_id
					join labuww.labuww_entity_role C
					on B.entity_role_id=C.entity_role_id
					join labuww.labuww_entity_type D
					on C.entity_type_id=D.entity_type_id
					join labuww.labuww_asset_type F
					on C.entity_role_id=F.entity_role_id 
					where B.entity_role_id = v_entity_role_id 
					and F.asset_type_id = v_asset_type_id 
					and B.ref_id=v_ref_id
					and A.is_deleted=0
					and A.is_active=1
					and B.is_active=1)
					 row_alias
					into p_entityjson1  ;

					p_entityjson2:= p_entityjson2 || p_entityjson1::jsonb ;
				
				else

					select json_agg(row_alias)
			   from 
						(select A.canonical_url,B.entity_role_map_id, B.source_object_id,B.priority,A.entity_display_name,
						 D.entity_type_name,D.entity_type_id,A.entity_name as name,
						 a.priority,case when b.entity_role_id = 2 then 1 else 0 end as is_lang

						 --,F.group_name,,A.entity_master_id
						from labuww.labuww_entity_master A
						join labuww.labuww_entity_role_map B
						on A.entity_master_id=B.entity_master_id
						join labuww.labuww_entity_role C
						on B.entity_role_id=C.entity_role_id
						join labuww.labuww_entity_type D
						on C.entity_type_id=D.entity_type_id
						--join labuww.labuww_entity_group F
						--on C.entity_group_id=F.entity_group_id 
						where lower(A.entity_name) = lower(v_entity_name)
						and A.is_deleted=0
						and A.is_active=1
						and B.is_active=1)
						 row_alias
						into p_entityjson  ;
		
		
				end if;

				
	end loop;

--select entity_role_id into v_entity_role_id from labuww.labuww_asset_type
--where asset_type_id = v_asset_type_id;

				raise notice 'p_entityjson2 %',p_entityjson2;
				p_entityjson:=to_jsonb(p_entityjson2);
				
--select * from alabuww;

p_result:=1;

end;
$$;


--
