-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_partner
-- Type: TABLE

-- Name: lablsg_partner; Type: TABLE; Schema: lablsg; Owner: -
--

CREATE TABLE lablsg.lablsg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
