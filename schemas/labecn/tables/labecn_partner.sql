-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_partner
-- Type: TABLE

-- Name: labecn_partner; Type: TABLE; Schema: labecn; Owner: -
--

CREATE TABLE labecn.labecn_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
