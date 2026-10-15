-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_entity_partner
-- Type: TABLE

-- Name: labpr_entity_partner; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
