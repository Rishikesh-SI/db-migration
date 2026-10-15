-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_web_user_audit
-- Type: TABLE

-- Name: labpkl_v1_web_user_audit; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying
);


--
