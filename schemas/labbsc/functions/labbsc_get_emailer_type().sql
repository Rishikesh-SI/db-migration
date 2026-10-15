-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_emailer_type()
-- Type: FUNCTION

-- Name: labbsc_get_emailer_type(); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_emailer_type(OUT p_emailer_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
----(''{"data":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
 execute 'select (''{"data":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
from (select emailer_type_id,emailer_name,number_of_records
	 from labbsc.labbsc_emailer_type
	 where is_active=1) row'
	 into p_emailer_json;

end;

$$;


--
