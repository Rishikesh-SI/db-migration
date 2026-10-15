-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_academy_fee
-- Type: TABLE

-- Name: labadkr_academy_fee; Type: TABLE; Schema: labadkr_beta; Owner: -
--

CREATE TABLE labadkr_beta.labadkr_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
