-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_partner
-- Type: TABLE

-- Name: msl_partner; Type: TABLE; Schema: msl; Owner: -
--

CREATE TABLE msl.msl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
