-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_partner
-- Type: TABLE

-- Name: tcs_partner; Type: TABLE; Schema: tcs; Owner: -
--

CREATE TABLE tcs.tcs_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
