-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_get_regex_page_data_r()
-- Type: FUNCTION

-- Name: labmi_v1_get_regex_page_data_r(); Type: FUNCTION; Schema: labmi_v1_bkp; Owner: -
--

CREATE FUNCTION labmi_v1_bkp.labmi_v1_get_regex_page_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare

begin

select json_agg(x) from
(select page_id,alias,asset_type_id,title,meta_info
 from labmi_v1.labmi_v1_page
where meta_info->>'is_regex'='1' and is_published=1)x 
into p_json;
 

end;
$_$;


--
