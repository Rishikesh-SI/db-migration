-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_api_error_log
-- Type: TABLE

-- Name: labdsg_api_error_log; Type: TABLE; Schema: labdsg; Owner: -
--

CREATE TABLE labdsg.labdsg_api_error_log (
    api_error_log_id numeric NOT NULL,
    log_method_name text,
    log_error_message text,
    log_guid character varying,
    error_json jsonb,
    created_date timestamp without time zone
);


--
