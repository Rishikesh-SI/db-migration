-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_entity_role_map_21102024
-- Type: TABLE

-- Name: labwis_entity_role_map_21102024; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_entity_role_map_21102024 (
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
    ref_id numeric,
    ref_guid character varying,
    ref_source_object_id character varying,
    ref_tag_id numeric,
    ref_url character varying,
    ref_category_ids numeric[]
);


--
