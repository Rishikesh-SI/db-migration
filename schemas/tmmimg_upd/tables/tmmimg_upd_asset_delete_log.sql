-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_asset_delete_log
-- Type: TABLE

-- Name: tmmimg_upd_asset_delete_log; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
