-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_academy
-- Type: TABLE

-- Name: upstox_academy; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
