-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: get_all_colors()
-- Type: FUNCTION

-- Name: get_all_colors(); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.get_all_colors() RETURNS TABLE(id integer, token character varying, type character varying, mode character varying, hex_code character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        colors.id,
        colors.token::VARCHAR(255),
        colors.type::VARCHAR(255),
        colors.mode::VARCHAR(10),
        colors.hex_code::VARCHAR(7)
    FROM lb_wf.colors 
    WHERE colors.is_deleted = FALSE;
END;
$$;


--
