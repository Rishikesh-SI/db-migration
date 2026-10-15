-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: insert_spacing_tokens(jsonb)
-- Type: FUNCTION

-- Name: insert_spacing_tokens(jsonb); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.insert_spacing_tokens(json_data jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    WITH extracted_spacing AS (
        SELECT
            key AS token,            -- Extract token names (e.g., 'spacing_0')
            value::INTEGER AS value  -- Extract integer values (e.g., 0, 2, 4, ...)
        FROM jsonb_each_text(json_data -> 'spacing') -- Extract key-value pairs from 'spacing'
    )
    INSERT INTO lb_wf.spacing (
        token, value, is_deleted, 
        created_by, created_at, 
        updated_by, updated_at, 
        deleted_by, deleted_at
    )
    SELECT
        token,                        -- Token name
        value,                        -- Spacing value
        FALSE AS is_deleted,          -- Default value for is_deleted
        1 AS created_by,              -- Set to 'system' by default
        CURRENT_TIMESTAMP AS created_at, -- Insert timestamp
        1 AS updated_by,              -- Set to 'system' by default
        CURRENT_TIMESTAMP AS updated_at, -- Insert timestamp
        NULL AS deleted_by,           -- Set to NULL (no deletion by default)
        NULL AS deleted_at            -- Set to NULL (no deletion by default)
    FROM extracted_spacing
    ON CONFLICT (token, value) DO NOTHING; -- Avoid inserting duplicates
END;
$$;


--
