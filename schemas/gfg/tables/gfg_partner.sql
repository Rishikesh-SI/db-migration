-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: gfg_partner
-- Type: TABLE

-- Name: gfg_partner; Type: TABLE; Schema: gfg; Owner: -
--

CREATE TABLE gfg.gfg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
