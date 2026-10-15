-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_partner
-- Type: TABLE

-- Name: hsl_partner; Type: TABLE; Schema: hsl; Owner: -
--

CREATE TABLE hsl.hsl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
