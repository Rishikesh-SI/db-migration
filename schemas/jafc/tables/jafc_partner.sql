-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_partner
-- Type: TABLE

-- Name: jafc_partner; Type: TABLE; Schema: jafc; Owner: -
--

CREATE TABLE jafc.jafc_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
