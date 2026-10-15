-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_entity_role_map_bkp_12062025
-- Type: TABLE

-- Name: labgrl_entity_role_map_bkp_12062025; Type: TABLE; Schema: labgrl; Owner: -
--

CREATE TABLE labgrl.labgrl_entity_role_map_bkp_12062025 (
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
    ref_source_object_id character varying,
    ref_tag_id character varying,
    ref_url character varying
);


--
