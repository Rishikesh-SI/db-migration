-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_asset_list
-- Type: TABLE

-- Name: swa_asset_list; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_asset_list (
    asset_list_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_title character varying(4000),
    title_alias character varying(4000),
    author_id numeric,
    short_desc text,
    tags character varying(4000),
    primary_entity_role_map_id numeric,
    secondary_entity_role_map_id numeric,
    total_assets numeric,
    image_file_name character varying(2000),
    image_path character varying(4000),
    duration character varying(1000),
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
    short_title character varying(4000)
);


--
