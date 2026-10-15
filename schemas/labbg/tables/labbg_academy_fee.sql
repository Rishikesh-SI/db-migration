-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_academy_fee
-- Type: TABLE

-- Name: labbg_academy_fee; Type: TABLE; Schema: labbg; Owner: -
--

CREATE TABLE labbg.labbg_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
