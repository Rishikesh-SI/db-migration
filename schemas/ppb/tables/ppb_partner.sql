-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_partner
-- Type: TABLE

-- Name: ppb_partner; Type: TABLE; Schema: ppb; Owner: -
--

CREATE TABLE ppb.ppb_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
