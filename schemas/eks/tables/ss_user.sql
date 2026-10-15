-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user
-- Type: TABLE

-- Name: ss_user; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_user (
    cf_userid integer DEFAULT nextval('eks.ss_user_cf_userid_seq'::regclass) NOT NULL,
    social_id character varying(4000) NOT NULL,
    cf_clientid numeric(10,0) NOT NULL,
    full_name character varying(256) NOT NULL,
    email_id character varying(1000),
    upper_email_id character varying(1000),
    mobile_no numeric(20,0),
    fav_team_id numeric(20,0) NOT NULL,
    user_guid character varying(4000) NOT NULL,
    cf_source_typeid numeric(25,0) NOT NULL,
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    user_source character varying(1000),
    is_password_changed numeric
);


--
