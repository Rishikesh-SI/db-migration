-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_partner
-- Type: TABLE

-- Name: labdsg_partner; Type: TABLE; Schema: labdsg; Owner: -
--

CREATE TABLE labdsg.labdsg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
