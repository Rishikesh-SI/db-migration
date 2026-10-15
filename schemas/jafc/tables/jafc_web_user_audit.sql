-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_web_user_audit
-- Type: TABLE

-- Name: jafc_web_user_audit; Type: TABLE; Schema: jafc; Owner: -
--

CREATE TABLE jafc.jafc_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    ipaddress character varying(200),
    option_type numeric,
    audit_date timestamp without time zone
);


--
