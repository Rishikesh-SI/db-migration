-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_academy_fee
-- Type: TABLE

-- Name: labpc_academy_fee; Type: TABLE; Schema: labpc; Owner: -
--

CREATE TABLE labpc.labpc_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
