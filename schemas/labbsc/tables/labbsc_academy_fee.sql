-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_academy_fee
-- Type: TABLE

-- Name: labbsc_academy_fee; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
