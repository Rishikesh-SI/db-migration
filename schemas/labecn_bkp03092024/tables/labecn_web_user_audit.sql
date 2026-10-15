-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp03092024
-- Object: labecn_web_user_audit
-- Type: TABLE

-- Name: labecn_web_user_audit; Type: TABLE; Schema: labecn_bkp03092024; Owner: -
--

CREATE TABLE labecn_bkp03092024.labecn_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric
);


--
