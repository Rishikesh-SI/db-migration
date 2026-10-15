-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: atom_read(uuid)
-- Type: FUNCTION

-- Name: atom_read(uuid); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.atom_read(_json_id uuid) RETURNS TABLE(id integer, json_id uuid, atom_type text, clamp integer, typography text, text_color text, appearance text, size text, sub_variant text, shape text, color text, background_color text, leading_icon text, trailing_icon text, full_width boolean, border_width jsonb, border_radius text, border_color text, ratio text, play boolean, icon text, additional_config jsonb, created_by uuid, created_at timestamp without time zone, updated_at timestamp without time zone, is_deleted boolean, deleted_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM lb_wf.atoms
    WHERE json_id = _json_id AND is_deleted = FALSE;
END;
$$;


--
