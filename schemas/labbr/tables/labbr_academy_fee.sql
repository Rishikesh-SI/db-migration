-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_academy_fee
-- Type: TABLE

-- Name: labbr_academy_fee; Type: TABLE; Schema: labbr; Owner: -
--

CREATE TABLE labbr.labbr_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
