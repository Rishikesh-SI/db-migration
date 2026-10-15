-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiug
-- Object: labkiug_poll_asset_map
-- Type: TABLE

-- Name: labkiug_poll_asset_map; Type: TABLE; Schema: labkiug; Owner: -
--

CREATE TABLE labkiug.labkiug_poll_asset_map (
    poll_asset_map_id numeric NOT NULL,
    poll_id numeric,
    asset_order numeric,
    asset_id numeric,
    asset_type_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    aamap_guid character varying(256),
    is_cover numeric
);


--
