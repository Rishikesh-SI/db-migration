-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: gfg_press_release_asset_map
-- Type: TABLE

-- Name: gfg_press_release_asset_map; Type: TABLE; Schema: gfg; Owner: -
--

CREATE TABLE gfg.gfg_press_release_asset_map (
    press_release_asset_map_id numeric NOT NULL,
    press_release_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    file_link character varying,
    file_name character varying,
    file_size character varying,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    pramap_guid character varying(256) NOT NULL,
    language_id numeric,
    file_type character varying
);


--
