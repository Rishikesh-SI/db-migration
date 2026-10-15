-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_web_user_audit_bkp
-- Type: TABLE

-- Name: lablsg_v1_web_user_audit_bkp; Type: TABLE; Schema: lablsg_v1; Owner: -
--

CREATE TABLE lablsg_v1.lablsg_v1_web_user_audit_bkp (
    audit_id numeric,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying,
    platform_type numeric,
    device_name character varying,
    platform_version character varying
);


--
