-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: fetch_molecules_for_atom(uuid)
-- Type: FUNCTION

-- Name: fetch_molecules_for_atom(uuid); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.fetch_molecules_for_atom(_atom_json_id uuid) RETURNS TABLE(molecule_json_id uuid, molecule_name text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT m.json_id, m.name
    FROM lb_wf.molecules m
    JOIN lb_wf.molecule_atom_map mam ON m.json_id = mam.molecule_json_id
    WHERE ma.atom_json_id = _atom_json_id AND m.is_deleted = FALSE;
END;
$$;


--
