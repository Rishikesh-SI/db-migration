-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_is_uuid_exists(text)
-- Type: FUNCTION

-- Name: labkc_v1_is_uuid_exists(text); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_is_uuid_exists(p_uuid text, OUT p_result boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_uuid character varying;
    v_exists_count numeric;
BEGIN
    -- Extract uuid from input JSON
    v_uuid := p_uuid;

    IF v_uuid IS NULL OR v_uuid = '' THEN
        p_result := False;
    ELSE
        SELECT COUNT(1)
        FROM labkc_v1.labkc_v1_uuid_storage
        WHERE uuid = v_uuid
        INTO v_exists_count;

        p_result := (v_exists_count > 0);
    END IF;
END;
$$;


--
