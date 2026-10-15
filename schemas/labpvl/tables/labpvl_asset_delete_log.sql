-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_asset_delete_log
-- Type: TABLE

-- Name: labpvl_asset_delete_log; Type: TABLE; Schema: labpvl; Owner: -
--

CREATE TABLE labpvl.labpvl_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
