-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_partner
-- Type: TABLE

-- Name: labrg_partner; Type: TABLE; Schema: labrg; Owner: -
--

CREATE TABLE labrg.labrg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
