-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_academy_fee
-- Type: TABLE

-- Name: labecn_v1_academy_fee; Type: TABLE; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE TABLE labecn_v1_bkp_29012025.labecn_v1_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
