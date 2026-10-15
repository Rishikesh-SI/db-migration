-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_api_error_log
-- Type: TABLE

-- Name: labgt_api_error_log; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_api_error_log (
    api_error_log_id numeric NOT NULL,
    log_method_name text,
    log_error_message text,
    error_json jsonb,
    created_date timestamp without time zone
);


--
