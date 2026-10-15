-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_press_release_asset_master
-- Type: TABLE

-- Name: labpbl_press_release_asset_master; Type: TABLE; Schema: labpbl; Owner: -
--

CREATE TABLE labpbl.labpbl_press_release_asset_master (
    asset_id numeric NOT NULL,
    asset_type_id numeric,
    asset_name character varying(256),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
