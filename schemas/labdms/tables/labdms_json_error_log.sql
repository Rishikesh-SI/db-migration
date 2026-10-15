-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_json_error_log
-- Type: TABLE

-- Name: labdms_json_error_log; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_json_error_log (
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
