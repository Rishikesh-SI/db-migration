-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: delete_spacing(integer, integer)
-- Type: FUNCTION

-- Name: delete_spacing(integer, integer); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.delete_spacing(p_id integer, p_deleted_by integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update the record to mark it as soft-deleted
    UPDATE lb_wf.spacing
    SET 
        is_deleted = TRUE,                -- Mark as deleted
        deleted_by = p_deleted_by,        -- Set the ID of the user who deleted it
        deleted_at = CURRENT_TIMESTAMP    -- Set the current timestamp as deletion time
    WHERE id = p_id;                      -- Match the record with the given ID
END;
$$;


--
