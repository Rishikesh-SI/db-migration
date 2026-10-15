-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_get_regex_page_data_r()
-- Type: FUNCTION

-- Name: labisl_v1_get_regex_page_data_r(); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_get_regex_page_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare

begin

select json_agg(x) from
(select page_id,alias,asset_type_id,title,meta_info
 from labisl_v1.labisl_v1_page
where meta_info->>'is_regex'='1' and is_published = 1)x
into p_json;
 

end;
$_$;


--
