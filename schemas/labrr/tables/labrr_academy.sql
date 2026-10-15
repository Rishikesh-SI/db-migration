-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_academy
-- Type: TABLE

-- Name: labrr_academy; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
