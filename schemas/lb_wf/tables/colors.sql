-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: colors
-- Type: TABLE

-- Name: colors; Type: TABLE; Schema: lb_wf; Owner: -
--

CREATE TABLE lb_wf.colors (
    id integer NOT NULL,
    token text NOT NULL,
    type text NOT NULL,
    mode text NOT NULL,
    hex_code text NOT NULL,
    is_deleted boolean DEFAULT false,
    created_by integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by integer,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_by integer,
    deleted_at timestamp without time zone,
    CONSTRAINT colors_hex_code_check CHECK ((hex_code ~ '^#[0-9A-Fa-f]{6}$'::text))
);


--
