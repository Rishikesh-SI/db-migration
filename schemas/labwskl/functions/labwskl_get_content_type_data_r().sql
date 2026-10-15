-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_get_content_type_data_r()
-- Type: FUNCTION

-- Name: labwskl_get_content_type_data_r(); Type: FUNCTION; Schema: labwskl; Owner: -
--

CREATE FUNCTION labwskl.labwskl_get_content_type_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 

select '{"items":' || json_agg(row_to_json(t)) || '}'
from (
  select asset_type_id,title,is_content_type from labwskl.labwskl_asset_type where is_content_type=1
) t into p_json;

end ;
$$;


--
