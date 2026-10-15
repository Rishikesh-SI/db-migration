-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: radius
-- Type: TABLE

-- Name: radius; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.radius (
    token text NOT NULL,
    value integer NOT NULL,
    is_deleted boolean DEFAULT false,
    created_by integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by integer NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_by integer,
    deleted_at timestamp without time zone
);


--
