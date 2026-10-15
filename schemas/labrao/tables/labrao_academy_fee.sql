-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_academy_fee
-- Type: TABLE

-- Name: labrao_academy_fee; Type: TABLE; Schema: labrao; Owner: -
--

CREATE TABLE labrao.labrao_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
