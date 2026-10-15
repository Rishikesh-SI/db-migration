-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_entity_partner
-- Type: TABLE

-- Name: labsaw_entity_partner; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
