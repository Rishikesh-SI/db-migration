-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_academy_fee
-- Type: TABLE

-- Name: labdv_academy_fee; Type: TABLE; Schema: labdv; Owner: -
--

CREATE TABLE labdv.labdv_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
