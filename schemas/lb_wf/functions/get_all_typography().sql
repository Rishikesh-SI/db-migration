-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: get_all_typography()
-- Type: FUNCTION

-- Name: get_all_typography(); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.get_all_typography() RETURNS TABLE(id integer, token text, device text, size integer, line_height integer, weight text, typeface text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        typography.id,
        typography.token,
        typography.device,
        typography.size,
        typography.line_height,
        typography.weight,
        typography.typeface
    FROM lb_wf.typography WHERE is_deleted = FALSE;
END;
$$;


--
