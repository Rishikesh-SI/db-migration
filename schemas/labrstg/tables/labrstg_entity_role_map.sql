-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_entity_role_map
-- Type: TABLE

-- Name: labrstg_entity_role_map; Type: TABLE; Schema: labrstg; Owner: -
--

CREATE TABLE labrstg.labrstg_entity_role_map (
    entity_role_map_id numeric NOT NULL,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric,
    tour_id text,
    league_id text,
    ref_source_object_id character varying,
    ref_tag_id character varying,
    ref_url character varying
);


--
