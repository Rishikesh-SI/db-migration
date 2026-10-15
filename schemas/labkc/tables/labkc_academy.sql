-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_academy
-- Type: TABLE

-- Name: labkc_academy; Type: TABLE; Schema: labkc; Owner: -
--

CREATE TABLE labkc.labkc_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
