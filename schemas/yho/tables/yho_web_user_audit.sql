-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_web_user_audit
-- Type: TABLE

-- Name: yho_web_user_audit; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(2000),
    ipaddress character varying(2000),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric
);


--
