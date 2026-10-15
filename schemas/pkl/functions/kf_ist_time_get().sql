-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: kf_ist_time_get()
-- Type: FUNCTION

-- Name: kf_ist_time_get(); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.kf_ist_time_get(OUT p_ist_time timestamp without time zone) RETURNS timestamp without time zone
    LANGUAGE plpgsql
    AS $$

DECLARE 

BEGIN

SELECT CURRENT_TIMESTAMP +CAST('0 MINUTE' AS INTERVAL)
INTO   P_IST_TIME;

END;

$$;


--
