-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_asset_delete_log
-- Type: TABLE

-- Name: labmsg_asset_delete_log; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    asset_deleted_by numeric,
    asset_deleted_date timestamp without time zone
);


--
