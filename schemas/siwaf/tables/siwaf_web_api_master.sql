-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_web_api_master
-- Type: TABLE

-- Name: siwaf_web_api_master; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_web_api_master (
    api_master_id numeric,
    api_name character varying(1000),
    api_path character varying(2000),
    status numeric,
    is_active numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
