-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_academy_fee
-- Type: TABLE

-- Name: labpvl_academy_fee; Type: TABLE; Schema: labpvl; Owner: -
--

CREATE TABLE labpvl.labpvl_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
