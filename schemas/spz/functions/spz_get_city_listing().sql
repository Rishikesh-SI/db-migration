-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_city_listing()
-- Type: FUNCTION

-- Name: spz_get_city_listing(); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_city_listing(OUT p_city_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	select ('{"cities":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb 
    into p_city_json
	from (select 0 city_id,'All Cities' city_name, 922 entity_role_map_id,  null::text source_object_id 
          union 
          select m.* , r.entity_role_map_id, r.source_object_id  
          from spz.spz_city_master m
          left join spz.spz_entity_role_map r 
          on (m.city_id::text = r.source_object_id)
          left join spz.spz_entity_role er
          on (er.entity_role_id = r.entity_role_id)
          left join spz.spz_entity_type t 
          on (er.entity_type_id = t.entity_type_id)
          where t.entity_type_name = 'City' 
          order by 1
         )row;
end;

$$;


--
