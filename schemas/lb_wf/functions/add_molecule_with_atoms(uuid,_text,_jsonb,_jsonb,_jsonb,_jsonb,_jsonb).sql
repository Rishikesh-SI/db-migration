-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: add_molecule_with_atoms(uuid, text, jsonb, jsonb, jsonb, jsonb, jsonb)
-- Type: FUNCTION

-- Name: add_molecule_with_atoms(uuid, text, jsonb, jsonb, jsonb, jsonb, jsonb); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.add_molecule_with_atoms(_json_id uuid, _name text, _properties jsonb, _styles jsonb, _additional_config jsonb, _token_overrides jsonb, _atoms jsonb) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    atom JSONB;
    atom_id UUID;
    atom_name TEXT;
    atom_visibility BOOLEAN;
BEGIN
    -- Check if molecule JSON ID already exists
    IF EXISTS (SELECT 1 FROM lb_wf.molecules WHERE json_id = _json_id) THEN
        RETURN 'Error: Molecule with the given JSON ID already exists.';
    END IF;

    -- Check if all atom IDs exist in the atoms table
    FOR atom IN SELECT * FROM jsonb_array_elements(_atoms)
    LOOP
        atom_id := atom->>'id';
        atom_name := atom->>'name';
        atom_visibility := (atom->>'visibility')::BOOLEAN;

        IF NOT EXISTS (SELECT 1 FROM lb_wf.atoms WHERE json_id = atom_id) THEN
            RETURN 'Error: Atom with JSON ID ' || atom_id || ' does not exist.';
        END IF;
    END LOOP;

    -- Begin transaction
    BEGIN
        -- Insert data into molecules table
        INSERT INTO lb_wf.molecules (
            json_id, name, properties, styles, additional_config, token_overrides
        ) VALUES (
            _json_id, _name, _properties, _styles, _additional_config, _token_overrides
        );

        -- Insert atom mappings into molecule_atom_map table
        FOR atom IN SELECT * FROM jsonb_array_elements(_atoms)
        LOOP
            atom_id := atom->>'id';
            atom_name := atom->>'name';
            atom_visibility := (atom->>'visibility')::BOOLEAN;

            INSERT INTO lb_wf.molecule_atom_map (
                molecule_json_id, atom_json_id, atom_name, visibility
            ) VALUES (
                _json_id, atom_id, atom_name, atom_visibility
            );
        END LOOP;

        RETURN 'Success: Molecule and atoms inserted successfully.';
    EXCEPTION
        WHEN OTHERS THEN
            -- Rollback transaction in case of any error
            RAISE EXCEPTION 'Error occurred: %', SQLERRM;
    END;
END;
$$;


--
