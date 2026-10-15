-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_academy_fee
-- Type: TABLE

-- Name: labsm_academy_fee; Type: TABLE; Schema: labsm; Owner: -
--

CREATE TABLE labsm.labsm_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
