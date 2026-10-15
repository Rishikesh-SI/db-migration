-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_academy_fee
-- Type: TABLE

-- Name: labfih_academy_fee; Type: TABLE; Schema: labfih; Owner: -
--

CREATE TABLE labfih.labfih_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
