-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: labkkr_get_visual_stories_list()
-- Type: FUNCTION

-- Name: labkkr_get_visual_stories_list(); Type: FUNCTION; Schema: labkkr_beta; Owner: -
--

CREATE FUNCTION labkkr_beta.labkkr_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from labkkr.labkkr_visual_stories ) tab
;
end ;

$$;


--
