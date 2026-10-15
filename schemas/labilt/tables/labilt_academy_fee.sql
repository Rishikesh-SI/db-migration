-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_academy_fee
-- Type: TABLE

-- Name: labilt_academy_fee; Type: TABLE; Schema: labilt; Owner: -
--

CREATE TABLE labilt.labilt_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
