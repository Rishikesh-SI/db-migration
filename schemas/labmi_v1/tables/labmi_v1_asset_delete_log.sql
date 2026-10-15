-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_asset_delete_log
-- Type: TABLE

-- Name: labmi_v1_asset_delete_log; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
