-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_json_error_log
-- Type: TABLE

-- Name: yho_json_error_log; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_json_error_log (
    json_error_log_id numeric NOT NULL,
    json_file jsonb,
    error text,
    title text,
    url text,
    error_guid text,
    log_date timestamp without time zone,
    error_type text
);


--
