-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_entity_partner
-- Type: TABLE

-- Name: stn_entity_partner; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
