-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_partner
-- Type: TABLE

-- Name: labmsg_partner; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
