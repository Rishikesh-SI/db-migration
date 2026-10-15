-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_get_content_type_data_r()
-- Type: FUNCTION

-- Name: labetpl_get_content_type_data_r(); Type: FUNCTION; Schema: labetpl; Owner: -
--

CREATE FUNCTION labetpl.labetpl_get_content_type_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 

select '{"items":' || json_agg(row_to_json(t)) || '}'
from (
  select asset_type_id,title,is_content_type from labetpl.labetpl_asset_type where is_content_type=1
) t into p_json;

end ;
$$;


--
