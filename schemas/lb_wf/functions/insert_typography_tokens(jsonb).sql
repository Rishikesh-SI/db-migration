-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: insert_typography_tokens(jsonb)
-- Type: FUNCTION

-- Name: insert_typography_tokens(jsonb); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.insert_typography_tokens(json_data jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    WITH extracted_typography AS (
        SELECT
            device,                       -- Extract device name (e.g., 'mobile', 'desktop', 'tablet')
            key AS token,                  -- Extract token name (e.g., 'display_dp1_bold')
            value->>'size' AS size,       -- Extract size value (e.g., 52, 40, etc.)
            value->>'line_height' AS line_height, -- Extract line_height value
            value->>'weight' AS weight,   -- Extract weight value (e.g., 'bold', 'medium')
            value->>'typeface' AS typeface -- Extract typeface value (e.g., 'SF Pro Display')
        FROM jsonb_each(json_data) AS devices(device, token_data), 
        jsonb_each(token_data) AS tokens(key, value)
    )
    INSERT INTO lb_wf.typography (
        token, device, size, line_height, weight, typeface, 
        is_deleted, created_by, created_at, updated_by, updated_at, 
        deleted_by, deleted_at
    )
    SELECT
        token,                        -- Token name (e.g., 'display_dp1_bold')
        device,                       -- Device name (e.g., 'mobile', 'desktop', 'tablet')
        size::INTEGER,                -- Size value (e.g., 52)
        line_height::INTEGER,         -- Line height value
        weight,                       -- Weight value (e.g., 'bold')
        typeface,                     -- Typeface value (e.g., 'SF Pro Display')
        FALSE AS is_deleted,          -- Default value for is_deleted
        1 AS created_by,              -- Set to 'system' by default
        CURRENT_TIMESTAMP AS created_at, -- Insert timestamp
        1 AS updated_by,              -- Set to 'system' by default
        CURRENT_TIMESTAMP AS updated_at, -- Insert timestamp
        NULL AS deleted_by,           -- Set to NULL (no deletion by default)
        NULL AS deleted_at            -- Set to NULL (no deletion by default)
    FROM extracted_typography
    ON CONFLICT (token, device) DO NOTHING; -- Avoid inserting duplicates
END;
$$;


--
