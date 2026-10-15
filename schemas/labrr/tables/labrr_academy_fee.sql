-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_academy_fee
-- Type: TABLE

-- Name: labrr_academy_fee; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
