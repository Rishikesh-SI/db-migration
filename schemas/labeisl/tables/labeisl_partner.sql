-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_partner
-- Type: TABLE

-- Name: labeisl_partner; Type: TABLE; Schema: labeisl; Owner: -
--

CREATE TABLE labeisl.labeisl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
