-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: update_color(integer, character varying, character varying, character varying, character varying, integer)
-- Type: FUNCTION

-- Name: update_color(integer, character varying, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.update_color(p_id integer, p_token character varying, p_semantic character varying, p_mode character varying, p_hex_code character varying, p_updated_by integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update the record in lb_wf.colors based on the provided ID
    UPDATE lb_wf.colors
    SET 
        token = p_token,                    -- Update token
        semantic = p_semantic,              -- Update semantic
        mode = p_mode,                      -- Update mode
        hex_code = p_hex_code,              -- Update hex code
        updated_by = p_updated_by,          -- Update updated_by
        updated_at = CURRENT_TIMESTAMP      -- Set the current timestamp for updated_at
    WHERE id = p_id;                        -- Apply the update to the row with the given ID
END;
$$;


--
