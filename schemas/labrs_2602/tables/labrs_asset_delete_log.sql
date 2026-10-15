-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_asset_delete_log
-- Type: TABLE

-- Name: labrs_asset_delete_log; Type: TABLE; Schema: labrs_2602; Owner: -
--

CREATE TABLE labrs_2602.labrs_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
