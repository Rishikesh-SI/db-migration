-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_academy
-- Type: TABLE

-- Name: labwf_academy; Type: TABLE; Schema: labwf; Owner: -
--

CREATE TABLE labwf.labwf_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
