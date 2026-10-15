-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_master_html_list_r()
-- Type: FUNCTION

-- Name: labrstg_get_master_html_list_r(); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_master_html_list_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 

select json_agg(row_to_json(t))
from (
  select template_id,template_name from labrstg.labrstg_template where is_master=1 and is_deleted=0 and is_active=1
) t into p_json;

end ;
$$;


--
