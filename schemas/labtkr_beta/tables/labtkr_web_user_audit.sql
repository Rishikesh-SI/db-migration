-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_web_user_audit
-- Type: TABLE

-- Name: labtkr_web_user_audit; Type: TABLE; Schema: labtkr_beta; Owner: -
--

CREATE TABLE labtkr_beta.labtkr_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric,
    ipaddress character varying(100)
);


--
