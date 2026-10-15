-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_academy
-- Type: TABLE

-- Name: labkc_v1_academy; Type: TABLE; Schema: labkc_v1_bkp; Owner: -
--

CREATE TABLE labkc_v1_bkp.labkc_v1_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
