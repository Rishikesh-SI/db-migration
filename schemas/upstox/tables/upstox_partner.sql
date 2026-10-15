-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_partner
-- Type: TABLE

-- Name: upstox_partner; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
