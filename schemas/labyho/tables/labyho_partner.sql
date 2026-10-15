-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_partner
-- Type: TABLE

-- Name: labyho_partner; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
