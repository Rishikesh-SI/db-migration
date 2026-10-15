-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_web_user_audit_21022024
-- Type: TABLE

-- Name: labkxip_web_user_audit_21022024; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_web_user_audit_21022024 (
    audit_id numeric,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying(100),
    platform_version character varying(100),
    device_name character varying,
    platform_type numeric,
    client_code text
);


--
