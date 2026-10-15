-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_academy_fee
-- Type: TABLE

-- Name: labkc_v1_academy_fee; Type: TABLE; Schema: labkc_v1_02042024; Owner: -
--

CREATE TABLE labkc_v1_02042024.labkc_v1_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
