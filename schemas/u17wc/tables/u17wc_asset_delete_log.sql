-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_asset_delete_log
-- Type: TABLE

-- Name: u17wc_asset_delete_log; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
