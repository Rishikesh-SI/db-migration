-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_get_visual_stories_list()
-- Type: FUNCTION

-- Name: upstox_get_visual_stories_list(); Type: FUNCTION; Schema: upstox; Owner: -
--

CREATE FUNCTION upstox.upstox_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from upstox.upstox_visual_stories ) tab
;
end ;

$$;


--
