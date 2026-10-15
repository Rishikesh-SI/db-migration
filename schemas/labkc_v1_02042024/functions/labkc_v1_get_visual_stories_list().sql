-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_get_visual_stories_list()
-- Type: FUNCTION

-- Name: labkc_v1_get_visual_stories_list(); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_get_visual_stories_list(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin

select '{"data":['||string_agg(row_to_json(tab)::text,',')||']}' into p_json
from (
select id as phototypeid,name as phototypename from labkc_v1.labkc_v1_visual_stories ) tab
;
end ;

$$;


--
