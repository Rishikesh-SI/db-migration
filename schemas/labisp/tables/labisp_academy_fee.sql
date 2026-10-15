-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_academy_fee
-- Type: TABLE

-- Name: labisp_academy_fee; Type: TABLE; Schema: labisp; Owner: -
--

CREATE TABLE labisp.labisp_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
