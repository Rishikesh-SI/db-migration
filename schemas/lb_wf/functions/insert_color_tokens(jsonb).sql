-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: insert_color_tokens(jsonb)
-- Type: FUNCTION

-- Name: insert_color_tokens(jsonb); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.insert_color_tokens(json_data jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    WITH extracted_colors AS (
        -- Extract colors from 'core' -> 'light'
        SELECT
            key AS token,
            value AS hex_code,
            'core' AS type, -- 'core' for colors under 'core'
            'light' AS mode
        FROM jsonb_each_text(json_data -> 'colors' -> 'core' -> 'light')

        UNION ALL

        -- Extract colors from 'core' -> 'dark'
        SELECT
            key AS token,
            value AS hex_code,
            'core' AS type, -- 'core' for colors under 'core'
            'dark' AS mode
        FROM jsonb_each_text(json_data -> 'colors' -> 'core' -> 'dark')

        UNION ALL

        -- Extract colors from 'semantic' -> 'light'
        SELECT
            key AS token,
            value AS hex_code,
            'semantic' AS type, -- 'semantic' for colors under 'semantic'
            'light' AS mode
        FROM jsonb_each_text(json_data -> 'colors' -> 'semantic' -> 'light')

        UNION ALL

        -- Extract colors from 'semantic' -> 'dark'
        SELECT
            key AS token,
            value AS hex_code,
            'semantic' AS type, -- 'semantic' for colors under 'semantic'
            'dark' AS mode
        FROM jsonb_each_text(json_data -> 'colors' -> 'semantic' -> 'dark')
    )
    INSERT INTO lb_wf.colors (
        token, type, mode, hex_code, is_deleted, 
        created_by, created_at, updated_by, updated_at,
        deleted_by, deleted_at
    )
    SELECT
        token,                        -- Color key
        type,                     -- Derived semantic ('core' or 'semantic')
        mode,                         -- Derived mode ('light' or 'dark')
        hex_code,                     -- Color hex value
        false AS is_deleted,          -- Default value for is_deleted
        1 AS created_by,              -- Set to 'system' by default
        CURRENT_TIMESTAMP AS created_at, -- Insert timestamp
        2 AS updated_by,              -- Set to 'system' by default
        CURRENT_TIMESTAMP AS updated_at, -- Insert timestamp
        NULL AS deleted_by,           -- Set to NULL (no deletion by default)
        NULL AS deleted_at            -- Set to NULL (no deletion by default)
    FROM extracted_colors;
END;
$$;


--
