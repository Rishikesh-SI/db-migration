-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: labtkr_template_component_content_map
-- Type: TABLE

-- Name: labtkr_template_component_content_map; Type: TABLE; Schema: labtkrold; Owner: -
--

CREATE TABLE labtkrold.labtkr_template_component_content_map (
    template_component_content_map_id numeric NOT NULL,
    template_component_map_id numeric,
    tccmap_name character varying(1000),
    tccmap_display_name character varying(1000),
    tccmap_desc text,
    order_number numeric,
    asset_id numeric,
    asset_type_id numeric,
    asset_meta jsonb,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    is_default numeric,
    published_version_number numeric,
    is_trashed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    asset_guid character varying(256)
);


--
