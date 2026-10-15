-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_partner
-- Type: TABLE

-- Name: lablakr_partner; Type: TABLE; Schema: lablakr; Owner: -
--

CREATE TABLE lablakr.lablakr_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
