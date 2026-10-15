-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_client_logs_import_04032024
-- Type: TABLE

-- Name: labgt_client_logs_import_04032024; Type: TABLE; Schema: labgt_02042024; Owner: -
--

CREATE TABLE labgt_02042024.labgt_client_logs_import_04032024 (
    api_error_log_id numeric,
    log_method_name text,
    log_error_message text,
    log_guid character varying,
    log_type text,
    client_name character varying,
    error_json jsonb,
    created_date timestamp without time zone
);


--
