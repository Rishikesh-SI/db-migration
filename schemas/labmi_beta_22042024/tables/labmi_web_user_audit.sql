-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_web_user_audit
-- Type: TABLE

-- Name: labmi_web_user_audit; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    ipaddress character varying,
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric
);


--
