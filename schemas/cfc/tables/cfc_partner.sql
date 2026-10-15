-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_partner
-- Type: TABLE

-- Name: cfc_partner; Type: TABLE; Schema: cfc; Owner: -
--

CREATE TABLE cfc.cfc_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
