-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_delete_otp()
-- Type: FUNCTION

-- Name: labisl_v1_delete_otp(); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_delete_otp(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare

v_day timestamp:= current_timestamp::date at time zone 'utc' - '3 day'::interval;
--v_current_timestamp:= current_timestamp::date at time zone 'utc';
begin

delete from labisl_v1.labisl_v1_otp_details where created_date::date<=v_day;	
	
end;

$$;


--
