-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_web_user_audit
-- Type: TABLE

-- Name: labmsg_web_user_audit; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying(1000),
    platform_version character varying(100),
    device_name character varying,
    platform_type numeric,
    client_code numeric
);


--
