-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_academy_fee
-- Type: TABLE

-- Name: lablsg_academy_fee; Type: TABLE; Schema: fanxp_lsg; Owner: -
--

CREATE TABLE fanxp_lsg.lablsg_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
