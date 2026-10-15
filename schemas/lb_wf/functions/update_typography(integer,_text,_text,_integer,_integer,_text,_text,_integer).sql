-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: update_typography(integer, text, text, integer, integer, text, text, integer)
-- Type: FUNCTION

-- Name: update_typography(integer, text, text, integer, integer, text, text, integer); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.update_typography(p_id integer, p_token text, p_device text, p_size integer, p_line_height integer, p_weight text, p_typeface text, p_updated_by integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update the record in lb_wf.typography based on the provided ID
    UPDATE lb_wf.typography
    SET 
        token = p_token,                    -- Update token
        device = p_device,                  -- Update device
        size = p_size,                      -- Update size
        line_height = p_line_height,        -- Update line height
        weight = p_weight,                  -- Update weight
        typeface = p_typeface,              -- Update typeface
        updated_by = p_updated_by,          -- Update updated_by
        updated_at = CURRENT_TIMESTAMP      -- Set the current timestamp for updated_at
    WHERE id = p_id;                        -- Apply the update to the row with the given ID
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
