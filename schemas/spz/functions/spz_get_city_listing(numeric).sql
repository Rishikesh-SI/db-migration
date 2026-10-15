-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_city_listing(numeric)
-- Type: FUNCTION

-- Name: spz_get_city_listing(numeric); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_city_listing(p_season_id numeric, OUT p_city_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin

 

	select ('{"cities":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb 
    into p_city_json
	from (
          select 0 city_id,'All Cities' city_name, 922 entity_role_map_id, 19::text source_object_id, null::numeric state_id, null::text state_name, 1 srno  
          union 
          select m.city_id, m.city_name, r.entity_role_map_id, r.source_object_id, m.state_id, S.state_name , 2 srno
          from spz.spz_city_master m
          left join spz.spz_entity_role_map r 
          on (m.city_id::text = r.source_object_id)
          left join spz.spz_entity_role er
          on (er.entity_role_id = r.entity_role_id)
          left join spz.spz_entity_type t 
          on (er.entity_type_id = t.entity_type_id)	
          left join spz.spz_state_master S 
          on (m.state_id = S.state_id)
          where t.entity_type_name = 'City' 
		  and  exists (
                    select 1 from (
                    select asset_id,asset_type_id,entity_role_map_id from spz.spz_asset_entity_map
                    where asset_id in (
                    select distinct asset_id from spz.spz_asset_entity_map
                    where entity_role_map_id=(case when coalesce(p_season_id,0) != 0 then  p_season_id else r.entity_role_map_id end))
                     )a
                     where entity_role_map_id=r.entity_role_map_id
                     ) 		
		 order by srno, city_name
         )row;
end;

$$;


--
