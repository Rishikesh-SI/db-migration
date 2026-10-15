-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_web_user_audit
-- Type: TABLE

-- Name: labgt_web_user_audit; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying,
    platform_type numeric,
    device_name character varying,
    platform_version character varying,
    client_code text
);


--
