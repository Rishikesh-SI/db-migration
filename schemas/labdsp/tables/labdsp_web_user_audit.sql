-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_web_user_audit
-- Type: TABLE

-- Name: labdsp_web_user_audit; Type: TABLE; Schema: labdsp; Owner: -
--

CREATE TABLE labdsp.labdsp_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    ipalabdspress character varying(2000),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric
);


--
