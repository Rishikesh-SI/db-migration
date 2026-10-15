-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_get_visual_stories_list()
-- Type: FUNCTION

-- Name: labw88_get_visual_stories_list(); Type: FUNCTION; Schema: labw88; Owner: -
--

CREATE FUNCTION labw88.labw88_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from labw88.labw88_visual_stories ) tab
;
end ;

$$;


--
