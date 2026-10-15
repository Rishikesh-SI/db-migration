-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_asset_delete_log
-- Type: TABLE

-- Name: labtri_asset_delete_log; Type: TABLE; Schema: labtri; Owner: -
--

CREATE TABLE labtri.labtri_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
