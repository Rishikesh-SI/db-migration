-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_academy_fee
-- Type: TABLE

-- Name: labgfg_academy_fee; Type: TABLE; Schema: labgfg; Owner: -
--

CREATE TABLE labgfg.labgfg_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
