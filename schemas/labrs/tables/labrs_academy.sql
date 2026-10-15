-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_academy
-- Type: TABLE

-- Name: labrs_academy; Type: TABLE; Schema: labrs; Owner: -
--

CREATE TABLE labrs.labrs_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
