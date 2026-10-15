-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: atom_update(uuid, uuid, text, integer, text, text, text, text, text, text, text, text, text, text, boolean, jsonb, text, text, text, boolean, text, jsonb)
-- Type: FUNCTION

-- Name: atom_update(uuid, uuid, text, integer, text, text, text, text, text, text, text, text, text, text, boolean, jsonb, text, text, text, boolean, text, jsonb); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.atom_update(_json_id uuid, _updated_by uuid, _atom_type text DEFAULT NULL::text, _clamp integer DEFAULT NULL::integer, _typography text DEFAULT NULL::text, _text_color text DEFAULT NULL::text, _appearance text DEFAULT NULL::text, _size text DEFAULT NULL::text, _sub_variant text DEFAULT NULL::text, _shape text DEFAULT NULL::text, _color text DEFAULT NULL::text, _background_color text DEFAULT NULL::text, _leading_icon text DEFAULT NULL::text, _trailing_icon text DEFAULT NULL::text, _full_width boolean DEFAULT NULL::boolean, _border_width jsonb DEFAULT NULL::jsonb, _border_radius text DEFAULT NULL::text, _border_color text DEFAULT NULL::text, _ratio text DEFAULT NULL::text, _play boolean DEFAULT NULL::boolean, _icon text DEFAULT NULL::text, _additional_config jsonb DEFAULT NULL::jsonb) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE lb_wf.atoms
    SET
        atom_type = COALESCE(_atom_type, atom_type),
        clamp = COALESCE(_clamp, clamp),
        typography = COALESCE(_typography, typography),
        text_color = COALESCE(_text_color, text_color),
        appearance = COALESCE(_appearance, appearance),
        size = COALESCE(_size, size),
        sub_variant = COALESCE(_sub_variant, sub_variant),
        shape = COALESCE(_shape, shape),
        color = COALESCE(_color, color),
        background_color = COALESCE(_background_color, background_color),
        leading_icon = COALESCE(_leading_icon, leading_icon),
        trailing_icon = COALESCE(_trailing_icon, trailing_icon),
        full_width = COALESCE(_full_width, full_width),
        border_width = COALESCE(_border_width, border_width),
        border_radius = COALESCE(_border_radius, border_radius),
        border_color = COALESCE(_border_color, border_color),
        ratio = COALESCE(_ratio, ratio),
        play = COALESCE(_play, play),
        icon = COALESCE(_icon, icon),
        additional_config = COALESCE(_additional_config, additional_config),
        updated_at = NOW(),
        updated_by = _updated_by
    WHERE json_id = _json_id AND is_deleted = FALSE;

    RETURN FOUND;
END;
$$;


--
