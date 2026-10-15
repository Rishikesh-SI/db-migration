-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_asset_delete_log
-- Type: TABLE

-- Name: labpr_asset_delete_log; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
