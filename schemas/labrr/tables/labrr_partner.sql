-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_partner
-- Type: TABLE

-- Name: labrr_partner; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
