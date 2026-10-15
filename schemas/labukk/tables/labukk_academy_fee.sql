-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_academy_fee
-- Type: TABLE

-- Name: labukk_academy_fee; Type: TABLE; Schema: labukk; Owner: -
--

CREATE TABLE labukk.labukk_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
