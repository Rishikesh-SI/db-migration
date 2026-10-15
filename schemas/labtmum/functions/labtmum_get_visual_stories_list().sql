-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: labtmum_get_visual_stories_list()
-- Type: FUNCTION

-- Name: labtmum_get_visual_stories_list(); Type: FUNCTION; Schema: labtmum; Owner: -
--

CREATE FUNCTION labtmum.labtmum_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from labtmum.labtmum_visual_stories ) tab
;
end ;

$$;


--
