-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_academy_fee
-- Type: TABLE

-- Name: labwpl_academy_fee; Type: TABLE; Schema: labwpl; Owner: -
--

CREATE TABLE labwpl.labwpl_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
