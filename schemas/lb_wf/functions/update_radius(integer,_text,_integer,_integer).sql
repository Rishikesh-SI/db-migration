-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: update_radius(integer, text, integer, integer)
-- Type: FUNCTION

-- Name: update_radius(integer, text, integer, integer); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.update_radius(p_id integer, p_token text, p_value integer, p_updated_by integer DEFAULT 1) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the record exists based on the ID
    IF EXISTS (
        SELECT 1 
        FROM lb_wf.radius 
        WHERE id = p_id
    ) THEN
        -- Update the existing record based on the ID
        UPDATE lb_wf.radius
        SET
            token = p_token,
            value = p_value,
            updated_by = p_updated_by,
            updated_at = CURRENT_TIMESTAMP
        WHERE id = p_id;
    ELSE
        -- Optionally handle cases where the ID does not exist
        RAISE EXCEPTION 'Record with id % does not exist.', p_id;
    END IF;
END;
$$;


--
