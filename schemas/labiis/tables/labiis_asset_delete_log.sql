-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_asset_delete_log
-- Type: TABLE

-- Name: labiis_asset_delete_log; Type: TABLE; Schema: labiis; Owner: -
--

CREATE TABLE labiis.labiis_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
