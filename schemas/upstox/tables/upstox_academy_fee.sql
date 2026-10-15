-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_academy_fee
-- Type: TABLE

-- Name: upstox_academy_fee; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
