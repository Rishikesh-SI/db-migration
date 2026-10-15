-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_ruf
-- Object: labecn_partner
-- Type: TABLE

-- Name: labecn_partner; Type: TABLE; Schema: labecn_ruf; Owner: -
--

CREATE TABLE labecn_ruf.labecn_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
