-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_get_master_html_list_r()
-- Type: FUNCTION

-- Name: labdsg_get_master_html_list_r(); Type: FUNCTION; Schema: labdsg; Owner: -
--

CREATE FUNCTION labdsg.labdsg_get_master_html_list_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 

select json_agg(row_to_json(t))
from (
  select template_id,template_name from labdsg.labdsg_template where is_master=1 and is_deleted=0 and is_active=1
) t into p_json;

end ;
$$;


--
