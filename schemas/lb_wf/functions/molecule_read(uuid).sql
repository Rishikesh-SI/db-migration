-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecule_read(uuid)
-- Type: FUNCTION

-- Name: molecule_read(uuid); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.molecule_read(_json_id uuid) RETURNS TABLE(id integer, json_id uuid, name text, properties jsonb, styles jsonb, additional_config jsonb, token_overrides jsonb, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        molecules.id, 
        molecules.json_id, 
        molecules.name, 
        molecules.properties, 
        molecules.styles, 
        molecules.additional_config, 
        molecules.token_overrides, 
        molecules.created_at, 
        molecules.updated_at
    FROM lb_wf.molecules AS molecules
    WHERE molecules.json_id = _json_id  AND molecules.is_deleted = FALSE;
END;
$$;


--
