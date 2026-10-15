-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_academy_fee
-- Type: TABLE

-- Name: labkkr_academy_fee; Type: TABLE; Schema: labkkr; Owner: -
--

CREATE TABLE labkkr.labkkr_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
