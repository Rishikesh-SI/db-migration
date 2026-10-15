-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: update_spacing(integer, text, integer, integer)
-- Type: FUNCTION

-- Name: update_spacing(integer, text, integer, integer); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.update_spacing(p_id integer, p_token text, p_value integer, p_updated_by integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update the record in lb_wf.spacing based on the provided ID
    UPDATE lb_wf.spacing
    SET 
        token = p_token,                    -- Update token
        value = p_value,                    -- Update value
        updated_by = p_updated_by,          -- Update updated_by
        updated_at = CURRENT_TIMESTAMP      -- Set the current timestamp for updated_at
    WHERE id = p_id;                        -- Apply the update to the row with the given ID
END;
$$;


--
