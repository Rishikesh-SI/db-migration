-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_academy
-- Type: TABLE

-- Name: labpvl_academy; Type: TABLE; Schema: labpvl; Owner: -
--

CREATE TABLE labpvl.labpvl_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
