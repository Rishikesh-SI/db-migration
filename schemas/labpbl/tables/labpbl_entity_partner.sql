-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_entity_partner
-- Type: TABLE

-- Name: labpbl_entity_partner; Type: TABLE; Schema: labpbl; Owner: -
--

CREATE TABLE labpbl.labpbl_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
