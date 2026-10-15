-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_entity_partner
-- Type: TABLE

-- Name: labkc_v1_entity_partner; Type: TABLE; Schema: labkc_v1_bkp; Owner: -
--

CREATE TABLE labkc_v1_bkp.labkc_v1_entity_partner (
    entity_partner_id numeric NOT NULL,
    entity_role_map_id numeric,
    partner_id numeric,
    handle character varying(50),
    profile_url character varying(3000)
);


--
