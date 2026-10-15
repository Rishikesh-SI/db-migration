-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_entity_partner
-- Type: TABLE

-- Name: waf_entity_partner; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric NOT NULL,
    partner_id numeric NOT NULL,
    handle character varying(50),
    profile_url character varying(3000)
);


--
