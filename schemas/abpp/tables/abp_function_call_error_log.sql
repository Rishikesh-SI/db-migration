-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_function_call_error_log
-- Type: TABLE

-- Name: abp_function_call_error_log; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_function_call_error_log (
    function_name text NOT NULL,
    parameter_json jsonb NOT NULL,
    error_text text,
    created_date timestamp without time zone NOT NULL
);


--
