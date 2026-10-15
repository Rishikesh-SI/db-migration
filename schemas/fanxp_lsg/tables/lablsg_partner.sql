-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_partner
-- Type: TABLE

-- Name: lablsg_partner; Type: TABLE; Schema: fanxp_lsg; Owner: -
--

CREATE TABLE fanxp_lsg.lablsg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
