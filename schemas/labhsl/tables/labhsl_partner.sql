-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_partner
-- Type: TABLE

-- Name: labhsl_partner; Type: TABLE; Schema: labhsl; Owner: -
--

CREATE TABLE labhsl.labhsl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
