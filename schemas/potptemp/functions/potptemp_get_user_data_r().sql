-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: potptemp
-- Object: potptemp_get_user_data_r()
-- Type: FUNCTION

-- Name: potptemp_get_user_data_r(); Type: FUNCTION; Schema: potptemp; Owner: -
--

CREATE FUNCTION potptemp.potptemp_get_user_data_r(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

begin
select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb into p_user_data
from (select datajson->'data'->'user_info'->>'name_of_school_representative' as name_of_school_representative,
       datajson->'data'->'user_info'->>'email_id' as email_id,
	    datajson->'data'->'user_info'->>'contact_number' as contact_number,
		datajson->'data'->>'school_name' as school_name,
		datajson->'data'->>'school_code' as school_code,
		datajson->'data'->>'state' as state
from potptemp.potptemp_custom_web_json) row;

end ;

$$;


--
