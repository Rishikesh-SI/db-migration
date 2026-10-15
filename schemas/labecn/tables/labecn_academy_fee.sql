-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_academy_fee
-- Type: TABLE

-- Name: labecn_academy_fee; Type: TABLE; Schema: labecn; Owner: -
--

CREATE TABLE labecn.labecn_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
