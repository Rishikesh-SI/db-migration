-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_academy_fee
-- Type: TABLE

-- Name: labos_academy_fee; Type: TABLE; Schema: labos; Owner: -
--

CREATE TABLE labos.labos_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
