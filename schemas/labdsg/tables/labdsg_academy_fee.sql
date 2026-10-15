-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_academy_fee
-- Type: TABLE

-- Name: labdsg_academy_fee; Type: TABLE; Schema: labdsg; Owner: -
--

CREATE TABLE labdsg.labdsg_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
