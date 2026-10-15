-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_academy
-- Type: TABLE

-- Name: labos_academy; Type: TABLE; Schema: labos; Owner: -
--

CREATE TABLE labos.labos_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
