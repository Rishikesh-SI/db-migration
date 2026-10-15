-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: gfg_press_release_asset_master
-- Type: TABLE

-- Name: gfg_press_release_asset_master; Type: TABLE; Schema: gfg; Owner: -
--

CREATE TABLE gfg.gfg_press_release_asset_master (
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_name character varying(256) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
