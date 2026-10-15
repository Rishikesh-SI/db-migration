-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_logs
-- Type: TABLE

-- Name: sibot_application_logs; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_logs (
    log_id numeric,
    function_name text,
    application_id numeric,
    json_input text,
    create_date timestamp with time zone
);


--
