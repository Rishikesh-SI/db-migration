-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_academy
-- Type: TABLE

-- Name: labbsc_academy; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
