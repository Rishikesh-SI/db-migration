-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_content_ingestion_xml_error_log
-- Type: TABLE

-- Name: labyho_content_ingestion_xml_error_log; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_content_ingestion_xml_error_log (
    error_log_id numeric,
    xml_data xml,
    title text,
    url text,
    error text,
    error_type text,
    epochtime text,
    log_date timestamp without time zone
);


--
