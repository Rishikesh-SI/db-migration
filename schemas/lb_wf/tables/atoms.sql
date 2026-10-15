-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: atoms
-- Type: TABLE

-- Name: atoms; Type: TABLE; Schema: lb_wf; Owner: -
--

CREATE TABLE lb_wf.atoms (
    id integer NOT NULL,
    json_id uuid NOT NULL,
    atom_type text NOT NULL,
    clamp integer,
    typography text,
    text_color text,
    appearance text,
    size text,
    sub_variant text,
    shape text,
    color text,
    background_color text,
    leading_icon text,
    trailing_icon text,
    full_width boolean DEFAULT false,
    border_width jsonb,
    border_radius text,
    border_color text,
    ratio text,
    play boolean,
    icon text,
    additional_config jsonb,
    is_deleted boolean DEFAULT false,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_by uuid NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    deleted_by uuid,
    deleted_at timestamp without time zone,
    CONSTRAINT atoms_atom_type_check CHECK ((atom_type = ANY (ARRAY['badge'::text, 'button'::text, 'text'::text, 'thumbnail'::text, 'icon'::text, 'box'::text, 'image'::text])))
);


--
