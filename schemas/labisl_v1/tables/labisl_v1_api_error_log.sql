-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_api_error_log
-- Type: TABLE

-- Name: labisl_v1_api_error_log; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_api_error_log (
    api_error_log_id numeric NOT NULL,
    log_method_name text,
    log_error_message text,
    log_guid character varying,
    error_json jsonb,
    created_date timestamp without time zone
);


--
