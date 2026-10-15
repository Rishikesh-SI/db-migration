-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_template_component_content_map
-- Type: TABLE

-- Name: abp_template_component_content_map; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_template_component_content_map (
    template_component_content_map_id numeric NOT NULL,
    template_component_map_id numeric NOT NULL,
    tccmap_name character varying(1000) NOT NULL,
    tccmap_display_name character varying(1000) NOT NULL,
    tccmap_desc text,
    order_number numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_meta jsonb,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    is_default numeric,
    published_version_number numeric NOT NULL,
    is_trashed numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    asset_guid character varying(256)
);


--
