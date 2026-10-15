-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_get_regex_page_data_r()
-- Type: FUNCTION

-- Name: labgt01_v1_get_regex_page_data_r(); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_get_regex_page_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare

begin

select json_agg(x) from
(select page_id,alias,asset_type_id,title,meta_info
 from labgt01_v1.labgt01_v1_page
where meta_info->>'is_regex'='1' and is_published=1)x
into p_json;
 

end;
$_$;


--
