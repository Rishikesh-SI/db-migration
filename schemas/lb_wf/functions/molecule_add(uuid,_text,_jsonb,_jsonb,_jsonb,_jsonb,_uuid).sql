-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecule_add(uuid, text, jsonb, jsonb, jsonb, jsonb, uuid)
-- Type: FUNCTION

-- Name: molecule_add(uuid, text, jsonb, jsonb, jsonb, jsonb, uuid); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.molecule_add(_json_id uuid, _name text, _properties jsonb, _styles jsonb, _additional_config jsonb DEFAULT '{}'::jsonb, _token_overrides jsonb DEFAULT '{}'::jsonb, _created_by uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    molecule_id UUID;
BEGIN
    INSERT INTO lb_wf.molecules (json_id, name, properties, styles, additional_config, token_overrides, created_by, updated_by)
    VALUES (_json_id, _name, _properties, _styles, _additional_config, _token_overrides, _created_by, '00000000-0000-0000-0000-000000000000')
    RETURNING json_id INTO molecule_id;

    RETURN molecule_id;
END;
$$;


--
