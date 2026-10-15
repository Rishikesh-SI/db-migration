-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_academy
-- Type: TABLE

-- Name: lablakr_academy; Type: TABLE; Schema: lablakr; Owner: -
--

CREATE TABLE lablakr.lablakr_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
