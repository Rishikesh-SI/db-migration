-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_api_error_log
-- Type: TABLE

-- Name: labmi_v1_api_error_log; Type: TABLE; Schema: labmi_v1_bkp; Owner: -
--

CREATE TABLE labmi_v1_bkp.labmi_v1_api_error_log (
    api_error_log_id numeric NOT NULL,
    log_method_name text,
    log_error_message text,
    log_guid character varying,
    error_json jsonb,
    created_date timestamp without time zone
);


--
