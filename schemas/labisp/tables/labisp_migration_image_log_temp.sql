-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_migration_image_log_temp
-- Type: TABLE

-- Name: labisp_migration_image_log_temp; Type: TABLE; Schema: labisp; Owner: -
--

CREATE TABLE labisp.labisp_migration_image_log_temp (
    asset_id numeric,
    asset_type_id numeric,
    source_path text,
    new_path text,
    ratio text,
    image_type text,
    error_if_any text,
    created_date timestamp without time zone
);


--
