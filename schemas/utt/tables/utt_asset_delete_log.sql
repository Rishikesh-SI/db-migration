-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_asset_delete_log
-- Type: TABLE

-- Name: utt_asset_delete_log; Type: TABLE; Schema: utt; Owner: -
--

CREATE TABLE utt.utt_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_deleted_by numeric NOT NULL,
    asset_deleted_date timestamp without time zone NOT NULL
);


--
