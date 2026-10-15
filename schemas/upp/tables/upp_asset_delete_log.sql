-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_asset_delete_log
-- Type: TABLE

-- Name: upp_asset_delete_log; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_asset_delete_log (
    asset_delete_log_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_deleted_by numeric NOT NULL,
    asset_deleted_date timestamp without time zone NOT NULL
);


--
