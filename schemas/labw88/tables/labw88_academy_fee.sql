-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_academy_fee
-- Type: TABLE

-- Name: labw88_academy_fee; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
