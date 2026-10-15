-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_web_user_audit
-- Type: TABLE

-- Name: dhm_web_user_audit; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying(1000)
);


--
