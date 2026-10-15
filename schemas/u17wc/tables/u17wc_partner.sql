-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_partner
-- Type: TABLE

-- Name: u17wc_partner; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
