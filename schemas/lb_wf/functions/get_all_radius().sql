-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: get_all_radius()
-- Type: FUNCTION

-- Name: get_all_radius(); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.get_all_radius() RETURNS TABLE(id integer, token text, value integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        radius.id,
        radius.token,
        radius.value
    FROM lb_wf.radius WHERE radius.is_deleted = FALSE;
END;
$$;


--
