-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_web_user_audit
-- Type: TABLE

-- Name: labecn_web_user_audit; Type: TABLE; Schema: labecn; Owner: -
--

CREATE TABLE labecn.labecn_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric
);


--
