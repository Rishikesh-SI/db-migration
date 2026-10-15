-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_partner
-- Type: TABLE

-- Name: stn_partner; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
