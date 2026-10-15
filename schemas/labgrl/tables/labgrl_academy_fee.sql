-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_academy_fee
-- Type: TABLE

-- Name: labgrl_academy_fee; Type: TABLE; Schema: labgrl; Owner: -
--

CREATE TABLE labgrl.labgrl_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
