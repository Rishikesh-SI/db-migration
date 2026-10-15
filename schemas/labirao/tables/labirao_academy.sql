-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_academy
-- Type: TABLE

-- Name: labirao_academy; Type: TABLE; Schema: labirao; Owner: -
--

CREATE TABLE labirao.labirao_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
