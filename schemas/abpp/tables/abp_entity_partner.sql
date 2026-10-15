-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_entity_partner
-- Type: TABLE

-- Name: abp_entity_partner; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric NOT NULL,
    partner_id numeric NOT NULL,
    handle character varying(50),
    profile_url character varying(3000)
);


--
