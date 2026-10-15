-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_api_error_log
-- Type: TABLE

-- Name: labkxip_api_error_log; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_api_error_log (
    api_error_log_id numeric NOT NULL,
    log_method_name text,
    log_error_message text,
    error_json jsonb,
    created_date timestamp without time zone
);


--
