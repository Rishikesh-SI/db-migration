-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: atom_delete(uuid, uuid)
-- Type: FUNCTION

-- Name: atom_delete(uuid, uuid); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.atom_delete(_json_id uuid, _deleted_by uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE lb_wf.atoms
    SET is_deleted = TRUE,
        deleted_at = NOW(),
        deleted_by = _deleted_by
    WHERE json_id = _json_id AND is_deleted = FALSE;

    RETURN FOUND;
END;
$$;


--
