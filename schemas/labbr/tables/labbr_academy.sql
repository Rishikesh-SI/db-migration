-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_academy
-- Type: TABLE

-- Name: labbr_academy; Type: TABLE; Schema: labbr; Owner: -
--

CREATE TABLE labbr.labbr_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
