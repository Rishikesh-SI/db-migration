-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_academy
-- Type: TABLE

-- Name: labadkr_academy; Type: TABLE; Schema: labadkr_beta; Owner: -
--

CREATE TABLE labadkr_beta.labadkr_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
