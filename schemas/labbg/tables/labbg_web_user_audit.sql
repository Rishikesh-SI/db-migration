-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_web_user_audit
-- Type: TABLE

-- Name: labbg_web_user_audit; Type: TABLE; Schema: labbg; Owner: -
--

CREATE TABLE labbg.labbg_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying(100)
);


--
