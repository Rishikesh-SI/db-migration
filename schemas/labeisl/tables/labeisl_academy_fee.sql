-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_academy_fee
-- Type: TABLE

-- Name: labeisl_academy_fee; Type: TABLE; Schema: labeisl; Owner: -
--

CREATE TABLE labeisl.labeisl_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
