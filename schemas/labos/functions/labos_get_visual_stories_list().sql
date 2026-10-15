-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_get_visual_stories_list()
-- Type: FUNCTION

-- Name: labos_get_visual_stories_list(); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from labos.labos_visual_stories ) tab
;
end ;

$$;


--
