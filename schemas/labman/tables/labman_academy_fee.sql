-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_academy_fee
-- Type: TABLE

-- Name: labman_academy_fee; Type: TABLE; Schema: labman; Owner: -
--

CREATE TABLE labman.labman_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
