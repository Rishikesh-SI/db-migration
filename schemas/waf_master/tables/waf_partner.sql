-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_partner
-- Type: TABLE

-- Name: waf_partner; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
