-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: sync_token(character varying, character varying, character varying, character varying, integer)
-- Type: FUNCTION

-- Name: sync_token(character varying, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.sync_token(p_token character varying, p_semantic character varying, p_mode character varying, p_hex_code character varying, p_created_by integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$
BEGIN
    -- Validate the mode value
    IF NOT (p_mode = 'light' OR p_mode = 'dark') THEN
        RAISE EXCEPTION 'Invalid mode. Mode must be either ''light'' or ''dark''';
    END IF;

    -- Validate the hex code format
    IF NOT (p_hex_code ~ '^#[0-9A-Fa-f]{6}$') THEN
        RAISE EXCEPTION 'Invalid hex code format. It must be in the format #RRGGBB';
    END IF;

    -- Insert or update the token
    INSERT INTO tokens (token, semantic, mode, hex_code, created_by, created_at, updated_at)
    VALUES (p_token, p_semantic, p_mode, p_hex_code, p_created_by, NOW(), NOW())
    ON CONFLICT (token, mode) DO UPDATE
    SET 
        semantic = EXCLUDED.semantic,
        hex_code = EXCLUDED.hex_code,
        updated_by = p_created_by,
        updated_at = NOW();
END;
$_$;


--
