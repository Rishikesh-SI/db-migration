-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: insert_radius_tokens(jsonb)
-- Type: FUNCTION

-- Name: insert_radius_tokens(jsonb); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.insert_radius_tokens(json_data jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    WITH extracted_radius AS (
        SELECT
            key AS token,          -- Extract token names (e.g., 'radius_none')
            value::INTEGER AS value -- Extract integer values (e.g., 0, 2, ...)
        FROM jsonb_each_text(json_data -> 'radius') -- Extract key-value pairs from 'radius'
    )
    INSERT INTO lb_wf.radius (
        token, value, is_deleted, 
        created_by, created_at, 
        updated_by, updated_at, 
        deleted_by, deleted_at
    )
    SELECT
        token,                      -- Token name
        value,                      -- Radius value
        FALSE AS is_deleted,        -- Default value for is_deleted
        1 AS created_by,            -- Set to 'system' by default
        CURRENT_TIMESTAMP AS created_at, -- Insert timestamp
        1 AS updated_by,            -- Set to 'system' by default
        CURRENT_TIMESTAMP AS updated_at, -- Insert timestamp
        NULL AS deleted_by,         -- Set to NULL (no deletion by default)
        NULL AS deleted_at          -- Set to NULL (no deletion by default)
    FROM extracted_radius
    ON CONFLICT (token, value) DO NOTHING; -- Avoid inserting duplicates
END;
$$;


--
