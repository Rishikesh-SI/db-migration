-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_partner
-- Type: TABLE

-- Name: tfa_partner; Type: TABLE; Schema: tfa; Owner: -
--

CREATE TABLE tfa.tfa_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
