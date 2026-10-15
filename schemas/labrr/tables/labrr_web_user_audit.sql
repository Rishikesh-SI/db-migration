-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_web_user_audit
-- Type: TABLE

-- Name: labrr_web_user_audit; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying(1000),
    platform_type numeric,
    device_name character varying,
    platform_version character varying,
    client_code character varying(50)
);


--
