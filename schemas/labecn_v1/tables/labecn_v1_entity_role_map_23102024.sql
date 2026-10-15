-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_entity_role_map_23102024
-- Type: TABLE

-- Name: labecn_v1_entity_role_map_23102024; Type: TABLE; Schema: labecn_v1; Owner: -
--

CREATE TABLE labecn_v1.labecn_v1_entity_role_map_23102024 (
    entity_role_map_id numeric,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric,
    tour_id numeric,
    entity_count numeric,
    league_id text,
    ref_url character varying,
    ref_tag_id numeric,
    ref_source_object_id character varying,
    old_entity_role_map_id numeric
);


--
