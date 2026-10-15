-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_academy
-- Type: TABLE

-- Name: labbg_academy; Type: TABLE; Schema: labbg; Owner: -
--

CREATE TABLE labbg.labbg_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
