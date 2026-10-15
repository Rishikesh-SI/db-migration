-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_asset_delete_log
-- Type: TABLE

-- Name: abp_asset_delete_log; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_deleted_by numeric NOT NULL,
    asset_deleted_date timestamp without time zone NOT NULL
);


--
