-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_partner
-- Type: TABLE

-- Name: spz_partner; Type: TABLE; Schema: spz; Owner: -
--

CREATE TABLE spz.spz_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
