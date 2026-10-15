-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_academy_fee
-- Type: TABLE

-- Name: labupstox_academy_fee; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
