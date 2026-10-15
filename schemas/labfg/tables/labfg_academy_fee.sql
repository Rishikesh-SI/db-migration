-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_academy_fee
-- Type: TABLE

-- Name: labfg_academy_fee; Type: TABLE; Schema: labfg; Owner: -
--

CREATE TABLE labfg.labfg_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
