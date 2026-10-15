-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_press_release_master
-- Type: TABLE

-- Name: labrr_press_release_master; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_press_release_master (
    press_release_id numeric NOT NULL,
    title character varying(2000),
    status numeric,
    published_date timestamp without time zone,
    guid text,
    version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    image_id numeric,
    is_cover numeric,
    image_name character varying(2000),
    image_path character varying(2000),
    press_release_json jsonb,
    zip_id numeric,
    zip_name text,
    zip_path text,
    zip_size text,
    is_trashed numeric,
    tagged_entity integer[],
    link character varying,
    web_listing_json jsonb,
    primary_entity_role_map_id numeric,
    secondary_entity_role_map_id numeric,
    title_alias character varying
);


--
