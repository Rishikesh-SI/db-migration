-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_academy_fee
-- Type: TABLE

-- Name: lablakr_academy_fee; Type: TABLE; Schema: lablakr; Owner: -
--

CREATE TABLE lablakr.lablakr_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
