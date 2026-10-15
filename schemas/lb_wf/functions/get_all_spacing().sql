-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: get_all_spacing()
-- Type: FUNCTION

-- Name: get_all_spacing(); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.get_all_spacing() RETURNS TABLE(id integer, token text, value integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        spacing.id,
        spacing.token,
        spacing.value
    FROM lb_wf.spacing WHERE spacing.is_deleted = FALSE;
END;
$$;


--
