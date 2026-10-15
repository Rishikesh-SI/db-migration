-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_sp_logs
-- Type: TABLE

-- Name: siwaf_sp_logs; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_sp_logs (
    schema_name character varying,
    sp_name character varying,
    error_code text,
    error_message character varying,
    created_date timestamp without time zone,
    input_json jsonb
);


--
