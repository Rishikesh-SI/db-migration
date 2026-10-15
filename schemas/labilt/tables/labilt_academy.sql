-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_academy
-- Type: TABLE

-- Name: labilt_academy; Type: TABLE; Schema: labilt; Owner: -
--

CREATE TABLE labilt.labilt_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
