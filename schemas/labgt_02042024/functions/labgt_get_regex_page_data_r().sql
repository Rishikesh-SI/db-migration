-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_get_regex_page_data_r()
-- Type: FUNCTION

-- Name: labgt_get_regex_page_data_r(); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_get_regex_page_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare

begin

select json_agg(x) from
(select page_id,alias,asset_type_id,title,meta_info
 from labgt.labgt_page
where meta_info->>'is_regex'='1' and is_published=1)x
into p_json;
 

end;
$_$;


--
