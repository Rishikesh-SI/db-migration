-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: labkiyg_get_visual_stories_list()
-- Type: FUNCTION

-- Name: labkiyg_get_visual_stories_list(); Type: FUNCTION; Schema: labkiyg; Owner: -
--

CREATE FUNCTION labkiyg.labkiyg_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from labkiyg.labkiyg_visual_stories ) tab
;
end ;

$$;


--
