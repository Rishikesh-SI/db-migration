-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_press_release_asset_map_20170724
-- Type: TABLE

-- Name: pkl_press_release_asset_map_20170724; Type: TABLE; Schema: pkl; Owner: -
--

CREATE TABLE pkl.pkl_press_release_asset_map_20170724 (
    press_release_asset_map_id numeric,
    press_release_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    file_link character varying,
    file_name character varying,
    file_size character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    pramap_guid character varying(256),
    language_id numeric,
    file_type character varying
);


--
