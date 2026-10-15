-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: fetch_atoms_for_molecule(uuid)
-- Type: FUNCTION

-- Name: fetch_atoms_for_molecule(uuid); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.fetch_atoms_for_molecule(_molecule_json_id uuid) RETURNS TABLE(atom_json_id uuid, visibility boolean, order_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT ma.atom_json_id, ma.visibility, ma.order_id
    FROM lb_wf.molecule_atom_map mam
    WHERE mam.molecule_json_id = _molecule_json_id;
END;
$$;


--
