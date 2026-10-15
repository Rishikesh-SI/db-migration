-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_asset_list
-- Type: TABLE

-- Name: abp_asset_list; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_asset_list (
    asset_list_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_title text,
    title_alias text,
    author_id numeric,
    short_desc text,
    tags text,
    primary_entity_role_map_id numeric,
    secondary_entity_role_map_id numeric,
    total_assets numeric,
    image_file_name text,
    image_path text,
    duration text,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
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
    asset_guid character varying(256),
    show_copyright numeric,
    order_number numeric,
    short_title text,
    is_live_blog numeric,
    language_entity_role_map_id numeric
);


--
