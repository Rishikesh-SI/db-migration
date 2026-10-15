-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: typography
-- Type: TABLE

-- Name: typography; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typography (
    token text NOT NULL,
    device text NOT NULL,
    size integer NOT NULL,
    line_height integer NOT NULL,
    weight text NOT NULL,
    typeface text NOT NULL,
    is_deleted boolean DEFAULT false,
    created_by integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_by integer,
    deleted_at timestamp without time zone
);


--
