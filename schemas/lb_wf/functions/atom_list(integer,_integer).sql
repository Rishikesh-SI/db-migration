-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: atom_list(integer, integer)
-- Type: FUNCTION

-- Name: atom_list(integer, integer); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.atom_list(_page integer, _page_size integer) RETURNS TABLE(json_id uuid, atom_type text, created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
DECLARE
    _offset INT;
BEGIN
    -- Calculate the offset based on the page number and page size
    _offset := (_page - 1) * _page_size;

    RETURN QUERY
    SELECT json_id, atom_type, created_at
    FROM lb_wf.atoms
    WHERE is_deleted = FALSE
    ORDER BY created_at DESC
    LIMIT _page_size OFFSET _offset;
END;
$$;


--
