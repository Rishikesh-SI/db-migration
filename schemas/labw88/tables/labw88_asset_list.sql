-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_asset_list
-- Type: TABLE

-- Name: labw88_asset_list; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_asset_list (
    asset_list_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_title character varying(4000),
    title_alias character varying,
    author_id numeric,
    short_desc character varying,
    tags character varying,
    primary_entity_role_map_id numeric,
    secondary_entity_role_map_id numeric,
    total_assets numeric,
    image_file_name character varying(2000),
    image_path character varying,
    duration character varying,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
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
    asset_guid character varying(256),
    show_copyright numeric,
    order_number numeric,
    short_title character varying(2000),
    language_id numeric,
    web_detail_jsn jsonb,
    language_url character varying(200),
    web_listing_json jsonb,
    tagged_entity integer[]
);


--
