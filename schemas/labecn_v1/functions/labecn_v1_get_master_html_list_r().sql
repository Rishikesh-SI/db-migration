-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_get_master_html_list_r()
-- Type: FUNCTION

-- Name: labecn_v1_get_master_html_list_r(); Type: FUNCTION; Schema: labecn_v1; Owner: -
--

CREATE FUNCTION labecn_v1.labecn_v1_get_master_html_list_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 

select json_agg(row_to_json(t))
from (
  select template_id,template_name from labecn_v1.labecn_v1_template where is_master=1 and is_deleted=0 and is_active=1
) t into p_json;

end ;
$$;


--
