-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_academy_fee
-- Type: TABLE

-- Name: labwis_academy_fee; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
