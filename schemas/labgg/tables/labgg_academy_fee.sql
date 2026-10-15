-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_academy_fee
-- Type: TABLE

-- Name: labgg_academy_fee; Type: TABLE; Schema: labgg; Owner: -
--

CREATE TABLE labgg.labgg_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
