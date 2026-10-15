-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_asset_delete_log
-- Type: TABLE

-- Name: tmm_asset_delete_log; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
