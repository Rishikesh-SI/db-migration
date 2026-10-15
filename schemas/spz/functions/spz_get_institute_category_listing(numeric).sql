-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_institute_category_listing(numeric)
-- Type: FUNCTION

-- Name: spz_get_institute_category_listing(numeric); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_institute_category_listing(p_sport_id numeric, OUT p_instcategory_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	select ('{"institute_category":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb 
    into p_instcategory_json
	from (select i.institute_category_id, i.category_name, i.parent_id , sc.sport_entity_role_map_id, 
                 r.source_object_id sport_id          
          from spz.spz_institute_category i 
          inner join spz.spz_sport_category_map sc 
          on (i.institute_category_id = sc.institute_category_id)
          inner join spz.spz_entity_role_map r 
          on (r.entity_role_map_id = sc.sport_entity_role_map_id)
          where  r.source_object_id = (case when coalesce(p_sport_id::text,'0') != '0' then  p_sport_id::text else r.source_object_id end)
          order by 1
         )row;
end;

$$;


--
