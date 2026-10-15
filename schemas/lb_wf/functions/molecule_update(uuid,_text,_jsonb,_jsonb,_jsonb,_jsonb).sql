-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecule_update(uuid, text, jsonb, jsonb, jsonb, jsonb)
-- Type: FUNCTION

-- Name: molecule_update(uuid, text, jsonb, jsonb, jsonb, jsonb); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.molecule_update(_json_id uuid, _name text DEFAULT NULL::text, _properties jsonb DEFAULT NULL::jsonb, _styles jsonb DEFAULT NULL::jsonb, _additional_config jsonb DEFAULT NULL::jsonb, _token_overrides jsonb DEFAULT NULL::jsonb) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE lb_wf.molecules
    SET 
        name = COALESCE(_name, name),
        properties = COALESCE(_properties, properties),
        styles = COALESCE(_styles, styles),
        additional_config = COALESCE(_additional_config, additional_config),
        token_overrides = COALESCE(_token_overrides, token_overrides),
        updated_at = NOW()
    WHERE json_id = _json_id;

    RETURN FOUND;
END;
$$;


--
