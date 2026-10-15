-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_partner
-- Type: TABLE

-- Name: dhm_partner; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
