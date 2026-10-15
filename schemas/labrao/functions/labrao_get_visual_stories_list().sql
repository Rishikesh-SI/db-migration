-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_get_visual_stories_list()
-- Type: FUNCTION

-- Name: labrao_get_visual_stories_list(); Type: FUNCTION; Schema: labrao; Owner: -
--

CREATE FUNCTION labrao.labrao_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from labrao.labrao_visual_stories ) tab
;
end ;

$$;


--
