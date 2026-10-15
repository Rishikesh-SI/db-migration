-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_get_visual_stories_list()
-- Type: FUNCTION

-- Name: labgrl_get_visual_stories_list(); Type: FUNCTION; Schema: labgrl; Owner: -
--

CREATE FUNCTION labgrl.labgrl_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from labgrl.labgrl_visual_stories ) tab
;
end ;

$$;


--
