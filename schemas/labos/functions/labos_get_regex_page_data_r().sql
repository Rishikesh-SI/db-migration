-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_get_regex_page_data_r()
-- Type: FUNCTION

-- Name: labos_get_regex_page_data_r(); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_get_regex_page_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare

begin

select json_agg(x) from
(select page_id,alias,asset_type_id,title,meta_info
 from labos.labos_page
where meta_info->>'is_regex'='1')x
into p_json;
 

end;
$_$;


--
