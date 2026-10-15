-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_academy
-- Type: TABLE

-- Name: labsm_academy; Type: TABLE; Schema: labsm; Owner: -
--

CREATE TABLE labsm.labsm_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
