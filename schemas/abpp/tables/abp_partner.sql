-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_partner
-- Type: TABLE

-- Name: abp_partner; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
