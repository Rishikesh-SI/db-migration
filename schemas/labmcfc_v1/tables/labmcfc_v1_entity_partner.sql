-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_entity_partner
-- Type: TABLE

-- Name: labmcfc_v1_entity_partner; Type: TABLE; Schema: labmcfc_v1; Owner: -
--

CREATE TABLE labmcfc_v1.labmcfc_v1_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
