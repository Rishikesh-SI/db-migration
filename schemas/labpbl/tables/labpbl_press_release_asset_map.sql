-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_press_release_asset_map
-- Type: TABLE

-- Name: labpbl_press_release_asset_map; Type: TABLE; Schema: labpbl; Owner: -
--

CREATE TABLE labpbl.labpbl_press_release_asset_map (
    press_release_asset_map_id numeric NOT NULL,
    press_release_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    pramap_guid character varying(256),
    language_id numeric
);


--
