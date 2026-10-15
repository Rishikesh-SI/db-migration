-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_entity_partner
-- Type: TABLE

-- Name: labkkr_v1_entity_partner; Type: TABLE; Schema: labkkr_v1; Owner: -
--

CREATE TABLE labkkr_v1.labkkr_v1_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
