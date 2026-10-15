-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_academy_fee
-- Type: TABLE

-- Name: labuww_academy_fee; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
