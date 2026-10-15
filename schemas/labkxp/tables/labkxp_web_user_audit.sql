-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_web_user_audit
-- Type: TABLE

-- Name: labkxp_web_user_audit; Type: TABLE; Schema: labkxp; Owner: -
--

CREATE TABLE labkxp.labkxp_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    ipaddress character varying(2000),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric
);


--
