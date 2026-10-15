-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_academy_fee
-- Type: TABLE

-- Name: labmsg_academy_fee; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
