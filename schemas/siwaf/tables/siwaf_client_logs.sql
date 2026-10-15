-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_client_logs
-- Type: TABLE

-- Name: siwaf_client_logs; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_client_logs (
    api_error_log_id numeric NOT NULL,
    log_method_name text,
    log_error_message text,
    log_guid character varying,
    log_type text,
    client_name character varying,
    error_json jsonb,
    created_date timestamp without time zone
);


--
