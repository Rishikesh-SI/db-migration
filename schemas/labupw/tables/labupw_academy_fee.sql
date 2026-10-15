-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_academy_fee
-- Type: TABLE

-- Name: labupw_academy_fee; Type: TABLE; Schema: labupw; Owner: -
--

CREATE TABLE labupw.labupw_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
