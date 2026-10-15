-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_asset_delete_log
-- Type: TABLE

-- Name: yho_asset_delete_log; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_deleted_by numeric NOT NULL,
    asset_deleted_date timestamp without time zone NOT NULL
);


--
