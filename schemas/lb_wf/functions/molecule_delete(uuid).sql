-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecule_delete(uuid)
-- Type: FUNCTION

-- Name: molecule_delete(uuid); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.molecule_delete(_json_id uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE lb_wf.molecules
    SET is_deleted = TRUE, deleted_at = NOW()
    WHERE json_id = _json_id;

    RETURN FOUND;
END;
$$;


--
