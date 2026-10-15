-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: wf_user
-- Type: TABLE

-- Name: wf_user; Type: TABLE; Schema: gfg; Owner: -
--

CREATE TABLE gfg.wf_user (
    cf_userid numeric(30,0) NOT NULL,
    social_id character varying(500) NOT NULL,
    cf_clientid numeric(10,0) NOT NULL,
    email_id character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    cf_fav_teamid numeric(10,0) NOT NULL,
    user_guid character varying(1000) NOT NULL,
    mobile_no numeric(20,0) NOT NULL,
    created_date_ist timestamp without time zone NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
