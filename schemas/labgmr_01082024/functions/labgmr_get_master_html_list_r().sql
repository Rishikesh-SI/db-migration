-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_get_master_html_list_r()
-- Type: FUNCTION

-- Name: labgmr_get_master_html_list_r(); Type: FUNCTION; Schema: labgmr_01082024; Owner: -
--

CREATE FUNCTION labgmr_01082024.labgmr_get_master_html_list_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 

select json_agg(row_to_json(t))
from (
  select template_id,template_name from labgmr.labgmr_template where is_master=1 and is_deleted=0 and is_active=1
) t into p_json;

end ;
$$;


--
