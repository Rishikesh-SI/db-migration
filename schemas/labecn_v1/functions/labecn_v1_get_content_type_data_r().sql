-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_get_content_type_data_r()
-- Type: FUNCTION

-- Name: labecn_v1_get_content_type_data_r(); Type: FUNCTION; Schema: labecn_v1; Owner: -
--

CREATE FUNCTION labecn_v1.labecn_v1_get_content_type_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 

select '{"items":' || json_agg(row_to_json(t)) || '}'
from (
  select asset_type_id,title,is_content_type from labecn_v1.labecn_v1_asset_type where is_content_type=1
) t into p_json;

end ;
$$;


--
