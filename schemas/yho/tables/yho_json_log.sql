-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_json_log
-- Type: TABLE

-- Name: yho_json_log; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_json_log (
    json_log_id numeric NOT NULL,
    json_file jsonb,
    url text,
    epochtime text,
    log_date timestamp without time zone
);


--
