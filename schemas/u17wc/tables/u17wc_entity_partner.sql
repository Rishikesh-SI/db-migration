-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_entity_partner
-- Type: TABLE

-- Name: u17wc_entity_partner; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
