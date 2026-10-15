-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_sport_list()
-- Type: FUNCTION

-- Name: spz_get_sport_list(); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_sport_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 

declare 

begin
select '{"data":['||string_agg((row_to_json(row))::text,',')||']}'  from (
select b.entity_name ,
a.entity_role_map_id,
a.source_object_id,
b.canonical_url
from spz.spz_entity_role_map a
join spz.spz_entity_master b on a.entity_master_id=b.entity_master_id
where entity_role_id=10
order by a.source_object_id )row

into p_json

;

end

$$;


--
