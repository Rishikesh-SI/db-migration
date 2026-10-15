-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_entity_detail_r(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_entity_detail_r(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_entity_detail_r(p_entity jsonb, OUT p_result numeric, OUT p_entityjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_entity numeric;
v_entity_role_id jsonb;
v_entity_array  character varying[];
v_entity_name character varying;
p_entityjson1 jsonb;
p_entityjson2 jsonb[] ;
i numeric;
p_entity_arr int[];
v_generic_video numeric;
begin

select p_entity->>'data' into v_entity_role_id;

select array_agg(elem)::int[] from jsonb_array_elements(v_entity_role_id) as elem into p_entity_arr;

--Login Video and Protected not present and generic video is present
if not (p_entity_arr::int[] && ARRAY[4287, 4407]) and 4327 = any(p_entity_arr) then 
   v_generic_video:=1;
end if;

--v_entity_array:=(SELECT string_to_array(v_entity_role_id,','));

--raise notice'v_entity_role_id:%',v_entity_role_id;

--(select entity_role_mapid from unnest(p_entityrole_mapid) U(entity_role_mapid)
--foreach i in array v_entity_role_id
for v_entity in (select * from jsonb_array_elements(v_entity_role_id))
	loop

		--raise notice'i:%',i;	
		
		raise notice'v_entity:%',v_entity;
		
				if v_entity is not null then

				 select row_to_json(row_alias)
				 from 
					(
					select A.canonical_url,B.entity_role_map_id, B.source_object_id,A.entity_display_name,
					 D.entity_type_name,D.entity_type_id,A.entity_name as name,
					 case when a.entity_name in ('Login Video','Protected') then 1 
					 when b.entity_role_id = 1 then 2
                     when v_generic_video=1 and a.entity_name in ('Generic Video') then 1
					 else 0 end as priority,
					 case when b.entity_role_id = 2 then 1 else 0 end as is_lang
					from labrr.labrr_entity_master A
					join labrr.labrr_entity_role_map B
					on A.entity_master_id=B.entity_master_id
					join labrr.labrr_entity_role C
					on B.entity_role_id=C.entity_role_id
					join labrr.labrr_entity_type D
					on C.entity_type_id=D.entity_type_id
					--join labrr.labrr_asset_type F
					--on C.entity_role_id=F.entity_role_id 
					where B.entity_role_map_id =v_entity
					and A.is_deleted=0
					and A.is_active=1
					and B.is_active=1)
					 row_alias
					into p_entityjson1;
                    
                    raise notice'p_entityjson1:%',p_entityjson1;
                    
                    if p_entityjson1=null then
                    raise notice'p_entityjson1:%',p_entityjson1;
                    p_entityjson1:='{}';
                    end if;
					
					p_entityjson2:= p_entityjson2 || p_entityjson1::jsonb ;
				
				else

					select json_agg(row_alias)
			   from 
						(select A.canonical_url,B.entity_role_map_id, B.source_object_id,A.entity_display_name,
						 D.entity_type_name,D.entity_type_id,A.entity_name as name,
						 case when a.entity_name in ('Login Video','Protected') then 1 
						 when b.entity_role_id = 1 then 2 
                         when v_generic_video=1 and a.entity_name in ('Generic Video') then 1
                         else 0 end as priority,
						 case when b.entity_role_id = 2 then 1 else 0 end as is_lang

						 --,F.group_name,,A.entity_master_id
						from labrr.labrr_entity_master A
						join labrr.labrr_entity_role_map B
						on A.entity_master_id=B.entity_master_id
						join labrr.labrr_entity_role C
						on B.entity_role_id=C.entity_role_id
						join labrr.labrr_entity_type D
						on C.entity_type_id=D.entity_type_id
						--join labrr.labrr_entity_group F
						--on C.entity_group_id=F.entity_group_id 
						where A.is_deleted=0
						and A.is_active=1
						and B.is_active=1)
						 row_alias
						into p_entityjson  ;
		
		
				end if;

				
	end loop;

--select entity_role_id into v_entity_role_id from labrr.labrr_asset_type
--where asset_type_id = v_asset_type_id;

				--raise notice 'p_entityjson2 %',p_entityjson2;
				p_entityjson:=to_jsonb(p_entityjson2);
				
--select * from alabrr;

p_result:=1;

end;
$$;


--
