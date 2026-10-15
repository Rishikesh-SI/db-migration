-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_partner
-- Type: TABLE

-- Name: isl_partner; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
