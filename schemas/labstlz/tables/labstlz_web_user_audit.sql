-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_web_user_audit
-- Type: TABLE

-- Name: labstlz_web_user_audit; Type: TABLE; Schema: labstlz; Owner: -
--

CREATE TABLE labstlz.labstlz_web_user_audit (
    audit_id numeric NOT NULL,
    user_id numeric,
    user_guid character varying(200),
    ipaddress character varying(2000),
    option_type numeric,
    audit_date timestamp without time zone,
    is_app numeric
);


--
