-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_json_log
-- Type: TABLE

-- Name: labyho_json_log; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_json_log (
    json_log_id numeric NOT NULL,
    json_file jsonb,
    url text,
    epochtime text,
    log_date timestamp without time zone
);


--
