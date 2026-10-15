-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: atom_add(uuid, text, uuid, integer, text, text, text, text, text, text, text, text, text, text, boolean, jsonb, text, text, text, boolean, text, jsonb)
-- Type: FUNCTION

-- Name: atom_add(uuid, text, uuid, integer, text, text, text, text, text, text, text, text, text, text, boolean, jsonb, text, text, text, boolean, text, jsonb); Type: FUNCTION; Schema: lb_wf; Owner: -
--

CREATE FUNCTION lb_wf.atom_add(_json_id uuid, _atom_type text, _created_by uuid, _clamp integer DEFAULT NULL::integer, _typography text DEFAULT NULL::text, _text_color text DEFAULT NULL::text, _appearance text DEFAULT NULL::text, _size text DEFAULT NULL::text, _sub_variant text DEFAULT NULL::text, _shape text DEFAULT NULL::text, _color text DEFAULT NULL::text, _background_color text DEFAULT NULL::text, _leading_icon text DEFAULT NULL::text, _trailing_icon text DEFAULT NULL::text, _full_width boolean DEFAULT NULL::boolean, _border_width jsonb DEFAULT NULL::jsonb, _border_radius text DEFAULT NULL::text, _border_color text DEFAULT NULL::text, _ratio text DEFAULT NULL::text, _play boolean DEFAULT NULL::boolean, _icon text DEFAULT NULL::text, _additional_config jsonb DEFAULT NULL::jsonb) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO lb_wf.atoms (
        json_id, atom_type, clamp, typography, text_color, appearance, size, sub_variant, shape,
        color, background_color, leading_icon, trailing_icon, full_width, border_width,
        border_radius, border_color, ratio, play, icon, additional_config, created_by
    )
    VALUES (
        _json_id, _atom_type, _clamp, _typography, _text_color, _appearance, _size, _sub_variant,
        _shape, _color, _background_color, _leading_icon, _trailing_icon, _full_width,
        _border_width, _border_radius, _border_color, _ratio, _play, _icon, _additional_config, _created_by
    )
    RETURNING json_id INTO _json_id;

    RETURN _json_id;
END;
$$;


--
