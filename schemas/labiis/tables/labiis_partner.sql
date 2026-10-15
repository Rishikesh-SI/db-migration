-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_partner
-- Type: TABLE

-- Name: labiis_partner; Type: TABLE; Schema: labiis; Owner: -
--

CREATE TABLE labiis.labiis_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
