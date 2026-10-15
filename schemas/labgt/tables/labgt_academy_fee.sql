-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_academy_fee
-- Type: TABLE

-- Name: labgt_academy_fee; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
