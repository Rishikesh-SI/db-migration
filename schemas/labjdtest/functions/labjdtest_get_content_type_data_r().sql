-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_get_content_type_data_r()
-- Type: FUNCTION

-- Name: labjdtest_get_content_type_data_r(); Type: FUNCTION; Schema: labjdtest; Owner: -
--

CREATE FUNCTION labjdtest.labjdtest_get_content_type_data_r(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin 

select '{"items":' || json_agg(row_to_json(t)) || '}'
from (
  select asset_type_id,title,is_content_type from labJDTEST.labJDTEST_asset_type where is_content_type=1
) t into p_json;

end ;
$$;


--
