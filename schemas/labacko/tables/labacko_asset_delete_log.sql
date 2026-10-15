-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_asset_delete_log
-- Type: TABLE

-- Name: labacko_asset_delete_log; Type: TABLE; Schema: labacko; Owner: -
--

CREATE TABLE labacko.labacko_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
