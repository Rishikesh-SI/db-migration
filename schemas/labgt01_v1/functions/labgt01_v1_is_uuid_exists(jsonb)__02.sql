-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_is_uuid_exists(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_is_uuid_exists(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_is_uuid_exists(p_uuid jsonb, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_uuid character varying;
    v_exists_count numeric;
BEGIN
    -- Extract uuid from input JSON
    SELECT p_uuid->>'uuid'
    INTO v_uuid;

    IF v_uuid IS NULL OR v_uuid = '' THEN
        p_result := False;
    ELSE
        SELECT COUNT(1)
        FROM labgt01_v1.labgt01_v1_uuid_storage
        WHERE uuid = v_uuid
        INTO v_exists_count;

        p_result := (v_exists_count > 0);
    END IF;
END;
$$;


--
