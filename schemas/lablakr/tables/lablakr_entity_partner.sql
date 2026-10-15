-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_entity_partner
-- Type: TABLE

-- Name: lablakr_entity_partner; Type: TABLE; Schema: lablakr; Owner: -
--

CREATE TABLE lablakr.lablakr_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
