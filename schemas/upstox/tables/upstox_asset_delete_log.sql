-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_asset_delete_log
-- Type: TABLE

-- Name: upstox_asset_delete_log; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
