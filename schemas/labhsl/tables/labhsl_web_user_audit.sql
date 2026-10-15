-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_web_user_audit
-- Type: TABLE

-- Name: labhsl_web_user_audit; Type: TABLE; Schema: labhsl; Owner: -
--

CREATE TABLE labhsl.labhsl_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(250),
    ipaddress character varying(250),
    option_type numeric,
    audit_date timestamp without time zone
);


--
