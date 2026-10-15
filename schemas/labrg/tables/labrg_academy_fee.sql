-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_academy_fee
-- Type: TABLE

-- Name: labrg_academy_fee; Type: TABLE; Schema: labrg; Owner: -
--

CREATE TABLE labrg.labrg_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
