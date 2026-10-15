-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_web_user_audit
-- Type: TABLE

-- Name: spz_web_user_audit; Type: TABLE; Schema: spz; Owner: -
--

CREATE TABLE spz.spz_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(2000),
    ipaddress character varying(2000),
    option_type numeric,
    audit_date timestamp without time zone
);


--
