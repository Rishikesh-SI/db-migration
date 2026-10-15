-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_entitydata_r(jsonb)
-- Type: FUNCTION

-- Name: labuww_get_entitydata_r(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_entitydata_r(p_entity jsonb, OUT p_result numeric, OUT p_entityjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_entity character varying[];
v_entity1 character varying;
v_entity2 character varying;
v_entity_role_id numeric;
v_asset_type_id numeric;
begin

select p_entity->>'entity_names',
      -- p_entity->>'asset_type_id',
	   p_entity->>'entity_role_id'
	into v_entity1,
	   --  v_asset_type_id,
	   v_entity_role_id
	   ;

-- v_entity2:= regexp_replace(v_entity1, '[\s+]', '', 'g');
 
raise notice 'v_entity2 % ',v_entity2;

v_entity:=(SELECT  string_to_array(lower(v_entity1),','));

--raise notice 'v_entity % ',v_entity;

--select entity_role_id into v_entity_role_id from labuww.labuww_asset_type
--where asset_type_id = v_asset_type_id;

if v_entity_role_id is not null then

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
				where lower(A.entity_name) in (select entity_name from unnest( v_entity)entity_name)
				and B.entity_role_id = v_entity_role_id 
				and A.is_deleted=0
				and A.is_active=1
				and B.is_active=1)
				 row_alias
				into p_entityjson  ;
				
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
				where lower(A.entity_name) in (select entity_name from unnest( v_entity)entity_name)
				and A.is_deleted=0
				and A.is_active=1
				and B.is_active=1)
				 row_alias
				into p_entityjson  ;
		
		
		end if;

--raise notice 'p_entityjson % ',p_entityjson;

--select * from alabuww;

p_result:=1;

end;
$$;


--
